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
`SMC-PAD-Private` (config/firmware), `Puerto 3` (the 3.5mm MIDI out); over
Bluetooth it is a fourth, `SMC-PAD Bluetooth`, carrying the same messages.

Measured 2026-08-29 with `midicap.swift`, owner pressing:

- Pads send notes on **MIDI channel 10**, numbered as the panel is printed:
  PAD1 bottom-left, PAD13 top-left. Within a bank the note is **35 + pad**
  (PAD1 = 36, PAD13 = 48, PAD16 = 51).
- **PAD BANK** moves the whole surface up one bank of 16 notes - PAD1 answered
  52 - and the pad *remembers* which bank it is on across power cycles. The
  show uses two: the hits on bank 1, the console's manual page on bank 2.
- **SHIFT sends nothing.** It picks the functions silkscreened on the pads
  (SWING, LATCH, SYNC, TAP TEMPO), which never leave the device. Nothing on a
  console can be bound to it.
- `<` and `>` send CC 25/26 and do **not** change the bank, so they are safe as
  console page arrows. The other three edge buttons are CC 27/28/29.
- Encoders send CC 30-37 absolute, on channel 1.

QLC+ must run its MIDI input in omni ("1-16") mode, or it never ORs the MIDI
channel into the channel number and every pad binding addresses the wrong
control. The map lives in
`tools/qlctool/qlctool/generate/smc_pad_device.py`; the bindings
(`smc_pad_bindings.py`) and the profile `QLC+ InputProfiles/M-VAVE-SMC-PAD.qxi`
are both derived from it - regenerate the profile with
`qlctool input-profile`, never by hand.

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

### The colour ENCODING - solved (2026-08-29)

The real desktop editor is **MidiSuite for macOS** (`MidiSuite_new.dmg` on
`m-vave.com`, a Flutter app with `flutter_midi_command` + `universal_ble`; the
earlier CubeSuite is a looper tool and does not know the pad). Its
"Export preset (.spc)" writes the pad config to a file; `reference/preset4.spc`
is a captured export and `reference/decode_preset.py` parses it. Each pad's
colour is one record:

```
09 <id> 00 7F <R> <G> <B> FF
  id    = pad MIDI note (bank A 0x04-0x13, bank B 0x14-0x23)
  R,G,B = full 8-bit channels 0-255   (F0 F0 00 yellow, F0 00 F0 magenta)
```

Confirmed against the editor's on-screen colours (the displayed yellow pads and
the magenta pad 16 matched `F0F000` / `F000F0` in the file byte-for-byte). So
the colour model is plain per-pad 24-bit RGB, keyed by note number.

### What is still NOT solved: applying it live

