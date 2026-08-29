# SMC-PAD colour command reverse engineering

## 2026-08-29 — scope and source inventory

- Read all 105 lines of `BRIEFING.md` (SHA-256 `ea030e79532300034fffec3759c949b5dbbc2733044398fa36662e750131f619`).
- Deterministic target: recover `core/usb/sysex_codec.dart` (`_collapseSysEx`, `_setSysEx`, `sendData`) and the colour `writeData` call path from the macOS Dart AOT snapshot, then emit exact USB SysEx and BLE AE41 bytes from `color_cmd.py`.
- Primary binary: `mac_arm/libapp.so`, arm64 Mach-O, SHA-256 `0b963d96bd1dbd7c008ea3c8bf021c398d1242117a47ec949fec55c5ea57dab9`.
- Important correction to the briefing metadata: the binary file hash above is not the Dart snapshot hash. The embedded Dart snapshot hash must be recovered separately; the briefing names `ace654289f5abc240509fc941453ebc5` as that embedded snapshot hash.
- Constraint acknowledged: all reads, writes, downloads, builds, and analysis will remain under this scratch directory.

## 2026-08-29 — Mach-O route selected

- `nm -nm mac_arm/libapp.so` exposes all four required symbols directly:
  - `_kDartVmSnapshotInstructions` at VM address/file offset `0x4000`
  - `_kDartIsolateSnapshotInstructions` at `0x10000`
  - `_kDartVmSnapshotData` at `0x434000`
  - `_kDartIsolateSnapshotData` at `0x440000`
- The VM snapshot header at `0x434000` independently confirms embedded snapshot hash `ace654289f5abc240509fc941453ebc5` and flags `product no-code_comments no-dwarf_stack_traces_mode dedup_instructions no-asan no-msan no-tsan no-shared_data arm64 macos no-compressed-pointers`.
- The paired `libflutter.so` identifies Dart `3.12.2`; engine hashes found are `77e2e94772b6eb43759e34ed1ad7da4674e19cab` and `e9ed4fc9f1544c58d8a9347c1fc9471d8dd7c465`.
- Upstream Blutter PR 204 (`0039efb`, `ipa support`) adds a complete thin/fat Mach-O parser, resolves the four snapshot symbols through `LC_SYMTAB`, and builds the Dart runtime with macOS/iOS target definitions. A separate local worktree `blutter-macho/` now contains that branch, preserving the original clean `blutter/` checkout.
- Running its Mach-O metadata extractor produced: `('3.12.2', 'ace654289f5abc240509fc941453ebc5', [... 'arm64', 'macos', 'no-compressed-pointers'], 'arm64', 'ios')`. The final `ios` label is the PR's build-route label; the embedded authoritative target flag is `macos`.

## 2026-08-29 — successful macOS AOT decompilation

- The PR initially built an iOS-target Dart VM, which the snapshot rejected because its flags require `macos`. Two scoped changes in the separate `blutter-macho/` worktree fixed the target selection: the Mach-O extractor now reports `macos`, and the CMake route defines `DART_TARGET_OS_MACOS` without `DART_TARGET_OS_MACOS_IOS`.
- `../blutter-venv/bin/python blutter.py ../mac_arm ../mac_blutter_out --rebuild` then built the matching Dart 3.12.2 arm64/macOS/no-compressed-pointers runtime and dumped 125 files under `mac_blutter_out/`.
- The dump includes the requested `mac_blutter_out/asm/musical_instruments/core/usb/sysex_codec.dart`, as well as `midi_transport.dart`, `usb_connect.dart`, the SMC-PAD data model, and the SMC-PAD desktop page. Blutter reported several non-fatal analysis warnings for newer Dart instructions, but it recovered complete disassembly for the target methods below.

## 2026-08-29 — exact SysEx codec and USB envelope

