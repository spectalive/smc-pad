# TODO Log - SMC-PAD LED bridge

> Searchable record of this repository's closed work. Active work lives in
> [TODO.md](TODO.md).
>
> States: `[x]` verified complete - `[-]` obsolete or superseded. Every entry
> carries the evidence that closed it, never a transcript.

## 2026

### 2026-09

#### 2026-09-26 - Round E follow-ups: a no-pad check for NoteOn/NoteOff, and three rough edges

- [x] 2026-09-26 - **NoteOn/NoteOff painting now has a check without the
  pad.** `--simulate-notes FILE` reads a palette and a file of raw MIDI
  bytes (one message per line, e.g. `90 24 7F`) and prints what each note
  would paint, through the same `notePaints` function `Bridge.handleMIDI`
  uses on live CoreMIDI input - the check exercises the live decision, not a
  reimplementation of it. `tests/test_print_palette.sh` runs it on the new
  fixtures `tests/fixtures/Vibra.notes.txt` / `Vibra.notes.expected.txt`
  (NoteOn, NoteOff, NoteOn velocity 0, and a note outside the palette all
  covered) and diffs the result.
- [x] 2026-09-26 - **A channel of 256 is now refused by the bridge's own
  range check.** `PadPalette.Pad.active`/`idle` decode as `[Int]` instead of
  `[UInt8]`, and `rgb()` checks each channel against `0...255` itself before
  narrowing to `UInt8`; the message is now `"... channel 256 is outside
  0-255"` rather than whatever Foundation's JSON decoder raised for the
  `UInt8` overflow. `tests/test_print_palette.sh` asserts the refusal text
  contains "outside 0-255".
- [x] 2026-09-26 - **Unknown flags, and the bridge's old positional
  unlock-file argument, are refused with a usage line instead of being
  ignored.** `validateArguments()` walks `CommandLine.arguments` and fails
  on anything that is not one of the four known `--flag FILE` pairs.
  `tests/test_print_palette.sh` checks both `--bogus-flag foo` and a bare
  positional path are refused with a `usage:` line.
- [x] 2026-09-26 - **The installer's refusal of an old `com.vibra` agent now
  also names the leftover `~/Library/Application Support/Vibra/` bundle.**
  `install-bridge.sh` checks for that directory alongside the old plist and
  lists `rm -rf` for it in the refusal. `bash -n install-bridge.sh` passes;
  neither path exists on this machine, so nothing was removed.

  Evidence for all four: `tests/test_print_palette.sh` passes 13/13 checks
  (`swiftc -O qlc_led_bridge.swift`, no warnings); tag `v0.1.2`. Not done:
  installing on the pad, and Bluetooth - out of scope for this round (no
  install, no Bluetooth).