The physical LEDs work (the pad shows the app's colours), but nothing this repo
sends makes them change:

- The desktop app drives the LEDs over **USB** as M-VAVE SysEx
  (`F0 00 32 ...`), via `flutter_midi_command`. CoreMIDI capture only sees the
  pad->Mac direction, so the app's outgoing colour SysEx was not captured.
- Raw writes of the `09 id 00 7F RGB FF` record to BLE `AE41` (and `AE01`),
  with and without the `B2 44` frame, with USB plugged and unplugged, app open
  and closed - all left the LEDs unchanged (owner confirmed).

The likely reason is the codec: SysEx data bytes must be < 0x80, but the RGB
channels are 8-bit (0xF0, 0xFF...), so the app's `core/usb/sysex_codec.dart`
**7-bit re-encodes** the payload before sending. The exact wire bytes need that
codec.

### The wire protocol - solved (2026-08-29, via Codex)

The macOS App snapshot (Dart 3.12.2) WAS decompiled, with Blutter's Mach-O
branch (PR 204) patched for a macOS target. The decompiled
`core/usb/sysex_codec.dart`, `midi_transport.dart`, `usb_connect.dart` are in
`reference/mac-decompile/`. From them the full wire format is known and, where
checkable, validated against real captured packets:

- **Logical packet**: `00 59 <cmd> <len24-le> <data...> <checksum>`, where
  `checksum = (~sum(data)) & 0xFF`. (An earlier pass read the constant as
  `0xB2`; decoding the pad's real status and OK packets proved it is `0x59` -
  `toMidi([00,59,...])` reproduces the device's real `F0 00 32 ...` header.)
- **USB transport**: `SysexCodec.toMidi` bit-packs that whole logical packet
  LSB-first into 7-bit bytes between `F0` and `F7`. Round-trips exactly against
  the captured status frame `F0 00 32 0D 21 ...` and the OK frame
  `F0 00 32 01 08 ... F7` (regression-tested in `reference/test_color_cmd.py`).
- **Colour write**: `_wColor` -> `_write(5, address, [R,G,B])` ->
  `flashWrite`, giving data `05 <address-le32> 03 00 00 R G B`. No handshake
  precedes it; no separate mode packet exists in the code.
- **BLE**: `makeWritePacket` emits the same logical packet raw to `AE41`
  (no 7-bit transform).

`reference/color_cmd.py` generates both wire forms for any `(pad, r, g, b)`.

### SOLVED (2026-08-29): writes need the app's full connect session first

The LEDs now change from our own code. The missing piece was not the bytes -
it was the **session**. A one-shot colour write is ignored; the pad only
accepts writes after a client has replayed the desktop app's whole connect
handshake on that same MIDI connection. Captured from the official app with
MIDI Monitor's output spy (`reference/captura.mmon`), the unlock is:

1. Discovery: `F0 00 32 45 00 00 00 40 7F F7`.
2. **Read the entire config**: a run of `F0 00 32 0D 41 ...` read requests with
   incrementing 32-bit addresses (0x000, 0x771, 0xF62, 0x1753, ...), each
   answered by a `0D 49` config chunk. Reading the whole config is what unlocks
   writes.
3. Then the colour write `F0 00 32 09 59 ...` is accepted and the LED changes
   instantly; the pad replies `F0 00 32 01 08 ... F7` (OK).
4. Keep the connection alive with the `0D 41` poll (~2/s).

`replay.swift` does exactly this: it replays the captured unlock frames
(`reference/replay_frames.txt`), then writes a colour, then polls. Confirmed
live - a pad changed colour the instant the write landed. Run:
`swift replay.swift <flash-address> <r> <g> <b>` (e.g. `... 1048 0 0 255` sets
address 0x418 blue).

### Bluetooth (wireless) LED feedback also works - via GATT

The desktop app configures only over USB, and the pad's BT-MIDI CoreMIDI
endpoint does NOT carry the config/colour protocol (a MIDI session replay to it
draws zero replies). But over Bluetooth the colour path is **GATT**, exactly as
the Android app uses it: service `AE40`, write to `AE41`, notify on `AE42`. The
same session unlock applies - write the logical unlock packets (the USB unlock
frames decoded back to logical `00 59 ...` form, `reference/gatt_unlock.txt`) to
`AE41`, and the pad answers on `AE42`; then write the colour logical packet
`00 59 22 <len24> 05 <addr32> 03 00 00 R G B <cksum>` to `AE41`.

`gatt_replay.swift` does this and was confirmed live: the unlock drew 109 `AE42`
replies and a pad turned white over Bluetooth. So the LED feedback can be fully
wireless - the pad is a QLC+ input over BT-MIDI and an LED output over BT-GATT
at the same time, no cable.

### The QLC+ bridge (working)

`qlc_led_bridge.swift` is the daemon that makes the feedback real. Run it from
this directory (it reads `reference/gatt_unlock.txt`):

```bash
swift qlc_led_bridge.swift
```

It does two things: holds the pad's LED session over BLE GATT (replays the
unlock, then keeps the session alive), and publishes a virtual CoreMIDI
destination **"SMC-PAD LED Bridge"**. In QLC+, Inputs/Outputs tab, on the universe the pad is patched to, add
`SMC-PAD LED Bridge` and — this is the part the UI makes easy to miss — make it
the universe's **Feedback** patch, not just an Output. QLC+ only sends widget
feedback if a `<Feedback>` patch exists; the on-screen "eye" toggle did not
reliably create one here, so the reliable fix is to add it in the saved `.qxw`:

```xml
<Universe Name="Universe 1" ID="0">
  <Input Plugin="MIDI" Name="ble device" Line="3"><PluginParameters midichannel="16"/></Input>
  <Output Plugin="DMX USB" Name="FT232R USB UART (...)" Line="0"/>
  <Feedback Plugin="MIDI" Name="SMC-PAD LED Bridge" Line="N"/>
</Universe>
```

(`Line` is the plugin's output line for the bridge on this machine; copy it
from the `<Output ... Name="SMC-PAD LED Bridge">` line QLC+ writes when you add
it.) Then reload the workspace. Now when a Virtual Console widget becomes
active QLC+ sends the widget's note to the bridge and the matching pad lights.
Confirmed working end to end (the bridge logs `MIDI in ... -> pad addr ...` and
the pad changes).

Two gotchas that cost time: the bridge output's **MIDI Channel must be omni
("1-16")** so QLC+ feedback carries the pad's real channel, and the bridge's
CoreMIDI endpoint is recreated on every restart — if you restart the daemon,
re-select it in QLC+ (or reload the workspace).

Verified end to end: a NoteOn to the virtual port paints the pad over Bluetooth
(`swift midisend2.swift "SMC-PAD LED Bridge" 90 10 7F` lit pad 1 white). The
note->pad->flash-address map is in the daemon: pad N's colour is at
`0x418 + (N-1)*26`, and bank-A pad notes 4-19 map to pads 13-16 / 9-12 / 5-8 /
1-4. Default colours are white when active, off when inactive - edit `ON_COLOR`
/ `OFF_COLOR` (or add a per-note colour table) for a show palette.

### The remaining tidy-up (not blockers)

Every derived colour command was sent (USB SysEx to the pad's CoreMIDI
destination - the same `MIDISend` path `flutter_midi_command` uses - and raw to
BLE `AE41`), app open and closed, owner watching: the LED never changed, even
though the desktop app changes it instantly over the same CoreMIDI transport.

The remaining unknown is the **address** in `_write(5, address, rgb)`.
`color_cmd.py` computes it as `profile*3539 + 211 + pad_index*26 + 5` - but
3539 is the `.spc` **file** size, so that is a file offset, not the device
flash address. In the app the address is a field on the pad object, loaded
from the device's own config at connect. The real per-pad addresses therefore
live in the config the pad streams on connect (`appcolor.log` has that stream:
48-byte records like `48 10 07 40 3F ...`); they must be decoded from there, or
captured from the app's actual write with a CoreMIDI output spy (snoize
MIDISpy - its driver would not load unapproved on Apple Silicon in this
session).

With the correct address the colour command is complete and the bridge sends
it over USB - no BLE, the pad stays a QLC+ input and an LED output on one cable.

## The bridge, once the packet is known

QLC+ cannot emit GATT and the pad ignores MIDI for LEDs, so a small macOS
daemon closes the gap: connect to the pad over BLE, subscribe to QLC+'s
note/CC feedback on a virtual MIDI port, and translate each event into the
`B2 44 ...` colour write. The pad stays a USB-MIDI input to QLC+ and a BLE LED
output at once.
