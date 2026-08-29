import CoreMIDI
import Foundation

setbuf(stdout, nil)

// Absolute session replay: send the app's captured connect sequence (discovery
// + full config read) to unlock writes, then inject a colour write, then keep
// polling. Unlock frames come from replay_frames.txt (one "F0 .. F7" per line).

func loadFrames() -> [[UInt8]] {
    let text = (try? String(contentsOfFile: "replay_frames.txt", encoding: .utf8)) ?? ""
    return text.split(separator: "\n").map { line in
        line.split(separator: " ").compactMap { UInt8($0, radix: 16) }
    }.filter { !$0.isEmpty }
}
func toMidi(_ data: [UInt8]) -> [UInt8] {
    var enc: [UInt8] = [0xF0]; var acc = 0; var bits = 0
    for x in data { acc |= Int(x) << bits; bits += 8
        while bits >= 7 { enc.append(UInt8(acc & 0x7F)); acc >>= 7; bits -= 7 } }
    if bits > 0 { enc.append(UInt8(acc & 0x7F)) }
    enc.append(0xF7); return enc
}
func le(_ v: Int, _ w: Int) -> [UInt8] { (0..<w).map { UInt8((v >> (8*$0)) & 0xFF) } }
let a = CommandLine.arguments.dropFirst().compactMap { Int($0) }
let addr = a.count > 0 ? a[0] : 0x418
let r = UInt8(a.count>1 ? a[1]:255), g = UInt8(a.count>2 ? a[2]:0), b = UInt8(a.count>3 ? a[3]:0)
var wd: [UInt8] = [0x05]+le(addr,4)+[0x03,0x00,0x00]+[r,g,b]
let ck = UInt8((~wd.map{Int($0)}.reduce(0,+)) & 0xFF)
let colorMsg = toMidi([0x00,0x59,0x22]+le(wd.count,3)+wd+[ck])
let POLL: [UInt8] = [0xF0,0x00,0x32,0x0D,0x41,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x00,0x40,0x01,0x00,0x00,0x6F,0x01,0xF7]

var frames = loadFrames()
// drop the trailing captured colour write (the black one) if present
if let last = frames.last, last.count>4, last[3]==0x09 { frames.removeLast() }

var client = MIDIClientRef(); MIDIClientCreate("replay" as CFString, nil, nil, &client)
var outPort = MIDIPortRef(); MIDIOutputPortCreate(client, "out" as CFString, &outPort)
var inPort = MIDIPortRef()
var dest = MIDIEndpointRef(); var src = MIDIEndpointRef()
for i in 0..<MIDIGetNumberOfDestinations() {
    let d = MIDIGetDestination(i); var n: Unmanaged<CFString>?
    MIDIObjectGetStringProperty(d, kMIDIPropertyDisplayName, &n)
    if ((n?.takeRetainedValue() as String?) ?? "").contains("SMC-PAD-Private") { dest = d }
}
for i in 0..<MIDIGetNumberOfSources() {
    let s = MIDIGetSource(i); var n: Unmanaged<CFString>?
    MIDIObjectGetStringProperty(s, kMIDIPropertyDisplayName, &n)
    if ((n?.takeRetainedValue() as String?) ?? "").contains("SMC-PAD-Private") { src = s }
}
guard dest != 0 else { print("no dest"); exit(1) }
var replyCount = 0
MIDIInputPortCreateWithBlock(client, "in" as CFString, &inPort) { pl, _ in replyCount += 1 }
MIDIPortConnectSource(inPort, src, nil)

func send(_ bytes: [UInt8]) {
    var pkt = MIDIPacket(); pkt.timeStamp = 0; pkt.length = UInt16(bytes.count)
    withUnsafeMutableBytes(of: &pkt.data) { raw in for (i,v) in bytes.enumerated() where i < 256 { raw[i]=v } }
    var list = MIDIPacketList(numPackets: 1, packet: pkt)
    MIDISend(outPort, dest, &list)
}

print("replaying \(frames.count) unlock frames...")
for f in frames { send(f); usleep(40_000) }
print("unlock done (\(replyCount) replies). injecting colour write to 0x\(String(addr,radix:16))")
usleep(200_000)
send(colorMsg); usleep(150_000); send(colorMsg)
print("colour sent. keeping session alive with polls...")
var ticks = 0
Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in
    send(POLL); ticks += 1
    if ticks == 4 { send(colorMsg) }
    if ticks > 24 { print("done"); exit(0) }
}
RunLoop.main.run()
