import unittest

import color_cmd


def independently_decode_sysex(message: list[int]) -> list[int]:
    accumulator = 0
    bit_count = 0
    decoded: list[int] = []
    for byte in message[1:-1]:
        accumulator |= byte << bit_count
        bit_count += 7
        while bit_count >= 8:
            decoded.append(accumulator & 0xFF)
            accumulator >>= 8
            bit_count -= 8
    return decoded


class ColorCommandTest(unittest.TestCase):
    def test_captured_status_packet_decodes_exactly(self) -> None:
        captured = [
            0xF0, 0x00, 0x32, 0x0D, 0x21, 0x01, 0x00, 0x00,
            0x02, 0x00, 0x00, 0x00, 0x00, 0x40, 0x01, 0x00,
            0x00, 0x78, 0x00, 0x48, 0x21, 0x00, 0x00, 0x40,
            0x00, 0x01, 0x06, 0x04, 0x08, 0x00, 0x40, 0x0E,
            0xF7,
        ]
        logical = [
            0x00, 0x59, 0x23, 0x14, 0x00, 0x00,
            0x04, 0x00, 0x00, 0x00, 0x00, 0x0C, 0x00,
            0x00, 0x78, 0x00, 0x32, 0x04, 0x00, 0x00,
            0x01, 0x01, 0x03, 0x01, 0x01, 0x00, 0x3A,
        ]

        self.assertEqual(color_cmd.decode_usb_sysex(captured), logical)
        self.assertEqual(color_cmd.encode_usb_sysex(logical), captured)

    def test_captured_ok_packet_decodes_exactly(self) -> None:
        captured = [
            0xF0, 0x00, 0x32, 0x01, 0x08, 0x00,
            0x00, 0x00, 0x00, 0x7F, 0x01, 0xF7,
        ]
        logical = [0x00, 0x59, 0x00, 0x01, 0x00, 0x00, 0x00, 0xFF]

        self.assertEqual(color_cmd.decode_usb_sysex(captured), logical)
        self.assertEqual(color_cmd.encode_usb_sysex(logical), captured)

    def test_known_red_packet_for_note_0x07(self) -> None:
        address = color_cmd.rgb_address(profile=0, pad_index=3)
        logical = color_cmd.usb_logical_packet(address, 0xFF, 0x00, 0x00)

        self.assertEqual(address, 0x126)
        self.assertEqual(
            logical,
            [
                0x00, 0x59, 0x22, 0x0B, 0x00, 0x00,
                0x05, 0x26, 0x01, 0x00, 0x00, 0x03,
                0x00, 0x00, 0xFF, 0x00, 0x00, 0xD1,
            ],
        )
        self.assertEqual(
            color_cmd.encode_usb_sysex(logical),
            [
                0xF0, 0x00, 0x32, 0x09, 0x59, 0x00, 0x00, 0x40,
                0x02, 0x26, 0x02, 0x00, 0x00, 0x30, 0x00, 0x00,
                0x00, 0x7F, 0x01, 0x00, 0x08, 0x0D, 0xF7,
            ],
        )
        self.assertEqual(
            color_cmd.ble_ae41_packet(address, 0xFF, 0x00, 0x00),
            [
                0x00, 0x59, 0x22, 0x0B, 0x00, 0x00, 0x00,
                0x05, 0x26, 0x01, 0x00, 0x00, 0x03, 0x00,
                0x00, 0xFF, 0x00, 0x00, 0xD1,
            ],
        )

    def test_usb_encoding_round_trips_and_is_midi_safe(self) -> None:
        logical = color_cmd.usb_logical_packet(0x126, 0x80, 0xFE, 0x7F)
        sysex = color_cmd.encode_usb_sysex(logical)

        self.assertEqual((sysex[0], sysex[-1]), (0xF0, 0xF7))
        self.assertTrue(all(byte < 0x80 for byte in sysex[1:-1]))
        self.assertEqual(independently_decode_sysex(sysex), logical)
        self.assertEqual(color_cmd.decode_usb_sysex(sysex), logical)

    def test_profile_and_pad_address_layout(self) -> None:
        self.assertEqual(color_cmd.rgb_address(0, 0), 216)
        self.assertEqual(color_cmd.rgb_address(1, 0), 3755)
        self.assertEqual(color_cmd.rgb_address(7, 127), 28291)

    def test_default_note_mapping_and_override(self) -> None:
        self.assertEqual(color_cmd.resolve_pad_index(0x04, None), 0)
        self.assertEqual(color_cmd.resolve_pad_index(0x23, None), 31)
        self.assertEqual(color_cmd.resolve_pad_index(0x40, 99), 99)
        with self.assertRaises(ValueError):
            color_cmd.resolve_pad_index(0x24, None)

    def test_checksums_make_complemented_region_sum_to_ff(self) -> None:
        logical = color_cmd.usb_logical_packet(0x126, 1, 2, 3)
        ble = color_cmd.ble_ae41_packet(0x126, 1, 2, 3)

        self.assertEqual(sum(logical[6:]) & 0xFF, 0xFF)
        self.assertEqual(sum(ble[6:]) & 0xFF, 0xFF)


if __name__ == "__main__":
    unittest.main()
