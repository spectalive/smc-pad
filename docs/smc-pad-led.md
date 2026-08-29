# Lighting the SMC-PAD's pads from the show

The M-VAVE SMC-PAD has an RGB LED under every pad. The show would read better
if those LEDs showed what is currently running - AUTO green, a held flash
white, and so on. This document records what drives those LEDs, established by
test and by reverse-engineering the official app on 2026-08-29, and what a
bridge would have to do.

## Plain MIDI does not touch the LEDs

A full NoteOn sweep - all 128 notes on all 16 channels - plus CC messages, to
every one of the device's three CoreMIDI destinations (`SMC-PAD-Master`,
`SMC-PAD-Private`, `Puerto 3`), with the owner watching: no pad ever lit. The
sibling SMC-Mixer behaves the same (QLC+ forum thread 18301). So QLC+'s own
MIDI feedback, which is note/CC, can never light a pad. That is the whole
reason this is hard.

## The LEDs are a proprietary BLE GATT protocol, not MIDI

The official app is `MidiSuite.apk` (Flutter). Decompiling its `libapp.so`
with Blutter (Dart 3.9.2, snapshot `97ff04a728735e6b6b098bdf983faaba`) shows
the colour path plainly:

- `BleManager.sendColorData` builds a three-value list and calls
  `BleManager.writeData(list, cmd: 5)`.
- `writeData` hands the payload to `makeWritePacket`
  (`Utils/bluetooth_packet_tools.dart`), which frames it as
  `[0xB2, 0x44] + payload bytes` - each byte masked to 8 bits. No `F0..F7`; it
  is **not** SysEx.
- `writeData` then calls `BluetoothCharacteristic.write` from
  `flutter_blue_plus`. The transport is **Bluetooth LE GATT**, not MIDI.

The device's GATT layout, from the same binary:

- Service `0xAE40`
- Characteristics `0xAE41` and `0xAE42` (one write, one notify)

So a pad's colour is a GATT write to the `0xAE40` service, payload beginning
`B2 44`, command `5`, followed by the colour/position bytes. The exact byte
order after the header is not yet confirmed - `sendColorData`'s three values
still have to be matched to (pad, colour) or (r, g, b) against the real device.

A separate path exists over USB MIDI: the M-VAVE SysEx family
(`F0 00 32 45 ...`, manufacturer `00 32`) is answered on the `SMC-PAD-Private`
port - the discovery request drew a real 41-byte reply. That path is the
firmware/OTA and config channel (shared with the Chocolate pedal, see
github.com/cbix/mvave-chocolate-sysex); the app does not use it for colour.

## What a bridge would look like

QLC+ cannot emit GATT writes, and the pad does not light from MIDI, so the two
cannot be wired directly. A small macOS daemon would:

1. Connect to the pad over BLE (CoreBluetooth), service `0xAE40`. The Mac can
   be the BLE central directly - no phone or the official app needed. The pad
   must be in Bluetooth mode (its BT button) and advertising; on USB alone it
   does not advertise.
2. Subscribe to QLC+'s MIDI feedback on a virtual port (QLC+ *does* send
   note/CC feedback; that half already works, it just cannot reach the pad).
3. Translate each feedback event into the `B2 44 05 ...` colour packet and
   write it to characteristic `0xAE41`.

The pad would stay a USB-MIDI **input** to QLC+ and a BLE **output** from the
daemon at the same time.

## Status

Blocked on one physical step to finish the map: the pad has to be put in
Bluetooth mode so the Mac can connect and the colour packet can be confirmed
byte for byte against the lit pad. Until the bridge exists, the console's
state lives on the laptop screen and the pad is a blind trigger surface -
which is fine for the fixed-position hits and states it is mapped to.
