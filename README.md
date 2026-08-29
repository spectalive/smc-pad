# tools/smc-pad - the M-VAVE SMC-PAD, mapped and probed

The show is driven from an M-VAVE SMC-PAD (16 RGB pads, 8 encoders, 5 transport
buttons). These are the throwaway-but-kept Swift tools that mapped its MIDI and
reverse-engineered its LED protocol on 2026-08-29. Run any of them with
`swift <file>.swift`. They need macOS with CoreMIDI/CoreBluetooth access
granted to the terminal.

The narrative and the operating conclusions are in
[`../../docs/smc-pad-led.md`](../../docs/smc-pad-led.md); this file is the
reference for the tools and the wire protocol.

## The tools

| File | What it does |
| --- | --- |
| `midicap.swift` | Listen on every SMC-PAD CoreMIDI source and print each message decoded. This produced the input map in `QLC+ InputProfiles/M-VAVE-SMC-PAD.qxi`. |
| `midisend.swift` | Send one MIDI message (hex bytes as args) to the `SMC-PAD-Master` port. Used to prove notes/CC do **not** drive the LEDs. |
| `blescan.swift` | Scan BLE, connect to the pad, enumerate GATT services and characteristics. |
| `bletool.swift` | Connect over BLE (retrieving the bonded peripheral), subscribe to notify chars, and write packets to `AE41`. Each arg is a hex packet **without** checksum - the tool appends `(~sum)&0xFF`; prefix `raw:` to send verbatim. |

## The MIDI side (input - solved, shipped)

Over USB the pad is three CoreMIDI ports: `SMC-PAD-Master` (pads/knobs),
`SMC-PAD-Private` (config/firmware), `Puerto 3` (the 3.5mm MIDI out). Pads send
notes on MIDI channel 10 (top-left = lowest note 4, bottom row 16-19; SHIFT
adds 48), encoders CC 30-37 on channel 1, the five buttons CC 25-29 on
channel 1. QLC+ must run its MIDI input in omni ("1-16") mode. The full map is
`QLC+ InputProfiles/M-VAVE-SMC-PAD.qxi` and the generator wiring is
`tools/qlctool/qlctool/generate/smc_pad_bindings.py`.

## The LED side (output - protocol cracked, colour payload open)

The pad LEDs do **not** respond to MIDI. The official app `MidiSuite.apk`
(Flutter) drives them over **Bluetooth LE GATT**, decompiled with Blutter
(Dart 3.9.2, snapshot `97ff04a728735e6b6b098bdf983faaba`).

### GATT layout (verified live)

- Service `AE40`: characteristic `AE41` (writeWithoutResponse, commands in),
  `AE42` (notify, replies out). A second command service `AE00` has
  `AE01`/`AE02` in the same shape.
- Char `7772E5DB-3868-4112-A1A9-F2669D106BF3`: BLE-MIDI, the pad's button
  presses stream here (e.g. `80 80 99 16 7F` = BLE-MIDI header + NoteOn ch10).

### Packet framing (verified from the decompile)

```
[0xB2, type, ...payload, checksum]
  type:     0x44 write   0x46 read   0x22 name/version
  checksum: (~(sum of all preceding bytes)) & 0xFF
```

Only three packet builders exist (`makeWritePacket`, `makeReadPacket`,
`makeNameAndVerPacket` in `bluetooth_packet_tools.dart`) - there is **no
separate "LED mode" command**, so a colour write is an ordinary `0xB2 0x44`
packet. Worked examples the tool produces:
`B2 22 00 00 00 2B` (name/ver), `B2 46 10 00 00 F7` (read).

### Connecting from the Mac (verified)

1. The pad advertises only in Bluetooth pairing mode; once **bonded** it stops
   advertising - retrieve it with `retrieveConnectedPeripherals`, not a scan.
2. **Unplug USB.** With USB connected the pad routes MIDI over USB and the BLE
   side goes silent; BLE-only, presses arrive on the `7772E5DB` char.

### What is NOT solved

The colour path is `BleManager.sendColorData` -> `writeData(list, cmd)` ->
`makeWritePacket` = `[0xB2,0x44] + data + checksum`, where `sendColorData`
builds a 3-value list. Every guess for those three bytes (`[idx,a,b]`,
`[idx,r,g,b]`, a full 16-pad frame, values 0-127 and 0-255, on `AE41` and
`AE01`) left the pads dark - owner watching, confirmed. Reads drew no config
dump on `AE42`. So the exact bytes after `B2 44` are unresolved.

### The two ways to finish

1. **Capture one real colour packet.** Run MidiSuite (Android/iOS) against the
   pad, set a pad colour, and sniff the `AE41` write (nRF Sniffer, or Android
   HCI snoop log). That one packet decodes the format. Needs the app on a
   phone.
2. **Finish the reverse.** The Blutter output has the answer in
   `writeData`/`sendColorData`/`pad_widget.dart`; the blocker was matching the
   3 values to (pad, colour) without symbol names.

### Dead end checked

There is **no desktop editor for the SMC-PAD**. CubeSuite for macOS
(`m-vave.com` download) is a looper/guitar-pedal tool (firmware, IR, amp) and
does not know the pad; the pad's only editor is the mobile MidiSuite. So the
colour packet cannot be captured over USB from a Mac app.

## The bridge, once the packet is known

QLC+ cannot emit GATT and the pad ignores MIDI for LEDs, so a small macOS
daemon closes the gap: connect to the pad over BLE, subscribe to QLC+'s
note/CC feedback on a virtual MIDI port, and translate each event into the
`B2 44 ...` colour write. The pad stays a USB-MIDI input to QLC+ and a BLE LED
output at once.
