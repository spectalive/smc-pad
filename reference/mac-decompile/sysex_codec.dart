// lib: , url: package:musical_instruments/core/usb/sysex_codec.dart

// class id: 1049200, size: 0x8
class :: {
}

// class id: 361, size: 0x8, field offset: 0x8
abstract class SysexCodec extends Object {

  static _ packetData(/* No info */) {
    // ** addr: 0x1a4f58, size: 0x7c
    // 0x1a4f58: EnterFrame
    //     0x1a4f58: stp             fp, lr, [SP, #-0x10]!
    //     0x1a4f5c: mov             fp, SP
    // 0x1a4f60: AllocStack(0x10)
    //     0x1a4f60: sub             SP, SP, #0x10
    // 0x1a4f64: SetupParameters(dynamic _ /* r1 => r0, fp-0x8 */)
    //     0x1a4f64: mov             x0, x1
    //     0x1a4f68: stur            x1, [fp, #-8]
    // 0x1a4f6c: CheckStackOverflow
    //     0x1a4f6c: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a4f70: cmp             SP, x16
    //     0x1a4f74: b.ls            #0x1a4fcc
    // 0x1a4f78: mov             x1, x0
    // 0x1a4f7c: r0 = _readLe()
    //     0x1a4f7c: bl              #0x1a4fd4  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::_readLe
    // 0x1a4f80: add             x2, x0, #6
    // 0x1a4f84: adds            x0, x2, x2
    // 0x1a4f88: b.vc            #0x1a4f94
    // 0x1a4f8c: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x1a4f8c: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x1a4f90: StoreField: r0->field_7 = r2
    //     0x1a4f90: stur            x2, [x0, #7]
    // 0x1a4f94: ldur            x1, [fp, #-8]
    // 0x1a4f98: r2 = LoadClassIdInstr(r1)
    //     0x1a4f98: ldur            x2, [x1, #-1]
    //     0x1a4f9c: ubfx            x2, x2, #0xc, #0x14
    // 0x1a4fa0: str             x0, [SP]
    // 0x1a4fa4: mov             x0, x2
    // 0x1a4fa8: r2 = 6
    //     0x1a4fa8: mov             x2, #6
    // 0x1a4fac: r4 = const [0, 0x3, 0x1, 0x3, null]
    //     0x1a4fac: ldr             x4, [PP, #0x3b0]  ; [pp+0x3b0] List(5) [0, 0x3, 0x1, 0x3, Null]
    // 0x1a4fb0: r0 = GDT[cid_x0 + 0xb63b]()
    //     0x1a4fb0: mov             x17, #0xb63b
    //     0x1a4fb4: add             lr, x0, x17
    //     0x1a4fb8: ldr             lr, [x21, lr, lsl #3]
    //     0x1a4fbc: blr             lr
    // 0x1a4fc0: LeaveFrame
    //     0x1a4fc0: mov             SP, fp
    //     0x1a4fc4: ldp             fp, lr, [SP], #0x10
    // 0x1a4fc8: ret
    //     0x1a4fc8: ret             
    // 0x1a4fcc: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a4fcc: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a4fd0: b               #0x1a4f78
  }
  static _ _readLe(/* No info */) {
    // ** addr: 0x1a4fd4, size: 0xf8
    // 0x1a4fd4: EnterFrame
    //     0x1a4fd4: stp             fp, lr, [SP, #-0x10]!
    //     0x1a4fd8: mov             fp, SP
    // 0x1a4fdc: AllocStack(0x28)
    //     0x1a4fdc: sub             SP, SP, #0x28
    // 0x1a4fe0: SetupParameters(dynamic _ /* r1 => r2, fp-0x18 */)
    //     0x1a4fe0: mov             x2, x1
    //     0x1a4fe4: stur            x1, [fp, #-0x18]
    // 0x1a4fe8: CheckStackOverflow
    //     0x1a4fe8: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a4fec: cmp             SP, x16
    //     0x1a4ff0: b.ls            #0x1a5090
    // 0x1a4ff4: r4 = 0
    //     0x1a4ff4: mov             x4, #0
    // 0x1a4ff8: r3 = 0
    //     0x1a4ff8: mov             x3, #0
    // 0x1a4ffc: stur            x4, [fp, #-8]
    // 0x1a5000: stur            x3, [fp, #-0x10]
    // 0x1a5004: CheckStackOverflow
    //     0x1a5004: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a5008: cmp             SP, x16
    //     0x1a500c: b.ls            #0x1a5098
    // 0x1a5010: cmp             x3, #3
    // 0x1a5014: b.ge            #0x1a5080
    // 0x1a5018: add             x5, x3, #3
    // 0x1a501c: adds            x0, x5, x5
    // 0x1a5020: b.vc            #0x1a502c
    // 0x1a5024: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x1a5024: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x1a5028: StoreField: r0->field_7 = r5
    //     0x1a5028: stur            x5, [x0, #7]
    // 0x1a502c: r1 = LoadClassIdInstr(r2)
    //     0x1a502c: ldur            x1, [x2, #-1]
    //     0x1a5030: ubfx            x1, x1, #0xc, #0x14
    // 0x1a5034: stp             x0, x2, [SP]
    // 0x1a5038: mov             x0, x1
    // 0x1a503c: r0 = GDT[cid_x0 + -0xd18]()
    //     0x1a503c: sub             lr, x0, #0xd18
    //     0x1a5040: ldr             lr, [x21, lr, lsl #3]
    //     0x1a5044: blr             lr
    // 0x1a5048: ldur            x1, [fp, #-0x10]
    // 0x1a504c: lsl             x2, x1, #3
    // 0x1a5050: asr             x3, x0, #1
    // 0x1a5054: tbz             w0, #0, #0x1a505c
    // 0x1a5058: LoadField: r3 = r0->field_7
    //     0x1a5058: ldur            x3, [x0, #7]
    // 0x1a505c: cmp             x2, #0x3f
    // 0x1a5060: b.hi            #0x1a50a0
    // 0x1a5064: lsl             x4, x3, x2
    // 0x1a5068: ldur            x0, [fp, #-8]
    // 0x1a506c: orr             x2, x0, x4
    // 0x1a5070: add             x3, x1, #1
    // 0x1a5074: mov             x4, x2
    // 0x1a5078: ldur            x2, [fp, #-0x18]
    // 0x1a507c: b               #0x1a4ffc
    // 0x1a5080: mov             x0, x4
    // 0x1a5084: LeaveFrame
    //     0x1a5084: mov             SP, fp
    //     0x1a5088: ldp             fp, lr, [SP], #0x10
    // 0x1a508c: ret
    //     0x1a508c: ret             
    // 0x1a5090: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a5090: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a5094: b               #0x1a4ff4
    // 0x1a5098: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a5098: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a509c: b               #0x1a5010
    // 0x1a50a0: tbnz            x2, #0x3f, #0x1a50ac
    // 0x1a50a4: mov             x4, xzr
    // 0x1a50a8: b               #0x1a5068
    // 0x1a50ac: str             x2, [THR, #0x898]  ; THR::
    // 0x1a50b0: stp             x2, x3, [SP, #-0x10]!
    // 0x1a50b4: SaveReg r1
    //     0x1a50b4: str             x1, [SP, #-8]!
    // 0x1a50b8: ldr             x5, [THR, #0x468]  ; THR::ArgumentErrorUnboxedInt64
    // 0x1a50bc: r4 = 0
    //     0x1a50bc: mov             x4, #0
    // 0x1a50c0: ldr             lr, [THR, #0x208]  ; THR::call_to_runtime_entry_point
    // 0x1a50c4: blr             lr
    // 0x1a50c8: brk             #0
  }
  static _ verify(/* No info */) {
    // ** addr: 0x1a517c, size: 0x124
    // 0x1a517c: EnterFrame
    //     0x1a517c: stp             fp, lr, [SP, #-0x10]!
    //     0x1a5180: mov             fp, SP
    // 0x1a5184: AllocStack(0x28)
    //     0x1a5184: sub             SP, SP, #0x28
    // 0x1a5188: SetupParameters(dynamic _ /* r1 => r0, fp-0x8 */)
    //     0x1a5188: mov             x0, x1
    //     0x1a518c: stur            x1, [fp, #-8]
    // 0x1a5190: CheckStackOverflow
    //     0x1a5190: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a5194: cmp             SP, x16
    //     0x1a5198: b.ls            #0x1a5298
    // 0x1a519c: mov             x1, x0
    // 0x1a51a0: r0 = _readLe()
    //     0x1a51a0: bl              #0x1a4fd4  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::_readLe
    // 0x1a51a4: mov             x2, x0
    // 0x1a51a8: ldur            x1, [fp, #-8]
    // 0x1a51ac: stur            x2, [fp, #-0x10]
    // 0x1a51b0: r0 = LoadClassIdInstr(r1)
    //     0x1a51b0: ldur            x0, [x1, #-1]
    //     0x1a51b4: ubfx            x0, x0, #0xc, #0x14
    // 0x1a51b8: str             x1, [SP]
    // 0x1a51bc: r0 = GDT[cid_x0 + 0x800d]()
    //     0x1a51bc: mov             x17, #0x800d
    //     0x1a51c0: add             lr, x0, x17
    //     0x1a51c4: ldr             lr, [x21, lr, lsl #3]
    //     0x1a51c8: blr             lr
    // 0x1a51cc: mov             x1, x0
    // 0x1a51d0: ldur            x0, [fp, #-0x10]
    // 0x1a51d4: add             x2, x0, #6
    // 0x1a51d8: asr             x0, x1, #1
    // 0x1a51dc: cmp             x0, x2
    // 0x1a51e0: b.gt            #0x1a51f4
    // 0x1a51e4: r0 = false
    //     0x1a51e4: add             x0, NULL, #0x30  ; false
    // 0x1a51e8: LeaveFrame
    //     0x1a51e8: mov             SP, fp
    //     0x1a51ec: ldp             fp, lr, [SP], #0x10
    // 0x1a51f0: ret
    //     0x1a51f0: ret             
    // 0x1a51f4: ldur            x3, [fp, #-8]
    // 0x1a51f8: adds            x0, x2, x2
    // 0x1a51fc: b.vc            #0x1a5208
    // 0x1a5200: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x1a5200: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x1a5204: StoreField: r0->field_7 = r2
    //     0x1a5204: stur            x2, [x0, #7]
    // 0x1a5208: mov             x4, x0
    // 0x1a520c: stur            x4, [fp, #-0x18]
    // 0x1a5210: r0 = LoadClassIdInstr(r3)
    //     0x1a5210: ldur            x0, [x3, #-1]
    //     0x1a5214: ubfx            x0, x0, #0xc, #0x14
    // 0x1a5218: str             x4, [SP]
    // 0x1a521c: mov             x1, x3
    // 0x1a5220: r2 = 6
    //     0x1a5220: mov             x2, #6
    // 0x1a5224: r4 = const [0, 0x3, 0x1, 0x3, null]
    //     0x1a5224: ldr             x4, [PP, #0x3b0]  ; [pp+0x3b0] List(5) [0, 0x3, 0x1, 0x3, Null]
    // 0x1a5228: r0 = GDT[cid_x0 + 0xb63b]()
    //     0x1a5228: mov             x17, #0xb63b
    //     0x1a522c: add             lr, x0, x17
    //     0x1a5230: ldr             lr, [x21, lr, lsl #3]
    //     0x1a5234: blr             lr
    // 0x1a5238: mov             x1, x0
    // 0x1a523c: r0 = checksum()
    //     0x1a523c: bl              #0x1a52a0  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::checksum
    // 0x1a5240: mov             x1, x0
    // 0x1a5244: ldur            x0, [fp, #-8]
    // 0x1a5248: stur            x1, [fp, #-0x10]
    // 0x1a524c: r2 = LoadClassIdInstr(r0)
    //     0x1a524c: ldur            x2, [x0, #-1]
    //     0x1a5250: ubfx            x2, x2, #0xc, #0x14
    // 0x1a5254: ldur            x16, [fp, #-0x18]
    // 0x1a5258: stp             x16, x0, [SP]
    // 0x1a525c: mov             x0, x2
    // 0x1a5260: r0 = GDT[cid_x0 + -0xd18]()
    //     0x1a5260: sub             lr, x0, #0xd18
    //     0x1a5264: ldr             lr, [x21, lr, lsl #3]
    //     0x1a5268: blr             lr
    // 0x1a526c: asr             x1, x0, #1
    // 0x1a5270: tbz             w0, #0, #0x1a5278
    // 0x1a5274: LoadField: r1 = r0->field_7
    //     0x1a5274: ldur            x1, [x0, #7]
    // 0x1a5278: ldur            x2, [fp, #-0x10]
    // 0x1a527c: cmp             x2, x1
    // 0x1a5280: r16 = true
    //     0x1a5280: add             x16, NULL, #0x20  ; true
    // 0x1a5284: r17 = false
    //     0x1a5284: add             x17, NULL, #0x30  ; false
    // 0x1a5288: csel            x0, x16, x17, eq
    // 0x1a528c: LeaveFrame
    //     0x1a528c: mov             SP, fp
    //     0x1a5290: ldp             fp, lr, [SP], #0x10
    // 0x1a5294: ret
    //     0x1a5294: ret             
    // 0x1a5298: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a5298: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a529c: b               #0x1a519c
  }
  static _ checksum(/* No info */) {
    // ** addr: 0x1a52a0, size: 0xe4
    // 0x1a52a0: EnterFrame
    //     0x1a52a0: stp             fp, lr, [SP, #-0x10]!
    //     0x1a52a4: mov             fp, SP
    // 0x1a52a8: AllocStack(0x10)
    //     0x1a52a8: sub             SP, SP, #0x10
    // 0x1a52ac: CheckStackOverflow
    //     0x1a52ac: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a52b0: cmp             SP, x16
    //     0x1a52b4: b.ls            #0x1a5374
    // 0x1a52b8: r0 = LoadClassIdInstr(r1)
    //     0x1a52b8: ldur            x0, [x1, #-1]
    //     0x1a52bc: ubfx            x0, x0, #0xc, #0x14
    // 0x1a52c0: r0 = GDT[cid_x0 + 0x98d0]()
    //     0x1a52c0: mov             x17, #0x98d0
    //     0x1a52c4: add             lr, x0, x17
    //     0x1a52c8: ldr             lr, [x21, lr, lsl #3]
    //     0x1a52cc: blr             lr
    // 0x1a52d0: mov             x2, x0
    // 0x1a52d4: stur            x2, [fp, #-0x10]
    // 0x1a52d8: r3 = 0
    //     0x1a52d8: mov             x3, #0
    // 0x1a52dc: stur            x3, [fp, #-8]
    // 0x1a52e0: CheckStackOverflow
    //     0x1a52e0: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a52e4: cmp             SP, x16
    //     0x1a52e8: b.ls            #0x1a537c
    // 0x1a52ec: r0 = LoadClassIdInstr(r2)
    //     0x1a52ec: ldur            x0, [x2, #-1]
    //     0x1a52f0: ubfx            x0, x0, #0xc, #0x14
    // 0x1a52f4: mov             x1, x2
    // 0x1a52f8: r0 = GDT[cid_x0 + 0x348]()
    //     0x1a52f8: add             lr, x0, #0x348
    //     0x1a52fc: ldr             lr, [x21, lr, lsl #3]
    //     0x1a5300: blr             lr
    // 0x1a5304: tbnz            w0, #4, #0x1a5350
    // 0x1a5308: ldur            x2, [fp, #-0x10]
    // 0x1a530c: r0 = LoadClassIdInstr(r2)
    //     0x1a530c: ldur            x0, [x2, #-1]
    //     0x1a5310: ubfx            x0, x0, #0xc, #0x14
    // 0x1a5314: mov             x1, x2
    // 0x1a5318: r0 = GDT[cid_x0 + 0x361]()
    //     0x1a5318: add             lr, x0, #0x361
    //     0x1a531c: ldr             lr, [x21, lr, lsl #3]
    //     0x1a5320: blr             lr
    // 0x1a5324: asr             x1, x0, #1
    // 0x1a5328: tbz             w0, #0, #0x1a5330
    // 0x1a532c: LoadField: r1 = r0->field_7
    //     0x1a532c: ldur            x1, [x0, #7]
    // 0x1a5330: ldur            x2, [fp, #-8]
    // 0x1a5334: ubfx            x2, x2, #0, #0x20
    // 0x1a5338: add             w3, w2, w1
    // 0x1a533c: and             w1, w3, #0xff
    // 0x1a5340: ubfx            x1, x1, #0, #0x20
    // 0x1a5344: mov             x3, x1
    // 0x1a5348: ldur            x2, [fp, #-0x10]
    // 0x1a534c: b               #0x1a52dc
    // 0x1a5350: ldur            x1, [fp, #-8]
    // 0x1a5354: ubfx            x1, x1, #0, #0x20
    // 0x1a5358: mvn             w2, w1
    // 0x1a535c: and             w1, w2, #0xff
    // 0x1a5360: ubfx            x1, x1, #0, #0x20
    // 0x1a5364: mov             x0, x1
    // 0x1a5368: LeaveFrame
    //     0x1a5368: mov             SP, fp
    //     0x1a536c: ldp             fp, lr, [SP], #0x10
    // 0x1a5370: ret
    //     0x1a5370: ret             
    // 0x1a5374: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a5374: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a5378: b               #0x1a52b8
    // 0x1a537c: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a537c: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a5380: b               #0x1a52ec
  }
  static _ packetCmd(/* No info */) {
    // ** addr: 0x1a5384, size: 0x58
    // 0x1a5384: EnterFrame
    //     0x1a5384: stp             fp, lr, [SP, #-0x10]!
    //     0x1a5388: mov             fp, SP
    // 0x1a538c: AllocStack(0x10)
    //     0x1a538c: sub             SP, SP, #0x10
    // 0x1a5390: CheckStackOverflow
    //     0x1a5390: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a5394: cmp             SP, x16
    //     0x1a5398: b.ls            #0x1a53d4
    // 0x1a539c: r0 = LoadClassIdInstr(r1)
    //     0x1a539c: ldur            x0, [x1, #-1]
    //     0x1a53a0: ubfx            x0, x0, #0xc, #0x14
    // 0x1a53a4: r16 = 4
    //     0x1a53a4: mov             x16, #4
    // 0x1a53a8: stp             x16, x1, [SP]
    // 0x1a53ac: r0 = GDT[cid_x0 + -0xd18]()
    //     0x1a53ac: sub             lr, x0, #0xd18
    //     0x1a53b0: ldr             lr, [x21, lr, lsl #3]
    //     0x1a53b4: blr             lr
    // 0x1a53b8: asr             x1, x0, #1
    // 0x1a53bc: tbz             w0, #0, #0x1a53c4
    // 0x1a53c0: LoadField: r1 = r0->field_7
    //     0x1a53c0: ldur            x1, [x0, #7]
    // 0x1a53c4: mov             x0, x1
    // 0x1a53c8: LeaveFrame
    //     0x1a53c8: mov             SP, fp
    //     0x1a53cc: ldp             fp, lr, [SP], #0x10
    // 0x1a53d0: ret
    //     0x1a53d0: ret             
    // 0x1a53d4: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a53d4: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a53d8: b               #0x1a539c
  }
  static _ toMidi(/* No info */) {
    // ** addr: 0x1a5a1c, size: 0x320
    // 0x1a5a1c: EnterFrame
    //     0x1a5a1c: stp             fp, lr, [SP, #-0x10]!
    //     0x1a5a20: mov             fp, SP
    // 0x1a5a24: AllocStack(0x50)
    //     0x1a5a24: sub             SP, SP, #0x50
    // 0x1a5a28: r0 = 2
    //     0x1a5a28: mov             x0, #2
    // 0x1a5a2c: mov             x3, x1
    // 0x1a5a30: stur            x1, [fp, #-8]
    // 0x1a5a34: CheckStackOverflow
    //     0x1a5a34: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a5a38: cmp             SP, x16
    //     0x1a5a3c: b.ls            #0x1a5ce0
    // 0x1a5a40: mov             x2, x0
    // 0x1a5a44: r1 = Null
    //     0x1a5a44: mov             x1, NULL
    // 0x1a5a48: r0 = AllocateArray()
    //     0x1a5a48: bl              #0x42a740  ; AllocateArrayStub
    // 0x1a5a4c: stur            x0, [fp, #-0x10]
    // 0x1a5a50: r16 = 480
    //     0x1a5a50: mov             x16, #0x1e0
    // 0x1a5a54: ArrayStore: r0[0] = r16  ; List_8
    //     0x1a5a54: stur            x16, [x0, #0x17]
    // 0x1a5a58: r1 = <int>
    //     0x1a5a58: ldr             x1, [PP, #0xa70]  ; [pp+0xa70] TypeArguments: <int>
    // 0x1a5a5c: r0 = AllocateGrowableArray()
    //     0x1a5a5c: bl              #0x429618  ; AllocateGrowableArrayStub
    // 0x1a5a60: mov             x2, x0
    // 0x1a5a64: ldur            x0, [fp, #-0x10]
    // 0x1a5a68: stur            x2, [fp, #-0x48]
    // 0x1a5a6c: ArrayStore: r2[0] = r0  ; List_8
    //     0x1a5a6c: stur            x0, [x2, #0x17]
    // 0x1a5a70: r1 = 2
    //     0x1a5a70: mov             x1, #2
    // 0x1a5a74: StoreField: r2->field_f = r1
    //     0x1a5a74: stur            x1, [x2, #0xf]
    // 0x1a5a78: ldur            x3, [fp, #-8]
    // 0x1a5a7c: LoadField: r1 = r3->field_f
    //     0x1a5a7c: ldur            x1, [x3, #0xf]
    // 0x1a5a80: asr             x4, x1, #1
    // 0x1a5a84: stur            x4, [fp, #-0x40]
    // 0x1a5a88: mov             x1, x0
    // 0x1a5a8c: r7 = 0
    //     0x1a5a8c: mov             x7, #0
    // 0x1a5a90: r6 = 0
    //     0x1a5a90: mov             x6, #0
    // 0x1a5a94: r5 = 1
    //     0x1a5a94: mov             x5, #1
    // 0x1a5a98: r0 = 0
    //     0x1a5a98: mov             x0, #0
    // 0x1a5a9c: stur            x5, [fp, #-0x50]
    // 0x1a5aa0: CheckStackOverflow
    //     0x1a5aa0: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a5aa4: cmp             SP, x16
    //     0x1a5aa8: b.ls            #0x1a5ce8
    // 0x1a5aac: LoadField: r8 = r3->field_f
    //     0x1a5aac: ldur            x8, [x3, #0xf]
    // 0x1a5ab0: asr             x9, x8, #1
    // 0x1a5ab4: cmp             x4, x9
    // 0x1a5ab8: b.ne            #0x1a5cc0
    // 0x1a5abc: cmp             x0, x9
    // 0x1a5ac0: b.ge            #0x1a5bd4
    // 0x1a5ac4: ArrayLoad: r8 = r3[0]  ; List_8
    //     0x1a5ac4: ldur            x8, [x3, #0x17]
    // 0x1a5ac8: ArrayLoad: r9 = r8[r0]  ; List_8
    //     0x1a5ac8: add             x16, x8, x0, lsl #3
    //     0x1a5acc: ldur            x9, [x16, #0x17]
    // 0x1a5ad0: add             x8, x0, #1
    // 0x1a5ad4: stur            x8, [fp, #-0x38]
    // 0x1a5ad8: asr             x0, x9, #1
    // 0x1a5adc: tbz             w9, #0, #0x1a5ae4
    // 0x1a5ae0: LoadField: r0 = r9->field_7
    //     0x1a5ae0: ldur            x0, [x9, #7]
    // 0x1a5ae4: cmp             x6, #0x3f
    // 0x1a5ae8: b.hi            #0x1a5cf0
    // 0x1a5aec: lsl             x9, x0, x6
    // 0x1a5af0: orr             x0, x7, x9
    // 0x1a5af4: add             x7, x6, #8
    // 0x1a5af8: mov             x6, x7
    // 0x1a5afc: mov             x7, x0
    // 0x1a5b00: mov             x0, x5
    // 0x1a5b04: stur            x7, [fp, #-0x20]
    // 0x1a5b08: stur            x6, [fp, #-0x28]
    // 0x1a5b0c: stur            x0, [fp, #-0x30]
    // 0x1a5b10: CheckStackOverflow
    //     0x1a5b10: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a5b14: cmp             SP, x16
    //     0x1a5b18: b.ls            #0x1a5d28
    // 0x1a5b1c: cmp             x6, #7
    // 0x1a5b20: b.lt            #0x1a5bbc
    // 0x1a5b24: mov             x5, x7
    // 0x1a5b28: ubfx            x5, x5, #0, #0x20
    // 0x1a5b2c: and             w9, w5, #0x7f
    // 0x1a5b30: stur            x9, [fp, #-0x18]
    // 0x1a5b34: LoadField: r5 = r1->field_f
    //     0x1a5b34: ldur            x5, [x1, #0xf]
    // 0x1a5b38: asr             x1, x5, #1
    // 0x1a5b3c: cmp             x0, x1
    // 0x1a5b40: b.ne            #0x1a5b4c
    // 0x1a5b44: mov             x1, x2
    // 0x1a5b48: r0 = _growToNextCapacity()
    //     0x1a5b48: bl              #0x106e8  ; [dart:core] _GrowableList::_growToNextCapacity
    // 0x1a5b4c: ldur            x7, [fp, #-0x20]
    // 0x1a5b50: ldur            x6, [fp, #-0x28]
    // 0x1a5b54: ldur            x4, [fp, #-0x18]
    // 0x1a5b58: ldur            x2, [fp, #-0x48]
    // 0x1a5b5c: ldur            x3, [fp, #-0x30]
    // 0x1a5b60: add             x5, x3, #1
    // 0x1a5b64: adds            x0, x5, x5
    // 0x1a5b68: b.vc            #0x1a5b74
    // 0x1a5b6c: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x1a5b6c: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x1a5b70: StoreField: r0->field_7 = r5
    //     0x1a5b70: stur            x5, [x0, #7]
    // 0x1a5b74: StoreField: r2->field_f = r0
    //     0x1a5b74: stur            x0, [x2, #0xf]
    // 0x1a5b78: mov             x0, x5
    // 0x1a5b7c: mov             x1, x3
    // 0x1a5b80: cmp             x1, x0
    // 0x1a5b84: b.hs            #0x1a5d30
    // 0x1a5b88: ArrayLoad: r1 = r2[0]  ; List_8
    //     0x1a5b88: ldur            x1, [x2, #0x17]
    // 0x1a5b8c: ubfiz           x0, x4, #1, #0x20
    // 0x1a5b90: ArrayStore: r1[r3] = r0  ; List_8
    //     0x1a5b90: add             x4, x1, x3, lsl #3
    //     0x1a5b94: stur            x0, [x4, #0x17]
    // 0x1a5b98: asr             x3, x7, #7
    // 0x1a5b9c: sub             x4, x6, #7
    // 0x1a5ba0: mov             x7, x3
    // 0x1a5ba4: mov             x6, x4
    // 0x1a5ba8: mov             x0, x5
    // 0x1a5bac: ldur            x3, [fp, #-8]
    // 0x1a5bb0: ldur            x8, [fp, #-0x38]
    // 0x1a5bb4: ldur            x4, [fp, #-0x40]
    // 0x1a5bb8: b               #0x1a5b04
    // 0x1a5bbc: mov             x3, x0
    // 0x1a5bc0: mov             x5, x3
    // 0x1a5bc4: ldur            x0, [fp, #-0x38]
    // 0x1a5bc8: ldur            x3, [fp, #-8]
    // 0x1a5bcc: ldur            x4, [fp, #-0x40]
    // 0x1a5bd0: b               #0x1a5a9c
    // 0x1a5bd4: cbz             x6, #0x1a5c48
    // 0x1a5bd8: ubfx            x7, x7, #0, #0x20
    // 0x1a5bdc: and             w0, w7, #0x7f
    // 0x1a5be0: stur            x0, [fp, #-0x18]
    // 0x1a5be4: LoadField: r3 = r1->field_f
    //     0x1a5be4: ldur            x3, [x1, #0xf]
    // 0x1a5be8: asr             x1, x3, #1
    // 0x1a5bec: cmp             x5, x1
    // 0x1a5bf0: b.ne            #0x1a5bfc
    // 0x1a5bf4: mov             x1, x2
    // 0x1a5bf8: r0 = _growToNextCapacity()
    //     0x1a5bf8: bl              #0x106e8  ; [dart:core] _GrowableList::_growToNextCapacity
    // 0x1a5bfc: ldur            x4, [fp, #-0x18]
    // 0x1a5c00: ldur            x3, [fp, #-0x48]
    // 0x1a5c04: ldur            x2, [fp, #-0x50]
    // 0x1a5c08: add             x5, x2, #1
    // 0x1a5c0c: adds            x0, x5, x5
    // 0x1a5c10: b.vc            #0x1a5c1c
    // 0x1a5c14: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x1a5c14: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x1a5c18: StoreField: r0->field_7 = r5
    //     0x1a5c18: stur            x5, [x0, #7]
    // 0x1a5c1c: StoreField: r3->field_f = r0
    //     0x1a5c1c: stur            x0, [x3, #0xf]
    // 0x1a5c20: mov             x0, x5
    // 0x1a5c24: mov             x1, x2
    // 0x1a5c28: cmp             x1, x0
    // 0x1a5c2c: b.hs            #0x1a5d34
    // 0x1a5c30: ArrayLoad: r0 = r3[0]  ; List_8
    //     0x1a5c30: ldur            x0, [x3, #0x17]
    // 0x1a5c34: ubfiz           x1, x4, #1, #0x20
    // 0x1a5c38: ArrayStore: r0[r2] = r1  ; List_8
    //     0x1a5c38: add             x4, x0, x2, lsl #3
    //     0x1a5c3c: stur            x1, [x4, #0x17]
    // 0x1a5c40: mov             x2, x5
    // 0x1a5c44: b               #0x1a5c54
    // 0x1a5c48: mov             x3, x2
    // 0x1a5c4c: mov             x2, x5
    // 0x1a5c50: mov             x0, x1
    // 0x1a5c54: stur            x2, [fp, #-0x18]
    // 0x1a5c58: LoadField: r1 = r0->field_f
    //     0x1a5c58: ldur            x1, [x0, #0xf]
    // 0x1a5c5c: asr             x0, x1, #1
    // 0x1a5c60: cmp             x2, x0
    // 0x1a5c64: b.ne            #0x1a5c70
    // 0x1a5c68: mov             x1, x3
    // 0x1a5c6c: r0 = _growToNextCapacity()
    //     0x1a5c6c: bl              #0x106e8  ; [dart:core] _GrowableList::_growToNextCapacity
    // 0x1a5c70: ldur            x2, [fp, #-0x48]
    // 0x1a5c74: ldur            x3, [fp, #-0x18]
    // 0x1a5c78: add             x4, x3, #1
    // 0x1a5c7c: adds            x0, x4, x4
    // 0x1a5c80: b.vc            #0x1a5c8c
    // 0x1a5c84: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x1a5c84: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x1a5c88: StoreField: r0->field_7 = r4
    //     0x1a5c88: stur            x4, [x0, #7]
    // 0x1a5c8c: StoreField: r2->field_f = r0
    //     0x1a5c8c: stur            x0, [x2, #0xf]
    // 0x1a5c90: mov             x0, x4
    // 0x1a5c94: mov             x1, x3
    // 0x1a5c98: cmp             x1, x0
    // 0x1a5c9c: b.hs            #0x1a5d38
    // 0x1a5ca0: ArrayLoad: r0 = r2[0]  ; List_8
    //     0x1a5ca0: ldur            x0, [x2, #0x17]
    // 0x1a5ca4: add             x1, x0, x3, lsl #3
    // 0x1a5ca8: r16 = 494
    //     0x1a5ca8: mov             x16, #0x1ee
    // 0x1a5cac: ArrayStore: r1[0] = r16  ; List_8
    //     0x1a5cac: stur            x16, [x1, #0x17]
    // 0x1a5cb0: mov             x0, x2
    // 0x1a5cb4: LeaveFrame
    //     0x1a5cb4: mov             SP, fp
    //     0x1a5cb8: ldp             fp, lr, [SP], #0x10
    // 0x1a5cbc: ret
    //     0x1a5cbc: ret             
    // 0x1a5cc0: mov             x0, x3
    // 0x1a5cc4: r0 = ConcurrentModificationError()
    //     0x1a5cc4: bl              #0x10b64  ; AllocateConcurrentModificationErrorStub -> ConcurrentModificationError (size=0x18)
    // 0x1a5cc8: mov             x1, x0
    // 0x1a5ccc: ldur            x0, [fp, #-8]
    // 0x1a5cd0: StoreField: r1->field_f = r0
    //     0x1a5cd0: stur            x0, [x1, #0xf]
    // 0x1a5cd4: mov             x0, x1
    // 0x1a5cd8: r0 = Throw()
    //     0x1a5cd8: bl              #0x42898c  ; ThrowStub
    // 0x1a5cdc: brk             #0
    // 0x1a5ce0: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a5ce0: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a5ce4: b               #0x1a5a40
    // 0x1a5ce8: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a5ce8: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a5cec: b               #0x1a5aac
    // 0x1a5cf0: tbnz            x6, #0x3f, #0x1a5cfc
    // 0x1a5cf4: mov             x9, xzr
    // 0x1a5cf8: b               #0x1a5af0
    // 0x1a5cfc: str             x6, [THR, #0x898]  ; THR::
    // 0x1a5d00: stp             x7, x8, [SP, #-0x10]!
    // 0x1a5d04: stp             x5, x6, [SP, #-0x10]!
    // 0x1a5d08: stp             x3, x4, [SP, #-0x10]!
    // 0x1a5d0c: stp             x1, x2, [SP, #-0x10]!
    // 0x1a5d10: SaveReg r0
    //     0x1a5d10: str             x0, [SP, #-8]!
    // 0x1a5d14: ldr             x5, [THR, #0x468]  ; THR::ArgumentErrorUnboxedInt64
    // 0x1a5d18: r4 = 0
    //     0x1a5d18: mov             x4, #0
    // 0x1a5d1c: ldr             lr, [THR, #0x208]  ; THR::call_to_runtime_entry_point
    // 0x1a5d20: blr             lr
    // 0x1a5d24: brk             #0
    // 0x1a5d28: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a5d28: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a5d2c: b               #0x1a5b1c
    // 0x1a5d30: r0 = RangeErrorSharedWithoutFPURegs()
    //     0x1a5d30: bl              #0x42ad74  ; RangeErrorSharedWithoutFPURegsStub
    // 0x1a5d34: r0 = RangeErrorSharedWithoutFPURegs()
    //     0x1a5d34: bl              #0x42ad74  ; RangeErrorSharedWithoutFPURegsStub
    // 0x1a5d38: r0 = RangeErrorSharedWithoutFPURegs()
    //     0x1a5d38: bl              #0x42ad74  ; RangeErrorSharedWithoutFPURegsStub
  }
  static List<int> queryPacket() {
    // ** addr: 0x1a5eb4, size: 0x38
    // 0x1a5eb4: EnterFrame
    //     0x1a5eb4: stp             fp, lr, [SP, #-0x10]!
    //     0x1a5eb8: mov             fp, SP
    // 0x1a5ebc: CheckStackOverflow
    //     0x1a5ebc: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a5ec0: cmp             SP, x16
    //     0x1a5ec4: b.ls            #0x1a5ee4
    // 0x1a5ec8: r1 = 17
    //     0x1a5ec8: mov             x1, #0x11
    // 0x1a5ecc: r2 = const []
    //     0x1a5ecc: add             x2, PP, #0xb, lsl #12  ; [pp+0xba88] List<int>(0)
    //     0x1a5ed0: ldr             x2, [x2, #0xa88]
    // 0x1a5ed4: r0 = packet()
    //     0x1a5ed4: bl              #0x1a5eec  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::packet
    // 0x1a5ed8: LeaveFrame
    //     0x1a5ed8: mov             SP, fp
    //     0x1a5edc: ldp             fp, lr, [SP], #0x10
    // 0x1a5ee0: ret
    //     0x1a5ee0: ret             
    // 0x1a5ee4: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a5ee4: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a5ee8: b               #0x1a5ec8
  }
  static _ packet(/* No info */) {
    // ** addr: 0x1a5eec, size: 0x164
    // 0x1a5eec: EnterFrame
    //     0x1a5eec: stp             fp, lr, [SP, #-0x10]!
    //     0x1a5ef0: mov             fp, SP
    // 0x1a5ef4: AllocStack(0x30)
    //     0x1a5ef4: sub             SP, SP, #0x30
    // 0x1a5ef8: r0 = 6
    //     0x1a5ef8: mov             x0, #6
    // 0x1a5efc: mov             x4, x1
    // 0x1a5f00: mov             x3, x2
    // 0x1a5f04: stur            x1, [fp, #-8]
    // 0x1a5f08: stur            x2, [fp, #-0x10]
    // 0x1a5f0c: CheckStackOverflow
    //     0x1a5f0c: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a5f10: cmp             SP, x16
    //     0x1a5f14: b.ls            #0x1a6048
    // 0x1a5f18: mov             x2, x0
    // 0x1a5f1c: r1 = Null
    //     0x1a5f1c: mov             x1, NULL
    // 0x1a5f20: r0 = AllocateArray()
    //     0x1a5f20: bl              #0x42a740  ; AllocateArrayStub
    // 0x1a5f24: stur            x0, [fp, #-0x18]
    // 0x1a5f28: ArrayStore: r0[0] = rZR  ; List_8
    //     0x1a5f28: stur            xzr, [x0, #0x17]
    // 0x1a5f2c: r16 = 178
    //     0x1a5f2c: mov             x16, #0xb2
    // 0x1a5f30: StoreField: r0->field_1f = r16
    //     0x1a5f30: stur            x16, [x0, #0x1f]
    // 0x1a5f34: ldur            x1, [fp, #-8]
    // 0x1a5f38: lsl             x2, x1, #1
    // 0x1a5f3c: StoreField: r0->field_27 = r2
    //     0x1a5f3c: stur            x2, [x0, #0x27]
    // 0x1a5f40: r1 = <int>
    //     0x1a5f40: ldr             x1, [PP, #0xa70]  ; [pp+0xa70] TypeArguments: <int>
    // 0x1a5f44: r0 = AllocateGrowableArray()
    //     0x1a5f44: bl              #0x429618  ; AllocateGrowableArrayStub
    // 0x1a5f48: mov             x1, x0
    // 0x1a5f4c: ldur            x0, [fp, #-0x18]
    // 0x1a5f50: stur            x1, [fp, #-0x20]
    // 0x1a5f54: ArrayStore: r1[0] = r0  ; List_8
    //     0x1a5f54: stur            x0, [x1, #0x17]
    // 0x1a5f58: r0 = 6
    //     0x1a5f58: mov             x0, #6
    // 0x1a5f5c: StoreField: r1->field_f = r0
    //     0x1a5f5c: stur            x0, [x1, #0xf]
    // 0x1a5f60: ldur            x2, [fp, #-0x10]
    // 0x1a5f64: r0 = LoadClassIdInstr(r2)
    //     0x1a5f64: ldur            x0, [x2, #-1]
    //     0x1a5f68: ubfx            x0, x0, #0xc, #0x14
    // 0x1a5f6c: str             x2, [SP]
    // 0x1a5f70: r0 = GDT[cid_x0 + 0x800d]()
    //     0x1a5f70: mov             x17, #0x800d
    //     0x1a5f74: add             lr, x0, x17
    //     0x1a5f78: ldr             lr, [x21, lr, lsl #3]
    //     0x1a5f7c: blr             lr
    // 0x1a5f80: asr             x1, x0, #1
    // 0x1a5f84: r2 = 3
    //     0x1a5f84: mov             x2, #3
    // 0x1a5f88: r0 = _le()
    //     0x1a5f88: bl              #0x1a6050  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::_le
    // 0x1a5f8c: ldur            x1, [fp, #-0x20]
    // 0x1a5f90: mov             x2, x0
    // 0x1a5f94: r0 = addAll()
    //     0x1a5f94: bl              #0x11280  ; [dart:core] _GrowableList::addAll
    // 0x1a5f98: ldur            x1, [fp, #-0x20]
    // 0x1a5f9c: ldur            x2, [fp, #-0x10]
    // 0x1a5fa0: r0 = addAll()
    //     0x1a5fa0: bl              #0x11280  ; [dart:core] _GrowableList::addAll
    // 0x1a5fa4: ldur            x1, [fp, #-0x10]
    // 0x1a5fa8: r0 = checksum()
    //     0x1a5fa8: bl              #0x1a52a0  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::checksum
    // 0x1a5fac: mov             x2, x0
    // 0x1a5fb0: ldur            x0, [fp, #-0x20]
    // 0x1a5fb4: stur            x2, [fp, #-0x28]
    // 0x1a5fb8: LoadField: r1 = r0->field_f
    //     0x1a5fb8: ldur            x1, [x0, #0xf]
    // 0x1a5fbc: ArrayLoad: r3 = r0[0]  ; List_8
    //     0x1a5fbc: ldur            x3, [x0, #0x17]
    // 0x1a5fc0: LoadField: r4 = r3->field_f
    //     0x1a5fc0: ldur            x4, [x3, #0xf]
    // 0x1a5fc4: asr             x3, x1, #1
    // 0x1a5fc8: stur            x3, [fp, #-8]
    // 0x1a5fcc: asr             x1, x4, #1
    // 0x1a5fd0: cmp             x3, x1
    // 0x1a5fd4: b.ne            #0x1a5fe0
    // 0x1a5fd8: mov             x1, x0
    // 0x1a5fdc: r0 = _growToNextCapacity()
    //     0x1a5fdc: bl              #0x106e8  ; [dart:core] _GrowableList::_growToNextCapacity
    // 0x1a5fe0: ldur            x3, [fp, #-0x28]
    // 0x1a5fe4: ldur            x2, [fp, #-0x20]
    // 0x1a5fe8: ldur            x4, [fp, #-8]
    // 0x1a5fec: add             x5, x4, #1
    // 0x1a5ff0: lsl             x6, x5, #1
    // 0x1a5ff4: StoreField: r2->field_f = r6
    //     0x1a5ff4: stur            x6, [x2, #0xf]
    // 0x1a5ff8: ArrayLoad: r5 = r2[0]  ; List_8
    //     0x1a5ff8: ldur            x5, [x2, #0x17]
    // 0x1a5ffc: adds            x0, x3, x3
    // 0x1a6000: b.vc            #0x1a600c
    // 0x1a6004: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x1a6004: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x1a6008: StoreField: r0->field_7 = r3
    //     0x1a6008: stur            x3, [x0, #7]
    // 0x1a600c: mov             x1, x5
    // 0x1a6010: ArrayStore: r1[r4] = r0  ; List_8
    //     0x1a6010: add             x25, x1, x4, lsl #3
    //     0x1a6014: add             x25, x25, #0x17
    //     0x1a6018: str             x0, [x25]
    //     0x1a601c: tbz             w0, #0, #0x1a6038
    //     0x1a6020: ldurb           w16, [x1, #-1]
    //     0x1a6024: ldurb           w17, [x0, #-1]
    //     0x1a6028: and             x16, x17, x16, lsr #2
    //     0x1a602c: tst             x16, HEAP, lsr #32
    //     0x1a6030: b.eq            #0x1a6038
    //     0x1a6034: bl              #0x4289b0  ; ArrayWriteBarrierStub
    // 0x1a6038: mov             x0, x2
    // 0x1a603c: LeaveFrame
    //     0x1a603c: mov             SP, fp
    //     0x1a6040: ldp             fp, lr, [SP], #0x10
    // 0x1a6044: ret
    //     0x1a6044: ret             
    // 0x1a6048: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a6048: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a604c: b               #0x1a5f18
  }
  static _ _le(/* No info */) {
    // ** addr: 0x1a6050, size: 0x120
    // 0x1a6050: EnterFrame
    //     0x1a6050: stp             fp, lr, [SP, #-0x10]!
    //     0x1a6054: mov             fp, SP
    // 0x1a6058: AllocStack(0x30)
    //     0x1a6058: sub             SP, SP, #0x30
    // 0x1a605c: SetupParameters(dynamic _ /* r1 => r3, fp-0x8 */, dynamic _ /* r2 => r0, fp-0x10 */)
    //     0x1a605c: mov             x3, x1
    //     0x1a6060: mov             x0, x2
    //     0x1a6064: stur            x1, [fp, #-8]
    //     0x1a6068: stur            x2, [fp, #-0x10]
    // 0x1a606c: CheckStackOverflow
    //     0x1a606c: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a6070: cmp             SP, x16
    //     0x1a6074: b.ls            #0x1a6130
    // 0x1a6078: r1 = <int>
    //     0x1a6078: ldr             x1, [PP, #0xa70]  ; [pp+0xa70] TypeArguments: <int>
    // 0x1a607c: r2 = 0
    //     0x1a607c: mov             x2, #0
    // 0x1a6080: r0 = _GrowableList()
    //     0x1a6080: bl              #0x108d8  ; [dart:core] _GrowableList::_GrowableList
    // 0x1a6084: stur            x0, [fp, #-0x30]
    // 0x1a6088: r4 = 0
    //     0x1a6088: mov             x4, #0
    // 0x1a608c: ldur            x3, [fp, #-8]
    // 0x1a6090: ldur            x2, [fp, #-0x10]
    // 0x1a6094: stur            x4, [fp, #-0x28]
    // 0x1a6098: CheckStackOverflow
    //     0x1a6098: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a609c: cmp             SP, x16
    //     0x1a60a0: b.ls            #0x1a6138
    // 0x1a60a4: cmp             x4, x2
    // 0x1a60a8: b.ge            #0x1a6124
    // 0x1a60ac: lsl             x1, x4, #3
    // 0x1a60b0: cmp             x1, #0x3f
    // 0x1a60b4: b.hi            #0x1a6140
    // 0x1a60b8: asr             x5, x3, x1
    // 0x1a60bc: ubfx            x5, x5, #0, #0x20
    // 0x1a60c0: and             w6, w5, #0xff
    // 0x1a60c4: stur            x6, [fp, #-0x20]
    // 0x1a60c8: LoadField: r1 = r0->field_f
    //     0x1a60c8: ldur            x1, [x0, #0xf]
    // 0x1a60cc: ArrayLoad: r5 = r0[0]  ; List_8
    //     0x1a60cc: ldur            x5, [x0, #0x17]
    // 0x1a60d0: LoadField: r7 = r5->field_f
    //     0x1a60d0: ldur            x7, [x5, #0xf]
    // 0x1a60d4: asr             x5, x1, #1
    // 0x1a60d8: stur            x5, [fp, #-0x18]
    // 0x1a60dc: asr             x1, x7, #1
    // 0x1a60e0: cmp             x5, x1
    // 0x1a60e4: b.ne            #0x1a60f0
    // 0x1a60e8: mov             x1, x0
    // 0x1a60ec: r0 = _growToNextCapacity()
    //     0x1a60ec: bl              #0x106e8  ; [dart:core] _GrowableList::_growToNextCapacity
    // 0x1a60f0: ldur            x0, [fp, #-0x30]
    // 0x1a60f4: ldur            x1, [fp, #-0x28]
    // 0x1a60f8: ldur            x2, [fp, #-0x20]
    // 0x1a60fc: ldur            x3, [fp, #-0x18]
    // 0x1a6100: add             x4, x3, #1
    // 0x1a6104: lsl             x5, x4, #1
    // 0x1a6108: StoreField: r0->field_f = r5
    //     0x1a6108: stur            x5, [x0, #0xf]
    // 0x1a610c: ArrayLoad: r4 = r0[0]  ; List_8
    //     0x1a610c: ldur            x4, [x0, #0x17]
    // 0x1a6110: ubfiz           x5, x2, #1, #0x20
    // 0x1a6114: ArrayStore: r4[r3] = r5  ; List_8
    //     0x1a6114: add             x2, x4, x3, lsl #3
    //     0x1a6118: stur            x5, [x2, #0x17]
    // 0x1a611c: add             x4, x1, #1
    // 0x1a6120: b               #0x1a608c
    // 0x1a6124: LeaveFrame
    //     0x1a6124: mov             SP, fp
    //     0x1a6128: ldp             fp, lr, [SP], #0x10
    // 0x1a612c: ret
    //     0x1a612c: ret             
    // 0x1a6130: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a6130: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a6134: b               #0x1a6078
    // 0x1a6138: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a6138: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a613c: b               #0x1a60a4
    // 0x1a6140: tbnz            x1, #0x3f, #0x1a614c
    // 0x1a6144: asr             x5, x3, #0x3f
    // 0x1a6148: b               #0x1a60bc
    // 0x1a614c: str             x1, [THR, #0x898]  ; THR::
    // 0x1a6150: stp             x3, x4, [SP, #-0x10]!
    // 0x1a6154: stp             x1, x2, [SP, #-0x10]!
    // 0x1a6158: SaveReg r0
    //     0x1a6158: str             x0, [SP, #-8]!
    // 0x1a615c: ldr             x5, [THR, #0x468]  ; THR::ArgumentErrorUnboxedInt64
    // 0x1a6160: r4 = 0
    //     0x1a6160: mov             x4, #0
    // 0x1a6164: ldr             lr, [THR, #0x208]  ; THR::call_to_runtime_entry_point
    // 0x1a6168: blr             lr
    // 0x1a616c: brk             #0
  }
  static _ fromMidi(/* No info */) {
    // ** addr: 0x1a719c, size: 0x1f4
    // 0x1a719c: EnterFrame
    //     0x1a719c: stp             fp, lr, [SP, #-0x10]!
    //     0x1a71a0: mov             fp, SP
    // 0x1a71a4: AllocStack(0x40)
    //     0x1a71a4: sub             SP, SP, #0x40
    // 0x1a71a8: SetupParameters(dynamic _ /* r1 => r0, fp-0x8 */)
    //     0x1a71a8: mov             x0, x1
    //     0x1a71ac: stur            x1, [fp, #-8]
    // 0x1a71b0: CheckStackOverflow
    //     0x1a71b0: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a71b4: cmp             SP, x16
    //     0x1a71b8: b.ls            #0x1a734c
    // 0x1a71bc: r1 = <int>
    //     0x1a71bc: ldr             x1, [PP, #0xa70]  ; [pp+0xa70] TypeArguments: <int>
    // 0x1a71c0: r2 = 0
    //     0x1a71c0: mov             x2, #0
    // 0x1a71c4: r0 = _GrowableList()
    //     0x1a71c4: bl              #0x108d8  ; [dart:core] _GrowableList::_GrowableList
    // 0x1a71c8: mov             x2, x0
    // 0x1a71cc: ldur            x0, [fp, #-8]
    // 0x1a71d0: stur            x2, [fp, #-0x40]
    // 0x1a71d4: LoadField: r1 = r0->field_f
    //     0x1a71d4: ldur            x1, [x0, #0xf]
    // 0x1a71d8: asr             x3, x1, #1
    // 0x1a71dc: stur            x3, [fp, #-0x38]
    // 0x1a71e0: r5 = 0
    //     0x1a71e0: mov             x5, #0
    // 0x1a71e4: r4 = 0
    //     0x1a71e4: mov             x4, #0
    // 0x1a71e8: r1 = 0
    //     0x1a71e8: mov             x1, #0
    // 0x1a71ec: CheckStackOverflow
    //     0x1a71ec: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a71f0: cmp             SP, x16
    //     0x1a71f4: b.ls            #0x1a7354
    // 0x1a71f8: LoadField: r6 = r0->field_f
    //     0x1a71f8: ldur            x6, [x0, #0xf]
    // 0x1a71fc: asr             x7, x6, #1
    // 0x1a7200: cmp             x3, x7
    // 0x1a7204: b.ne            #0x1a7330
    // 0x1a7208: cmp             x1, x7
    // 0x1a720c: b.ge            #0x1a7320
    // 0x1a7210: ArrayLoad: r6 = r0[0]  ; List_8
    //     0x1a7210: ldur            x6, [x0, #0x17]
    // 0x1a7214: ArrayLoad: r7 = r6[r1]  ; List_8
    //     0x1a7214: add             x16, x6, x1, lsl #3
    //     0x1a7218: ldur            x7, [x16, #0x17]
    // 0x1a721c: add             x6, x1, #1
    // 0x1a7220: stur            x6, [fp, #-0x30]
    // 0x1a7224: asr             x1, x7, #1
    // 0x1a7228: tbz             w7, #0, #0x1a7230
    // 0x1a722c: LoadField: r1 = r7->field_7
    //     0x1a722c: ldur            x1, [x7, #7]
    // 0x1a7230: cmp             x1, #0xf0
    // 0x1a7234: b.ne            #0x1a7240
    // 0x1a7238: mov             x0, x2
    // 0x1a723c: b               #0x1a7304
    // 0x1a7240: cmp             x1, #0xf7
    // 0x1a7244: b.eq            #0x1a7318
    // 0x1a7248: cmp             x4, #0x3f
    // 0x1a724c: b.hi            #0x1a735c
    // 0x1a7250: lsl             x7, x1, x4
    // 0x1a7254: orr             x8, x5, x7
    // 0x1a7258: stur            x8, [fp, #-0x28]
    // 0x1a725c: add             x5, x4, #7
    // 0x1a7260: stur            x5, [fp, #-0x20]
    // 0x1a7264: cmp             x5, #8
    // 0x1a7268: b.lt            #0x1a72e4
    // 0x1a726c: mov             x1, x8
    // 0x1a7270: ubfx            x1, x1, #0, #0x20
    // 0x1a7274: and             w4, w1, #0xff
    // 0x1a7278: stur            x4, [fp, #-0x18]
    // 0x1a727c: LoadField: r1 = r2->field_f
    //     0x1a727c: ldur            x1, [x2, #0xf]
    // 0x1a7280: ArrayLoad: r7 = r2[0]  ; List_8
    //     0x1a7280: ldur            x7, [x2, #0x17]
    // 0x1a7284: LoadField: r9 = r7->field_f
    //     0x1a7284: ldur            x9, [x7, #0xf]
    // 0x1a7288: asr             x7, x1, #1
    // 0x1a728c: stur            x7, [fp, #-0x10]
    // 0x1a7290: asr             x1, x9, #1
    // 0x1a7294: cmp             x7, x1
    // 0x1a7298: b.ne            #0x1a72a4
    // 0x1a729c: mov             x1, x2
    // 0x1a72a0: r0 = _growToNextCapacity()
    //     0x1a72a0: bl              #0x106e8  ; [dart:core] _GrowableList::_growToNextCapacity
    // 0x1a72a4: ldur            x0, [fp, #-0x40]
    // 0x1a72a8: ldur            x2, [fp, #-0x28]
    // 0x1a72ac: ldur            x3, [fp, #-0x20]
    // 0x1a72b0: ldur            x1, [fp, #-0x18]
    // 0x1a72b4: ldur            x4, [fp, #-0x10]
    // 0x1a72b8: add             x5, x4, #1
    // 0x1a72bc: lsl             x6, x5, #1
    // 0x1a72c0: StoreField: r0->field_f = r6
    //     0x1a72c0: stur            x6, [x0, #0xf]
    // 0x1a72c4: ArrayLoad: r5 = r0[0]  ; List_8
    //     0x1a72c4: ldur            x5, [x0, #0x17]
    // 0x1a72c8: ubfiz           x6, x1, #1, #0x20
    // 0x1a72cc: ArrayStore: r5[r4] = r6  ; List_8
    //     0x1a72cc: add             x1, x5, x4, lsl #3
    //     0x1a72d0: stur            x6, [x1, #0x17]
    // 0x1a72d4: asr             x5, x2, #8
    // 0x1a72d8: sub             x2, x3, #8
    // 0x1a72dc: mov             x3, x5
    // 0x1a72e0: b               #0x1a72fc
    // 0x1a72e4: mov             x0, x2
    // 0x1a72e8: mov             x2, x8
    // 0x1a72ec: mov             x3, x5
    // 0x1a72f0: mov             x16, x3
    // 0x1a72f4: mov             x3, x2
    // 0x1a72f8: mov             x2, x16
    // 0x1a72fc: mov             x5, x3
    // 0x1a7300: mov             x4, x2
    // 0x1a7304: ldur            x1, [fp, #-0x30]
    // 0x1a7308: mov             x2, x0
    // 0x1a730c: ldur            x0, [fp, #-8]
    // 0x1a7310: ldur            x3, [fp, #-0x38]
    // 0x1a7314: b               #0x1a71ec
    // 0x1a7318: mov             x0, x2
    // 0x1a731c: b               #0x1a7324
    // 0x1a7320: mov             x0, x2
    // 0x1a7324: LeaveFrame
    //     0x1a7324: mov             SP, fp
    //     0x1a7328: ldp             fp, lr, [SP], #0x10
    // 0x1a732c: ret
    //     0x1a732c: ret             
    // 0x1a7330: r0 = ConcurrentModificationError()
    //     0x1a7330: bl              #0x10b64  ; AllocateConcurrentModificationErrorStub -> ConcurrentModificationError (size=0x18)
    // 0x1a7334: mov             x1, x0
    // 0x1a7338: ldur            x0, [fp, #-8]
    // 0x1a733c: StoreField: r1->field_f = r0
    //     0x1a733c: stur            x0, [x1, #0xf]
    // 0x1a7340: mov             x0, x1
    // 0x1a7344: r0 = Throw()
    //     0x1a7344: bl              #0x42898c  ; ThrowStub
    // 0x1a7348: brk             #0
    // 0x1a734c: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a734c: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a7350: b               #0x1a71bc
    // 0x1a7354: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a7354: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a7358: b               #0x1a71f8
    // 0x1a735c: tbnz            x4, #0x3f, #0x1a7368
    // 0x1a7360: mov             x7, xzr
    // 0x1a7364: b               #0x1a7254
    // 0x1a7368: str             x4, [THR, #0x898]  ; THR::
    // 0x1a736c: stp             x5, x6, [SP, #-0x10]!
    // 0x1a7370: stp             x3, x4, [SP, #-0x10]!
    // 0x1a7374: stp             x1, x2, [SP, #-0x10]!
    // 0x1a7378: SaveReg r0
    //     0x1a7378: str             x0, [SP, #-8]!
    // 0x1a737c: ldr             x5, [THR, #0x468]  ; THR::ArgumentErrorUnboxedInt64
    // 0x1a7380: r4 = 0
    //     0x1a7380: mov             x4, #0
    // 0x1a7384: ldr             lr, [THR, #0x208]  ; THR::call_to_runtime_entry_point
    // 0x1a7388: blr             lr
    // 0x1a738c: brk             #0
  }
  static _ erasePacket(/* No info */) {
    // ** addr: 0x289154, size: 0x94
    // 0x289154: EnterFrame
    //     0x289154: stp             fp, lr, [SP, #-0x10]!
    //     0x289158: mov             fp, SP
    // 0x28915c: AllocStack(0x18)
    //     0x28915c: sub             SP, SP, #0x18
    // 0x289160: r0 = 2
    //     0x289160: mov             x0, #2
    // 0x289164: mov             x3, x1
    // 0x289168: stur            x1, [fp, #-8]
    // 0x28916c: CheckStackOverflow
    //     0x28916c: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x289170: cmp             SP, x16
    //     0x289174: b.ls            #0x2891e0
    // 0x289178: mov             x2, x0
    // 0x28917c: r1 = Null
    //     0x28917c: mov             x1, NULL
    // 0x289180: r0 = AllocateArray()
    //     0x289180: bl              #0x42a740  ; AllocateArrayStub
    // 0x289184: stur            x0, [fp, #-0x10]
    // 0x289188: r16 = 10
    //     0x289188: mov             x16, #0xa
    // 0x28918c: ArrayStore: r0[0] = r16  ; List_8
    //     0x28918c: stur            x16, [x0, #0x17]
    // 0x289190: r1 = <int>
    //     0x289190: ldr             x1, [PP, #0xa70]  ; [pp+0xa70] TypeArguments: <int>
    // 0x289194: r0 = AllocateGrowableArray()
    //     0x289194: bl              #0x429618  ; AllocateGrowableArrayStub
    // 0x289198: mov             x3, x0
    // 0x28919c: ldur            x0, [fp, #-0x10]
    // 0x2891a0: stur            x3, [fp, #-0x18]
    // 0x2891a4: ArrayStore: r3[0] = r0  ; List_8
    //     0x2891a4: stur            x0, [x3, #0x17]
    // 0x2891a8: r0 = 2
    //     0x2891a8: mov             x0, #2
    // 0x2891ac: StoreField: r3->field_f = r0
    //     0x2891ac: stur            x0, [x3, #0xf]
    // 0x2891b0: ldur            x1, [fp, #-8]
    // 0x2891b4: r2 = 4
    //     0x2891b4: mov             x2, #4
    // 0x2891b8: r0 = _le()
    //     0x2891b8: bl              #0x1a6050  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::_le
    // 0x2891bc: ldur            x1, [fp, #-0x18]
    // 0x2891c0: mov             x2, x0
    // 0x2891c4: r0 = addAll()
    //     0x2891c4: bl              #0x11280  ; [dart:core] _GrowableList::addAll
    // 0x2891c8: ldur            x2, [fp, #-0x18]
    // 0x2891cc: r1 = 33
    //     0x2891cc: mov             x1, #0x21
    // 0x2891d0: r0 = packet()
    //     0x2891d0: bl              #0x1a5eec  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::packet
    // 0x2891d4: LeaveFrame
    //     0x2891d4: mov             SP, fp
    //     0x2891d8: ldp             fp, lr, [SP], #0x10
    // 0x2891dc: ret
    //     0x2891dc: ret             
    // 0x2891e0: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x2891e0: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x2891e4: b               #0x289178
  }
  static _ save0Packet(/* No info */) {
    // ** addr: 0x29be64, size: 0xb0
    // 0x29be64: EnterFrame
    //     0x29be64: stp             fp, lr, [SP, #-0x10]!
    //     0x29be68: mov             fp, SP
    // 0x29be6c: AllocStack(0x10)
    //     0x29be6c: sub             SP, SP, #0x10
    // 0x29be70: r0 = 2
    //     0x29be70: mov             x0, #2
    // 0x29be74: CheckStackOverflow
    //     0x29be74: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x29be78: cmp             SP, x16
    //     0x29be7c: b.ls            #0x29bf0c
    // 0x29be80: lsl             x3, x1, #1
    // 0x29be84: mov             x2, x0
    // 0x29be88: stur            x3, [fp, #-8]
    // 0x29be8c: r1 = Null
    //     0x29be8c: mov             x1, NULL
    // 0x29be90: r0 = AllocateArray()
    //     0x29be90: bl              #0x42a740  ; AllocateArrayStub
    // 0x29be94: mov             x2, x0
    // 0x29be98: ldur            x0, [fp, #-8]
    // 0x29be9c: stur            x2, [fp, #-0x10]
    // 0x29bea0: ArrayStore: r2[0] = r0  ; List_8
    //     0x29bea0: stur            x0, [x2, #0x17]
    // 0x29bea4: r1 = <int>
    //     0x29bea4: ldr             x1, [PP, #0xa70]  ; [pp+0xa70] TypeArguments: <int>
    // 0x29bea8: r0 = AllocateGrowableArray()
    //     0x29bea8: bl              #0x429618  ; AllocateGrowableArrayStub
    // 0x29beac: mov             x3, x0
    // 0x29beb0: ldur            x0, [fp, #-0x10]
    // 0x29beb4: stur            x3, [fp, #-8]
    // 0x29beb8: ArrayStore: r3[0] = r0  ; List_8
    //     0x29beb8: stur            x0, [x3, #0x17]
    // 0x29bebc: r0 = 2
    //     0x29bebc: mov             x0, #2
    // 0x29bec0: StoreField: r3->field_f = r0
    //     0x29bec0: stur            x0, [x3, #0xf]
    // 0x29bec4: r1 = 0
    //     0x29bec4: mov             x1, #0
    // 0x29bec8: r2 = 4
    //     0x29bec8: mov             x2, #4
    // 0x29becc: r0 = _le()
    //     0x29becc: bl              #0x1a6050  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::_le
    // 0x29bed0: ldur            x1, [fp, #-8]
    // 0x29bed4: mov             x2, x0
    // 0x29bed8: r0 = addAll()
    //     0x29bed8: bl              #0x11280  ; [dart:core] _GrowableList::addAll
    // 0x29bedc: r1 = 0
    //     0x29bedc: mov             x1, #0
    // 0x29bee0: r2 = 3
    //     0x29bee0: mov             x2, #3
    // 0x29bee4: r0 = _le()
    //     0x29bee4: bl              #0x1a6050  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::_le
    // 0x29bee8: ldur            x1, [fp, #-8]
    // 0x29beec: mov             x2, x0
    // 0x29bef0: r0 = addAll()
    //     0x29bef0: bl              #0x11280  ; [dart:core] _GrowableList::addAll
    // 0x29bef4: ldur            x2, [fp, #-8]
    // 0x29bef8: r1 = 34
    //     0x29bef8: mov             x1, #0x22
    // 0x29befc: r0 = packet()
    //     0x29befc: bl              #0x1a5eec  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::packet
    // 0x29bf00: LeaveFrame
    //     0x29bf00: mov             SP, fp
    //     0x29bf04: ldp             fp, lr, [SP], #0x10
    // 0x29bf08: ret
    //     0x29bf08: ret             
    // 0x29bf0c: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x29bf0c: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x29bf10: b               #0x29be80
  }
}
