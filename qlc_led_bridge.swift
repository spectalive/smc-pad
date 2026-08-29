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
// Feedback convention: a NoteOn (velocity > 0) lights the pad ON_COLOR; a NoteOff
// (or velocity 0) dims it to OFF_COLOR. Pad note numbers are the SMC-PAD's own
// (bank A notes 4-19); the address of each pad's colour in flash is
// 0x418 + (padNumber-1)*26.

let ON_COLOR: (UInt8, UInt8, UInt8) = (255, 255, 255)   // active widget = white
let OFF_COLOR: (UInt8, UInt8, UInt8) = (0, 0, 0)        // inactive = off

// Physical pad number (1..16) -> MIDI note (from the captured input profile):
// rows top-to-bottom are pads 13-16, 9-12, 5-8, 1-4 with notes 4-7, 8-11,
// 12-15, 16-19. So pad N's note and its flash address:
func noteToAddress() -> [UInt8: Int] {
    let padForNote: [UInt8: Int] = [
        4:13, 5:14, 6:15, 7:16, 8:9, 9:10, 10:11, 11:12,
        12:5, 13:6, 14:7, 15:8, 16:1, 17:2, 18:3, 19:4,
    ]
    var map: [UInt8: Int] = [:]
    for (note, pad) in padForNote { map[note] = 0x418 + (pad - 1) * 26 }
    return map
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
    let map = noteToAddress()
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
                print("session ready - QLC+ feedback will now paint pads")
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
            let note = b[i+1], vel = b[i+2]
            if let addr = map[note] {
                let on = (status == 0x90 && vel > 0)
                let c = on ? ON_COLOR : OFF_COLOR
                DispatchQueue.main.async { self.write(addr, c.0, c.1, c.2) }
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
