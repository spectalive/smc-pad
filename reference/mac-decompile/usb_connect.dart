// lib: , url: package:musical_instruments/core/usb/usb_connect.dart

// class id: 1049201, size: 0x8
class :: {
}

// class id: 359, size: 0x10, field offset: 0x8
class UsbConnect extends Object {

  _ queryNameAndVersion(/* No info */) async {
    // ** addr: 0x1a4ce8, size: 0x21c
    // 0x1a4ce8: EnterFrame
    //     0x1a4ce8: stp             fp, lr, [SP, #-0x10]!
    //     0x1a4cec: mov             fp, SP
    // 0x1a4cf0: AllocStack(0x30)
    //     0x1a4cf0: sub             SP, SP, #0x30
    // 0x1a4cf4: SetupParameters(UsbConnect this /* r1 => r1, fp-0x18 */, {dynamic timeout = Instance_Duration /* r3, fp-0x10 */})
    //     0x1a4cf4: stur            NULL, [fp, #-8]
    //     0x1a4cf8: stur            x1, [fp, #-0x18]
    //     0x1a4cfc: ldur            x0, [x4, #0x1f]
    //     0x1a4d00: ldur            x2, [x4, #0x37]
    //     0x1a4d04: add             x16, PP, #0xd, lsl #12  ; [pp+0xd820] "timeout"
    //     0x1a4d08: ldr             x16, [x16, #0x820]
    //     0x1a4d0c: cmp             x2, x16
    //     0x1a4d10: b.ne            #0x1a4d2c
    //     0x1a4d14: ldur            x2, [x4, #0x3f]
    //     0x1a4d18: sub             x3, x0, x2
    //     0x1a4d1c: add             x0, fp, x3, lsl #2
    //     0x1a4d20: ldr             x0, [x0, #8]
    //     0x1a4d24: mov             x3, x0
    //     0x1a4d28: b               #0x1a4d30
    //     0x1a4d2c: ldr             x3, [PP, #0x2420]  ; [pp+0x2420] Obj!Duration@2be37c1
    //     0x1a4d30: stur            x3, [fp, #-0x10]
    // 0x1a4d34: CheckStackOverflow
    //     0x1a4d34: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a4d38: cmp             SP, x16
    //     0x1a4d3c: b.ls            #0x1a4ef8
    // 0x1a4d40: InitAsync() -> Future<DeviceIdentity?>
    //     0x1a4d40: add             x0, PP, #0xd, lsl #12  ; [pp+0xd828] TypeArguments: <DeviceIdentity?>
    //     0x1a4d44: ldr             x0, [x0, #0x828]
    //     0x1a4d48: bl              #0x473b4  ; InitAsyncStub
    // 0x1a4d4c: ldur            x1, [fp, #-0x18]
    // 0x1a4d50: LoadField: r0 = r1->field_7
    //     0x1a4d50: ldur            x0, [x1, #7]
    // 0x1a4d54: stur            x0, [fp, #-0x20]
    // 0x1a4d58: r0 = queryPacket()
    //     0x1a4d58: bl              #0x1a5eb4  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::queryPacket
    // 0x1a4d5c: ldur            x1, [fp, #-0x20]
    // 0x1a4d60: mov             x2, x0
    // 0x1a4d64: ldur            x3, [fp, #-0x10]
    // 0x1a4d68: r0 = request()
    //     0x1a4d68: bl              #0x1a53dc  ; [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::request
    // 0x1a4d6c: mov             x1, x0
    // 0x1a4d70: stur            x1, [fp, #-0x10]
    // 0x1a4d74: r0 = Await()
    //     0x1a4d74: bl              #0x14028  ; AwaitStub
    // 0x1a4d78: ldur            x1, [fp, #-0x18]
    // 0x1a4d7c: mov             x2, x0
    // 0x1a4d80: r3 = 17
    //     0x1a4d80: mov             x3, #0x11
    // 0x1a4d84: stur            x0, [fp, #-0x10]
    // 0x1a4d88: r0 = _validResponse()
    //     0x1a4d88: bl              #0x1a50cc  ; [package:musical_instruments/core/usb/usb_connect.dart] UsbConnect::_validResponse
    // 0x1a4d8c: tbz             w0, #4, #0x1a4d98
    // 0x1a4d90: r0 = Null
    //     0x1a4d90: mov             x0, NULL
    // 0x1a4d94: r0 = ReturnAsyncNotFuture()
    //     0x1a4d94: b               #0x13ffc  ; ReturnAsyncNotFutureStub
    // 0x1a4d98: ldur            x1, [fp, #-0x10]
    // 0x1a4d9c: cmp             x1, NULL
    // 0x1a4da0: b.eq            #0x1a4f00
    // 0x1a4da4: r0 = packetData()
    //     0x1a4da4: bl              #0x1a4f58  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::packetData
    // 0x1a4da8: r1 = LoadClassIdInstr(r0)
    //     0x1a4da8: ldur            x1, [x0, #-1]
    //     0x1a4dac: ubfx            x1, x1, #0xc, #0x14
    // 0x1a4db0: mov             x16, x0
    // 0x1a4db4: mov             x0, x1
    // 0x1a4db8: mov             x1, x16
    // 0x1a4dbc: r2 = 24
    //     0x1a4dbc: mov             x2, #0x18
    // 0x1a4dc0: r0 = GDT[cid_x0 + 0x7cee]()
    //     0x1a4dc0: mov             x17, #0x7cee
    //     0x1a4dc4: add             lr, x0, x17
    //     0x1a4dc8: ldr             lr, [x21, lr, lsl #3]
    //     0x1a4dcc: blr             lr
    // 0x1a4dd0: r1 = Function '<anonymous closure>':.
    //     0x1a4dd0: add             x1, PP, #0xd, lsl #12  ; [pp+0xd830] AnonymousClosure: (0x1a6170), in [package:musical_instruments/core/usb/usb_connect.dart] UsbConnect::queryNameAndVersion (0x1a4ce8)
    //     0x1a4dd4: ldr             x1, [x1, #0x830]
    // 0x1a4dd8: r2 = Null
    //     0x1a4dd8: mov             x2, NULL
    // 0x1a4ddc: stur            x0, [fp, #-0x10]
    // 0x1a4de0: r0 = AllocateClosure()
    //     0x1a4de0: bl              #0x429a24  ; AllocateClosureStub
    // 0x1a4de4: ldur            x1, [fp, #-0x10]
    // 0x1a4de8: mov             x2, x0
    // 0x1a4dec: r0 = takeWhile()
    //     0x1a4dec: bl              #0x1a4f10  ; [dart:core] Iterable::takeWhile
    // 0x1a4df0: mov             x1, x0
    // 0x1a4df4: r2 = 0
    //     0x1a4df4: mov             x2, #0
    // 0x1a4df8: r3 = Null
    //     0x1a4df8: mov             x3, NULL
    // 0x1a4dfc: r0 = createFromCharCodes()
    //     0x1a4dfc: bl              #0x17610  ; [dart:core] _StringBase::createFromCharCodes
    // 0x1a4e00: mov             x3, x0
    // 0x1a4e04: stur            x3, [fp, #-0x10]
    // 0x1a4e08: r0 = LoadClassIdInstr(r3)
    //     0x1a4e08: ldur            x0, [x3, #-1]
    //     0x1a4e0c: ubfx            x0, x0, #0xc, #0x14
    // 0x1a4e10: mov             x1, x3
    // 0x1a4e14: r2 = "_"
    //     0x1a4e14: ldr             x2, [PP, #0xe78]  ; [pp+0xe78] "_"
    // 0x1a4e18: r4 = const [0, 0x2, 0, 0x2, null]
    //     0x1a4e18: ldr             x4, [PP, #0x3a8]  ; [pp+0x3a8] List(5) [0, 0x2, 0, 0x2, Null]
    // 0x1a4e1c: r0 = GDT[cid_x0 + -0xff8]()
    //     0x1a4e1c: sub             lr, x0, #0xff8
    //     0x1a4e20: ldr             lr, [x21, lr, lsl #3]
    //     0x1a4e24: blr             lr
    // 0x1a4e28: mov             x3, x0
    // 0x1a4e2c: stur            x3, [fp, #-0x28]
    // 0x1a4e30: tbz             x3, #0x3f, #0x1a4e60
    // 0x1a4e34: ldur            x1, [fp, #-0x10]
    // 0x1a4e38: r0 = trim()
    //     0x1a4e38: bl              #0x32c4c  ; [dart:core] _StringBase::trim
    // 0x1a4e3c: stur            x0, [fp, #-0x18]
    // 0x1a4e40: r0 = DeviceIdentity()
    //     0x1a4e40: bl              #0x1a4f04  ; AllocateDeviceIdentityStub -> DeviceIdentity (size=0x18)
    // 0x1a4e44: mov             x1, x0
    // 0x1a4e48: ldur            x0, [fp, #-0x18]
    // 0x1a4e4c: StoreField: r1->field_7 = r0
    //     0x1a4e4c: stur            x0, [x1, #7]
    // 0x1a4e50: r0 = 1
    //     0x1a4e50: mov             x0, #1
    // 0x1a4e54: StoreField: r1->field_f = r0
    //     0x1a4e54: stur            x0, [x1, #0xf]
    // 0x1a4e58: mov             x0, x1
    // 0x1a4e5c: r0 = ReturnAsyncNotFuture()
    //     0x1a4e5c: b               #0x13ffc  ; ReturnAsyncNotFutureStub
    // 0x1a4e60: adds            x0, x3, x3
    // 0x1a4e64: b.vc            #0x1a4e70
    // 0x1a4e68: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x1a4e68: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x1a4e6c: StoreField: r0->field_7 = r3
    //     0x1a4e6c: stur            x3, [x0, #7]
    // 0x1a4e70: str             x0, [SP]
    // 0x1a4e74: ldur            x1, [fp, #-0x10]
    // 0x1a4e78: r2 = 0
    //     0x1a4e78: mov             x2, #0
    // 0x1a4e7c: r4 = const [0, 0x3, 0x1, 0x3, null]
    //     0x1a4e7c: ldr             x4, [PP, #0x3b0]  ; [pp+0x3b0] List(5) [0, 0x3, 0x1, 0x3, Null]
    // 0x1a4e80: r0 = substring()
    //     0x1a4e80: bl              #0x1641c  ; [dart:core] _StringBase::substring
    // 0x1a4e84: mov             x1, x0
    // 0x1a4e88: r0 = trim()
    //     0x1a4e88: bl              #0x32c4c  ; [dart:core] _StringBase::trim
    // 0x1a4e8c: mov             x3, x0
    // 0x1a4e90: ldur            x0, [fp, #-0x28]
    // 0x1a4e94: stur            x3, [fp, #-0x18]
    // 0x1a4e98: add             x2, x0, #1
    // 0x1a4e9c: ldur            x1, [fp, #-0x10]
    // 0x1a4ea0: r4 = const [0, 0x2, 0, 0x2, null]
    //     0x1a4ea0: ldr             x4, [PP, #0x3a8]  ; [pp+0x3a8] List(5) [0, 0x2, 0, 0x2, Null]
    // 0x1a4ea4: r0 = substring()
    //     0x1a4ea4: bl              #0x1641c  ; [dart:core] _StringBase::substring
    // 0x1a4ea8: mov             x1, x0
    // 0x1a4eac: r0 = trim()
    //     0x1a4eac: bl              #0x32c4c  ; [dart:core] _StringBase::trim
    // 0x1a4eb0: mov             x1, x0
    // 0x1a4eb4: r4 = const [0, 0x1, 0, 0x1, null]
    //     0x1a4eb4: ldr             x4, [PP, #0x1c0]  ; [pp+0x1c0] List(5) [0, 0x1, 0, 0x1, Null]
    // 0x1a4eb8: r0 = tryParse()
    //     0x1a4eb8: bl              #0x26fec  ; [dart:core] int::tryParse
    // 0x1a4ebc: cmp             x0, NULL
    // 0x1a4ec0: b.ne            #0x1a4ecc
    // 0x1a4ec4: r1 = 1
    //     0x1a4ec4: mov             x1, #1
    // 0x1a4ec8: b               #0x1a4ed8
    // 0x1a4ecc: asr             x1, x0, #1
    // 0x1a4ed0: tbz             w0, #0, #0x1a4ed8
    // 0x1a4ed4: LoadField: r1 = r0->field_7
    //     0x1a4ed4: ldur            x1, [x0, #7]
    // 0x1a4ed8: ldur            x0, [fp, #-0x18]
    // 0x1a4edc: stur            x1, [fp, #-0x28]
    // 0x1a4ee0: r0 = DeviceIdentity()
    //     0x1a4ee0: bl              #0x1a4f04  ; AllocateDeviceIdentityStub -> DeviceIdentity (size=0x18)
    // 0x1a4ee4: ldur            x1, [fp, #-0x18]
    // 0x1a4ee8: StoreField: r0->field_7 = r1
    //     0x1a4ee8: stur            x1, [x0, #7]
    // 0x1a4eec: ldur            x1, [fp, #-0x28]
    // 0x1a4ef0: StoreField: r0->field_f = r1
    //     0x1a4ef0: stur            x1, [x0, #0xf]
    // 0x1a4ef4: r0 = ReturnAsyncNotFuture()
    //     0x1a4ef4: b               #0x13ffc  ; ReturnAsyncNotFutureStub
    // 0x1a4ef8: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a4ef8: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a4efc: b               #0x1a4d40
    // 0x1a4f00: r0 = NullCastErrorSharedWithoutFPURegs()
    //     0x1a4f00: bl              #0x42aebc  ; NullCastErrorSharedWithoutFPURegsStub
  }
  _ _validResponse(/* No info */) {
    // ** addr: 0x1a50cc, size: 0xb0
    // 0x1a50cc: EnterFrame
    //     0x1a50cc: stp             fp, lr, [SP, #-0x10]!
    //     0x1a50d0: mov             fp, SP
    // 0x1a50d4: AllocStack(0x18)
    //     0x1a50d4: sub             SP, SP, #0x18
    // 0x1a50d8: SetupParameters(UsbConnect this /* r1 => r0 */, dynamic _ /* r2 => r1, fp-0x8 */, dynamic _ /* r3 => r3, fp-0x10 */)
    //     0x1a50d8: mov             x0, x1
    //     0x1a50dc: mov             x1, x2
    //     0x1a50e0: stur            x2, [fp, #-8]
    //     0x1a50e4: stur            x3, [fp, #-0x10]
    // 0x1a50e8: CheckStackOverflow
    //     0x1a50e8: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a50ec: cmp             SP, x16
    //     0x1a50f0: b.ls            #0x1a5174
    // 0x1a50f4: cmp             x1, NULL
    // 0x1a50f8: b.eq            #0x1a5124
    // 0x1a50fc: r0 = LoadClassIdInstr(r1)
    //     0x1a50fc: ldur            x0, [x1, #-1]
    //     0x1a5100: ubfx            x0, x0, #0xc, #0x14
    // 0x1a5104: str             x1, [SP]
    // 0x1a5108: r0 = GDT[cid_x0 + 0x800d]()
    //     0x1a5108: mov             x17, #0x800d
    //     0x1a510c: add             lr, x0, x17
    //     0x1a5110: ldr             lr, [x21, lr, lsl #3]
    //     0x1a5114: blr             lr
    // 0x1a5118: asr             x1, x0, #1
    // 0x1a511c: cmp             x1, #6
    // 0x1a5120: b.gt            #0x1a5134
    // 0x1a5124: r0 = false
    //     0x1a5124: add             x0, NULL, #0x30  ; false
    // 0x1a5128: LeaveFrame
    //     0x1a5128: mov             SP, fp
    //     0x1a512c: ldp             fp, lr, [SP], #0x10
    // 0x1a5130: ret
    //     0x1a5130: ret             
    // 0x1a5134: ldur            x0, [fp, #-0x10]
    // 0x1a5138: ldur            x1, [fp, #-8]
    // 0x1a513c: r0 = packetCmd()
    //     0x1a513c: bl              #0x1a5384  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::packetCmd
    // 0x1a5140: mov             x1, x0
    // 0x1a5144: ldur            x0, [fp, #-0x10]
    // 0x1a5148: cmp             x1, x0
    // 0x1a514c: b.eq            #0x1a5160
    // 0x1a5150: r0 = false
    //     0x1a5150: add             x0, NULL, #0x30  ; false
    // 0x1a5154: LeaveFrame
    //     0x1a5154: mov             SP, fp
    //     0x1a5158: ldp             fp, lr, [SP], #0x10
    // 0x1a515c: ret
    //     0x1a515c: ret             
    // 0x1a5160: ldur            x1, [fp, #-8]
    // 0x1a5164: r0 = verify()
    //     0x1a5164: bl              #0x1a517c  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::verify
    // 0x1a5168: LeaveFrame
    //     0x1a5168: mov             SP, fp
    //     0x1a516c: ldp             fp, lr, [SP], #0x10
    // 0x1a5170: ret
    //     0x1a5170: ret             
    // 0x1a5174: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a5174: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a5178: b               #0x1a50f4
  }
  [closure] bool <anonymous closure>(dynamic, int) {
    // ** addr: 0x1a6170, size: 0x18
    // 0x1a6170: ldr             x1, [SP]
    // 0x1a6174: cbnz            x1, #0x1a6180
    // 0x1a6178: r0 = false
    //     0x1a6178: add             x0, NULL, #0x30  ; false
    // 0x1a617c: b               #0x1a6184
    // 0x1a6180: r0 = true
    //     0x1a6180: add             x0, NULL, #0x20  ; true
    // 0x1a6184: ret
    //     0x1a6184: ret             
  }
  _ flashRead(/* No info */) async {
    // ** addr: 0x1f7840, size: 0x474
    // 0x1f7840: EnterFrame
    //     0x1f7840: stp             fp, lr, [SP, #-0x10]!
    //     0x1f7844: mov             fp, SP
    // 0x1f7848: AllocStack(0x80)
    //     0x1f7848: sub             SP, SP, #0x80
    // 0x1f784c: SetupParameters(UsbConnect this /* r1 => r1, fp-0x10 */, dynamic _ /* r2 => r2, fp-0x18 */, dynamic _ /* r3 => r3, fp-0x20 */, dynamic _ /* r5 => r5, fp-0x28 */)
    //     0x1f784c: stur            NULL, [fp, #-8]
    //     0x1f7850: stur            x1, [fp, #-0x10]
    //     0x1f7854: stur            x2, [fp, #-0x18]
    //     0x1f7858: stur            x3, [fp, #-0x20]
    //     0x1f785c: stur            x5, [fp, #-0x28]
    // 0x1f7860: CheckStackOverflow
    //     0x1f7860: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1f7864: cmp             SP, x16
    //     0x1f7868: b.ls            #0x1f7c40
    // 0x1f786c: InitAsync() -> Future<List<int>?>
    //     0x1f786c: add             x0, PP, #0xd, lsl #12  ; [pp+0xd838] TypeArguments: <List<int>?>
    //     0x1f7870: ldr             x0, [x0, #0x838]
    //     0x1f7874: bl              #0x473b4  ; InitAsyncStub
    // 0x1f7878: r1 = <int>
    //     0x1f7878: ldr             x1, [PP, #0xa70]  ; [pp+0xa70] TypeArguments: <int>
    // 0x1f787c: r2 = 0
    //     0x1f787c: mov             x2, #0
    // 0x1f7880: r0 = _GrowableList()
    //     0x1f7880: bl              #0x108d8  ; [dart:core] _GrowableList::_GrowableList
    // 0x1f7884: mov             x3, x0
    // 0x1f7888: ldur            x0, [fp, #-0x10]
    // 0x1f788c: stur            x3, [fp, #-0x48]
    // 0x1f7890: LoadField: r4 = r0->field_7
    //     0x1f7890: ldur            x4, [x0, #7]
    // 0x1f7894: ldur            x5, [fp, #-0x18]
    // 0x1f7898: stur            x4, [fp, #-0x40]
    // 0x1f789c: lsl             x6, x5, #1
    // 0x1f78a0: stur            x6, [fp, #-0x38]
    // 0x1f78a4: ldur            x9, [fp, #-0x28]
    // 0x1f78a8: ldur            x8, [fp, #-0x20]
    // 0x1f78ac: r7 = 2
    //     0x1f78ac: mov             x7, #2
    // 0x1f78b0: stur            x9, [fp, #-0x28]
    // 0x1f78b4: stur            x8, [fp, #-0x30]
    // 0x1f78b8: CheckStackOverflow
    //     0x1f78b8: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1f78bc: cmp             SP, x16
    //     0x1f78c0: b.ls            #0x1f7c48
    // 0x1f78c4: cmp             x9, #0
    // 0x1f78c8: b.le            #0x1f7c38
    // 0x1f78cc: cmp             x9, #0x3f1
    // 0x1f78d0: b.le            #0x1f78dc
    // 0x1f78d4: r10 = 1009
    //     0x1f78d4: mov             x10, #0x3f1
    // 0x1f78d8: b               #0x1f78e0
    // 0x1f78dc: mov             x10, x9
    // 0x1f78e0: mov             x2, x7
    // 0x1f78e4: stur            x10, [fp, #-0x20]
    // 0x1f78e8: r1 = Null
    //     0x1f78e8: mov             x1, NULL
    // 0x1f78ec: r0 = AllocateArray()
    //     0x1f78ec: bl              #0x42a740  ; AllocateArrayStub
    // 0x1f78f0: mov             x2, x0
    // 0x1f78f4: ldur            x0, [fp, #-0x38]
    // 0x1f78f8: stur            x2, [fp, #-0x50]
    // 0x1f78fc: ArrayStore: r2[0] = r0  ; List_8
    //     0x1f78fc: stur            x0, [x2, #0x17]
    // 0x1f7900: r1 = <int>
    //     0x1f7900: ldr             x1, [PP, #0xa70]  ; [pp+0xa70] TypeArguments: <int>
    // 0x1f7904: r0 = AllocateGrowableArray()
    //     0x1f7904: bl              #0x429618  ; AllocateGrowableArrayStub
    // 0x1f7908: mov             x3, x0
    // 0x1f790c: ldur            x0, [fp, #-0x50]
    // 0x1f7910: stur            x3, [fp, #-0x58]
    // 0x1f7914: ArrayStore: r3[0] = r0  ; List_8
    //     0x1f7914: stur            x0, [x3, #0x17]
    // 0x1f7918: r0 = 2
    //     0x1f7918: mov             x0, #2
    // 0x1f791c: StoreField: r3->field_f = r0
    //     0x1f791c: stur            x0, [x3, #0xf]
    // 0x1f7920: ldur            x1, [fp, #-0x30]
    // 0x1f7924: r2 = 4
    //     0x1f7924: mov             x2, #4
    // 0x1f7928: r0 = _le()
    //     0x1f7928: bl              #0x1a6050  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::_le
    // 0x1f792c: ldur            x1, [fp, #-0x58]
    // 0x1f7930: mov             x2, x0
    // 0x1f7934: r0 = addAll()
    //     0x1f7934: bl              #0x11280  ; [dart:core] _GrowableList::addAll
    // 0x1f7938: ldur            x1, [fp, #-0x20]
    // 0x1f793c: r2 = 3
    //     0x1f793c: mov             x2, #3
    // 0x1f7940: r0 = _le()
    //     0x1f7940: bl              #0x1a6050  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::_le
    // 0x1f7944: ldur            x1, [fp, #-0x58]
    // 0x1f7948: mov             x2, x0
    // 0x1f794c: r0 = addAll()
    //     0x1f794c: bl              #0x11280  ; [dart:core] _GrowableList::addAll
    // 0x1f7950: ldur            x2, [fp, #-0x58]
    // 0x1f7954: r1 = 35
    //     0x1f7954: mov             x1, #0x23
    // 0x1f7958: r0 = packet()
    //     0x1f7958: bl              #0x1a5eec  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::packet
    // 0x1f795c: ldur            x1, [fp, #-0x40]
    // 0x1f7960: mov             x2, x0
    // 0x1f7964: r3 = Instance_Duration
    //     0x1f7964: add             x3, PP, #0x14, lsl #12  ; [pp+0x14f70] Obj!Duration@2be3991
    //     0x1f7968: ldr             x3, [x3, #0xf70]
    // 0x1f796c: r0 = request()
    //     0x1f796c: bl              #0x1a53dc  ; [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::request
    // 0x1f7970: mov             x1, x0
    // 0x1f7974: stur            x1, [fp, #-0x50]
    // 0x1f7978: r0 = Await()
    //     0x1f7978: bl              #0x14028  ; AwaitStub
    // 0x1f797c: mov             x1, x0
    // 0x1f7980: stur            x1, [fp, #-0x50]
    // 0x1f7984: cmp             x1, NULL
    // 0x1f7988: b.eq            #0x1f7c30
    // 0x1f798c: r0 = LoadClassIdInstr(r1)
    //     0x1f798c: ldur            x0, [x1, #-1]
    //     0x1f7990: ubfx            x0, x0, #0xc, #0x14
    // 0x1f7994: str             x1, [SP]
    // 0x1f7998: r0 = GDT[cid_x0 + 0x800d]()
    //     0x1f7998: mov             x17, #0x800d
    //     0x1f799c: add             lr, x0, x17
    //     0x1f79a0: ldr             lr, [x21, lr, lsl #3]
    //     0x1f79a4: blr             lr
    // 0x1f79a8: asr             x1, x0, #1
    // 0x1f79ac: cmp             x1, #6
    // 0x1f79b0: b.le            #0x1f7c30
    // 0x1f79b4: ldur            x1, [fp, #-0x50]
    // 0x1f79b8: r0 = packetCmd()
    //     0x1f79b8: bl              #0x1a5384  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::packetCmd
    // 0x1f79bc: cmp             x0, #0x23
    // 0x1f79c0: b.ne            #0x1f7c30
    // 0x1f79c4: ldur            x1, [fp, #-0x50]
    // 0x1f79c8: r0 = verify()
    //     0x1f79c8: bl              #0x1a517c  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::verify
    // 0x1f79cc: tbnz            w0, #4, #0x1f7c30
    // 0x1f79d0: ldur            x0, [fp, #-0x50]
    // 0x1f79d4: mov             x1, x0
    // 0x1f79d8: r0 = _readLe()
    //     0x1f79d8: bl              #0x1a4fd4  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::_readLe
    // 0x1f79dc: add             x2, x0, #6
    // 0x1f79e0: adds            x0, x2, x2
    // 0x1f79e4: b.vc            #0x1f79f0
    // 0x1f79e8: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x1f79e8: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x1f79ec: StoreField: r0->field_7 = r2
    //     0x1f79ec: stur            x2, [x0, #7]
    // 0x1f79f0: ldur            x1, [fp, #-0x50]
    // 0x1f79f4: r2 = LoadClassIdInstr(r1)
    //     0x1f79f4: ldur            x2, [x1, #-1]
    //     0x1f79f8: ubfx            x2, x2, #0xc, #0x14
    // 0x1f79fc: str             x0, [SP]
    // 0x1f7a00: mov             x0, x2
    // 0x1f7a04: r2 = 6
    //     0x1f7a04: mov             x2, #6
    // 0x1f7a08: r4 = const [0, 0x3, 0x1, 0x3, null]
    //     0x1f7a08: ldr             x4, [PP, #0x3b0]  ; [pp+0x3b0] List(5) [0, 0x3, 0x1, 0x3, Null]
    // 0x1f7a0c: r0 = GDT[cid_x0 + 0xb63b]()
    //     0x1f7a0c: mov             x17, #0xb63b
    //     0x1f7a10: add             lr, x0, x17
    //     0x1f7a14: ldr             lr, [x21, lr, lsl #3]
    //     0x1f7a18: blr             lr
    // 0x1f7a1c: mov             x1, x0
    // 0x1f7a20: stur            x1, [fp, #-0x50]
    // 0x1f7a24: r0 = LoadClassIdInstr(r1)
    //     0x1f7a24: ldur            x0, [x1, #-1]
    //     0x1f7a28: ubfx            x0, x0, #0xc, #0x14
    // 0x1f7a2c: stp             xzr, x1, [SP]
    // 0x1f7a30: r0 = GDT[cid_x0 + -0xd18]()
    //     0x1f7a30: sub             lr, x0, #0xd18
    //     0x1f7a34: ldr             lr, [x21, lr, lsl #3]
    //     0x1f7a38: blr             lr
    // 0x1f7a3c: mov             x2, x0
    // 0x1f7a40: stur            x2, [fp, #-0x58]
    // 0x1f7a44: r5 = 0
    //     0x1f7a44: mov             x5, #0
    // 0x1f7a48: r4 = 0
    //     0x1f7a48: mov             x4, #0
    // 0x1f7a4c: ldur            x3, [fp, #-0x50]
    // 0x1f7a50: stur            x5, [fp, #-0x68]
    // 0x1f7a54: stur            x4, [fp, #-0x70]
    // 0x1f7a58: CheckStackOverflow
    //     0x1f7a58: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1f7a5c: cmp             SP, x16
    //     0x1f7a60: b.ls            #0x1f7c50
    // 0x1f7a64: cmp             x4, #4
    // 0x1f7a68: b.ge            #0x1f7ad8
    // 0x1f7a6c: add             x6, x4, #1
    // 0x1f7a70: stur            x6, [fp, #-0x60]
    // 0x1f7a74: adds            x0, x6, x6
    // 0x1f7a78: b.vc            #0x1f7a84
    // 0x1f7a7c: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x1f7a7c: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x1f7a80: StoreField: r0->field_7 = r6
    //     0x1f7a80: stur            x6, [x0, #7]
    // 0x1f7a84: r1 = LoadClassIdInstr(r3)
    //     0x1f7a84: ldur            x1, [x3, #-1]
    //     0x1f7a88: ubfx            x1, x1, #0xc, #0x14
    // 0x1f7a8c: stp             x0, x3, [SP]
    // 0x1f7a90: mov             x0, x1
    // 0x1f7a94: r0 = GDT[cid_x0 + -0xd18]()
    //     0x1f7a94: sub             lr, x0, #0xd18
    //     0x1f7a98: ldr             lr, [x21, lr, lsl #3]
    //     0x1f7a9c: blr             lr
    // 0x1f7aa0: mov             x1, x0
    // 0x1f7aa4: ldur            x0, [fp, #-0x70]
    // 0x1f7aa8: lsl             x2, x0, #3
    // 0x1f7aac: asr             x0, x1, #1
    // 0x1f7ab0: tbz             w1, #0, #0x1f7ab8
    // 0x1f7ab4: LoadField: r0 = r1->field_7
    //     0x1f7ab4: ldur            x0, [x1, #7]
    // 0x1f7ab8: cmp             x2, #0x3f
    // 0x1f7abc: b.hi            #0x1f7c58
    // 0x1f7ac0: lsl             x1, x0, x2
    // 0x1f7ac4: ldur            x2, [fp, #-0x68]
    // 0x1f7ac8: orr             x5, x2, x1
    // 0x1f7acc: ldur            x4, [fp, #-0x60]
    // 0x1f7ad0: ldur            x2, [fp, #-0x58]
    // 0x1f7ad4: b               #0x1f7a4c
    // 0x1f7ad8: mov             x2, x5
    // 0x1f7adc: r5 = 0
    //     0x1f7adc: mov             x5, #0
    // 0x1f7ae0: r4 = 0
    //     0x1f7ae0: mov             x4, #0
    // 0x1f7ae4: ldur            x3, [fp, #-0x50]
    // 0x1f7ae8: stur            x5, [fp, #-0x60]
    // 0x1f7aec: stur            x4, [fp, #-0x70]
    // 0x1f7af0: CheckStackOverflow
    //     0x1f7af0: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1f7af4: cmp             SP, x16
    //     0x1f7af8: b.ls            #0x1f7c80
    // 0x1f7afc: cmp             x4, #3
    // 0x1f7b00: b.ge            #0x1f7b6c
    // 0x1f7b04: add             x6, x4, #5
    // 0x1f7b08: adds            x0, x6, x6
    // 0x1f7b0c: b.vc            #0x1f7b18
    // 0x1f7b10: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x1f7b10: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x1f7b14: StoreField: r0->field_7 = r6
    //     0x1f7b14: stur            x6, [x0, #7]
    // 0x1f7b18: r1 = LoadClassIdInstr(r3)
    //     0x1f7b18: ldur            x1, [x3, #-1]
    //     0x1f7b1c: ubfx            x1, x1, #0xc, #0x14
    // 0x1f7b20: stp             x0, x3, [SP]
    // 0x1f7b24: mov             x0, x1
    // 0x1f7b28: r0 = GDT[cid_x0 + -0xd18]()
    //     0x1f7b28: sub             lr, x0, #0xd18
    //     0x1f7b2c: ldr             lr, [x21, lr, lsl #3]
    //     0x1f7b30: blr             lr
    // 0x1f7b34: mov             x1, x0
    // 0x1f7b38: ldur            x0, [fp, #-0x70]
    // 0x1f7b3c: lsl             x2, x0, #3
    // 0x1f7b40: asr             x3, x1, #1
    // 0x1f7b44: tbz             w1, #0, #0x1f7b4c
    // 0x1f7b48: LoadField: r3 = r1->field_7
    //     0x1f7b48: ldur            x3, [x1, #7]
    // 0x1f7b4c: cmp             x2, #0x3f
    // 0x1f7b50: b.hi            #0x1f7c88
    // 0x1f7b54: lsl             x1, x3, x2
    // 0x1f7b58: ldur            x2, [fp, #-0x60]
    // 0x1f7b5c: orr             x5, x2, x1
    // 0x1f7b60: add             x4, x0, #1
    // 0x1f7b64: ldur            x2, [fp, #-0x68]
    // 0x1f7b68: b               #0x1f7ae4
    // 0x1f7b6c: ldur            x3, [fp, #-0x18]
    // 0x1f7b70: ldur            x0, [fp, #-0x58]
    // 0x1f7b74: mov             x2, x5
    // 0x1f7b78: asr             x1, x0, #1
    // 0x1f7b7c: tbz             w0, #0, #0x1f7b84
    // 0x1f7b80: LoadField: r1 = r0->field_7
    //     0x1f7b80: ldur            x1, [x0, #7]
    // 0x1f7b84: cmp             x1, x3
    // 0x1f7b88: b.ne            #0x1f7c28
    // 0x1f7b8c: ldur            x4, [fp, #-0x30]
    // 0x1f7b90: ldur            x0, [fp, #-0x68]
    // 0x1f7b94: cmp             x0, x4
    // 0x1f7b98: b.ne            #0x1f7c28
    // 0x1f7b9c: ldur            x5, [fp, #-0x20]
    // 0x1f7ba0: cmp             x2, x5
    // 0x1f7ba4: b.ne            #0x1f7c28
    // 0x1f7ba8: ldur            x7, [fp, #-0x28]
    // 0x1f7bac: ldur            x6, [fp, #-0x50]
    // 0x1f7bb0: add             x8, x2, #8
    // 0x1f7bb4: adds            x0, x8, x8
    // 0x1f7bb8: b.vc            #0x1f7bc4
    // 0x1f7bbc: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x1f7bbc: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x1f7bc0: StoreField: r0->field_7 = r8
    //     0x1f7bc0: stur            x8, [x0, #7]
    // 0x1f7bc4: r1 = LoadClassIdInstr(r6)
    //     0x1f7bc4: ldur            x1, [x6, #-1]
    //     0x1f7bc8: ubfx            x1, x1, #0xc, #0x14
    // 0x1f7bcc: str             x0, [SP]
    // 0x1f7bd0: mov             x0, x1
    // 0x1f7bd4: mov             x1, x6
    // 0x1f7bd8: r2 = 8
    //     0x1f7bd8: mov             x2, #8
    // 0x1f7bdc: r4 = const [0, 0x3, 0x1, 0x3, null]
    //     0x1f7bdc: ldr             x4, [PP, #0x3b0]  ; [pp+0x3b0] List(5) [0, 0x3, 0x1, 0x3, Null]
    // 0x1f7be0: r0 = GDT[cid_x0 + 0xb63b]()
    //     0x1f7be0: mov             x17, #0xb63b
    //     0x1f7be4: add             lr, x0, x17
    //     0x1f7be8: ldr             lr, [x21, lr, lsl #3]
    //     0x1f7bec: blr             lr
    // 0x1f7bf0: ldur            x1, [fp, #-0x48]
    // 0x1f7bf4: mov             x2, x0
    // 0x1f7bf8: r0 = addAll()
    //     0x1f7bf8: bl              #0x11280  ; [dart:core] _GrowableList::addAll
    // 0x1f7bfc: ldur            x2, [fp, #-0x28]
    // 0x1f7c00: ldur            x1, [fp, #-0x20]
    // 0x1f7c04: sub             x9, x2, x1
    // 0x1f7c08: ldur            x2, [fp, #-0x30]
    // 0x1f7c0c: add             x8, x2, x1
    // 0x1f7c10: ldur            x0, [fp, #-0x10]
    // 0x1f7c14: ldur            x5, [fp, #-0x18]
    // 0x1f7c18: ldur            x3, [fp, #-0x48]
    // 0x1f7c1c: ldur            x4, [fp, #-0x40]
    // 0x1f7c20: ldur            x6, [fp, #-0x38]
    // 0x1f7c24: b               #0x1f78ac
    // 0x1f7c28: r0 = Null
    //     0x1f7c28: mov             x0, NULL
    // 0x1f7c2c: r0 = ReturnAsyncNotFuture()
    //     0x1f7c2c: b               #0x13ffc  ; ReturnAsyncNotFutureStub
    // 0x1f7c30: r0 = Null
    //     0x1f7c30: mov             x0, NULL
    // 0x1f7c34: r0 = ReturnAsyncNotFuture()
    //     0x1f7c34: b               #0x13ffc  ; ReturnAsyncNotFutureStub
    // 0x1f7c38: ldur            x0, [fp, #-0x48]
    // 0x1f7c3c: r0 = ReturnAsyncNotFuture()
    //     0x1f7c3c: b               #0x13ffc  ; ReturnAsyncNotFutureStub
    // 0x1f7c40: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1f7c40: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1f7c44: b               #0x1f786c
    // 0x1f7c48: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1f7c48: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1f7c4c: b               #0x1f78c4
    // 0x1f7c50: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1f7c50: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1f7c54: b               #0x1f7a64
    // 0x1f7c58: tbnz            x2, #0x3f, #0x1f7c64
    // 0x1f7c5c: mov             x1, xzr
    // 0x1f7c60: b               #0x1f7ac4
    // 0x1f7c64: str             x2, [THR, #0x898]  ; THR::
    // 0x1f7c68: stp             x0, x2, [SP, #-0x10]!
    // 0x1f7c6c: ldr             x5, [THR, #0x468]  ; THR::ArgumentErrorUnboxedInt64
    // 0x1f7c70: r4 = 0
    //     0x1f7c70: mov             x4, #0
    // 0x1f7c74: ldr             lr, [THR, #0x208]  ; THR::call_to_runtime_entry_point
    // 0x1f7c78: blr             lr
    // 0x1f7c7c: brk             #0
    // 0x1f7c80: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1f7c80: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1f7c84: b               #0x1f7afc
    // 0x1f7c88: tbnz            x2, #0x3f, #0x1f7c94
    // 0x1f7c8c: mov             x1, xzr
    // 0x1f7c90: b               #0x1f7b58
    // 0x1f7c94: str             x2, [THR, #0x898]  ; THR::
    // 0x1f7c98: stp             x2, x3, [SP, #-0x10]!
    // 0x1f7c9c: SaveReg r0
    //     0x1f7c9c: str             x0, [SP, #-8]!
    // 0x1f7ca0: ldr             x5, [THR, #0x468]  ; THR::ArgumentErrorUnboxedInt64
    // 0x1f7ca4: r4 = 0
    //     0x1f7ca4: mov             x4, #0
    // 0x1f7ca8: ldr             lr, [THR, #0x208]  ; THR::call_to_runtime_entry_point
    // 0x1f7cac: blr             lr
    // 0x1f7cb0: brk             #0
  }
  _ flashWrite(/* No info */) async {
    // ** addr: 0x1fcc2c, size: 0x2e8
    // 0x1fcc2c: EnterFrame
    //     0x1fcc2c: stp             fp, lr, [SP, #-0x10]!
    //     0x1fcc30: mov             fp, SP
    // 0x1fcc34: AllocStack(0x78)
    //     0x1fcc34: sub             SP, SP, #0x78
    // 0x1fcc38: SetupParameters(UsbConnect this /* r1 => r4, fp-0x10 */, dynamic _ /* r2 => r2, fp-0x18 */, dynamic _ /* r3 => r3, fp-0x20 */, dynamic _ /* r5 => r1, fp-0x28 */)
    //     0x1fcc38: stur            NULL, [fp, #-8]
    //     0x1fcc3c: mov             x4, x1
    //     0x1fcc40: stur            x1, [fp, #-0x10]
    //     0x1fcc44: mov             x1, x5
    //     0x1fcc48: stur            x2, [fp, #-0x18]
    //     0x1fcc4c: stur            x3, [fp, #-0x20]
    //     0x1fcc50: stur            x5, [fp, #-0x28]
    // 0x1fcc54: CheckStackOverflow
    //     0x1fcc54: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1fcc58: cmp             SP, x16
    //     0x1fcc5c: b.ls            #0x1fcf04
    // 0x1fcc60: InitAsync() -> Future<bool>
    //     0x1fcc60: ldr             x0, [PP, #0x2818]  ; [pp+0x2818] TypeArguments: <bool>
    //     0x1fcc64: bl              #0x473b4  ; InitAsyncStub
    // 0x1fcc68: ldur            x0, [fp, #-0x20]
    // 0x1fcc6c: asr             x1, x0, #1
    // 0x1fcc70: tbz             w0, #0, #0x1fcc78
    // 0x1fcc74: LoadField: r1 = r0->field_7
    //     0x1fcc74: ldur            x1, [x0, #7]
    // 0x1fcc78: ldur            x2, [fp, #-0x10]
    // 0x1fcc7c: LoadField: r3 = r2->field_7
    //     0x1fcc7c: ldur            x3, [x2, #7]
    // 0x1fcc80: ldur            x4, [fp, #-0x18]
    // 0x1fcc84: stur            x3, [fp, #-0x40]
    // 0x1fcc88: lsl             x5, x4, #1
    // 0x1fcc8c: stur            x5, [fp, #-0x20]
    // 0x1fcc90: mov             x6, x1
    // 0x1fcc94: r7 = 0
    //     0x1fcc94: mov             x7, #0
    // 0x1fcc98: ldur            x1, [fp, #-0x28]
    // 0x1fcc9c: stur            x7, [fp, #-0x30]
    // 0x1fcca0: stur            x6, [fp, #-0x38]
    // 0x1fcca4: CheckStackOverflow
    //     0x1fcca4: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1fcca8: cmp             SP, x16
    //     0x1fccac: b.ls            #0x1fcf0c
    // 0x1fccb0: r0 = LoadClassIdInstr(r1)
    //     0x1fccb0: ldur            x0, [x1, #-1]
    //     0x1fccb4: ubfx            x0, x0, #0xc, #0x14
    // 0x1fccb8: str             x1, [SP]
    // 0x1fccbc: r0 = GDT[cid_x0 + 0x800d]()
    //     0x1fccbc: mov             x17, #0x800d
    //     0x1fccc0: add             lr, x0, x17
    //     0x1fccc4: ldr             lr, [x21, lr, lsl #3]
    //     0x1fccc8: blr             lr
    // 0x1fcccc: asr             x1, x0, #1
    // 0x1fccd0: ldur            x2, [fp, #-0x30]
    // 0x1fccd4: cmp             x2, x1
    // 0x1fccd8: b.ge            #0x1fcefc
    // 0x1fccdc: ldur            x1, [fp, #-0x28]
    // 0x1fcce0: r0 = LoadClassIdInstr(r1)
    //     0x1fcce0: ldur            x0, [x1, #-1]
    //     0x1fcce4: ubfx            x0, x0, #0xc, #0x14
    // 0x1fcce8: str             x1, [SP]
    // 0x1fccec: r0 = GDT[cid_x0 + 0x800d]()
    //     0x1fccec: mov             x17, #0x800d
    //     0x1fccf0: add             lr, x0, x17
    //     0x1fccf4: ldr             lr, [x21, lr, lsl #3]
    //     0x1fccf8: blr             lr
    // 0x1fccfc: asr             x1, x0, #1
    // 0x1fcd00: ldur            x2, [fp, #-0x30]
    // 0x1fcd04: sub             x0, x1, x2
    // 0x1fcd08: cmp             x0, #0x400
    // 0x1fcd0c: b.le            #0x1fcd1c
    // 0x1fcd10: mov             x3, x2
    // 0x1fcd14: r6 = 1024
    //     0x1fcd14: mov             x6, #0x400
    // 0x1fcd18: b               #0x1fcd4c
    // 0x1fcd1c: ldur            x1, [fp, #-0x28]
    // 0x1fcd20: r0 = LoadClassIdInstr(r1)
    //     0x1fcd20: ldur            x0, [x1, #-1]
    //     0x1fcd24: ubfx            x0, x0, #0xc, #0x14
    // 0x1fcd28: str             x1, [SP]
    // 0x1fcd2c: r0 = GDT[cid_x0 + 0x800d]()
    //     0x1fcd2c: mov             x17, #0x800d
    //     0x1fcd30: add             lr, x0, x17
    //     0x1fcd34: ldr             lr, [x21, lr, lsl #3]
    //     0x1fcd38: blr             lr
    // 0x1fcd3c: asr             x1, x0, #1
    // 0x1fcd40: ldur            x3, [fp, #-0x30]
    // 0x1fcd44: sub             x0, x1, x3
    // 0x1fcd48: mov             x6, x0
    // 0x1fcd4c: ldur            x4, [fp, #-0x28]
    // 0x1fcd50: ldur            x5, [fp, #-0x20]
    // 0x1fcd54: stur            x6, [fp, #-0x50]
    // 0x1fcd58: add             x7, x3, x6
    // 0x1fcd5c: stur            x7, [fp, #-0x48]
    // 0x1fcd60: adds            x0, x7, x7
    // 0x1fcd64: b.vc            #0x1fcd70
    // 0x1fcd68: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x1fcd68: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x1fcd6c: StoreField: r0->field_7 = r7
    //     0x1fcd6c: stur            x7, [x0, #7]
    // 0x1fcd70: r1 = LoadClassIdInstr(r4)
    //     0x1fcd70: ldur            x1, [x4, #-1]
    //     0x1fcd74: ubfx            x1, x1, #0xc, #0x14
    // 0x1fcd78: str             x0, [SP]
    // 0x1fcd7c: mov             x0, x1
    // 0x1fcd80: mov             x1, x4
    // 0x1fcd84: mov             x2, x3
    // 0x1fcd88: r4 = const [0, 0x3, 0x1, 0x3, null]
    //     0x1fcd88: ldr             x4, [PP, #0x3b0]  ; [pp+0x3b0] List(5) [0, 0x3, 0x1, 0x3, Null]
    // 0x1fcd8c: r0 = GDT[cid_x0 + 0xb63b]()
    //     0x1fcd8c: mov             x17, #0xb63b
    //     0x1fcd90: add             lr, x0, x17
    //     0x1fcd94: ldr             lr, [x21, lr, lsl #3]
    //     0x1fcd98: blr             lr
    // 0x1fcd9c: r1 = Null
    //     0x1fcd9c: mov             x1, NULL
    // 0x1fcda0: r2 = 2
    //     0x1fcda0: mov             x2, #2
    // 0x1fcda4: stur            x0, [fp, #-0x58]
    // 0x1fcda8: r0 = AllocateArray()
    //     0x1fcda8: bl              #0x42a740  ; AllocateArrayStub
    // 0x1fcdac: mov             x2, x0
    // 0x1fcdb0: ldur            x0, [fp, #-0x20]
    // 0x1fcdb4: stur            x2, [fp, #-0x60]
    // 0x1fcdb8: ArrayStore: r2[0] = r0  ; List_8
    //     0x1fcdb8: stur            x0, [x2, #0x17]
    // 0x1fcdbc: r1 = <int>
    //     0x1fcdbc: ldr             x1, [PP, #0xa70]  ; [pp+0xa70] TypeArguments: <int>
    // 0x1fcdc0: r0 = AllocateGrowableArray()
    //     0x1fcdc0: bl              #0x429618  ; AllocateGrowableArrayStub
    // 0x1fcdc4: mov             x3, x0
    // 0x1fcdc8: ldur            x0, [fp, #-0x60]
    // 0x1fcdcc: stur            x3, [fp, #-0x68]
    // 0x1fcdd0: ArrayStore: r3[0] = r0  ; List_8
    //     0x1fcdd0: stur            x0, [x3, #0x17]
    // 0x1fcdd4: r0 = 2
    //     0x1fcdd4: mov             x0, #2
    // 0x1fcdd8: StoreField: r3->field_f = r0
    //     0x1fcdd8: stur            x0, [x3, #0xf]
    // 0x1fcddc: ldur            x1, [fp, #-0x38]
    // 0x1fcde0: r2 = 4
    //     0x1fcde0: mov             x2, #4
    // 0x1fcde4: r0 = _le()
    //     0x1fcde4: bl              #0x1a6050  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::_le
    // 0x1fcde8: ldur            x1, [fp, #-0x68]
    // 0x1fcdec: mov             x2, x0
    // 0x1fcdf0: r0 = addAll()
    //     0x1fcdf0: bl              #0x11280  ; [dart:core] _GrowableList::addAll
    // 0x1fcdf4: ldur            x2, [fp, #-0x58]
    // 0x1fcdf8: r0 = LoadClassIdInstr(r2)
    //     0x1fcdf8: ldur            x0, [x2, #-1]
    //     0x1fcdfc: ubfx            x0, x0, #0xc, #0x14
    // 0x1fce00: str             x2, [SP]
    // 0x1fce04: r0 = GDT[cid_x0 + 0x800d]()
    //     0x1fce04: mov             x17, #0x800d
    //     0x1fce08: add             lr, x0, x17
    //     0x1fce0c: ldr             lr, [x21, lr, lsl #3]
    //     0x1fce10: blr             lr
    // 0x1fce14: asr             x1, x0, #1
    // 0x1fce18: r2 = 3
    //     0x1fce18: mov             x2, #3
    // 0x1fce1c: r0 = _le()
    //     0x1fce1c: bl              #0x1a6050  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::_le
    // 0x1fce20: ldur            x1, [fp, #-0x68]
    // 0x1fce24: mov             x2, x0
    // 0x1fce28: r0 = addAll()
    //     0x1fce28: bl              #0x11280  ; [dart:core] _GrowableList::addAll
    // 0x1fce2c: ldur            x1, [fp, #-0x68]
    // 0x1fce30: ldur            x2, [fp, #-0x58]
    // 0x1fce34: r0 = addAll()
    //     0x1fce34: bl              #0x11280  ; [dart:core] _GrowableList::addAll
    // 0x1fce38: ldur            x2, [fp, #-0x68]
    // 0x1fce3c: r1 = 34
    //     0x1fce3c: mov             x1, #0x22
    // 0x1fce40: r0 = packet()
    //     0x1fce40: bl              #0x1a5eec  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::packet
    // 0x1fce44: ldur            x1, [fp, #-0x40]
    // 0x1fce48: mov             x2, x0
    // 0x1fce4c: r3 = Instance_Duration
    //     0x1fce4c: add             x3, PP, #0x14, lsl #12  ; [pp+0x14f78] Obj!Duration@2be39a1
    //     0x1fce50: ldr             x3, [x3, #0xf78]
    // 0x1fce54: r0 = request()
    //     0x1fce54: bl              #0x1a53dc  ; [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::request
    // 0x1fce58: mov             x1, x0
    // 0x1fce5c: stur            x1, [fp, #-0x58]
    // 0x1fce60: r0 = Await()
    //     0x1fce60: bl              #0x14028  ; AwaitStub
    // 0x1fce64: stur            x0, [fp, #-0x58]
    // 0x1fce68: cmp             x0, NULL
    // 0x1fce6c: b.eq            #0x1fcef4
    // 0x1fce70: mov             x1, x0
    // 0x1fce74: r0 = packetCmd()
    //     0x1fce74: bl              #0x1a5384  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::packetCmd
    // 0x1fce78: cbnz            x0, #0x1fcef4
    // 0x1fce7c: ldur            x1, [fp, #-0x58]
    // 0x1fce80: r0 = packetData()
    //     0x1fce80: bl              #0x1a4f58  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::packetData
    // 0x1fce84: mov             x2, x0
    // 0x1fce88: stur            x2, [fp, #-0x58]
    // 0x1fce8c: r0 = LoadClassIdInstr(r2)
    //     0x1fce8c: ldur            x0, [x2, #-1]
    //     0x1fce90: ubfx            x0, x0, #0xc, #0x14
    // 0x1fce94: mov             x1, x2
    // 0x1fce98: r0 = GDT[cid_x0 + 0x9da6]()
    //     0x1fce98: mov             x17, #0x9da6
    //     0x1fce9c: add             lr, x0, x17
    //     0x1fcea0: ldr             lr, [x21, lr, lsl #3]
    //     0x1fcea4: blr             lr
    // 0x1fcea8: tbnz            w0, #4, #0x1fcef4
    // 0x1fceac: ldur            x0, [fp, #-0x58]
    // 0x1fceb0: r1 = LoadClassIdInstr(r0)
    //     0x1fceb0: ldur            x1, [x0, #-1]
    //     0x1fceb4: ubfx            x1, x1, #0xc, #0x14
    // 0x1fceb8: stp             xzr, x0, [SP]
    // 0x1fcebc: mov             x0, x1
    // 0x1fcec0: r0 = GDT[cid_x0 + -0xd18]()
    //     0x1fcec0: sub             lr, x0, #0xd18
    //     0x1fcec4: ldr             lr, [x21, lr, lsl #3]
    //     0x1fcec8: blr             lr
    // 0x1fcecc: cbnz            x0, #0x1fcef4
    // 0x1fced0: ldur            x2, [fp, #-0x38]
    // 0x1fced4: ldur            x1, [fp, #-0x50]
    // 0x1fced8: add             x6, x2, x1
    // 0x1fcedc: ldur            x7, [fp, #-0x48]
    // 0x1fcee0: ldur            x2, [fp, #-0x10]
    // 0x1fcee4: ldur            x4, [fp, #-0x18]
    // 0x1fcee8: ldur            x3, [fp, #-0x40]
    // 0x1fceec: ldur            x5, [fp, #-0x20]
    // 0x1fcef0: b               #0x1fcc98
    // 0x1fcef4: r0 = false
    //     0x1fcef4: add             x0, NULL, #0x30  ; false
    // 0x1fcef8: r0 = ReturnAsyncNotFuture()
    //     0x1fcef8: b               #0x13ffc  ; ReturnAsyncNotFutureStub
    // 0x1fcefc: r0 = true
    //     0x1fcefc: add             x0, NULL, #0x20  ; true
    // 0x1fcf00: r0 = ReturnAsyncNotFuture()
    //     0x1fcf00: b               #0x13ffc  ; ReturnAsyncNotFutureStub
    // 0x1fcf04: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1fcf04: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1fcf08: b               #0x1fcc60
    // 0x1fcf0c: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1fcf0c: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1fcf10: b               #0x1fccb0
  }
  _ _respondsSuccess(/* No info */) {
    // ** addr: 0x1fcf14, size: 0xd4
    // 0x1fcf14: EnterFrame
    //     0x1fcf14: stp             fp, lr, [SP, #-0x10]!
    //     0x1fcf18: mov             fp, SP
    // 0x1fcf1c: AllocStack(0x18)
    //     0x1fcf1c: sub             SP, SP, #0x18
    // 0x1fcf20: SetupParameters(dynamic _ /* r2 => r0, fp-0x8 */)
    //     0x1fcf20: mov             x0, x2
    //     0x1fcf24: stur            x2, [fp, #-8]
    // 0x1fcf28: CheckStackOverflow
    //     0x1fcf28: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1fcf2c: cmp             SP, x16
    //     0x1fcf30: b.ls            #0x1fcfe0
    // 0x1fcf34: cmp             x0, NULL
    // 0x1fcf38: b.ne            #0x1fcf4c
    // 0x1fcf3c: r0 = false
    //     0x1fcf3c: add             x0, NULL, #0x30  ; false
    // 0x1fcf40: LeaveFrame
    //     0x1fcf40: mov             SP, fp
    //     0x1fcf44: ldp             fp, lr, [SP], #0x10
    // 0x1fcf48: ret
    //     0x1fcf48: ret             
    // 0x1fcf4c: mov             x1, x0
    // 0x1fcf50: r0 = packetCmd()
    //     0x1fcf50: bl              #0x1a5384  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::packetCmd
    // 0x1fcf54: cbz             x0, #0x1fcf68
    // 0x1fcf58: r0 = false
    //     0x1fcf58: add             x0, NULL, #0x30  ; false
    // 0x1fcf5c: LeaveFrame
    //     0x1fcf5c: mov             SP, fp
    //     0x1fcf60: ldp             fp, lr, [SP], #0x10
    // 0x1fcf64: ret
    //     0x1fcf64: ret             
    // 0x1fcf68: ldur            x1, [fp, #-8]
    // 0x1fcf6c: r0 = packetData()
    //     0x1fcf6c: bl              #0x1a4f58  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::packetData
    // 0x1fcf70: mov             x2, x0
    // 0x1fcf74: stur            x2, [fp, #-8]
    // 0x1fcf78: r0 = LoadClassIdInstr(r2)
    //     0x1fcf78: ldur            x0, [x2, #-1]
    //     0x1fcf7c: ubfx            x0, x0, #0xc, #0x14
    // 0x1fcf80: mov             x1, x2
    // 0x1fcf84: r0 = GDT[cid_x0 + 0x9da6]()
    //     0x1fcf84: mov             x17, #0x9da6
    //     0x1fcf88: add             lr, x0, x17
    //     0x1fcf8c: ldr             lr, [x21, lr, lsl #3]
    //     0x1fcf90: blr             lr
    // 0x1fcf94: tbnz            w0, #4, #0x1fcfd0
    // 0x1fcf98: ldur            x0, [fp, #-8]
    // 0x1fcf9c: r1 = LoadClassIdInstr(r0)
    //     0x1fcf9c: ldur            x1, [x0, #-1]
    //     0x1fcfa0: ubfx            x1, x1, #0xc, #0x14
    // 0x1fcfa4: stp             xzr, x0, [SP]
    // 0x1fcfa8: mov             x0, x1
    // 0x1fcfac: r0 = GDT[cid_x0 + -0xd18]()
    //     0x1fcfac: sub             lr, x0, #0xd18
    //     0x1fcfb0: ldr             lr, [x21, lr, lsl #3]
    //     0x1fcfb4: blr             lr
    // 0x1fcfb8: cbz             x0, #0x1fcfc4
    // 0x1fcfbc: r1 = false
    //     0x1fcfbc: add             x1, NULL, #0x30  ; false
    // 0x1fcfc0: b               #0x1fcfc8
    // 0x1fcfc4: r1 = true
    //     0x1fcfc4: add             x1, NULL, #0x20  ; true
    // 0x1fcfc8: mov             x0, x1
    // 0x1fcfcc: b               #0x1fcfd4
    // 0x1fcfd0: r0 = false
    //     0x1fcfd0: add             x0, NULL, #0x30  ; false
    // 0x1fcfd4: LeaveFrame
    //     0x1fcfd4: mov             SP, fp
    //     0x1fcfd8: ldp             fp, lr, [SP], #0x10
    // 0x1fcfdc: ret
    //     0x1fcfdc: ret             
    // 0x1fcfe0: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1fcfe0: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1fcfe4: b               #0x1fcf34
  }
  _ flashErase(/* No info */) async {
    // ** addr: 0x2890d0, size: 0x84
    // 0x2890d0: EnterFrame
    //     0x2890d0: stp             fp, lr, [SP, #-0x10]!
    //     0x2890d4: mov             fp, SP
    // 0x2890d8: AllocStack(0x20)
    //     0x2890d8: sub             SP, SP, #0x20
    // 0x2890dc: SetupParameters(UsbConnect this /* r1 => r2, fp-0x10 */, dynamic _ /* r2 => r1, fp-0x18 */)
    //     0x2890dc: stur            NULL, [fp, #-8]
    //     0x2890e0: stur            x1, [fp, #-0x10]
    //     0x2890e4: mov             x16, x2
    //     0x2890e8: mov             x2, x1
    //     0x2890ec: mov             x1, x16
    //     0x2890f0: stur            x1, [fp, #-0x18]
    // 0x2890f4: CheckStackOverflow
    //     0x2890f4: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x2890f8: cmp             SP, x16
    //     0x2890fc: b.ls            #0x28914c
    // 0x289100: InitAsync() -> Future<bool>
    //     0x289100: ldr             x0, [PP, #0x2818]  ; [pp+0x2818] TypeArguments: <bool>
    //     0x289104: bl              #0x473b4  ; InitAsyncStub
    // 0x289108: ldur            x0, [fp, #-0x10]
    // 0x28910c: LoadField: r2 = r0->field_7
    //     0x28910c: ldur            x2, [x0, #7]
    // 0x289110: ldur            x1, [fp, #-0x18]
    // 0x289114: stur            x2, [fp, #-0x20]
    // 0x289118: r0 = erasePacket()
    //     0x289118: bl              #0x289154  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::erasePacket
    // 0x28911c: ldur            x1, [fp, #-0x20]
    // 0x289120: mov             x2, x0
    // 0x289124: r3 = Instance_Duration
    //     0x289124: add             x3, PP, #0x17, lsl #12  ; [pp+0x17988] Obj!Duration@2be39d1
    //     0x289128: ldr             x3, [x3, #0x988]
    // 0x28912c: r0 = request()
    //     0x28912c: bl              #0x1a53dc  ; [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::request
    // 0x289130: mov             x1, x0
    // 0x289134: stur            x1, [fp, #-0x20]
    // 0x289138: r0 = Await()
    //     0x289138: bl              #0x14028  ; AwaitStub
    // 0x28913c: ldur            x1, [fp, #-0x10]
    // 0x289140: mov             x2, x0
    // 0x289144: r0 = _respondsSuccess()
    //     0x289144: bl              #0x1fcf14  ; [package:musical_instruments/core/usb/usb_connect.dart] UsbConnect::_respondsSuccess
    // 0x289148: r0 = ReturnAsyncNotFuture()
    //     0x289148: b               #0x13ffc  ; ReturnAsyncNotFutureStub
    // 0x28914c: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x28914c: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x289150: b               #0x289100
  }
  _ flashSave0(/* No info */) async {
    // ** addr: 0x29bde0, size: 0x84
    // 0x29bde0: EnterFrame
    //     0x29bde0: stp             fp, lr, [SP, #-0x10]!
    //     0x29bde4: mov             fp, SP
    // 0x29bde8: AllocStack(0x20)
    //     0x29bde8: sub             SP, SP, #0x20
    // 0x29bdec: SetupParameters(UsbConnect this /* r1 => r2, fp-0x10 */, dynamic _ /* r2 => r1, fp-0x18 */)
    //     0x29bdec: stur            NULL, [fp, #-8]
    //     0x29bdf0: stur            x1, [fp, #-0x10]
    //     0x29bdf4: mov             x16, x2
    //     0x29bdf8: mov             x2, x1
    //     0x29bdfc: mov             x1, x16
    //     0x29be00: stur            x1, [fp, #-0x18]
    // 0x29be04: CheckStackOverflow
    //     0x29be04: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x29be08: cmp             SP, x16
    //     0x29be0c: b.ls            #0x29be5c
    // 0x29be10: InitAsync() -> Future<bool>
    //     0x29be10: ldr             x0, [PP, #0x2818]  ; [pp+0x2818] TypeArguments: <bool>
    //     0x29be14: bl              #0x473b4  ; InitAsyncStub
    // 0x29be18: ldur            x0, [fp, #-0x10]
    // 0x29be1c: LoadField: r2 = r0->field_7
    //     0x29be1c: ldur            x2, [x0, #7]
    // 0x29be20: ldur            x1, [fp, #-0x18]
    // 0x29be24: stur            x2, [fp, #-0x20]
    // 0x29be28: r0 = save0Packet()
    //     0x29be28: bl              #0x29be64  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::save0Packet
    // 0x29be2c: ldur            x1, [fp, #-0x20]
    // 0x29be30: mov             x2, x0
    // 0x29be34: r3 = Instance_Duration
    //     0x29be34: add             x3, PP, #0x14, lsl #12  ; [pp+0x14f78] Obj!Duration@2be39a1
    //     0x29be38: ldr             x3, [x3, #0xf78]
    // 0x29be3c: r0 = request()
    //     0x29be3c: bl              #0x1a53dc  ; [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::request
    // 0x29be40: mov             x1, x0
    // 0x29be44: stur            x1, [fp, #-0x20]
    // 0x29be48: r0 = Await()
    //     0x29be48: bl              #0x14028  ; AwaitStub
    // 0x29be4c: ldur            x1, [fp, #-0x10]
    // 0x29be50: mov             x2, x0
    // 0x29be54: r0 = _respondsSuccess()
    //     0x29be54: bl              #0x1fcf14  ; [package:musical_instruments/core/usb/usb_connect.dart] UsbConnect::_respondsSuccess
    // 0x29be58: r0 = ReturnAsyncNotFuture()
    //     0x29be58: b               #0x13ffc  ; ReturnAsyncNotFutureStub
    // 0x29be5c: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x29be5c: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x29be60: b               #0x29be10
  }
}

