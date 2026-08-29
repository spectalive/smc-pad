import CoreMIDI
import Foundation

// Robust raw dumper: print every MIDI packet's exact bytes, no decoding.

setbuf(stdout, nil)

func name(of obj: MIDIObjectRef) -> String {
    var n: Unmanaged<CFString>?
    MIDIObjectGetStringProperty(obj, kMIDIPropertyDisplayName, &n)
    return (n?.takeRetainedValue() as String?) ?? "?"
}

var client = MIDIClientRef()
MIDIClientCreate("rawcap" as CFString, nil, nil, &client)
var port = MIDIPortRef()

MIDIInputPortCreateWithBlock(client, "in" as CFString, &port) { pktListPtr, srcRefCon in
    let src = srcRefCon.map { Unmanaged<NSString>.fromOpaque($0).takeUnretainedValue() as String } ?? "?"
    var packet = pktListPtr.pointee.packet
    for _ in 0..<pktListPtr.pointee.numPackets {
        let len = Int(packet.length)
        var bytes = [UInt8](repeating: 0, count: len)
        withUnsafeBytes(of: packet.data) { raw in
            for i in 0..<min(len, 256) { bytes[i] = raw[i] }
        }
        let hex = bytes.map { String(format: "%02X", $0) }.joined(separator: " ")
        print("[\(src)] \(hex)")
        packet = MIDIPacketNext(&packet).pointee
    }
}

for i in 0..<MIDIGetNumberOfSources() {
    let s = MIDIGetSource(i)
    let n = name(of: s)
    guard n.contains("SMC-PAD") || n.contains("SINCO") || n.contains("Puerto") else { continue }
    let box = Unmanaged.passRetained(n as NSString).toOpaque()
    MIDIPortConnectSource(port, s, box)
    print("LISTENING: \(n)")
}
RunLoop.main.run()
