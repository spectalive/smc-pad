#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DESTINATION="Private"
REQUEST_DELAY_SECONDS="0.55"
DRY_RUN=false

if [[ "${1:-}" == "--dry-run" ]]; then
    DRY_RUN=true
    shift
fi
if [[ "$#" -ne 0 ]]; then
    echo "Usage: $0 [--dry-run]" >&2
    exit 2
fi

SENDER_DIR=""
SENDER=""
cleanup() {
    if [[ -n "$SENDER" && -f "$SENDER" ]]; then
        rm -f "$SENDER"
    fi
    if [[ -n "$SENDER_DIR" && -d "$SENDER_DIR" ]]; then
        rmdir "$SENDER_DIR"
    fi
}
trap cleanup EXIT

if [[ "$DRY_RUN" == false ]]; then
    command -v swiftc >/dev/null || {
        echo "swiftc is required" >&2
        exit 1
    }
    SENDER_DIR="$(mktemp -d "$SCRIPT_DIR/.apply-color.XXXXXX")"
    SENDER="$SENDER_DIR/midisend2"
    swiftc "$SCRIPT_DIR/midisend2.swift" -o "$SENDER"
fi

packet_number=0
send_packet() {
    local label="$1"
    local packet="$2"
    local -a bytes
    IFS=' ' read -r -a bytes <<< "$packet"
    packet_number=$((packet_number + 1))
    printf '%02d %-18s %s\n' "$packet_number" "$label" "$packet"
    if [[ "$DRY_RUN" == false ]]; then
        "$SENDER" "$DESTINATION" "${bytes[@]}"
        sleep "$REQUEST_DELAY_SECONDS"
    fi
}

echo "Destination match: $DESTINATION"
echo "Close Midi Suite before live use so its polling cannot interleave with this sequence."

connect_index=0
while IFS= read -r packet; do
    connect_index=$((connect_index + 1))
    if [[ "$connect_index" -eq 1 ]]; then
        label="query identity"
    elif [[ "$connect_index" -eq 2 ]]; then
        label="read global"
    else
        label="read user $((connect_index - 2))/29"
    fi
    send_packet "$label" "$packet"
done < <(python3 "$SCRIPT_DIR/usb_connect_sequence.py" --wire-only)

color_packet="$(
    PYTHONPATH="$SCRIPT_DIR" python3 - <<'PY'
from color_cmd import encode_usb_sysex, format_hex, rgb_address, usb_logical_packet

address = rgb_address(profile=0, pad_index=3)
logical = usb_logical_packet(address, 0xFF, 0x00, 0x00)
print(format_hex(encode_usb_sysex(logical)))
PY
)"
send_packet "write note 07 red" "$color_packet"

if [[ "$DRY_RUN" == true ]]; then
    echo "Dry run complete: no MIDI was sent."
else
    echo "Sequence sent. Physical LED confirmation remains a human check."
fi