// class id: 360, size: 0x18, field offset: 0x8
//   const constructor, 
class DeviceIdentity extends Object {

  _ toString(/* No info */) {
    // ** addr: 0x30dc28, size: 0x88
    // 0x30dc28: EnterFrame
    //     0x30dc28: stp             fp, lr, [SP, #-0x10]!
    //     0x30dc2c: mov             fp, SP
    // 0x30dc30: AllocStack(0x10)
    //     0x30dc30: sub             SP, SP, #0x10
    // 0x30dc34: CheckStackOverflow
    //     0x30dc34: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x30dc38: cmp             SP, x16
    //     0x30dc3c: b.ls            #0x30dca8
    // 0x30dc40: ldr             x0, [fp, #0x10]
    // 0x30dc44: LoadField: r3 = r0->field_7
    //     0x30dc44: ldur            x3, [x0, #7]
    // 0x30dc48: stur            x3, [fp, #-8]
    // 0x30dc4c: r1 = Null
    //     0x30dc4c: mov             x1, NULL
    // 0x30dc50: r2 = 8
    //     0x30dc50: mov             x2, #8
    // 0x30dc54: r0 = AllocateArray()
    //     0x30dc54: bl              #0x42a740  ; AllocateArrayStub
    // 0x30dc58: mov             x2, x0
    // 0x30dc5c: ldur            x0, [fp, #-8]
    // 0x30dc60: ArrayStore: r2[0] = r0  ; List_8
    //     0x30dc60: stur            x0, [x2, #0x17]
    // 0x30dc64: r16 = " (v"
    //     0x30dc64: add             x16, PP, #0x11, lsl #12  ; [pp+0x11e58] " (v"
    //     0x30dc68: ldr             x16, [x16, #0xe58]
    // 0x30dc6c: StoreField: r2->field_1f = r16
    //     0x30dc6c: stur            x16, [x2, #0x1f]
    // 0x30dc70: ldr             x0, [fp, #0x10]
    // 0x30dc74: LoadField: r3 = r0->field_f
    //     0x30dc74: ldur            x3, [x0, #0xf]
    // 0x30dc78: adds            x0, x3, x3
    // 0x30dc7c: b.vc            #0x30dc88
    // 0x30dc80: r0 = AllocateMintSharedWithoutFPURegs()
    //     0x30dc80: bl              #0x42a9c4  ; AllocateMintSharedWithoutFPURegsStub
    // 0x30dc84: StoreField: r0->field_7 = r3
    //     0x30dc84: stur            x3, [x0, #7]
    // 0x30dc88: StoreField: r2->field_27 = r0
    //     0x30dc88: stur            x0, [x2, #0x27]
    // 0x30dc8c: r16 = ")"
    //     0x30dc8c: ldr             x16, [PP, #0x25f0]  ; [pp+0x25f0] ")"
    // 0x30dc90: StoreField: r2->field_2f = r16
    //     0x30dc90: stur            x16, [x2, #0x2f]
    // 0x30dc94: str             x2, [SP]
    // 0x30dc98: r0 = _interpolate()
    //     0x30dc98: bl              #0x14da8  ; [dart:core] _StringBase::_interpolate
    // 0x30dc9c: LeaveFrame
    //     0x30dc9c: mov             SP, fp
    //     0x30dca0: ldp             fp, lr, [SP], #0x10
    // 0x30dca4: ret
    //     0x30dca4: ret             
    // 0x30dca8: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x30dca8: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x30dcac: b               #0x30dc40
  }
}
