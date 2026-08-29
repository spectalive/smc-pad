import CoreMIDI
import Foundation

private let endpointName = "SINCO SMC-PAD-Private"
private let profileSize = 3_539
private let userDataSize = 28_312
private let readChunkSize = 1_009
private let requestTimeout: TimeInterval = 5

private struct Options {
    let dryRun: Bool
    let profile: Int
    let note: UInt8
    let red: UInt8
    let green: UInt8
    let blue: UInt8
}

private struct Request {
    let command: UInt8
    let region: UInt8?
    let address: Int?
    let length: Int?
    let logical: [UInt8]
}

private struct LogicalPacket {
    let command: UInt8
    let data: [UInt8]
}

private enum SessionError: Error, CustomStringConvertible {
    case usage(String)
    case failed(String)

    var description: String {
        switch self {
        case .usage(let message), .failed(let message): return message
        }
    }
}

private func parseInteger(_ text: String) throws -> Int {
    if text.lowercased().hasPrefix("0x"), let value = Int(text.dropFirst(2), radix: 16) {
        return value
    }
    if text.range(of: "[a-fA-F]", options: .regularExpression) != nil,
       let value = Int(text, radix: 16) {
        return value
    }
    if let value = Int(text, radix: 10) { return value }
    throw SessionError.usage("invalid integer: \(text)")
}

private func byte(_ name: String, _ value: Int) throws -> UInt8 {
    guard (0...255).contains(value) else {
        throw SessionError.usage("\(name) must be in 0...255")
    }
    return UInt8(value)
}

private func parseOptions() throws -> Options {
    var dryRun = false
    var profile = 0
    var positional: [String] = []
    var index = 1
    while index < CommandLine.arguments.count {
        let argument = CommandLine.arguments[index]
        if argument == "--dry-run" {
            dryRun = true
        } else if argument == "--profile" {
            index += 1
            guard index < CommandLine.arguments.count else {
                throw SessionError.usage("--profile requires a value")
            }
            profile = try parseInteger(CommandLine.arguments[index])
        } else {
            positional.append(argument)
        }
        index += 1
    }
    guard (0...7).contains(profile), positional.count == 4 else {
        throw SessionError.usage(
            "usage: swift session_write.swift [--dry-run] [--profile N] <pad_note> <r> <g> <b>"
        )
    }
    return Options(
        dryRun: dryRun,
        profile: profile,
        note: try byte("pad_note", parseInteger(positional[0])),
        red: try byte("r", parseInteger(positional[1])),
        green: try byte("g", parseInteger(positional[2])),
        blue: try byte("b", parseInteger(positional[3]))
    )
}

private func littleEndian(_ value: Int, width: Int) -> [UInt8] {
    (0..<width).map { UInt8((value >> (8 * $0)) & 0xFF) }
}

private func integer(_ bytes: ArraySlice<UInt8>) -> Int {
    bytes.enumerated().reduce(0) { $0 | (Int($1.element) << (8 * $1.offset)) }
}

private func checksum(_ data: [UInt8]) -> UInt8 {
    UInt8(truncatingIfNeeded: ~data.reduce(0) { $0 + Int($1) })
}

private func logicalPacket(command: UInt8, data: [UInt8]) -> [UInt8] {
    [0x00, 0x59, command] + littleEndian(data.count, width: 3) + data + [checksum(data)]
}

private func encodeSysEx(_ logical: [UInt8]) -> [UInt8] {
    var encoded: [UInt8] = [0xF0]
    var accumulator = 0
    var bitCount = 0
    for value in logical {
        accumulator |= Int(value) << bitCount
        bitCount += 8
        while bitCount >= 7 {
            encoded.append(UInt8(accumulator & 0x7F))
            accumulator >>= 7
            bitCount -= 7
        }
    }
    if bitCount > 0 { encoded.append(UInt8(accumulator & 0x7F)) }
    encoded.append(0xF7)
    return encoded
}

private func decodeSysEx(_ message: [UInt8]) throws -> [UInt8] {
    guard message.count >= 2, message.first == 0xF0, message.last == 0xF7 else {
        throw SessionError.failed("reply is not a complete SysEx frame")
    }
    var decoded: [UInt8] = []
    var accumulator = 0
    var bitCount = 0
    for value in message.dropFirst().dropLast() {
        guard value < 0x80 else { throw SessionError.failed("reply contains an invalid MIDI data byte") }
        accumulator |= Int(value) << bitCount
        bitCount += 7
        while bitCount >= 8 {
            decoded.append(UInt8(accumulator & 0xFF))
            accumulator >>= 8
            bitCount -= 8
        }
    }
    return decoded
}

