import CoreBluetooth
import Foundation

// Scan for the SMC-PAD's BLE service AE40, connect, enumerate characteristics.

setbuf(stdout, nil)

let TARGET = CBUUID(string: "AE40")

final class Scanner: NSObject, CBCentralManagerDelegate, CBPeripheralDelegate {
    var central: CBCentralManager!
    var pad: CBPeripheral?

    func start() { central = CBCentralManager(delegate: self, queue: nil) }

    func centralManagerDidUpdateState(_ c: CBCentralManager) {
        switch c.state {
        case .poweredOn:
            print("BLE on - scanning for AE40 and any named SMC/SINCO...")
            c.scanForPeripherals(withServices: nil, options: [CBCentralManagerScanOptionAllowDuplicatesKey: false])
        case .unauthorized: print("BLE UNAUTHORIZED - grant Bluetooth to the terminal in System Settings > Privacy"); exit(2)
        default: print("BLE state: \(c.state.rawValue)")
        }
    }

    func centralManager(_ c: CBCentralManager, didDiscover p: CBPeripheral,
                        advertisementData: [String: Any], rssi: NSNumber) {
        let name = p.name ?? (advertisementData[CBAdvertisementDataLocalNameKey] as? String) ?? ""
        let svcs = advertisementData[CBAdvertisementDataServiceUUIDsKey] as? [CBUUID] ?? []
        let hit = name.uppercased().contains("SMC") || name.uppercased().contains("SINCO")
            || name.uppercased().contains("PAD") || svcs.contains(TARGET)
        if hit || !name.isEmpty {
            print("found: '\(name)' rssi \(rssi) services \(svcs) \(hit ? "<-- CANDIDATE" : "")")
        }
        if hit {
            pad = p; p.delegate = self
            c.stopScan()
            print("connecting to '\(name)'...")
            c.connect(p, options: nil)
        }
    }

    func centralManager(_ c: CBCentralManager, didConnect p: CBPeripheral) {
        print("CONNECTED. discovering services...")
        p.discoverServices(nil)
    }

    func peripheral(_ p: CBPeripheral, didDiscoverServices error: Error?) {
        for s in p.services ?? [] {
            print("service \(s.uuid)")
            p.discoverCharacteristics(nil, for: s)
        }
    }

    func peripheral(_ p: CBPeripheral, didDiscoverCharacteristicsFor s: CBService, error: Error?) {
        for ch in s.characteristics ?? [] {
            print("  char \(ch.uuid) props \(ch.properties.rawValue) [\(propsDesc(ch.properties))]")
        }
    }

    func propsDesc(_ p: CBCharacteristicProperties) -> String {
        var out: [String] = []
        if p.contains(.read) { out.append("read") }
        if p.contains(.write) { out.append("write") }
        if p.contains(.writeWithoutResponse) { out.append("writeNR") }
        if p.contains(.notify) { out.append("notify") }
        return out.joined(separator: ",")
    }
}

let s = Scanner()
s.start()
RunLoop.main.run()
