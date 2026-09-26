import CoreBluetooth
import CoreMIDI
import Foundation

setbuf(stdout, nil)

// QLC+ -> SMC-PAD LED bridge (Bluetooth GATT).
//
// QLC+ cannot light the pad's LEDs itself (they are not MIDI, and the pad only
// accepts colour writes inside a session). This daemon bridges the gap:
//
//   1. It holds the pad's LED session over BLE GATT (service AE40): it replays
//      the connect unlock (reference/gatt_unlock.txt), then keeps writing colours
//      to characteristic AE41.
//   2. It reads the show's pad palette (see below) and paints every pad it
//      names its idle colour once the session is up.
//   3. It publishes a virtual CoreMIDI destination, "SMC-PAD LED Bridge". Point
//      QLC+'s output (of the universe the pad is patched to) at this port with
//      Feedback enabled. When a Virtual Console widget lights, QLC+ sends the
//      widget's note here; the bridge paints the matching pad.
//
// Feedback convention: a NoteOn (velocity > 0) lights the pad full-bright; a
// NoteOff (or velocity 0) dims it to its idle colour.
//
// Note numbers are the pad's own, measured 2026-08-29: within a bank the note
// is 35 + padNumber counting from the bottom-left (PAD1 = 36, PAD13 = 48), and
// PAD BANK moves the whole surface 16 notes up. A show may use two banks, so
// this bridge paints notes 36..67. The pad's flash keeps one 26-byte record per note slot, so a
// note's colour address is 0x418 + (note - 36) * 26 for any of them.

// The palette is not this file's business. Which pad wears which colour is
// the show's: `qlctool pad-palette --out <file.json> <workspace>`
// (https://github.com/spectalive/qlctool, docs/pad-palette.md) writes it from
// the same bindings and colours the generated console paints its buttons
// with, so the pad and the screen cannot drift apart. The bridge reads that
// file at start, lights each pad by its `note`, and uses `active` and `idle`
// exactly as given. Format 1 is the only one it knows; it refuses any other.
//
// What stays here is the device: the note range and where each note's colour
// lives in the pad's flash.

struct PadPalette: Decodable {
    struct Pad: Decodable {
        let bank: Int
        let pad: Int
        let note: Int
        let control: String?
        let lit: Bool
        let active: [Int]
        let idle: [Int]
    }
    let format: Int
    let pads: [Pad]
}

/// Read before the rest, so a file of another format is refused as such and
/// not as a shape this bridge does not know.
struct PaletteFormat: Decodable {
    let format: Int
}

struct PadColors {
    let active: (UInt8, UInt8, UInt8)
    let idle: (UInt8, UInt8, UInt8)
    let label: String
    let control: String?
}

let FIRST_NOTE = 36           // PAD1 on bank 1
let LAST_NOTE = FIRST_NOTE + 31  // PAD16 on bank 2

// One 26-byte record per note slot, so the same arithmetic covers both banks.
func noteAddress(_ note: Int) -> Int { 0x418 + (note - FIRST_NOTE) * 26 }

func fail(_ message: String) -> Never {
    FileHandle.standardError.write(("ERROR: " + message + "\n").data(using: .utf8)!)
    exit(1)
}

/// Decoded as `Int`, wider than the colour byte it must become, so an
/// out-of-range channel (256, or negative) is this bridge's own refusal and
/// not whatever message Foundation's JSON decoder happens to raise for a
/// `UInt8` overflow.
func rgb(_ channels: [Int], _ what: String) -> (UInt8, UInt8, UInt8) {
    guard channels.count == 3 else { fail("\(what) has \(channels.count) channels, not 3") }
    for c in channels {
        guard (0...255).contains(c) else { fail("\(what) channel \(c) is outside 0-255") }
    }
    return (UInt8(channels[0]), UInt8(channels[1]), UInt8(channels[2]))
}