private func parseLogical(_ logical: [UInt8]) throws -> LogicalPacket {
    guard logical.count >= 7, logical[0] == 0x00, logical[1] == 0x59 else {
        throw SessionError.failed("reply has an invalid 00 59 header")
    }
    let length = integer(logical[3...5])
    guard logical.count == length + 7 else {
        throw SessionError.failed("reply length field does not match its payload")
    }
    let data = Array(logical[6..<(6 + length)])
    guard logical.last == checksum(data) else {
        throw SessionError.failed("reply checksum mismatch")
    }
    return LogicalPacket(command: logical[2], data: data)
}

private func queryRequest() -> Request {
    Request(command: 0x11, region: nil, address: nil, length: nil,
            logical: logicalPacket(command: 0x11, data: []))
}

private func readRequest(region: UInt8, address: Int, length: Int) -> Request {
    let data = [region] + littleEndian(address, width: 4) + littleEndian(length, width: 3)
    return Request(command: 0x23, region: region, address: address, length: length,
                   logical: logicalPacket(command: 0x23, data: data))
}

private func handshakeRequests() -> [Request] {
    var requests = [queryRequest(), readRequest(region: 4, address: 0, length: 12)]
    var address = 0
    while address < userDataSize {
        let length = min(readChunkSize, userDataSize - address)
        requests.append(readRequest(region: 5, address: address, length: length))
        address += length
    }
    return requests
}

private func writeRequest(address: Int, options: Options) -> Request {
    let data: [UInt8] = [5] + littleEndian(address, width: 4) + littleEndian(3, width: 3)
        + [options.red, options.green, options.blue]
    return Request(command: 0x22, region: 5, address: address, length: 3,
                   logical: logicalPacket(command: 0x22, data: data))
}

private func hex(_ bytes: [UInt8]) -> String {
    bytes.map { String(format: "%02X", $0) }.joined(separator: " ")
}

private func flashURL() -> URL {
    let script = URL(fileURLWithPath: CommandLine.arguments[0]).standardizedFileURL
    return script.deletingLastPathComponent().appendingPathComponent("flash.bin")
}

private func resolveRGBAddress(options: Options) throws -> Int {
    let flash: [UInt8]
    do {
        flash = [UInt8](try Data(contentsOf: flashURL()))
    } catch {
        throw SessionError.failed("cannot read flash.bin beside session_write.swift: \(error)")
    }
    let start = options.profile * profileSize
    let end = min(start + profileSize, flash.count)
    guard start < end else { throw SessionError.failed("profile \(options.profile) is absent from flash.bin") }
    let prefix: [UInt8] = [0x09, options.note, 0x00, 0x7F]
    var matches: [Int] = []
    if end - start >= 8 {
        for offset in start...(end - 8) {
            if Array(flash[offset..<(offset + 4)]) == prefix, flash[offset + 7] == 0xFF {
                matches.append(offset + 4)
            }
        }
    }
    guard matches.count == 1, let address = matches.first else {
        throw SessionError.failed(
            "expected one profile-\(options.profile) record for note 0x\(String(format: "%02X", options.note)); found \(matches.count)"
        )
    }
    return address
}

private final class SysExInbox {
    private let condition = NSCondition()
    private var partial: [UInt8] = []
    private var frames: [[UInt8]] = []

    func accept(_ bytes: [UInt8]) {
        condition.lock()
        defer { condition.unlock() }
        for value in bytes {
            if value == 0xF0 { partial = [value] }
            else if !partial.isEmpty {
                partial.append(value)
                if value == 0xF7 {
                    frames.append(partial)
                    partial = []
                    condition.broadcast()
                }
            }
        }
    }

    func next(deadline: Date) -> [UInt8]? {
        condition.lock()
        defer { condition.unlock() }
        while frames.isEmpty {
            if !condition.wait(until: deadline) { return nil }
        }
        return frames.removeFirst()
    }
}

private func displayName(_ endpoint: MIDIEndpointRef) -> String? {
    var value: Unmanaged<CFString>?
    guard MIDIObjectGetStringProperty(endpoint, kMIDIPropertyDisplayName, &value) == noErr else { return nil }
    return value?.takeRetainedValue() as String?
}

private func exactSource() throws -> MIDIEndpointRef {
    for index in 0..<MIDIGetNumberOfSources() {
        let endpoint = MIDIGetSource(index)
        if displayName(endpoint) == endpointName { return endpoint }
    }
    throw SessionError.failed("CoreMIDI source not found with exact name '\(endpointName)'")
}

private func exactDestination() throws -> MIDIEndpointRef {
    for index in 0..<MIDIGetNumberOfDestinations() {
        let endpoint = MIDIGetDestination(index)
        if displayName(endpoint) == endpointName { return endpoint }
    }
    throw SessionError.failed("CoreMIDI destination not found with exact name '\(endpointName)'")
}

