#!/bin/bash
# Compile the bridge and check how it reads a pad palette, without a pad.
#
#     tests/test_print_palette.sh
#
# `--print-palette` parses a `qlctool pad-palette` file the way the bridge
# does at start and prints what each note would show. The fixture was written
# by `qlctool pad-palette` from the Vibra show's `Vibra.qxw`; its expected
# reading is `Vibra.pads.expected.txt`. The refusals are the bridge's own:
# a file it cannot paint faithfully must stop it, not light the wrong pads.

set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FIXTURES="$HERE/fixtures"
WORK="$(mktemp -d)"
trap 'rm -rf "$WORK"' EXIT

swiftc -O "$HERE/../qlc_led_bridge.swift" -o "$WORK/qlc-led-bridge"
BRIDGE="$WORK/qlc-led-bridge"
failures=0

"$BRIDGE" --print-palette "$FIXTURES/Vibra.pads.json" > "$WORK/reading.txt"
if diff -u "$FIXTURES/Vibra.pads.expected.txt" "$WORK/reading.txt"; then
    echo "ok   the Vibra palette reads as expected"
else
    echo "FAIL the Vibra palette reads differently"; failures=$((failures + 1))
fi

# refuses <name> <sed expression>: the fixture, edited, must be refused.
refuses() {
    sed -e "$2" "$FIXTURES/Vibra.pads.json" > "$WORK/$1.json"
    if cmp -s "$FIXTURES/Vibra.pads.json" "$WORK/$1.json"; then
        echo "FAIL $1: the edit changed nothing"; failures=$((failures + 1)); return
    fi
    if "$BRIDGE" --print-palette "$WORK/$1.json" > /dev/null 2> "$WORK/$1.err"; then
        echo "FAIL $1: accepted"; failures=$((failures + 1))
    else
        echo "ok   $1: $(cat "$WORK/$1.err")"
    fi
}

refuses format-2 's/"format": 1,/"format": 2,/'
refuses note-outside-the-pad 's/"note": 36,/"note": 99,/'
refuses note-twice 's/"note": 37,/"note": 36,/'
refuses channel-over-255 '1,/^    255,$/s/^    255,$/    256,/'
refuses not-json '1s/{/[/'

if "$BRIDGE" --print-palette "$WORK/missing.json" > /dev/null 2>&1; then
    echo "FAIL a missing file was accepted"; failures=$((failures + 1))
else
    echo "ok   a missing file is refused"
fi

if [ "$failures" -ne 0 ]; then
    echo "$failures failed"
    exit 1
fi
echo "all passed"
