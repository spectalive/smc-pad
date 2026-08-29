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

## Live BLE session, 2026-08-29 (what worked and what did not)

Connected to the pad from the Mac over BLE with a CoreBluetooth tool
(`bletool.swift` in scratch), no phone or app. Confirmed against the real
device:

- The pad advertises in Bluetooth pairing mode; once **bonded** it stops
  advertising and must be retrieved with
  `retrieveConnectedPeripherals(withServices:[AE40])`, not a scan.
- **USB must be unplugged.** With USB connected the pad routes its MIDI over
  USB and the BLE side is silent. BLE-only, the pad streams its button presses
  as BLE-MIDI on characteristic `7772E5DB-3868-4112-A1A9-F2669D106BF3`
  (e.g. a press = `80 80 99 16 7F`, NoteOn ch10). So the return channel is
  proven live - the transport works both ways.
- Writes to `AE41` are accepted with no error. Packet framing verified from
  the decompile: `[0xB2, type] + payload + checksum`, where type is `0x44`
  write / `0x46` read / `0x22` name-version, and
  `checksum = (~sum_of_preceding_bytes) & 0xFF`. There are only these three
  packet builders - **no separate "mode" command**, so the app's colour write
  is the same `0xB2 0x44` write this tool sends.

**Still unsolved: the colour payload.** Every `B2 44 ...` colour guess tried
(3-byte `[idx, a, b]`, 4-byte `[idx, r, g, b]`, a full 16-pad frame, values
0-127 and 0-255, on both `AE41` and `AE01`) left the pads dark - owner
watching, confirmed "no". Config-read requests (`B2 46 ...`) drew no dump on
`AE42`. So the exact bytes after `B2 44` are wrong, and the meaning of
`sendColorData`'s three values (buried in `writeData`'s multi-arg assembly and
un-named object fields in the Dart AOT snapshot) is not yet decoded.

## Status and the honest next step

The transport is fully cracked and reachable; the colour encoding is not. The
two reliable ways to close it, in order of certainty:

1. **Capture one real colour packet.** Run MidiSuite (Android/iOS) against the
   pad and sniff the `AE41` write when a pad colour is set - that one packet
   decodes the whole format. Needs the app on a phone; a BLE sniffer (nRF
   Sniffer, or Android's HCI snoop log) reads it.
2. **Finish reversing `writeData` + `sendColorData`** in the Blutter output
   (`out_blutter/asm/musical_instruments/`) to derive the three payload bytes
   analytically. Slower and less certain without symbol names.

Until then the console's state lives on the laptop screen and the pad is a
blind trigger surface - fine for the fixed-position hits and states it is
mapped to. The bridge daemon design above still holds; it only needs the
confirmed colour packet to be written.
