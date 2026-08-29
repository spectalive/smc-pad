#!/usr/bin/env python3
"""Print exact SMC-PAD colour-write bytes for USB SysEx and BLE AE41."""

from __future__ import annotations

import argparse
from collections.abc import Sequence


PROFILE_STRIDE = 3539
PAD_ARRAY_OFFSET = 211
PAD_RECORD_SIZE = 26
PAD_RGB_OFFSET = 5
DEFAULT_FIRST_PAD_NOTE = 0x04
DEFAULT_LAST_PAD_NOTE = 0x23


def parse_integer(value: str) -> int:
    """Parse decimal, 0x-prefixed hex, or bare hex containing A-F."""
    try:
        return int(value, 0)
    except ValueError:
        if value and all(character in "0123456789abcdefABCDEF" for character in value):
            return int(value, 16)
        raise argparse.ArgumentTypeError(f"invalid integer: {value!r}") from None


def require_range(name: str, value: int, minimum: int, maximum: int) -> int:
    if not minimum <= value <= maximum:
        raise ValueError(f"{name} must be in {minimum}..{maximum}, got {value}")
    return value


def little_endian(value: int, width: int) -> list[int]:
    return [(value >> (8 * index)) & 0xFF for index in range(width)]


def complement_checksum(data: Sequence[int]) -> int:
    return (~sum(data)) & 0xFF


def usb_packet(command: int, data: Sequence[int]) -> list[int]:
    require_range("command", command, 0, 0xFF)
    payload = list(data)
    if any(not 0 <= byte <= 0xFF for byte in payload):
        raise ValueError("packet data bytes must be in 0..255")
    return [
        0x00,
        0x59,
        command,
        *little_endian(len(payload), 3),
        *payload,
        complement_checksum(payload),
    ]


def usb_query_packet() -> list[int]:
    return usb_packet(0x11, [])


def usb_flash_read_packet(region: int, address: int, length: int) -> list[int]:
    require_range("region", region, 0, 0xFF)
    require_range("address", address, 0, 0xFFFFFFFF)
    require_range("length", length, 0, 0xFFFFFF)
    return usb_packet(
        0x23,
        [region, *little_endian(address, 4), *little_endian(length, 3)],
    )


def resolve_pad_index(pad_note: int, override: int | None) -> int:
    require_range("pad_note", pad_note, 0, 0x7F)
    if override is not None:
        return require_range("pad_index", override, 0, 127)
    if not DEFAULT_FIRST_PAD_NOTE <= pad_note <= DEFAULT_LAST_PAD_NOTE:
        raise ValueError(
            "the default preset maps only notes 0x04..0x23; "
            "pass --pad-index for a remapped preset"
        )
    return pad_note - DEFAULT_FIRST_PAD_NOTE


def rgb_address(profile: int, pad_index: int) -> int:
    require_range("profile", profile, 0, 7)
    require_range("pad_index", pad_index, 0, 127)
    return (
        profile * PROFILE_STRIDE
        + PAD_ARRAY_OFFSET
        + pad_index * PAD_RECORD_SIZE
        + PAD_RGB_OFFSET
    )


def usb_logical_packet(address: int, red: int, green: int, blue: int) -> list[int]:
    payload = [
        0x05,
        *little_endian(address, 4),
        *little_endian(3, 3),
        red,
        green,
        blue,
    ]
    return usb_packet(0x22, payload)


def encode_usb_sysex(data: Sequence[int]) -> list[int]:
    encoded = [0xF0]
    accumulator = 0
    bit_count = 0
    for byte in data:
        accumulator |= byte << bit_count
        bit_count += 8
        while bit_count >= 7:
            encoded.append(accumulator & 0x7F)
            accumulator >>= 7
            bit_count -= 7
    if bit_count:
        encoded.append(accumulator & 0x7F)
    encoded.append(0xF7)
    return encoded


def decode_usb_sysex(message: Sequence[int]) -> list[int]:
    if len(message) < 2 or message[0] != 0xF0 or message[-1] != 0xF7:
        raise ValueError("USB SysEx must start with F0 and end with F7")
    decoded: list[int] = []
    accumulator = 0
    bit_count = 0
    for byte in message[1:-1]:
        if not 0 <= byte < 0x80:
            raise ValueError(f"invalid SysEx data byte: 0x{byte:02X}")
        accumulator |= byte << bit_count
        bit_count += 7
        while bit_count >= 8:
            decoded.append(accumulator & 0xFF)
            accumulator >>= 8
            bit_count -= 8
    return decoded


def ble_ae41_packet(address: int, red: int, green: int, blue: int) -> list[int]:
    data = [red, green, blue]
    packet = [
        0x00,
        0x59,
        0x22,
        *little_endian(len(data) + 8, 4),
        0x05,
        *little_endian(address, 4),
        *little_endian(len(data), 3),
        *data,
    ]
    packet.append(complement_checksum(packet[6:]))
    return packet


def format_hex(data: Sequence[int]) -> str:
    return " ".join(f"{byte:02X}" for byte in data)


def build_argument_parser() -> argparse.ArgumentParser:
    parser = argparse.ArgumentParser(
        description="Generate an SMC-PAD RGB write for USB SysEx and BLE AE41."
    )
    parser.add_argument("pad_note", type=parse_integer, help="MIDI note, e.g. 0x07")
    parser.add_argument("r", type=parse_integer, help="red byte")
    parser.add_argument("g", type=parse_integer, help="green byte")
    parser.add_argument("b", type=parse_integer, help="blue byte")
    parser.add_argument(
        "--profile",
        type=parse_integer,
        default=0,
        help="user-profile index 0..7 (default: 0)",
    )
    parser.add_argument(
        "--pad-index",
        type=parse_integer,
        help="pad record index 0..127; overrides the default note-minus-0x04 mapping",
    )
    return parser


def main() -> int:
    parser = build_argument_parser()
    arguments = parser.parse_args()
    try:
        red = require_range("r", arguments.r, 0, 0xFF)
        green = require_range("g", arguments.g, 0, 0xFF)
        blue = require_range("b", arguments.b, 0, 0xFF)
        pad_index = resolve_pad_index(arguments.pad_note, arguments.pad_index)
        address = rgb_address(arguments.profile, pad_index)
    except ValueError as error:
        parser.error(str(error))

    logical = usb_logical_packet(address, red, green, blue)
    print(f"pad_note:   0x{arguments.pad_note:02X}")
    print(f"profile:    {arguments.profile}")
    print(f"pad_index:  {pad_index}")
    print(f"rgb_address: 0x{address:08X}")
    print(f"usb_logical (audit only): {format_hex(logical)}")
    print(f"usb_sysex (send):         {format_hex(encode_usb_sysex(logical))}")
    print(f"ble_ae41 (raw send):      {format_hex(ble_ae41_packet(address, red, green, blue))}")
    return 0


if __name__ == "__main__":
    raise SystemExit(main())
