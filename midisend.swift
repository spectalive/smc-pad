import CoreMIDI
import Foundation

// Send test NoteOn messages to the SMC-PAD to probe LED feedback.
// Usage: swift midisend.swift <hex bytes...>  e.g. 99 04 7F

var client = MIDIClientRef()
MIDIClientCreate("qlc-send" as CFString, nil, nil, &client)
var outPort = MIDIPortRef()
MIDIOutputPortCreate(client, "out" as CFString, &outPort)

var dest = MIDIEndpointRef()
for i in 0..<MIDIGetNumberOfDestinations() {
    let d = MIDIGetDestination(i)
    var n: Unmanaged<CFString>?
    MIDIObjectGetStringProperty(d, kMIDIPropertyDisplayName, &n)
    let name = (n?.takeRetainedValue() as String?) ?? ""
    if name.contains("SMC-PAD-Master") { dest = d; print("DEST:", name) }
}
guard dest != 0 else { print("no SMC-PAD destination"); exit(1) }

let bytes = CommandLine.arguments.dropFirst().compactMap { UInt8($0, radix: 16) }
var packet = MIDIPacket()
packet.timeStamp = 0
packet.length = UInt16(bytes.count)
withUnsafeMutableBytes(of: &packet.data) { raw in
    for (i, b) in bytes.enumerated() { raw[i] = b }
}
var list = MIDIPacketList(numPackets: 1, packet: packet)
MIDISend(outPort, dest, &list)
usleep(200_000)
print("sent:", bytes.map { String(format: "%02X", $0) }.joined(separator: " "))