- `SysexCodec.toMidi` at snapshot address `0x1a5a1c` is a continuous, least-significant-bit-first bitstream transform. It starts with `F0`, then for each 8-bit input byte executes `accumulator |= byte << bit_count`, increments `bit_count` by 8, and repeatedly emits `accumulator & 0x7F`, right-shifts the accumulator by 7, and subtracts 7 bits. After all input, it emits the residual low 7 bits when non-empty and finally `F7`. This is not the common seven-payload-bytes-plus-MSB-header layout.
- `SysexCodec.fromMidi` at `0x1a719c` is the exact inverse: between `F0` and `F7`, it accumulates each 7-bit byte at the current bit count and repeatedly emits low 8-bit bytes.
- `SysexCodec.packet(cmd, data)` at `0x1a5eec` builds the unencoded logical packet `00 59 <cmd> <data_length_le24> <data...> <checksum>`, where `checksum = ~(sum(data) & 0xFF) & 0xFF`. Only `data` participates in this checksum. The disassembly literal stored for `59` is `178` because a Dart small integer (Smi) is tagged as `value << 1`; reading that storage literal as byte `B2` is incorrect.
- `MidiTransport.send` at `0x1a57fc` applies `SysexCodec.toMidi` to that entire logical packet, converts it to `Uint8List`, and calls the `flutter_midi_command` `sendData` method. Therefore those `F0 ... F7` bytes are the exact USB MIDI wire message.
- SMC-PAD `_wColor` at `0x2980f4` reads the address of the first entry in the pad object's three-byte colour list, collects the three values as `[R & 0xFF, G & 0xFF, B & 0xFF]`, and calls `_write(5, address, rgb)`.
- `_write` delegates to `UsbConnect.flashWrite`. `flashWrite` prepends `05 <address_le32> <chunk_length_le24>` to the RGB bytes and then wraps that data with `SysexCodec.packet(0x22, ...)`. For a single colour the unencoded USB packet is consequently `00 59 22 0B 00 00 05 <address_le32> 03 00 00 R G B <~(sum(data))>` before the 8-to-7-bit transform.

## 2026-08-29 — exact BLE AE41 builder

- Android `BleManager.sendColorData` at `0x4da470` receives the same three `AddrUnsigned8Data` objects: it extracts the first object's address, builds `[R,G,B]`, and calls `writeData(5, address, rgb)`.
- `writeData` chunks at 135 bytes and calls `makeWritePacket(cmd, current_address, chunk)` before `BluetoothCharacteristic.write`; no 7-bit transform occurs on this BLE route.
- `makeWritePacket` at `0x43a1ac` emits `00 59 22 <data_length_plus_8_le32> <cmd_u8> <address_le32> <data_length_le24> <data...> <checksum>`. Its direct list-storage literals are `178` and `68`, which decode through the same Smi tag to `89` (`59`) and `34` (`22`). The briefing's earlier `B2 44` reading used the tagged machine representation as if it were the Dart integer value.
- Its checksum loop begins at packet index 6, not index 0: `checksum = ~(sum(packet[6:]) & 0xFF) & 0xFF`, evaluated before appending the checksum. For a three-byte colour, the high byte of the four-byte `0B 00 00 00` payload length is index 6 and is zero, so the effective sum is `05 + sum(address_le32) + 03 + R + G + B`.
- This proves the previously failed 32-bit-field theory was structurally wrong: command `05` is one byte and RGB count `03 00 00` is three bytes; only the address is four bytes.

## 2026-08-29 — symbol-name correction and SMC-PAD address mapping