/// note -> colours, from a `qlctool pad-palette` file. Exits on anything it
/// cannot paint faithfully: a bridge that guesses lights the wrong pads.
func loadPalette(_ path: String) -> [Int: PadColors] {
    guard let data = FileManager.default.contents(atPath: path) else {
        fail("cannot read the pad palette \(path)")
    }
    let format: Int
    do {
        format = try JSONDecoder().decode(PaletteFormat.self, from: data).format
    } catch {
        fail("\(path) is not a pad palette: \(error)")
    }
    guard format == 1 else {
        fail("\(path) is pad palette format \(format); this bridge reads format 1 only")
    }
    let palette: PadPalette
    do {
        palette = try JSONDecoder().decode(PadPalette.self, from: data)
    } catch {
        fail("\(path) is not a pad palette: \(error)")
    }
    var byNote: [Int: PadColors] = [:]
    for pad in palette.pads {
        guard (FIRST_NOTE...LAST_NOTE).contains(pad.note) else {
            fail("\(path): note \(pad.note) is outside the pad's \(FIRST_NOTE)-\(LAST_NOTE)")
        }
        guard byNote[pad.note] == nil else { fail("\(path): note \(pad.note) appears twice") }
        byNote[pad.note] = PadColors(
            active: rgb(pad.active, "note \(pad.note) active"),
            idle: rgb(pad.idle, "note \(pad.note) idle"),
            label: "bank \(pad.bank) pad \(pad.pad)",
            control: pad.control)
    }
    return byNote
}

/// What each note would show, one line per note; the bridge's own reading of
/// the file, so it can be checked without a pad in reach.
func printPalette(_ palette: [Int: PadColors]) {
    print("\(palette.count) pads")
    for note in palette.keys.sorted() {
        let p = palette[note]!
        let address = String(format: "0x%04X", noteAddress(note))
        print("note \(note)  \(p.label)  addr \(address)  " +
              "active \(p.active.0),\(p.active.1),\(p.active.2)  " +
              "idle \(p.idle.0),\(p.idle.1),\(p.idle.2)  \(p.control ?? "free")")
    }
}

/// `--palette FILE`, `--unlock FILE`, `--print-palette FILE`, `--simulate-notes FILE`.
func option(_ name: String) -> String? {
    let args = CommandLine.arguments
    guard let i = args.firstIndex(of: name) else { return nil }
    guard i + 1 < args.count else { fail("\(name) needs a file") }
    return args[i + 1]
}

let knownFlags: Set<String> = ["--palette", "--unlock", "--print-palette", "--simulate-notes"]
let usageLine = "usage: qlc-led-bridge [--palette FILE] [--unlock FILE] " +
                "[--print-palette FILE] [--simulate-notes FILE]"

/// Every argument must be one of the flags above, each taking its file next.
/// An unrecognized flag - or the bridge's old positional unlock-file argument
/// - used to be ignored silently; now either one stops the bridge with a
/// usage line, same as a flag missing its file already does.
func validateArguments() {
    let args = Array(CommandLine.arguments.dropFirst())
    var i = 0
    while i < args.count {
        // LaunchServices may add a process serial number to a Finder launch,
        // and the Finder launch is the one that earns the Bluetooth grant.
        if args[i].hasPrefix("-psn_") {
            i += 1
            continue
        }
        guard knownFlags.contains(args[i]) else {
            fail("unrecognized argument '\(args[i])'\n\(usageLine)")
        }
        i += 2
    }
}
validateArguments()

let exeDir = URL(fileURLWithPath: CommandLine.arguments[0]).deletingLastPathComponent()

/// The palette to paint: `--palette` when given, else the copy the installer
/// put in the bundle's Resources. The bundle copy is what the launchd agent
/// and a Finder launch use - `open` passes no arguments, and the app must run
/// from the Finder once for macOS to offer the Bluetooth prompt.
func palettePath() -> String {
    if let path = option("--palette") { return path }
    let bundled = exeDir.appendingPathComponent("../Resources/palette.json").path
    if FileManager.default.fileExists(atPath: bundled) { return bundled }
    fail("no pad palette: pass --palette <file.json> (written by `qlctool pad-palette`)")
}

func le(_ v: Int, _ w: Int) -> [UInt8] { (0..<w).map { UInt8((v >> (8*$0)) & 0xFF) } }
func colorLogical(_ addr: Int, _ r: UInt8, _ g: UInt8, _ b: UInt8) -> [UInt8] {
    let d: [UInt8] = [0x05] + le(addr,4) + [0x03,0x00,0x00] + [r,g,b]
    let ck = UInt8((~d.map{Int($0)}.reduce(0,+)) & 0xFF)
    return [0x00,0x59,0x22] + le(d.count,3) + d + [ck]
}
func unlockPackets() -> [[UInt8]] {
    // Where gatt_unlock.txt can be, in the order worth trying:
    //  - an explicit `--unlock <file>`.
    //  - inside our own .app bundle, which is how install-bridge.sh ships it.
    //    This one matters beyond tidiness: macOS only shows the Bluetooth
    //    permission prompt to an app launched from the Finder, and `open` passes
    //    no arguments - so a build that could only be told its data file on the
    //    command line could never be granted Bluetooth at all.
    //  - relative to the working directory, for `swift qlc_led_bridge.swift`
    //    run straight out of this repository.
    let candidates = [
        option("--unlock") ?? "",
        exeDir.appendingPathComponent("../Resources/gatt_unlock.txt").path,
        exeDir.appendingPathComponent("gatt_unlock.txt").path,
        "reference/gatt_unlock.txt",
        "gatt_unlock.txt",
    ]
    for p in candidates where !p.isEmpty {
        if let t = try? String(contentsOfFile: p, encoding: .utf8) {
            return t.split(separator: "\n").map { $0.split(separator: " ").compactMap { UInt8($0, radix: 16) } }.filter { !$0.isEmpty }
        }
    }
    return []
}

