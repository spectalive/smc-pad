import CoreMIDI
import Foundation

// Capture every MIDI message from all SINCO SMC-PAD ports, decoded, one line each.

func name(of obj: MIDIObjectRef) -> String {
    var n: Unmanaged<CFString>?
    MIDIObjectGetStringProperty(obj, kMIDIPropertyDisplayName, &n)
    return (n?.takeRetainedValue() as String?) ?? "?"
}

func decode(_ b: [UInt8]) -> String {
    guard let st = b.first else { return "" }
    let ch = (st & 0x0F) + 1
    switch st & 0xF0 {
    case 0x90: return b.count > 2 ? (b[2] == 0 ? "NoteOff ch\(ch) note\(b[1])" : "NoteOn  ch\(ch) note\(b[1]) vel\(b[2])") : "NoteOn?"
    case 0x80: return b.count > 2 ? "NoteOff ch\(ch) note\(b[1])" : "NoteOff?"
    case 0xB0: return b.count > 2 ? "CC      ch\(ch) cc\(b[1]) val\(b[2])" : "CC?"
    case 0xA0: return b.count > 2 ? "PolyAT  ch\(ch) note\(b[1]) val\(b[2])" : "AT?"
    case 0xD0: return b.count > 1 ? "ChanAT  ch\(ch) val\(b[1])" : "AT?"
    case 0xE0: return b.count > 2 ? "Pitch   ch\(ch) \(Int(b[1]) | Int(b[2]) << 7)" : "PB?"
    case 0xC0: return b.count > 1 ? "Program ch\(ch) pgm\(b[1])" : "PC?"
    case 0xF0: return "System \(b.map { String(format: "%02X", $0) }.joined(separator: " "))"
    default: return "Raw \(b.map { String(format: "%02X", $0) }.joined(separator: " "))"
    }
}

setbuf(stdout, nil)
var client = MIDIClientRef()
MIDIClientCreate("qlc-capture" as CFString, nil, nil, &client)
var port = MIDIPortRef()

MIDIInputPortCreateWithBlock(client, "in" as CFString, &port) { pktListPtr, srcRefCon in
    let src = srcRefCon.map { Unmanaged<NSString>.fromOpaque($0).takeUnretainedValue() as String } ?? "?"
    let pktList = pktListPtr.pointee
    var packet = pktList.packet
    for _ in 0..<pktList.numPackets {
        let raw = Mirror(reflecting: packet.data).children.prefix(Int(packet.length)).compactMap { $0.value as? UInt8 }
        // A packet may hold several status-led messages back to back; split on status bytes.
        var msgs: [[UInt8]] = []
        for byte in raw {
            if byte >= 0x80 { msgs.append([byte]) } else if !msgs.isEmpty { msgs[msgs.count - 1].append(byte) }
        }
        for m in msgs {
            print("[\(src)] \(decode(m))  (\(m.map { String(format: "%02X", $0) }.joined(separator: " ")))")
        }
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
