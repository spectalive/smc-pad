# Lighting the SMC-PAD's pads from the show

The M-VAVE SMC-PAD has an RGB LED under every pad, and the show now uses them:
each pad wears its function's colour, dimmed while the function is idle and
full-bright the instant QLC+ reports it active. This document is the narrative -
how the protocol was found, what it turned out to be, and the dead ends worth
not repeating. The wire reference and the tools are in
[`../tools/smc-pad/`](../tools/smc-pad/).

Established by test and by reverse-engineering the official app on 2026-08-29.

## What it does today

`tools/smc-pad/qlc_led_bridge.swift` is a small macOS daemon that holds the
pad's LED session over Bluetooth LE and publishes a virtual CoreMIDI
destination, **"SMC-PAD LED Bridge"**. QLC+ sends its ordinary widget feedback
to that port; the bridge turns each note into a colour write on the pad. Install
it once with `tools/smc-pad/install-bridge.sh` and a launchd agent starts it at
login and restarts it if it dies.

The palette is one RGB per master function, in
`tools/qlctool/qlctool/generate/smc_pad_colors.py`, and the generated console
paints each button the same colour - the pad and the screen read as one surface.

Two things the operator has to know, both in
[`show-operation.md`](show-operation.md): the universe needs a **`<Feedback>`**
patch, not only an Output (QLC+'s eye toggle does not reliably create one, so it
ships in the `.qxw`), and the workspace must be loaded **after** the bridge,
because the virtual MIDI endpoint gets a new identity on every restart.

## Why it took a day: plain MIDI does not touch the LEDs

A full NoteOn sweep - all 128 notes on all 16 channels - plus CC messages, to
every one of the device's three CoreMIDI destinations (`SMC-PAD-Master`,
`SMC-PAD-Private`, `Puerto 3`), with the owner watching: no pad ever lit. The
sibling SMC-Mixer behaves the same (QLC+ forum thread 18301). So QLC+'s own MIDI
feedback, which is note/CC, can never reach a pad by itself. That is the whole
reason a bridge exists.

## The colour path is a proprietary protocol on top of MIDI and GATT

The official app is `MidiSuite.apk` (Flutter). Decompiling its `libapp.so` with
Blutter (Dart 3.9.2, snapshot `97ff04a728735e6b6b098bdf983faaba`), and later the
macOS build (Dart 3.12.2, Blutter's Mach-O branch), showed the colour path
plainly. In logical form a packet is:

```
[0x00, 0x59, <cmd>, <len24-le>, <data...>, <checksum>]
  checksum = (~sum(data)) & 0xFF
```

and a colour write is `cmd 5` with data `05 <address-le32> 03 00 00 R G B`.
There is no separate "LED mode" command - the colour write is an ordinary write.

The same logical packet travels two transports:

- **USB**: `SysexCodec.toMidi` bit-packs it LSB-first into 7-bit bytes between
  `F0` and `F7`. This matters - the RGB channels are 8-bit and SysEx data bytes
  must be below `0x80`, so the payload cannot go on the wire unencoded.
- **Bluetooth LE**: `makeWritePacket` writes it raw to GATT service `0xAE40`,
  characteristic `0xAE41` (`0xAE42` notifies the replies). No 7-bit transform.

The pad also streams its own button presses as BLE-MIDI on characteristic
`7772E5DB-3868-4112-A1A9-F2669D106BF3`, so over Bluetooth alone it is both a
QLC+ input and an LED output. The cable is optional.

## The piece that was actually missing: the session

Every correct colour packet was ignored for most of a day. The bytes were not
the problem - the **session** was. The pad only accepts writes once a client has
replayed the desktop app's whole connect handshake on that same connection:
discovery, then a run of read requests walking the entire config, and only then
is a colour write accepted (the pad answers OK) and the LED changes instantly. A
poll keeps the session alive.

That unlock is captured in `tools/smc-pad/reference/` and replayed by
`replay.swift` (USB) and `gatt_replay.swift` (Bluetooth); the bridge does the
GATT version and holds the session open for as long as it runs.

## Dead ends, so nobody walks them twice (2026-08-29)

- **There is no desktop editor other than MidiSuite.** CubeSuite for macOS, the
  other download on `m-vave.com`, is a looper / guitar-pedal editor and carries
  no reference to the pad.
- **The `.spc` export is a file, not the device.** MidiSuite's preset export
  stores each pad's colour as `09 <note> 00 7F <R> <G> <B> FF`, which is how the
  24-bit-RGB-keyed-by-note colour model was confirmed. But the address computed
  from that file's layout is a *file offset*; the real per-pad flash address is
  `0x418 + (note - 36) * 26`, and it came from the live protocol, not the file.
- **USB does not have to be unplugged.** An earlier note here said the pad goes
  silent on BLE while the cable is in. It does not: with USB connected and all
  three `SINCO` ports enumerated, the same presses still arrived on the
  `SMC-PAD Bluetooth` CoreMIDI source. The pad sends on every transport it has
  open at once. What does need the cable is MidiSuite, which configures the pad
  over USB only.
- **The M-VAVE SysEx family** (`F0 00 32 45 ...`, manufacturer `00 32`, shared
  with the Chocolate pedal - github.com/cbix/mvave-chocolate-sysex) is answered
  on `SMC-PAD-Private` and is the firmware/OTA and config channel. It is the
  same protocol underneath, reached the USB way.
- **Bonding hides the pad.** It advertises only in Bluetooth pairing mode; once
  bonded it must be retrieved with
  `retrieveConnectedPeripherals(withServices:[AE40])`, not by scanning.
- **A launchd agent cannot grant itself Bluetooth.** macOS gates BLE behind TCC
  and an agent gets no prompt: it starts, publishes its port, logs nothing wrong
  and silently never connects. The tell is a log that stops after
  `bridge running` with no `pad connected`. Open the app once from the Finder,
  grant Bluetooth, then `launchctl kickstart -k`.

## What is still open

Tuning, not protocol: the resting brightness (`DIM` in the bridge) and the
palette itself want a look in the room, and the manual layer on bank 2 wants a
press on the real pad. Both are in `TODO.md`.
