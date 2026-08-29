import CoreBluetooth
import Foundation

setbuf(stdout, nil)

// BLE GATT session replay: connect AE40, subscribe AE42, write the logical
// unlock packets (from gatt_unlock.txt) to AE41 to unlock, then write a colour.

func le(_ v: Int, _ w: Int) -> [UInt8] { (0..<w).map { UInt8((v >> (8*$0)) & 0xFF) } }
func colorLogical(_ addr: Int, _ r: UInt8, _ g: UInt8, _ b: UInt8) -> [UInt8] {
    var d: [UInt8] = [0x05] + le(addr,4) + [0x03,0x00,0x00] + [r,g,b]
    let ck = UInt8((~d.map{Int($0)}.reduce(0,+)) & 0xFF)
    return [0x00,0x59,0x22] + le(d.count,3) + d + [ck]
}
func loadUnlock() -> [[UInt8]] {
    let t = (try? String(contentsOfFile: "gatt_unlock.txt", encoding: .utf8)) ?? ""
    return t.split(separator: "\n").map { $0.split(separator: " ").compactMap { UInt8($0, radix: 16) } }.filter { !$0.isEmpty }
}

final class T: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var c: CBCentralManager!; var pad: CBPeripheral?
    var w: CBCharacteristic?; var replies = 0
    var unlock = loadUnlock()
    func start() { c = CBCentralManager(delegate: self, queue: nil) }
    func centralManagerDidUpdateState(_ cm: CBCentralManager) {
        guard cm.state == .poweredOn else { print("ble state \(cm.state.rawValue)"); exit(2) }
        let known = cm.retrieveConnectedPeripherals(withServices: [CBUUID(string:"AE40")])
        if let p = known.first { pad = p; p.delegate = self; cm.connect(p); return }
        cm.scanForPeripherals(withServices: nil)
    }
    func centralManager(_ cm: CBCentralManager, didDiscover p: CBPeripheral, advertisementData: [String:Any], rssi: NSNumber) {
        if (p.name ?? "").contains("SMC-PAD") { pad = p; p.delegate = self; cm.stopScan(); cm.connect(p) }
    }
    func centralManager(_ cm: CBCentralManager, didConnect p: CBPeripheral) { print("connected"); p.discoverServices([CBUUID(string:"AE40")]) }
    func peripheral(_ p: CBPeripheral, didDiscoverServices e: Error?) { for s in p.services ?? [] { p.discoverCharacteristics(nil, for: s) } }
    func peripheral(_ p: CBPeripheral, didDiscoverCharacteristicsFor s: CBService, error: Error?) {
        for ch in s.characteristics ?? [] {
            if ch.uuid == CBUUID(string:"AE42") { p.setNotifyValue(true, for: ch) }
            if ch.uuid == CBUUID(string:"AE41") { w = ch }
        }
        if w != nil { DispatchQueue.main.asyncAfter(deadline: .now()+0.5) { self.runUnlock() } }
    }
    func peripheral(_ p: CBPeripheral, didUpdateValueFor ch: CBCharacteristic, error: Error?) { replies += 1 }
    func runUnlock() {
        guard let ch = w else { return }
        print("writing \(unlock.count) unlock packets to AE41...")
        var i = 0
        Timer.scheduledTimer(withTimeInterval: 0.06, repeats: true) { t in
            if i < self.unlock.count {
                self.pad?.writeValue(Data(self.unlock[i]), for: ch, type: .withoutResponse); i += 1
            } else {
                t.invalidate()
                print("unlock done, AE42 replies: \(self.replies)")
                let col = colorLogical(0x418, 255,255,255)
                self.pad?.writeValue(Data(col), for: ch, type: .withoutResponse)
                print("colour written to 0x418 white")
                DispatchQueue.main.asyncAfter(deadline: .now()+3) { exit(0) }
            }
        }
    }
}
let t = T(); t.start(); RunLoop.main.run()
