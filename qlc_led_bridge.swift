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
//   2. It publishes a virtual CoreMIDI destination, "SMC-PAD LED Bridge". Point
//      QLC+'s output (of the universe the pad is patched to) at this port with
//      Feedback enabled. When a Virtual Console widget lights, QLC+ sends the
//      widget's note here; the bridge paints the matching pad.
//
// Feedback convention: a NoteOn (velocity > 0) lights the pad full-bright; a
// NoteOff (or velocity 0) dims it to its idle colour.
//
// Note numbers are the pad's own, measured 2026-08-29: within a bank the note
// is 35 + padNumber counting from the bottom-left (PAD1 = 36, PAD13 = 48), and
// PAD BANK moves the whole surface 16 notes up. The show uses two banks - the
// hits on bank 1, the console's manual page on bank 2 - so this bridge paints
// notes 36..67. The pad's flash keeps one 26-byte record per note slot, so a
// note's colour address is 0x418 + (note - 36) * 26 for any of them.

// The palette, note -> RGB, mirroring the console button colours in
// tools/qlctool/qlctool/generate/smc_pad_colors.py. Each pad glows its colour
// dimmed while idle and full-bright while its function is active. Keep the two
// in step: the console paints the button, this paints the pad under the finger.
let PAD_COLORS: [(UInt8, UInt8, UInt8)] = [
    (255, 255, 255),  // pad 1  Blanco Total
    (255,  40,  40),  // pad 2  Todo Negro
    (255, 170,  60),  // pad 3  Charla
    ( 20,  20,  20),  // pad 4  free - faint grey
    ( 40, 255,  60),  // pad 5  AUTO
    (255,  40, 180),  // pad 6  Fiesta
    (255,  90,   0),  // pad 7  Locura
    ( 40, 120, 255),  // pad 8  Tranquilo
    (  0, 220, 255),  // pad 9  Humo Vertical
    (150, 220, 255),  // pad 10 Humo
    (255, 255,   0),  // pad 11 Strobo
    (255, 200,   0),  // pad 12 Strobo Medio
    (255, 255, 255),  // pad 13 Flash 100%
    (255, 225, 180),  // pad 14 Flash 50%
    (255,   0, 255),  // pad 15 Flash Color
    (  0, 255, 255),  // pad 16 Color Beam
]
// Bank 2 (PAD BANK): the console's manual page. Its bottom two rows are unused,
// so they sit at the same faint grey as the free pad on bank 1.
let FREE_PAD: (UInt8, UInt8, UInt8) = (20, 20, 20)
let BANK2_COLORS: [(UInt8, UInt8, UInt8)] = [
    FREE_PAD, FREE_PAD, FREE_PAD, FREE_PAD,          // pads 1-4  free
    FREE_PAD, FREE_PAD, FREE_PAD, FREE_PAD,          // pads 5-8  free
    (255, 255, 255),  // pad 9  Prisma Animacion
    (150, 220, 255),  // pad 10 Humo Auto
    (255, 140,   0),  // pad 11 Arcoiris Simultaneo
    (255, 220,   0),  // pad 12 Arcoiris Pasos
    (255,   0, 128),  // pad 13 Rueda Colores
    (128,   0, 255),  // pad 14 Rueda Mezcla
    (  0, 128, 255),  // pad 15 Movimientos Cabezas
    (  0, 255, 128),  // pad 16 Gobo Animacion
]
let DIM = 6   // idle brightness = colour / DIM

let FIRST_NOTE = 36           // PAD1 on bank 1
let LAST_NOTE = FIRST_NOTE + 31  // PAD16 on bank 2

// One 26-byte record per note slot, so the same arithmetic covers both banks.
func noteAddress(_ note: Int) -> Int { 0x418 + (note - FIRST_NOTE) * 26 }

func paletteColor(_ note: Int) -> (UInt8, UInt8, UInt8)? {
    guard (FIRST_NOTE...LAST_NOTE).contains(note) else { return nil }
    let offset = note - FIRST_NOTE
    return offset < 16 ? PAD_COLORS[offset] : BANK2_COLORS[offset - 16]
}

func dimmed(_ c: (UInt8, UInt8, UInt8)) -> (UInt8, UInt8, UInt8) {
    (c.0 / UInt8(DIM), c.1 / UInt8(DIM), c.2 / UInt8(DIM))
}

/// "bank 2 pad 13" - what the operator sees, for the log line.
func padLabel(_ note: Int) -> String {
    let offset = note - FIRST_NOTE
    return offset < 16 ? "pad \(offset + 1)" : "bank 2 pad \(offset - 15)"
}

func le(_ v: Int, _ w: Int) -> [UInt8] { (0..<w).map { UInt8((v >> (8*$0)) & 0xFF) } }
func colorLogical(_ addr: Int, _ r: UInt8, _ g: UInt8, _ b: UInt8) -> [UInt8] {
    var d: [UInt8] = [0x05] + le(addr,4) + [0x03,0x00,0x00] + [r,g,b]
    let ck = UInt8((~d.map{Int($0)}.reduce(0,+)) & 0xFF)
    return [0x00,0x59,0x22] + le(d.count,3) + d + [ck]
}
func unlockPackets() -> [[UInt8]] {
    // gatt_unlock.txt sits next to this file's reference/ dir; try a couple paths.
    for p in ["reference/gatt_unlock.txt", "gatt_unlock.txt",
              (CommandLine.arguments.dropFirst().first ?? "")] where !p.isEmpty {
        if let t = try? String(contentsOfFile: p, encoding: .utf8) {
            return t.split(separator: "\n").map { $0.split(separator: " ").compactMap { UInt8($0, radix: 16) } }.filter { !$0.isEmpty }
        }
    }
    return []
}

final class Bridge: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var central: CBCentralManager!
    var pad: CBPeripheral?
    var writeChar: CBCharacteristic?
    var ready = false
    let unlock = unlockPackets()
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
                // Paint every pad of both banks its dim idle colour.
                for note in FIRST_NOTE...LAST_NOTE {
                    guard let c = paletteColor(note).map(dimmed) else { continue }
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
        var i = 0
        while i + 2 < b.count {
            let status = b[i] & 0xF0
            guard status == 0x90 || status == 0x80 else { i += 1; continue }
            let note = Int(b[i+1]), vel = b[i+2]
            if let colour = paletteColor(note) {
                let on = (status == 0x90 && vel > 0)
                let c = on ? colour : dimmed(colour)
                print("MIDI in: note \(note) -> \(padLabel(note)) \(on ? "ACTIVE" : "idle")" +
                      (ready ? "" : " (session NOT ready, dropped)"))
                DispatchQueue.main.async { self.write(noteAddress(note), c.0, c.1, c.2) }
            }
            i += 3
        }
    }
}

let bridge = Bridge()
bridge.start()
print("SMC-PAD LED bridge running. In QLC+, set the pad universe's OUTPUT to")
print("'SMC-PAD LED Bridge' with Feedback enabled. Ctrl-C to stop.")
RunLoop.main.run()
