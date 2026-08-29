"""Decode an SMC-PAD .spc preset into its per-pad colour records.

The desktop MidiSuite editor's "Export preset (.spc)" writes the pad
configuration as a flat byte stream. The colour of each pad is one record:

    09 <id> 00 7F <R> <G> <B> FF

  id : the pad's MIDI note number (bank A pads are 0x04-0x13, bank B 0x14-0x23)
  R,G,B : full 8-bit channels, 0-255 (NOT 7-bit) - e.g. F0 F0 00 is yellow,
          F0 00 F0 magenta, confirmed against the editor's on-screen colours

This is the STORAGE format. On the wire the editor talks to the pad over USB
as M-VAVE SysEx (F0 00 32 ...); since SysEx data bytes must stay below 0x80,
the 8-bit channels here are 7-bit re-encoded by the app's
`core/usb/sysex_codec.dart` before transmission - that codec is the remaining
piece needed to drive the LEDs directly.

Usage: python3 decode_preset.py preset4.spc
"""

import sys


def decode(path: str) -> list[tuple[int, int, int, int]]:
    data = open(path, "rb").read()
    records = []
    i = 0
    while i < len(data) - 7:
        if data[i] == 0x09 and data[i + 2] == 0x00 and data[i + 3] == 0x7F and data[i + 7] == 0xFF:
            records.append((data[i + 1], data[i + 4], data[i + 5], data[i + 6]))
            i += 8
        else:
            i += 1
    return records


if __name__ == "__main__":
    for pad_id, r, g, b in decode(sys.argv[1]):
        print(f"id 0x{pad_id:02X} ({pad_id:3d})  RGB {r:3d},{g:3d},{b:3d}  #{r:02X}{g:02X}{b:02X}")