/// A flat stream of hex bytes, one MIDI message per line (e.g. `90 24 7F`),
/// the same shape `gatt_unlock.txt` already uses. `--simulate-notes` reads
/// its file this way.
func readHexBytes(_ path: String) -> [UInt8] {
    guard let text = try? String(contentsOfFile: path, encoding: .utf8) else {
        fail("cannot read \(path)")
    }
    return text.split(separator: "\n").flatMap { line in
        line.split(separator: " ").compactMap { UInt8($0, radix: 16) }
    }
}

struct NotePaint {
    let note: Int
    let label: String
    let on: Bool
    let colour: (UInt8, UInt8, UInt8)
}

/// What a raw MIDI byte stream would paint: a NoteOn with velocity > 0 lights
/// a palette note ACTIVE, anything else (NoteOff, or NoteOn velocity 0) dims
/// it to idle. `Bridge.handleMIDI` uses this on live CoreMIDI input, and
/// `--simulate-notes` uses it on a file - the same decision either way, so a
/// check made without the pad cannot drift from what the pad would see.
func notePaints(_ b: [UInt8], _ palette: [Int: PadColors]) -> [NotePaint] {
    var events: [NotePaint] = []
    var i = 0
    while i + 2 < b.count {
        let status = b[i] & 0xF0
        guard status == 0x90 || status == 0x80 else { i += 1; continue }
        let note = Int(b[i+1]), vel = b[i+2]
        if let colours = palette[note] {
            let on = (status == 0x90 && vel > 0)
            events.append(NotePaint(note: note, label: colours.label, on: on,
                                     colour: on ? colours.active : colours.idle))
        }
        i += 3
    }
    return events
}