- A full dump search corrects one premise in the briefing: `_collapseSysEx` and `_setSysEx` are not members of `core/usb/sysex_codec.dart`. They are UI/data-entry methods in the foot-controller and foot-controller-plus bank editors. `_collapseSysEx` collapses a multi-row 128-byte editable SysEx action, while `_setSysEx` parses a hexadecimal string and copies up to 128 values into that action. Neither method performs MIDI 8-to-7-bit encoding or participates in the SMC-PAD colour path.
- The actual codec entry points recovered in `core/usb/sysex_codec.dart` are `SysexCodec.toMidi` at `0x1a5a1c` and `SysexCodec.fromMidi` at `0x1a719c`. The instruction sequences at `0x1a5aec` through `0x1a5ba0` and `0x1a7250` through `0x1a72d8` establish the exact mutually inverse bit packing described above.
- The Smi correction reconciles the captured status frame instead of contradicting it: running the captured `F0 00 32 0D 21 ... F7` prefix through `fromMidi` yields logical `00 59 23 14 ...`. Likewise, the outbound colour packet below starts logical `00 59 22 0B ...` and encodes as `F0 00 32 09 59 ... F7`. The observed `00 32` wire prefix is exactly what the recovered codec produces from logical `00 59`.
- The colour call receives an address, not a MIDI note. `SmcPadUsrListData.setData` requires 28,312 source bytes over eight user profiles. The apparent length constant `56,624` and apparent doubled list indexes in the assembly are the Smi-tagged forms of length 28,312 and each ordinary index. The recovered profile structure is 3,539 bytes: five 23-byte button records, sixteen 6-byte encoder records, and 128 26-byte pad records. The pad array starts at offset 211 and the three RGB values start at offset 5 within each pad record.
- Consequently, the RGB write address is exactly `profile * 3539 + 211 + pad_index * 26 + 5`. For the briefing's documented default exported preset, notes `0x04..0x23` are positional pad records `0..31`, so the default conversion is `pad_index = pad_note - 0x04`. MIDI notes are editable, so an arbitrary remapped preset cannot be resolved from `pad_note` alone; `color_cmd.py` exposes `--profile` and `--pad-index` to make the persisted location explicit.
- The briefing mentions `reference/preset4.spc` and `reference/decode_preset.py`, but no `reference/` directory or either file is present in this supplied scratch tree. The default note mapping above is therefore taken from the briefing's stated decoded result; the address layout itself is independently recovered from the AOT snapshot.

## 2026-08-29 — executable generator and exact note 0x07 red proposal

- `color_cmd.py` accepts `(pad_note, r, g, b)` as decimal, `0x`-prefixed hexadecimal, or bare hexadecimal containing `A-F`. It defaults to user profile 0 and the documented default note mapping. It validates all ranges and prints the logical USB packet for audit plus the exact USB SysEx and BLE AE41 wire bytes.
- Command: `python3 color_cmd.py 0x07 0xFF 0 0`
- Resolved location: pad record index 3, RGB address `0x00000126`.
- Exact USB MIDI SysEx to send to the SMC-PAD MIDI destination:

  `F0 00 32 09 59 00 00 40 02 26 02 00 00 30 00 00 00 7F 01 00 08 0D F7`

  With the supplied sender (replace `SMC-PAD` only if its destination name differs):

  `swift midisend2.swift SMC-PAD F0 00 32 09 59 00 00 40 02 26 02 00 00 30 00 00 00 7F 01 00 08 0D F7`

- Exact raw BLE write to characteristic AE41 (service AE40), without a second checksum or 7-bit encoding:

  `00 59 22 0B 00 00 00 05 26 01 00 00 03 00 00 FF 00 00 D1`

  The supplied BLE tool normally appends a checksum, so this already checksummed packet must use its verbatim `raw:` mode as one quoted argument:

  `swift bletool.swift 'raw:00 59 22 0B 00 00 00 05 26 01 00 00 03 00 00 FF 00 00 D1'`

- The corresponding pre-encoding USB logical packet is:

  `00 59 22 0B 00 00 05 26 01 00 00 03 00 00 FF 00 00 D1`

- Neither `SmcPadData._wColor` / `UsbConnect.flashWrite` nor Android `BleManager.sendColorData` issues a protocol handshake immediately before the colour write. Normal transport setup is still required: an open SMC-PAD MIDI destination for USB, or a connected AE40 service with writable AE41 for BLE. The code does not justify inventing an additional mode packet.
- The packet derivation is complete without LED observation, as requested. Physical LED confirmation remains deliberately outstanding for the human; no claim is made that either message has yet been accepted by this specific device/firmware.

