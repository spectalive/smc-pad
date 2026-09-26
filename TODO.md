# TODO

- [ ] **Install and verify with the physical pad (2026-09-26).** The bridge
  now reads its palette from a `qlctool pad-palette` file, and that path has
  only been checked without the pad: `tests/test_print_palette.sh` compiles it
  and reads the Vibra palette as the old hard-coded arrays painted it (all 32
  notes, active and idle). It is installed nowhere: the install needs the pad
  in reach and a human to accept macOS's Bluetooth prompt. Smallest next step:
  on the machine that runs the show, remove any old
  `com.vibra.smc-pad-led-bridge` agent, run
  `./install-bridge.sh "<show>.pads.json"`, open the app once from the Finder
  and grant Bluetooth, reload the workspace in QLC+, then press a pad and see
  it go from its idle colour to its active one (log: `pad palette: ... 32
  pads`, `pad connected`, `MIDI in: note ...`).
- [ ] **A restarted bridge costs QLC+'s feedback until the workspace is
  reloaded (from vibra-lighting, 2026-08-29).** The virtual MIDI endpoint gets
  a new identity on every start, and QLC+ resolves its feedback patch only when
  it loads the workspace. The show keeps running; the pads stop updating.
  Smallest next step: find out whether a CoreMIDI endpoint created with a fixed
  `kMIDIPropertyUniqueID` survives a restart as the same port for QLC+.
- [ ] **`reference/` has three Python scripts outside any gate (from
  vibra-lighting).** `color_cmd.py`, `decode_preset.py` and
  `test_color_cmd.py` are the protocol's worked examples and their test; the
  7 tests pass under pytest (2026-09-26), but nothing runs them. Smallest next
  step: run `python3 -m pytest reference/test_color_cmd.py` next to
  `tests/test_print_palette.sh`, or say here that they are kept as history
  only.
- [ ] **A changed palette may cost the Bluetooth grant again (review,
  2026-09-26, unverified).** `install-bridge.sh` copies the palette into the
  bundle before the ad-hoc signature, so a new palette changes the code
  signature's hash, and macOS may ask for Bluetooth again from a Finder
  launch. Smallest next step: check it during the first install; if it asks,
  read the palette from a fixed path in the support folder, outside the
  signed bundle.
- [ ] **NoteOn/NoteOff painting has no check without the pad (review,
  2026-09-26).** `--print-palette` covers parsing only. Smallest next step: a
  mode that feeds MIDI notes and prints the colour each would paint.
- [ ] **Small rough edges from the review (2026-09-26).** A channel of 256 is
  refused by the JSON parser, not by the bridge's own range check, so the
  message is Foundation's; unknown flags and the old positional unlock
  argument are ignored silently; the installer's refusal of an old
  `com.vibra` agent does not mention the leftover
  `~/Library/Application Support/Vibra/` bundle.