private final class MIDISession {
    private var client = MIDIClientRef()
    private var inputPort = MIDIPortRef()
    private var outputPort = MIDIPortRef()
    private let source: MIDIEndpointRef
    private let destination: MIDIEndpointRef
    private let inbox = SysExInbox()

    init() throws {
        source = try exactSource()
        destination = try exactDestination()
        guard MIDIClientCreate("SMC-PAD persistent session" as CFString, nil, nil, &client) == noErr else {
            throw SessionError.failed("MIDIClientCreate failed")
        }
        let inbox = self.inbox
        guard MIDIInputPortCreateWithBlock(client, "SMC-PAD replies" as CFString, &inputPort, { packetList, _ in
            var packet = packetList.pointee.packet
            for _ in 0..<packetList.pointee.numPackets {
                let bytes = withUnsafeBytes(of: packet.data) { Array($0.prefix(Int(packet.length))) }
                inbox.accept(bytes)
                packet = MIDIPacketNext(&packet).pointee
            }
        }) == noErr else {
            throw SessionError.failed("MIDIInputPortCreateWithBlock failed")
        }
        guard MIDIOutputPortCreate(client, "SMC-PAD requests" as CFString, &outputPort) == noErr else {
            throw SessionError.failed("MIDIOutputPortCreate failed")
        }
        guard MIDIPortConnectSource(inputPort, source, nil) == noErr else {
            throw SessionError.failed("MIDIPortConnectSource failed")
        }
    }

    deinit {
        if inputPort != 0 { MIDIPortDisconnectSource(inputPort, source) }
        if outputPort != 0 { MIDIPortDispose(outputPort) }
        if inputPort != 0 { MIDIPortDispose(inputPort) }
        if client != 0 { MIDIClientDispose(client) }
    }

    private func send(_ bytes: [UInt8]) throws {
        let storageSize = MemoryLayout<MIDIPacketList>.size + bytes.count
        let storage = UnsafeMutableRawPointer.allocate(byteCount: storageSize, alignment: MemoryLayout<MIDIPacketList>.alignment)
        defer { storage.deallocate() }
        let packetList = storage.bindMemory(to: MIDIPacketList.self, capacity: 1)
        let packet = MIDIPacketListInit(packetList)
        MIDIPacketListAdd(packetList, storageSize, packet, 0, bytes.count, bytes)
        guard MIDISend(outputPort, destination, packetList) == noErr else {
            throw SessionError.failed("MIDISend failed")
        }
    }

    func transact(_ request: Request, index: Int) throws {
        let wire = encodeSysEx(request.logical)
        print(String(format: "%02d SEND: %@", index, hex(wire)))
        try send(wire)
        guard let frame = inbox.next(deadline: Date().addingTimeInterval(requestTimeout)) else {
            throw SessionError.failed("request \(index) timed out waiting for a reply")
        }
        print(String(format: "%02d RECV: %@", index, hex(frame)))
        let reply = try parseLogical(decodeSysEx(frame))
        if request.command == 0x22 {
            guard reply.command == 0x00, reply.data.first == 0x00 else {
                throw SessionError.failed("write reply is not command 00 / status 00")
            }
            return
        }
        guard reply.command == request.command else {
            throw SessionError.failed("request \(index) expected command \(String(format: "%02X", request.command)), got \(String(format: "%02X", reply.command))")
        }
        if request.command == 0x23 {
            guard reply.data.count >= 8,
                  reply.data[0] == request.region,
                  integer(reply.data[1...4]) == request.address,
                  integer(reply.data[5...7]) == request.length,
                  reply.data.count == 8 + (request.length ?? -1) else {
                throw SessionError.failed("read reply metadata does not match request \(index)")
            }
        }
    }
}

private func run() throws {
    let options = try parseOptions()
    let address = try resolveRGBAddress(options: options)
    let requests = handshakeRequests() + [writeRequest(address: address, options: options)]
    print(String(format: "resolved profile %d note 0x%02X RGB address: 0x%X", options.profile, options.note, address))
    for (offset, request) in requests.enumerated() {
        print(String(format: "%02d logical: %@", offset + 1, hex(request.logical)))
        print(String(format: "%02d usb:     %@", offset + 1, hex(encodeSysEx(request.logical))))
    }
    if options.dryRun {
        print("dry run: CoreMIDI was not opened and no bytes were sent")
        return
    }
    let session = try MIDISession()
    for (offset, request) in requests.enumerated() {
        try session.transact(request, index: offset + 1)
    }
    print("write accepted; retaining the same CoreMIDI session for 5 seconds")
    RunLoop.current.run(until: Date().addingTimeInterval(5))
}

do {
    try run()
} catch {
    fputs("error: \(error)\n", stderr)
    exit(1)
}