## 2026-08-29 — verification

- Added `test_color_cmd.py` with a hard-coded note `0x07` red regression vector for all three forms, an independent SysEx inverse, MIDI-data-byte safety checks, checksum invariants, profile/pad address boundaries, and note-mapping validation.
- Verification command:

  `python3 -m unittest -v test_color_cmd.py && python3 color_cmd.py 0x07 0xFF 0 0 && python3 -m py_compile color_cmd.py test_color_cmd.py`

- Result: all five tests passed; the CLI printed the exact vectors above; both modules compiled successfully.

## 2026-08-29 — fourth-pass scope and correction status

- Read all 144 lines of the updated `BRIEFING.md`, including `THIRD PASS corrections + new blockers` and `FOURTH deliverable`.
- The working `color_cmd.py` already contains the corrected logical header byte `0x59` on both USB and BLE paths; the earlier `0xB2` interpretation had been corrected after auditing Dart Smi tagging. This pass will add direct regression assertions for the supplied captured status and OK packets rather than relying only on generated round trips.
- New deterministic work in progress: recover the ordered USB connect writes from `usb_connect.dart`, `midi_transport.dart`, and the SMC-PAD page initialization; determine whether the colour path sends a post-write command; decode `appcolor.log` to validate the known yellow pad's flash location; then generate an executable `apply_color.sh` using only evidenced packets.

## 2026-08-29 — captured codec regression vectors

- Added `SysexCodec.fromMidi`'s recovered inverse as `decode_usb_sysex` in `color_cmd.py`, including `F0/F7` and seven-bit data validation.
- The complete captured status frame from `appcolor.log` line 6 decodes to logical `00 59 23 14 00 00 04 00 00 00 00 0C 00 00 78 00 32 04 00 00 01 01 03 01 01 00 3A`. This is command `0x23`, 24-bit length `0x14`, 20 data bytes, and checksum `0x3A`.
- The captured OK frame `F0 00 32 01 08 00 00 00 00 7F 01 F7` decodes to logical `00 59 00 01 00 00 00 FF`: command `0x00`, one zero data byte, checksum `0xFF`.
- Both are now hard-coded bidirectional assertions in `test_color_cmd.py`: decode must equal the complete logical vector and re-encode must equal the original capture. `python3 -m unittest -v test_color_cmd.py` passes all seven tests.

## 2026-08-29 — exact desktop USB initialization sequence

- `_SmcPadDesktopPageState._load` at `0x20b590` first awaits `MidiTransport.connect` at call site `0x20b5f0`. `MidiTransport.connect` at `0x1a6194` only invokes the plugin's `connectToDevice`, records the device, cancels the prior subscription, and subscribes to `onMidiDataReceived`; it sends no MIDI bytes.
- The first protocol request is `UsbConnect.queryNameAndVersion` at call site `0x20b628`. It sends `SysexCodec.queryPacket()` (command `0x11`, empty data) and waits for a verified command-`0x11` response. `appcolor.log`'s first device frame decodes to that response, including the `SMC-PAD_003` identity.
- The page may show the firmware-update UI after the identity response. If that flow takes over, `_load` returns. In the normal editor-load path represented by this capture, it continues with `flashRead(4, 0, 12)` at `0x20b6f8`, then `flashRead(5, 0, 28312)` at `0x20b724`.
- `UsbConnect.flashRead` at `0x1f7840` splits reads at exactly `0x3F1` = 1,009 bytes and awaits a matching, checksum-valid command-`0x23` response before issuing the next request. The 28,312-byte region therefore becomes 28 full 1,009-byte requests plus one 60-byte request. Including identity and the global read, normal initialization sends exactly 31 protocol packets.
- `appcolor.log` independently corroborates this order: identity response, one region-4 response for address `0`/length `12`, then region-5 responses at addresses `0x0000`, `0x03F1`, ..., `0x6A6B` with length 1,009 and `0x6E5C` with length 60. These are the exact response counterparts of the requests below.
- `usb_connect_sequence.py` encodes the recovered loop and prints every logical and wire packet. The ordered output is:

```text
01 logical: 00 59 11 00 00 00 FF
01 usb:     F0 00 32 45 00 00 00 40 7F F7
02 logical: 00 59 23 08 00 00 04 00 00 00 00 0C 00 00 EF
02 usb:     F0 00 32 0D 41 00 00 00 02 00 00 00 00 40 01 00 00 6F 01 F7
03 logical: 00 59 23 08 00 00 05 00 00 00 00 F1 03 00 06
03 usb:     F0 00 32 0D 41 00 00 40 02 00 00 00 00 10 7E 00 00 06 00 F7
04 logical: 00 59 23 08 00 00 05 F1 03 00 00 F1 03 00 12
04 usb:     F0 00 32 0D 41 00 00 40 02 71 07 00 00 10 7E 00 00 12 00 F7
05 logical: 00 59 23 08 00 00 05 E2 07 00 00 F1 03 00 1D
05 usb:     F0 00 32 0D 41 00 00 40 02 62 0F 00 00 10 7E 00 00 1D 00 F7
06 logical: 00 59 23 08 00 00 05 D3 0B 00 00 F1 03 00 28
06 usb:     F0 00 32 0D 41 00 00 40 02 53 17 00 00 10 7E 00 00 28 00 F7
07 logical: 00 59 23 08 00 00 05 C4 0F 00 00 F1 03 00 33
07 usb:     F0 00 32 0D 41 00 00 40 02 44 1F 00 00 10 7E 00 00 33 00 F7
08 logical: 00 59 23 08 00 00 05 B5 13 00 00 F1 03 00 3E
08 usb:     F0 00 32 0D 41 00 00 40 02 35 27 00 00 10 7E 00 00 3E 00 F7
09 logical: 00 59 23 08 00 00 05 A6 17 00 00 F1 03 00 49
09 usb:     F0 00 32 0D 41 00 00 40 02 26 2F 00 00 10 7E 00 00 49 00 F7
10 logical: 00 59 23 08 00 00 05 97 1B 00 00 F1 03 00 54
10 usb:     F0 00 32 0D 41 00 00 40 02 17 37 00 00 10 7E 00 00 54 00 F7
11 logical: 00 59 23 08 00 00 05 88 1F 00 00 F1 03 00 5F
11 usb:     F0 00 32 0D 41 00 00 40 02 08 3F 00 00 10 7E 00 00 5F 00 F7
12 logical: 00 59 23 08 00 00 05 79 23 00 00 F1 03 00 6A
12 usb:     F0 00 32 0D 41 00 00 40 02 79 46 00 00 10 7E 00 00 6A 00 F7
13 logical: 00 59 23 08 00 00 05 6A 27 00 00 F1 03 00 75
13 usb:     F0 00 32 0D 41 00 00 40 02 6A 4E 00 00 10 7E 00 00 75 00 F7
14 logical: 00 59 23 08 00 00 05 5B 2B 00 00 F1 03 00 80
14 usb:     F0 00 32 0D 41 00 00 40 02 5B 56 00 00 10 7E 00 00 00 01 F7
15 logical: 00 59 23 08 00 00 05 4C 2F 00 00 F1 03 00 8B
15 usb:     F0 00 32 0D 41 00 00 40 02 4C 5E 00 00 10 7E 00 00 0B 01 F7
16 logical: 00 59 23 08 00 00 05 3D 33 00 00 F1 03 00 96
16 usb:     F0 00 32 0D 41 00 00 40 02 3D 66 00 00 10 7E 00 00 16 01 F7
17 logical: 00 59 23 08 00 00 05 2E 37 00 00 F1 03 00 A1
17 usb:     F0 00 32 0D 41 00 00 40 02 2E 6E 00 00 10 7E 00 00 21 01 F7
18 logical: 00 59 23 08 00 00 05 1F 3B 00 00 F1 03 00 AC
18 usb:     F0 00 32 0D 41 00 00 40 02 1F 76 00 00 10 7E 00 00 2C 01 F7
19 logical: 00 59 23 08 00 00 05 10 3F 00 00 F1 03 00 B7
19 usb:     F0 00 32 0D 41 00 00 40 02 10 7E 00 00 10 7E 00 00 37 01 F7
20 logical: 00 59 23 08 00 00 05 01 43 00 00 F1 03 00 C2
20 usb:     F0 00 32 0D 41 00 00 40 02 01 06 01 00 10 7E 00 00 42 01 F7
21 logical: 00 59 23 08 00 00 05 F2 46 00 00 F1 03 00 CE
21 usb:     F0 00 32 0D 41 00 00 40 02 72 0D 01 00 10 7E 00 00 4E 01 F7
22 logical: 00 59 23 08 00 00 05 E3 4A 00 00 F1 03 00 D9
22 usb:     F0 00 32 0D 41 00 00 40 02 63 15 01 00 10 7E 00 00 59 01 F7
23 logical: 00 59 23 08 00 00 05 D4 4E 00 00 F1 03 00 E4
23 usb:     F0 00 32 0D 41 00 00 40 02 54 1D 01 00 10 7E 00 00 64 01 F7
24 logical: 00 59 23 08 00 00 05 C5 52 00 00 F1 03 00 EF
24 usb:     F0 00 32 0D 41 00 00 40 02 45 25 01 00 10 7E 00 00 6F 01 F7
25 logical: 00 59 23 08 00 00 05 B6 56 00 00 F1 03 00 FA
25 usb:     F0 00 32 0D 41 00 00 40 02 36 2D 01 00 10 7E 00 00 7A 01 F7
26 logical: 00 59 23 08 00 00 05 A7 5A 00 00 F1 03 00 05
26 usb:     F0 00 32 0D 41 00 00 40 02 27 35 01 00 10 7E 00 00 05 00 F7
27 logical: 00 59 23 08 00 00 05 98 5E 00 00 F1 03 00 10
27 usb:     F0 00 32 0D 41 00 00 40 02 18 3D 01 00 10 7E 00 00 10 00 F7
28 logical: 00 59 23 08 00 00 05 89 62 00 00 F1 03 00 1B
28 usb:     F0 00 32 0D 41 00 00 40 02 09 45 01 00 10 7E 00 00 1B 00 F7
29 logical: 00 59 23 08 00 00 05 7A 66 00 00 F1 03 00 26
29 usb:     F0 00 32 0D 41 00 00 40 02 7A 4C 01 00 10 7E 00 00 26 00 F7
30 logical: 00 59 23 08 00 00 05 6B 6A 00 00 F1 03 00 31
30 usb:     F0 00 32 0D 41 00 00 40 02 6B 54 01 00 10 7E 00 00 31 00 F7
31 logical: 00 59 23 08 00 00 05 5C 6E 00 00 3C 00 00 F4
31 usb:     F0 00 32 0D 41 00 00 40 02 5C 5C 01 00 40 07 00 00 74 01 F7
```

