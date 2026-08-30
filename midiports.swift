import CoreMIDI
import Foundation

// Every MIDI source on this Mac, named the way QLC+ names it.
//
// QLC+ does not show the port name macOS shows. Its macOS enumerator asks for
// kMIDIPropertyModel first and only falls back to kMIDIPropertyDisplayName
// (plugins/midi/src/macx/coremidienumerator.cpp:65-91), which is why the
// workspace's input patch says "ble device" for a port the Audio MIDI Setup
// window calls "SMC-PAD Bluetooth". When a show opens with the pad dead, the
// first question is which of these lines the workspace is bound to - QLC+
// matches by UID, then by this name, then falls through to the saved line
// number, which is some other port entirely.
//
//   swift midiports.swift

func property(_ obj: MIDIObjectRef, _ key: CFString) -> String? {
    var value: Unmanaged<CFString>?
    guard MIDIObjectGetStringProperty(obj, key, &value) == noErr else { return nil }
    return value?.takeRetainedValue() as String?
}

func uid(_ obj: MIDIObjectRef) -> String {
    var value: Int32 = 0
    guard MIDIObjectGetIntegerProperty(obj, kMIDIPropertyUniqueID, &value) == noErr
    else { return "?" }
    return String(value)
}

print("line  QLC+ name                        UID          macOS display name")
for index in 0..<MIDIGetNumberOfSources() {
    let source = MIDIGetSource(index)
    let display = property(source, kMIDIPropertyDisplayName) ?? "?"
    let qlc = property(source, kMIDIPropertyModel) ?? display
    print(String(format: "%-5d %-32s %-12s %@",
                 index, (qlc as NSString).utf8String!,
                 (uid(source) as NSString).utf8String!, display))
}