final class Bridge: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var central: CBCentralManager!
    var pad: CBPeripheral?
    var writeChar: CBCharacteristic?
    var ready = false
    let unlock = unlockPackets()
    let palette: [Int: PadColors]

    init(palette: [Int: PadColors]) { self.palette = palette }
    var midiClient = MIDIClientRef()
    var virtualDest = MIDIEndpointRef()

    func start() {
        guard !unlock.isEmpty else { print("ERROR: gatt_unlock.txt not found"); exit(1) }
        central = CBCentralManager(delegate: self, queue: nil)
        setupMIDI()
    }

    // MARK: BLE
    func centralManagerDidUpdateState(_ c: CBCentralManager) {
        guard c.state == .poweredOn else { print("BLE state \(c.state.rawValue)"); return }
        let known = c.retrieveConnectedPeripherals(withServices: [CBUUID(string:"AE40")])
        if let p = known.first { connect(p); return }
        c.scanForPeripherals(withServices: nil)
    }
    func centralManager(_ c: CBCentralManager, didDiscover p: CBPeripheral, advertisementData: [String:Any], rssi: NSNumber) {
        if (p.name ?? "").contains("SMC-PAD") { c.stopScan(); connect(p) }
    }
    func connect(_ p: CBPeripheral) { pad = p; p.delegate = self; central.connect(p) }
    func centralManager(_ c: CBCentralManager, didConnect p: CBPeripheral) {
        print("pad connected, discovering..."); p.discoverServices([CBUUID(string:"AE40")])
    }
    func centralManager(_ c: CBCentralManager, didDisconnectPeripheral p: CBPeripheral, error: Error?) {
        print("pad disconnected, reconnecting..."); ready = false; c.connect(p)
    }
    func peripheral(_ p: CBPeripheral, didDiscoverServices e: Error?) { for s in p.services ?? [] { p.discoverCharacteristics(nil, for: s) } }
    func peripheral(_ p: CBPeripheral, didDiscoverCharacteristicsFor s: CBService, error: Error?) {
        for ch in s.characteristics ?? [] {
            if ch.uuid == CBUUID(string:"AE42") { p.setNotifyValue(true, for: ch) }
            if ch.uuid == CBUUID(string:"AE41") { writeChar = ch }
        }
        if writeChar != nil && !ready { runUnlock() }
    }
    func runUnlock() {
        guard let ch = writeChar else { return }
        print("unlocking session (\(unlock.count) packets)...")
        var i = 0
        Timer.scheduledTimer(withTimeInterval: 0.05, repeats: true) { t in
            if i < self.unlock.count {
                self.pad?.writeValue(Data(self.unlock[i]), for: ch, type: .withoutResponse); i += 1
            } else {
                t.invalidate(); self.ready = true
                print("session ready - painting idle palette, QLC+ feedback live")
                // Paint every pad the palette names its idle colour.
                for (note, colours) in self.palette {
                    let c = colours.idle
                    self.pad?.writeValue(Data(colorLogical(noteAddress(note), c.0, c.1, c.2)),
                                         for: ch, type: .withoutResponse)
                }
                // keep-alive poll to hold the session
                let poll = self.unlock.first(where: { $0.count > 3 && $0[2] == 0x23 }) ?? self.unlock[1]
                Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
                    self.pad?.writeValue(Data(poll), for: ch, type: .withoutResponse)
                }
            }
        }
    }
    func write(_ addr: Int, _ r: UInt8, _ g: UInt8, _ b: UInt8) {
        guard ready, let ch = writeChar else { return }
        pad?.writeValue(Data(colorLogical(addr, r, g, b)), for: ch, type: .withoutResponse)
    }

    // MARK: MIDI in from QLC+
    func setupMIDI() {
        MIDIClientCreate("SMC-PAD LED Bridge" as CFString, nil, nil, &midiClient)
        MIDIDestinationCreateWithBlock(midiClient, "SMC-PAD LED Bridge" as CFString, &virtualDest) { [weak self] pktList, _ in
            guard let self = self else { return }
            var pkt = pktList.pointee.packet
            for _ in 0..<pktList.pointee.numPackets {
                let len = Int(pkt.length)
                var bytes = [UInt8](repeating: 0, count: len)
                withUnsafeBytes(of: pkt.data) { raw in for i in 0..<min(len,256) { bytes[i] = raw[i] } }
                self.handleMIDI(bytes)
                pkt = MIDIPacketNext(&pkt).pointee
            }
        }
        print("virtual MIDI destination 'SMC-PAD LED Bridge' is live")
    }
    func handleMIDI(_ b: [UInt8]) {
        for paint in notePaints(b, palette) {
            print("MIDI in: note \(paint.note) -> \(paint.label) \(paint.on ? "ACTIVE" : "idle")" +
                  (ready ? "" : " (session NOT ready, dropped)"))
            let c = paint.colour
            DispatchQueue.main.async { self.write(noteAddress(paint.note), c.0, c.1, c.2) }
        }
    }
}

if let path = option("--print-palette") {
    printPalette(loadPalette(path))
    exit(0)
}

/// What the NoteOn/NoteOff feedback QLC+ sends would paint, without a pad or
/// a MIDI port: reads a palette and a file of raw MIDI bytes (one message per
/// line, e.g. `90 24 7F`) and prints each note's decision through the same
/// `notePaints` the live bridge uses. Touches no Bluetooth and no CoreMIDI.
if let notesPath = option("--simulate-notes") {
    let palette = loadPalette(palettePath())
    let events = notePaints(readHexBytes(notesPath), palette)
    if events.isEmpty { print("no palette notes in \(notesPath)") }
    for e in events {
        print("note \(e.note)  \(e.label)  \(e.on ? "ACTIVE" : "idle")  " +
              "\(e.colour.0),\(e.colour.1),\(e.colour.2)")
    }
    exit(0)
}

let palettePathInUse = palettePath()
let palette = loadPalette(palettePathInUse)
print("pad palette: \(palettePathInUse), \(palette.count) pads")
if palette.isEmpty { print("WARNING: the palette lights no pad") }
let bridge = Bridge(palette: palette)
bridge.start()
print("SMC-PAD LED bridge running. In QLC+, set the pad universe's OUTPUT to")
print("'SMC-PAD LED Bridge' with Feedback enabled. Ctrl-C to stop.")
RunLoop.main.run()