## 2026-08-29 — colour write, polling, and explicit save behavior

- `_wColor` at `0x2980f4` calls `_write(5, RGB address, [R,G,B])`. `_write` at `0x26c240` calls `UsbConnect.flashWrite` at `0x26c2c0`; its only continuation displays `Write failed` if the returned boolean is false. There is no second protocol request on the colour callback path.
- `UsbConnect.flashWrite` at `0x1fcc2c` sends command `0x22` chunks and requires a command-`0x00` response whose first data byte is zero. After the last accepted response it returns `true`; it sends no refresh or commit packet.
- `_pollGlob` at `0x20cd24` is started by a periodic timer only after the initial reads. It repeatedly reads region 4 at address 0 for 12 bytes. It re-reads all 28,312 region-5 bytes only if the active-user selector in the global data changes. This is background synchronization, not a post-colour-write operation.
- The app does have a persistent-save operation, but it is bound to the separate Save UI callback `_save` at `0x29dd1c`, not to `_wColor`. `SysexCodec.save0Packet(5)` builds logical `00 59 22 08 00 00 05 00 00 00 00 00 00 00 FA`, encoded as `F0 00 32 09 41 00 00 40 02 00 00 00 00 00 00 00 00 7A 01 F7`. Because the official app changes the LED on the ordinary colour-write callback before a separate Save action, `apply_color.sh` deliberately does not append this persistence command.

