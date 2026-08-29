import CoreMIDI
import Foundation

setbuf(stdout, nil)

// Rainbow across the 16 bank-A pads: unlock the session (replay the captured
// connect handshake), then write 16 hues to flash addresses base+n*26, then
// keep the session alive so the colours stay.

let BASE = 0x418
let STRIDE = 0x1A

func loadFrames() -> [[UInt8]] {
    let text = (try? String(contentsOfFile: "replay_frames.txt", encoding: .utf8)) ?? ""
    return text.split(separator: "\n").map { $0.split(separator: " ").compactMap { UInt8($0, radix: 16) } }.filter { !$0.isEmpty }
}
func toMidi(_ data: [UInt8]) -> [UInt8] {
    var enc: [UInt8] = [0xF0]; var acc = 0; var bits = 0
    for x in data { acc |= Int(x) << bits; bits += 8
        while bits >= 7 { enc.append(UInt8(acc & 0x7F)); acc >>= 7; bits -= 7 } }
    if bits > 0 { enc.append(UInt8(acc & 0x7F)) }
    enc.append(0xF7); return enc
}
func le(_ v: Int, _ w: Int) -> [UInt8] { (0..<w).map { UInt8((v >> (8*$0)) & 0xFF) } }
func hsv(_ h: Double) -> (UInt8, UInt8, UInt8) {
    let c = 1.0, x = 1.0 - abs((h/60.0).truncatingRemainder(dividingBy: 2) - 1)
    let (r,g,b): (Double,Double,Double)
    switch h {
    case ..<60: (r,g,b) = (c,x,0)
    case ..<120: (r,g,b) = (x,c,0)
    case ..<180: (r,g,b) = (0,c,x)
    case ..<240: (r,g,b) = (0,x,c)
    case ..<300: (r,g,b) = (x,0,c)
    default: (r,g,b) = (c,0,x)
    }
    return (UInt8(r*240), UInt8(g*240), UInt8(b*240))
}
func colorMsg(_ addr: Int, _ r: UInt8, _ g: UInt8, _ b: UInt8) -> [UInt8] {
    var d: [UInt8] = [0x05] + le(addr,4) + [0x03,0x00,0x00] + [r,g,b]
    let ck = UInt8((~d.map{Int($0)}.reduce(0,+)) & 0xFF)
    return toMidi([0x00,0x59,0x22] + le(d.count,3) + d + [ck])
}
let POLL: [UInt8] = [0xF0,0x00,0x32,0x0D,0x41,0x00,0x00,0x00,0x02,0x00,0x00,0x00,0x00,0x40,0x01,0x00,0x00,0x6F,0x01,0xF7]

var client = MIDIClientRef(); MIDIClientCreate("rainbow" as CFString, nil, nil, &client)
var outPort = MIDIPortRef(); MIDIOutputPortCreate(client, "out" as CFString, &outPort)
var dest = MIDIEndpointRef()
for i in 0..<MIDIGetNumberOfDestinations() {
    let d = MIDIGetDestination(i); var n: Unmanaged<CFString>?
    MIDIObjectGetStringProperty(d, kMIDIPropertyDisplayName, &n)
    if ((n?.takeRetainedValue() as String?) ?? "").contains("SMC-PAD-Private") { dest = d }
}
guard dest != 0 else { print("no dest"); exit(1) }
func send(_ bytes: [UInt8]) {
    var pkt = MIDIPacket(); pkt.timeStamp = 0; pkt.length = UInt16(bytes.count)
    withUnsafeMutableBytes(of: &pkt.data) { raw in for (i,v) in bytes.enumerated() where i < 256 { raw[i]=v } }
    var list = MIDIPacketList(numPackets: 1, packet: pkt)
    MIDISend(outPort, dest, &list)
}

var frames = loadFrames()
if let last = frames.last, last.count>4, last[3]==0x09 { frames.removeLast() }
print("unlocking (\(frames.count) frames)...")
for f in frames { send(f); usleep(35_000) }
usleep(200_000)
print("painting rainbow across 16 pads...")
for n in 0..<16 {
    let (r,g,b) = hsv(Double(n) * 360.0 / 16.0)
    send(colorMsg(BASE + n*STRIDE, r, g, b))
    usleep(60_000)
}
print("rainbow up. holding session (Ctrl-C to stop)...")
Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true) { _ in send(POLL) }
RunLoop.main.run()
