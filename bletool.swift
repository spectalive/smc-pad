import CoreBluetooth
import Foundation

setbuf(stdout, nil)

// Connect to the SMC-PAD, subscribe to notify chars, and write packets to AE41.
// Each argv packet is a hex string WITHOUT the trailing checksum; this tool
// appends checksum = (~sum) & 0xFF, the algorithm from make*Packet.
// Special arg "raw:<hex>" writes the bytes verbatim (no checksum appended).

func checksum(_ b: [UInt8]) -> UInt8 { UInt8((~Int(b.reduce(0) { Int($0) + Int($1) })) & 0xFF) }

let packets: [[UInt8]] = CommandLine.arguments.dropFirst().map { arg in
    if arg.hasPrefix("raw:") {
        return arg.dropFirst(4).split(separator: " ").compactMap { UInt8($0, radix: 16) }
    }
    var body = arg.split(separator: " ").compactMap { UInt8($0, radix: 16) }
    body.append(checksum(body))
    return body
}

final class Tool: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var central: CBCentralManager!
    var pad: CBPeripheral?
    var writeChar: CBCharacteristic?
    var sent = 0
    var exited = false

    func start() { central = CBCentralManager(delegate: self, queue: nil) }

    func centralManagerDidUpdateState(_ c: CBCentralManager) {
        guard c.state == .poweredOn else { print("BLE state \(c.state.rawValue)"); exit(2) }
        // Bonded devices stop advertising; retrieve them as already-connected system peripherals.
        let known = c.retrieveConnectedPeripherals(withServices: [CBUUID(string: "AE40"), CBUUID(string: "180A")])
        if let p = known.first(where: { ($0.name ?? "").contains("SMC-PAD") }) ?? known.first {
            print("retrieved connected peripheral '\(p.name ?? "?")'")
            pad = p; p.delegate = self; c.connect(p, options: nil); return
        }
        print("scanning..."); c.scanForPeripherals(withServices: nil)
    }
    func centralManager(_ c: CBCentralManager, didDiscover p: CBPeripheral,
                        advertisementData: [String: Any], rssi: NSNumber) {
        if (p.name ?? "").contains("SMC-PAD") {
            pad = p; p.delegate = self; c.stopScan(); c.connect(p, options: nil)
        }
    }
    func centralManager(_ c: CBCentralManager, didConnect p: CBPeripheral) {
        print("connected"); p.discoverServices(nil)
    }
    func peripheral(_ p: CBPeripheral, didDiscoverServices e: Error?) {
        for s in p.services ?? [] { p.discoverCharacteristics(nil, for: s) }
    }
    func peripheral(_ p: CBPeripheral, didDiscoverCharacteristicsFor s: CBService, error: Error?) {
        for ch in s.characteristics ?? [] {
            if ch.properties.contains(.notify) { p.setNotifyValue(true, for: ch) }
            if ch.uuid == CBUUID(string: (ProcessInfo.processInfo.environment["WRITEUUID"] ?? "AE41")) { writeChar = ch }
        }
        if writeChar != nil && sent == 0 { DispatchQueue.main.asyncAfter(deadline: .now() + 1) { self.sendNext() } }
    }
    func sendNext() {
        guard let ch = writeChar else { return }
        if sent >= packets.count {
            if exited { return }; exited = true
            print("all sent; listening")
            DispatchQueue.main.asyncAfter(deadline: .now() + 24) { exit(0) }
            return
        }
        let pkt = packets[sent]; sent += 1
        print("write <- " + pkt.map { String(format: "%02X", $0) }.joined(separator: " "))
        pad?.writeValue(Data(pkt), for: ch, type: .withoutResponse)
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) { self.sendNext() }
    }
    func peripheral(_ p: CBPeripheral, didUpdateValueFor ch: CBCharacteristic, error: Error?) {
        guard let d = ch.value else { return }
        print("notify \(ch.uuid): " + d.map { String(format: "%02X", $0) }.joined(separator: " "))
    }
}
let t = Tool(); t.start(); RunLoop.main.run()