## 2026-08-29 — `appcolor.log` address cross-check

- Reassembling split CoreMIDI chunks from `F0` through `F7`, applying the recovered inverse codec, and concatenating the first 29 region-5 responses produces a complete 28,312-byte snapshot. Repeating this for the second read produces a second complete snapshot. `test_appcolor_capture.py` performs this reconstruction directly from the supplied capture.
- The capture strongly confirms the note-to-address derivation. In snapshot 1, note `0x07` has record prefix `09 07 00 7F`, RGB `FF 00 00` exactly at `0x126`, and trailing `FF`; snapshot 2 has `96 C8 F0` at the same address. This is direct capture evidence for the target address used by `apply_color.sh`.
- The capture's concrete yellow records are notes `0x14..0x23`, each with RGB `F0 F0 00`. The first is `09 14 00 7F F0 F0 00 FF`, with RGB at `0x278`; this independently matches `211 + (0x14 - 0x04) * 26 + 5 = 0x278`.
- Important limitation: neither complete snapshot shows a pad identified as decimal note 13 (`0x0D`) yellow. Note `0x0D` is `96 C8 F0` at `0x1C2` in both snapshots; note `0x13` is also `96 C8 F0` at `0x25E`. Later in the log there are command-`0x00` OK replies but no third region-5 snapshot, and the capture explicitly lacks the app-to-device direction, so those ACKs cannot reveal the address that was written. The log therefore validates the address formula and multiple known colours, but it cannot truthfully identify the later manual “pad 13 yellow” write itself from the available direction.

## 2026-08-29 — executable full-load replay and red write

- `apply_color.sh` compiles the supplied `midisend2.swift` into an ephemeral sender under this scratch directory, targets the destination substring `Private`, sends the 31 initialization requests above in order, then sends note `0x07` red as packet 32.
- Since the supplied sender is transmit-only and cannot await a matching response as the app does, each invocation retains its internal 200 ms wait and the shell adds 550 ms before the next request. This gives each maximum-size response time to complete but is a timing approximation, not response-correlated flow control. `rawcap.swift` may remain listening, but Midi Suite should be closed so its periodic reads cannot interleave with the replay.
- Packet 32 logical: `00 59 22 0B 00 00 05 26 01 00 00 03 00 00 FF 00 00 D1`.
- Packet 32 USB: `F0 00 32 09 59 00 00 40 02 26 02 00 00 30 00 00 00 7F 01 00 08 0D F7`.
- Safe inspection command: `./apply_color.sh --dry-run`. Live command, to be run while watching the device: `./apply_color.sh`. No live MIDI was sent during this analysis.

## 2026-08-29 — fourth-pass verification

- Added generic USB packet/query/read builders to `color_cmd.py`, `usb_connect_sequence.py` for the exact 31 requests, `test_usb_connect_sequence.py` for count/boundary/round-trip assertions, and `test_appcolor_capture.py` for capture-backed RGB-address assertions.
- Verification command:

  `python3 -m unittest -v test_color_cmd.py test_usb_connect_sequence.py test_appcolor_capture.py && bash -n apply_color.sh && swiftc -typecheck midisend2.swift && ./apply_color.sh --dry-run && python3 -m py_compile color_cmd.py usb_connect_sequence.py test_color_cmd.py test_usb_connect_sequence.py test_appcolor_capture.py`

- Final result: all ten tests passed; shell syntax, Swift type checking, and Python byte compilation passed; the dry run printed exactly 32 ordered packets and explicitly sent no MIDI.
