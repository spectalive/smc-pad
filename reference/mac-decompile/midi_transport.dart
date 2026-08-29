// lib: , url: package:musical_instruments/core/usb/midi_transport.dart

// class id: 1049199, size: 0x8
class :: {
}

// class id: 362, size: 0x48, field offset: 0x8
class MidiTransport extends Object {

  _ disconnect(/* No info */) {
    // ** addr: 0x1a49c8, size: 0x80
    // 0x1a49c8: EnterFrame
    //     0x1a49c8: stp             fp, lr, [SP, #-0x10]!
    //     0x1a49cc: mov             fp, SP
    // 0x1a49d0: AllocStack(0x8)
    //     0x1a49d0: sub             SP, SP, #8
    // 0x1a49d4: SetupParameters(MidiTransport this /* r1 => r0, fp-0x8 */)
    //     0x1a49d4: mov             x0, x1
    //     0x1a49d8: stur            x1, [fp, #-8]
    // 0x1a49dc: CheckStackOverflow
    //     0x1a49dc: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a49e0: cmp             SP, x16
    //     0x1a49e4: b.ls            #0x1a4a40
    // 0x1a49e8: LoadField: r2 = r0->field_f
    //     0x1a49e8: ldur            x2, [x0, #0xf]
    // 0x1a49ec: cmp             x2, NULL
    // 0x1a49f0: b.eq            #0x1a49fc
    // 0x1a49f4: LoadField: r1 = r0->field_7
    //     0x1a49f4: ldur            x1, [x0, #7]
    // 0x1a49f8: r0 = disconnectDevice()
    //     0x1a49f8: bl              #0x1a4a48  ; [package:flutter_midi_command/flutter_midi_command.dart] MidiCommand::disconnectDevice
    // 0x1a49fc: ldur            x0, [fp, #-8]
    // 0x1a4a00: ArrayLoad: r1 = r0[0]  ; List_8
    //     0x1a4a00: ldur            x1, [x0, #0x17]
    // 0x1a4a04: cmp             x1, NULL
    // 0x1a4a08: b.eq            #0x1a4a14
    // 0x1a4a0c: r0 = cancel()
    //     0x1a4a0c: bl              #0x3d80b8  ; [dart:async] _BufferingStreamSubscription::cancel
    // 0x1a4a10: ldur            x0, [fp, #-8]
    // 0x1a4a14: ArrayStore: r0[0] = rNULL  ; List_8
    //     0x1a4a14: stur            NULL, [x0, #0x17]
    // 0x1a4a18: StoreField: r0->field_f = rNULL
    //     0x1a4a18: stur            NULL, [x0, #0xf]
    // 0x1a4a1c: LoadField: r1 = r0->field_1f
    //     0x1a4a1c: ldur            x1, [x0, #0x1f]
    // 0x1a4a20: r0 = clear()
    //     0x1a4a20: bl              #0x40dc4  ; [dart:core] _GrowableList::clear
    // 0x1a4a24: ldur            x1, [fp, #-8]
    // 0x1a4a28: r2 = false
    //     0x1a4a28: add             x2, NULL, #0x30  ; false
    // 0x1a4a2c: StoreField: r1->field_27 = r2
    //     0x1a4a2c: stur            x2, [x1, #0x27]
    // 0x1a4a30: r0 = Null
    //     0x1a4a30: mov             x0, NULL
    // 0x1a4a34: LeaveFrame
    //     0x1a4a34: mov             SP, fp
    //     0x1a4a38: ldp             fp, lr, [SP], #0x10
    // 0x1a4a3c: ret
    //     0x1a4a3c: ret             
    // 0x1a4a40: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a4a40: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a4a44: b               #0x1a49e8
  }
  _ request(/* No info */) {
    // ** addr: 0x1a53dc, size: 0x15c
    // 0x1a53dc: EnterFrame
    //     0x1a53dc: stp             fp, lr, [SP, #-0x10]!
    //     0x1a53e0: mov             fp, SP
    // 0x1a53e4: AllocStack(0x40)
    //     0x1a53e4: sub             SP, SP, #0x40
    // 0x1a53e8: SetupParameters(MidiTransport this /* r1 => r1, fp-0x8 */, dynamic _ /* r2 => r2, fp-0x10 */, dynamic _ /* r3 => r3, fp-0x18 */)
    //     0x1a53e8: stur            x1, [fp, #-8]
    //     0x1a53ec: stur            x2, [fp, #-0x10]
    //     0x1a53f0: stur            x3, [fp, #-0x18]
    // 0x1a53f4: CheckStackOverflow
    //     0x1a53f4: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a53f8: cmp             SP, x16
    //     0x1a53fc: b.ls            #0x1a5530
    // 0x1a5400: r1 = 4
    //     0x1a5400: mov             x1, #4
    // 0x1a5404: r0 = AllocateContext()
    //     0x1a5404: bl              #0x429658  ; AllocateContextStub
    // 0x1a5408: mov             x2, x0
    // 0x1a540c: ldur            x0, [fp, #-8]
    // 0x1a5410: stur            x2, [fp, #-0x20]
    // 0x1a5414: ArrayStore: r2[0] = r0  ; List_8
    //     0x1a5414: stur            x0, [x2, #0x17]
    // 0x1a5418: ldur            x1, [fp, #-0x10]
    // 0x1a541c: StoreField: r2->field_1f = r1
    //     0x1a541c: stur            x1, [x2, #0x1f]
    // 0x1a5420: ldur            x1, [fp, #-0x18]
    // 0x1a5424: StoreField: r2->field_27 = r1
    //     0x1a5424: stur            x1, [x2, #0x27]
    // 0x1a5428: r1 = <List<int>?>
    //     0x1a5428: add             x1, PP, #0xd, lsl #12  ; [pp+0xd838] TypeArguments: <List<int>?>
    //     0x1a542c: ldr             x1, [x1, #0x838]
    // 0x1a5430: r0 = _Future()
    //     0x1a5430: bl              #0x2d2f0  ; Allocate_FutureStub -> _Future<X0> (size=0x28)
    // 0x1a5434: stur            x0, [fp, #-0x10]
    // 0x1a5438: StoreField: r0->field_f = rZR
    //     0x1a5438: stur            xzr, [x0, #0xf]
    // 0x1a543c: r0 = LoadStaticField(0x6b0)
    //     0x1a543c: ldr             x0, [THR, #0x70]  ; THR::field_table_values
    //     0x1a5440: ldr             x0, [x0, #0x6b0]
    // 0x1a5444: ldr             x16, [THR, #0x88]  ; THR::object_sentinel
    // 0x1a5448: cmp             x0, x16
    // 0x1a544c: b.ne            #0x1a5458
    // 0x1a5450: r2 = _current
    //     0x1a5450: ldr             x2, [PP, #0x358]  ; [pp+0x358] Field <Zone._current@5048458>: static late (offset: 0x6b0)
    // 0x1a5454: r0 = InitLateStaticField()
    //     0x1a5454: bl              #0x4288b8  ; InitLateStaticFieldStub
    // 0x1a5458: mov             x1, x0
    // 0x1a545c: ldur            x0, [fp, #-0x10]
    // 0x1a5460: ArrayStore: r0[0] = r1  ; List_8
    //     0x1a5460: stur            x1, [x0, #0x17]
    // 0x1a5464: r1 = <List<int>?>
    //     0x1a5464: add             x1, PP, #0xd, lsl #12  ; [pp+0xd838] TypeArguments: <List<int>?>
    //     0x1a5468: ldr             x1, [x1, #0x838]
    // 0x1a546c: r0 = _AsyncCompleter()
    //     0x1a546c: bl              #0x24f78  ; Allocate_AsyncCompleterStub -> _AsyncCompleter<X0> (size=0x18)
    // 0x1a5470: mov             x1, x0
    // 0x1a5474: ldur            x0, [fp, #-0x10]
    // 0x1a5478: StoreField: r1->field_f = r0
    //     0x1a5478: stur            x0, [x1, #0xf]
    // 0x1a547c: ldur            x3, [fp, #-0x20]
    // 0x1a5480: StoreField: r3->field_2f = r1
    //     0x1a5480: stur            x1, [x3, #0x2f]
    // 0x1a5484: ldur            x4, [fp, #-8]
    // 0x1a5488: LoadField: r5 = r4->field_3f
    //     0x1a5488: ldur            x5, [x4, #0x3f]
    // 0x1a548c: mov             x2, x3
    // 0x1a5490: stur            x5, [fp, #-0x18]
    // 0x1a5494: r1 = Function '<anonymous closure>':.
    //     0x1a5494: add             x1, PP, #0xd, lsl #12  ; [pp+0xd840] AnonymousClosure: (0x1a5618), in [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::request (0x1a53dc)
    //     0x1a5498: ldr             x1, [x1, #0x840]
    // 0x1a549c: r0 = AllocateClosure()
    //     0x1a549c: bl              #0x429a24  ; AllocateClosureStub
    // 0x1a54a0: r16 = <List<int>?>
    //     0x1a54a0: add             x16, PP, #0xd, lsl #12  ; [pp+0xd838] TypeArguments: <List<int>?>
    //     0x1a54a4: ldr             x16, [x16, #0x838]
    // 0x1a54a8: ldur            lr, [fp, #-0x18]
    // 0x1a54ac: stp             lr, x16, [SP, #8]
    // 0x1a54b0: str             x0, [SP]
    // 0x1a54b4: r4 = const [0x1, 0x2, 0x2, 0x2, null]
    //     0x1a54b4: ldr             x4, [PP, #0x40]  ; [pp+0x40] List(5) [0x1, 0x2, 0x2, 0x2, Null]
    // 0x1a54b8: r0 = then()
    //     0x1a54b8: bl              #0x3ec21c  ; [dart:async] _Future::then
    // 0x1a54bc: ldur            x2, [fp, #-0x20]
    // 0x1a54c0: r1 = Function '<anonymous closure>':.
    //     0x1a54c0: add             x1, PP, #0xd, lsl #12  ; [pp+0xd848] AnonymousClosure: (0x1a55b8), in [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::request (0x1a53dc)
    //     0x1a54c4: ldr             x1, [x1, #0x848]
    // 0x1a54c8: stur            x0, [fp, #-0x18]
    // 0x1a54cc: r0 = AllocateClosure()
    //     0x1a54cc: bl              #0x429a24  ; AllocateClosureStub
    // 0x1a54d0: ldur            x2, [fp, #-0x20]
    // 0x1a54d4: r1 = Function '<anonymous closure>':.
    //     0x1a54d4: add             x1, PP, #0xd, lsl #12  ; [pp+0xd850] AnonymousClosure: (0x1a5538), in [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::request (0x1a53dc)
    //     0x1a54d8: ldr             x1, [x1, #0x850]
    // 0x1a54dc: stur            x0, [fp, #-0x20]
    // 0x1a54e0: r0 = AllocateClosure()
    //     0x1a54e0: bl              #0x429a24  ; AllocateClosureStub
    // 0x1a54e4: r16 = <void?>
    //     0x1a54e4: ldr             x16, [PP, #0x528]  ; [pp+0x528] TypeArguments: <void?>
    // 0x1a54e8: ldur            lr, [fp, #-0x18]
    // 0x1a54ec: stp             lr, x16, [SP, #0x10]
    // 0x1a54f0: ldur            x16, [fp, #-0x20]
    // 0x1a54f4: stp             x0, x16, [SP]
    // 0x1a54f8: r4 = const [0x1, 0x3, 0x3, 0x2, onError, 0x2, null]
    //     0x1a54f8: ldr             x4, [PP, #0x1a00]  ; [pp+0x1a00] List(7) [0x1, 0x3, 0x3, 0x2, "onError", 0x2, Null]
    // 0x1a54fc: r0 = then()
    //     0x1a54fc: bl              #0x3ec21c  ; [dart:async] _Future::then
    // 0x1a5500: ldur            x1, [fp, #-8]
    // 0x1a5504: StoreField: r1->field_3f = r0
    //     0x1a5504: stur            x0, [x1, #0x3f]
    //     0x1a5508: ldurb           w16, [x1, #-1]
    //     0x1a550c: ldurb           w17, [x0, #-1]
    //     0x1a5510: and             x16, x17, x16, lsr #2
    //     0x1a5514: tst             x16, HEAP, lsr #32
    //     0x1a5518: b.eq            #0x1a5520
    //     0x1a551c: bl              #0x428dd0  ; WriteBarrierWrappersStub
    // 0x1a5520: ldur            x0, [fp, #-0x10]
    // 0x1a5524: LeaveFrame
    //     0x1a5524: mov             SP, fp
    //     0x1a5528: ldp             fp, lr, [SP], #0x10
    // 0x1a552c: ret
    //     0x1a552c: ret             
    // 0x1a5530: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a5530: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a5534: b               #0x1a5400
  }
  [closure] Null <anonymous closure>(dynamic, dynamic) {
    // ** addr: 0x1a5538, size: 0x5c
    // 0x1a5538: EnterFrame
    //     0x1a5538: stp             fp, lr, [SP, #-0x10]!
    //     0x1a553c: mov             fp, SP
    // 0x1a5540: AllocStack(0x10)
    //     0x1a5540: sub             SP, SP, #0x10
    // 0x1a5544: SetupParameters([dynamic _ /* r0 */])
    //     0x1a5544: ldr             x0, [fp, #0x18]
    //     0x1a5548: ldur            x1, [x0, #0x27]
    // 0x1a554c: CheckStackOverflow
    //     0x1a554c: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a5550: cmp             SP, x16
    //     0x1a5554: b.ls            #0x1a558c
    // 0x1a5558: LoadField: r0 = r1->field_2f
    //     0x1a5558: ldur            x0, [x1, #0x2f]
    // 0x1a555c: mov             x1, x0
    // 0x1a5560: stur            x0, [fp, #-8]
    // 0x1a5564: r0 = isCompleted()
    //     0x1a5564: bl              #0x1a5594  ; [dart:async] _Completer::isCompleted
    // 0x1a5568: tbz             w0, #4, #0x1a557c
    // 0x1a556c: str             NULL, [SP]
    // 0x1a5570: ldur            x1, [fp, #-8]
    // 0x1a5574: r4 = const [0, 0x2, 0x1, 0x2, null]
    //     0x1a5574: ldr             x4, [PP, #0x668]  ; [pp+0x668] List(5) [0, 0x2, 0x1, 0x2, Null]
    // 0x1a5578: r0 = complete()
    //     0x1a5578: bl              #0x3eab3c  ; [dart:async] _AsyncCompleter::complete
    // 0x1a557c: r0 = Null
    //     0x1a557c: mov             x0, NULL
    // 0x1a5580: LeaveFrame
    //     0x1a5580: mov             SP, fp
    //     0x1a5584: ldp             fp, lr, [SP], #0x10
    // 0x1a5588: ret
    //     0x1a5588: ret             
    // 0x1a558c: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a558c: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a5590: b               #0x1a5558
  }
  [closure] Null <anonymous closure>(dynamic, List<int>?) {
    // ** addr: 0x1a55b8, size: 0x60
    // 0x1a55b8: EnterFrame
    //     0x1a55b8: stp             fp, lr, [SP, #-0x10]!
    //     0x1a55bc: mov             fp, SP
    // 0x1a55c0: AllocStack(0x8)
    //     0x1a55c0: sub             SP, SP, #8
    // 0x1a55c4: SetupParameters([dynamic _ /* r0 */])
    //     0x1a55c4: ldr             x0, [fp, #0x18]
    //     0x1a55c8: ldur            x1, [x0, #0x27]
    // 0x1a55cc: CheckStackOverflow
    //     0x1a55cc: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a55d0: cmp             SP, x16
    //     0x1a55d4: b.ls            #0x1a5610
    // 0x1a55d8: LoadField: r0 = r1->field_2f
    //     0x1a55d8: ldur            x0, [x1, #0x2f]
    // 0x1a55dc: LoadField: r1 = r0->field_f
    //     0x1a55dc: ldur            x1, [x0, #0xf]
    // 0x1a55e0: LoadField: r2 = r1->field_f
    //     0x1a55e0: ldur            x2, [x1, #0xf]
    // 0x1a55e4: tst             x2, #0x1e
    // 0x1a55e8: b.ne            #0x1a5600
    // 0x1a55ec: ldr             x16, [fp, #0x10]
    // 0x1a55f0: str             x16, [SP]
    // 0x1a55f4: mov             x1, x0
    // 0x1a55f8: r4 = const [0, 0x2, 0x1, 0x2, null]
    //     0x1a55f8: ldr             x4, [PP, #0x668]  ; [pp+0x668] List(5) [0, 0x2, 0x1, 0x2, Null]
    // 0x1a55fc: r0 = complete()
    //     0x1a55fc: bl              #0x3eab3c  ; [dart:async] _AsyncCompleter::complete
    // 0x1a5600: r0 = Null
    //     0x1a5600: mov             x0, NULL
    // 0x1a5604: LeaveFrame
    //     0x1a5604: mov             SP, fp
    //     0x1a5608: ldp             fp, lr, [SP], #0x10
    // 0x1a560c: ret
    //     0x1a560c: ret             
    // 0x1a5610: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a5610: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a5614: b               #0x1a55d8
  }
  [closure] Future<List<int>?> <anonymous closure>(dynamic, void) {
    // ** addr: 0x1a5618, size: 0x44
    // 0x1a5618: EnterFrame
    //     0x1a5618: stp             fp, lr, [SP, #-0x10]!
    //     0x1a561c: mov             fp, SP
    // 0x1a5620: ldr             x0, [fp, #0x18]
    // 0x1a5624: LoadField: r1 = r0->field_27
    //     0x1a5624: ldur            x1, [x0, #0x27]
    // 0x1a5628: CheckStackOverflow
    //     0x1a5628: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a562c: cmp             SP, x16
    //     0x1a5630: b.ls            #0x1a5654
    // 0x1a5634: ArrayLoad: r0 = r1[0]  ; List_8
    //     0x1a5634: ldur            x0, [x1, #0x17]
    // 0x1a5638: LoadField: r2 = r1->field_1f
    //     0x1a5638: ldur            x2, [x1, #0x1f]
    // 0x1a563c: LoadField: r3 = r1->field_27
    //     0x1a563c: ldur            x3, [x1, #0x27]
    // 0x1a5640: mov             x1, x0
    // 0x1a5644: r0 = _doRequest()
    //     0x1a5644: bl              #0x1a565c  ; [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::_doRequest
    // 0x1a5648: LeaveFrame
    //     0x1a5648: mov             SP, fp
    //     0x1a564c: ldp             fp, lr, [SP], #0x10
    // 0x1a5650: ret
    //     0x1a5650: ret             
    // 0x1a5654: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a5654: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a5658: b               #0x1a5634
  }
  _ _doRequest(/* No info */) async {
    // ** addr: 0x1a565c, size: 0x1a0
    // 0x1a565c: EnterFrame
    //     0x1a565c: stp             fp, lr, [SP, #-0x10]!
    //     0x1a5660: mov             fp, SP
    // 0x1a5664: AllocStack(0xb0)
    //     0x1a5664: sub             SP, SP, #0xb0
    // 0x1a5668: SetupParameters(MidiTransport this /* r1 => r1, fp-0x70 */, dynamic _ /* r2 => r2, fp-0x78 */, dynamic _ /* r3 => r3, fp-0x80 */)
    //     0x1a5668: stur            NULL, [fp, #-8]
    //     0x1a566c: stur            x1, [fp, #-0x70]
    //     0x1a5670: stur            x2, [fp, #-0x78]
    //     0x1a5674: stur            x3, [fp, #-0x80]
    // 0x1a5678: CheckStackOverflow
    //     0x1a5678: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a567c: cmp             SP, x16
    //     0x1a5680: b.ls            #0x1a57f4
    // 0x1a5684: InitAsync() -> Future<List<int>?>
    //     0x1a5684: add             x0, PP, #0xd, lsl #12  ; [pp+0xd838] TypeArguments: <List<int>?>
    //     0x1a5688: ldr             x0, [x0, #0x838]
    //     0x1a568c: bl              #0x473b4  ; InitAsyncStub
    // 0x1a5690: r1 = <List<int>?>
    //     0x1a5690: add             x1, PP, #0xd, lsl #12  ; [pp+0xd838] TypeArguments: <List<int>?>
    //     0x1a5694: ldr             x1, [x1, #0x838]
    // 0x1a5698: r0 = _Future()
    //     0x1a5698: bl              #0x2d2f0  ; Allocate_FutureStub -> _Future<X0> (size=0x28)
    // 0x1a569c: stur            x0, [fp, #-0x88]
    // 0x1a56a0: StoreField: r0->field_f = rZR
    //     0x1a56a0: stur            xzr, [x0, #0xf]
    // 0x1a56a4: r0 = LoadStaticField(0x6b0)
    //     0x1a56a4: ldr             x0, [THR, #0x70]  ; THR::field_table_values
    //     0x1a56a8: ldr             x0, [x0, #0x6b0]
    // 0x1a56ac: ldr             x16, [THR, #0x88]  ; THR::object_sentinel
    // 0x1a56b0: cmp             x0, x16
    // 0x1a56b4: b.ne            #0x1a56c0
    // 0x1a56b8: r2 = _current
    //     0x1a56b8: ldr             x2, [PP, #0x358]  ; [pp+0x358] Field <Zone._current@5048458>: static late (offset: 0x6b0)
    // 0x1a56bc: r0 = InitLateStaticField()
    //     0x1a56bc: bl              #0x4288b8  ; InitLateStaticFieldStub
    // 0x1a56c0: mov             x1, x0
    // 0x1a56c4: ldur            x0, [fp, #-0x88]
    // 0x1a56c8: ArrayStore: r0[0] = r1  ; List_8
    //     0x1a56c8: stur            x1, [x0, #0x17]
    // 0x1a56cc: r1 = <List<int>?>
    //     0x1a56cc: add             x1, PP, #0xd, lsl #12  ; [pp+0xd838] TypeArguments: <List<int>?>
    //     0x1a56d0: ldr             x1, [x1, #0x838]
    // 0x1a56d4: r0 = _AsyncCompleter()
    //     0x1a56d4: bl              #0x24f78  ; Allocate_AsyncCompleterStub -> _AsyncCompleter<X0> (size=0x18)
    // 0x1a56d8: mov             x1, x0
    // 0x1a56dc: ldur            x0, [fp, #-0x88]
    // 0x1a56e0: stur            x1, [fp, #-0x90]
    // 0x1a56e4: StoreField: r1->field_f = r0
    //     0x1a56e4: stur            x0, [x1, #0xf]
    // 0x1a56e8: r1 = 1
    //     0x1a56e8: mov             x1, #1
    // 0x1a56ec: r0 = AllocateContext()
    //     0x1a56ec: bl              #0x429658  ; AllocateContextStub
    // 0x1a56f0: mov             x2, x0
    // 0x1a56f4: ldur            x0, [fp, #-0x90]
    // 0x1a56f8: stur            x2, [fp, #-0x98]
    // 0x1a56fc: ArrayStore: r2[0] = r0  ; List_8
    //     0x1a56fc: stur            x0, [x2, #0x17]
    // 0x1a5700: ldur            x1, [fp, #-0x70]
    // 0x1a5704: r0 = onPacket()
    //     0x1a5704: bl              #0x1a5d3c  ; [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::onPacket
    // 0x1a5708: ldur            x2, [fp, #-0x98]
    // 0x1a570c: r1 = Function '<anonymous closure>':.
    //     0x1a570c: add             x1, PP, #0xd, lsl #12  ; [pp+0xd858] AnonymousClosure: (0x1a5e54), in [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::_doRequest (0x1a565c)
    //     0x1a5710: ldr             x1, [x1, #0x858]
    // 0x1a5714: stur            x0, [fp, #-0x90]
    // 0x1a5718: r0 = AllocateClosure()
    //     0x1a5718: bl              #0x429a24  ; AllocateClosureStub
    // 0x1a571c: ldur            x1, [fp, #-0x90]
    // 0x1a5720: mov             x2, x0
    // 0x1a5724: r4 = const [0, 0x2, 0, 0x2, null]
    //     0x1a5724: ldr             x4, [PP, #0x3a8]  ; [pp+0x3a8] List(5) [0, 0x2, 0, 0x2, Null]
    // 0x1a5728: r0 = listen()
    //     0x1a5728: bl              #0x3bead0  ; [dart:async] _StreamImpl::listen
    // 0x1a572c: stur            x0, [fp, #-0x90]
    // 0x1a5730: ldur            x1, [fp, #-0x70]
    // 0x1a5734: ldur            x2, [fp, #-0x78]
    // 0x1a5738: r0 = send()
    //     0x1a5738: bl              #0x1a57fc  ; [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::send
    // 0x1a573c: r1 = Function '<anonymous closure>':.
    //     0x1a573c: add             x1, PP, #0xd, lsl #12  ; [pp+0xd860] Function: [dart:ui] _NativeScene::_NativeScene._ (0x424fe4)
    //     0x1a5740: ldr             x1, [x1, #0x860]
    // 0x1a5744: r2 = Null
    //     0x1a5744: mov             x2, NULL
    // 0x1a5748: r0 = AllocateClosure()
    //     0x1a5748: bl              #0x429a24  ; AllocateClosureStub
    // 0x1a574c: ldur            x16, [fp, #-0x88]
    // 0x1a5750: ldur            lr, [fp, #-0x80]
    // 0x1a5754: stp             lr, x16, [SP, #8]
    // 0x1a5758: str             x0, [SP]
    // 0x1a575c: r4 = const [0, 0x3, 0x3, 0x2, onTimeout, 0x2, null]
    //     0x1a575c: ldr             x4, [PP, #0x1d90]  ; [pp+0x1d90] List(7) [0, 0x3, 0x3, 0x2, "onTimeout", 0x2, Null]
    // 0x1a5760: r0 = timeout()
    //     0x1a5760: bl              #0x146b4  ; [dart:async] _Future::timeout
    // 0x1a5764: mov             x1, x0
    // 0x1a5768: stur            x1, [fp, #-0x88]
    // 0x1a576c: r0 = Await()
    //     0x1a576c: bl              #0x14028  ; AwaitStub
    // 0x1a5770: mov             x2, x0
    // 0x1a5774: stur            x2, [fp, #-0x70]
    // 0x1a5778: ldur            x3, [fp, #-0x90]
    // 0x1a577c: r0 = LoadClassIdInstr(r3)
    //     0x1a577c: ldur            x0, [x3, #-1]
    //     0x1a5780: ubfx            x0, x0, #0xc, #0x14
    // 0x1a5784: mov             x1, x3
    // 0x1a5788: r0 = GDT[cid_x0 + -0x82a]()
    //     0x1a5788: sub             lr, x0, #0x82a
    //     0x1a578c: ldr             lr, [x21, lr, lsl #3]
    //     0x1a5790: blr             lr
    // 0x1a5794: mov             x1, x0
    // 0x1a5798: stur            x1, [fp, #-0x78]
    // 0x1a579c: r0 = Await()
    //     0x1a579c: bl              #0x14028  ; AwaitStub
    // 0x1a57a0: ldur            x0, [fp, #-0x70]
    // 0x1a57a4: r0 = ReturnAsync()
    //     0x1a57a4: b               #0x60c2c  ; ReturnAsyncStub
    // 0x1a57a8: sub             SP, fp, #0xb0
    // 0x1a57ac: ldur            x3, [fp, #-0x90]
    // 0x1a57b0: mov             x4, x0
    // 0x1a57b4: mov             x2, x1
    // 0x1a57b8: stur            x0, [fp, #-0x70]
    // 0x1a57bc: stur            x1, [fp, #-0x78]
    // 0x1a57c0: r0 = LoadClassIdInstr(r3)
    //     0x1a57c0: ldur            x0, [x3, #-1]
    //     0x1a57c4: ubfx            x0, x0, #0xc, #0x14
    // 0x1a57c8: mov             x1, x3
    // 0x1a57cc: r0 = GDT[cid_x0 + -0x82a]()
    //     0x1a57cc: sub             lr, x0, #0x82a
    //     0x1a57d0: ldr             lr, [x21, lr, lsl #3]
    //     0x1a57d4: blr             lr
    // 0x1a57d8: mov             x1, x0
    // 0x1a57dc: stur            x1, [fp, #-0x80]
    // 0x1a57e0: r0 = Await()
    //     0x1a57e0: bl              #0x14028  ; AwaitStub
    // 0x1a57e4: ldur            x0, [fp, #-0x70]
    // 0x1a57e8: ldur            x1, [fp, #-0x78]
    // 0x1a57ec: r0 = ReThrow()
    //     0x1a57ec: bl              #0x428960  ; ReThrowStub
    // 0x1a57f0: brk             #0
    // 0x1a57f4: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a57f4: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a57f8: b               #0x1a5684
  }
  _ send(/* No info */) {
    // ** addr: 0x1a57fc, size: 0xc8
    // 0x1a57fc: EnterFrame
    //     0x1a57fc: stp             fp, lr, [SP, #-0x10]!
    //     0x1a5800: mov             fp, SP
    // 0x1a5804: AllocStack(0x28)
    //     0x1a5804: sub             SP, SP, #0x28
    // 0x1a5808: SetupParameters(MidiTransport this /* r1 => r0, fp-0x10 */, dynamic _ /* r2 => r1 */)
    //     0x1a5808: mov             x0, x1
    //     0x1a580c: stur            x1, [fp, #-0x10]
    //     0x1a5810: mov             x1, x2
    // 0x1a5814: CheckStackOverflow
    //     0x1a5814: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a5818: cmp             SP, x16
    //     0x1a581c: b.ls            #0x1a58bc
    // 0x1a5820: LoadField: r2 = r0->field_7
    //     0x1a5820: ldur            x2, [x0, #7]
    // 0x1a5824: stur            x2, [fp, #-8]
    // 0x1a5828: r0 = toMidi()
    //     0x1a5828: bl              #0x1a5a1c  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::toMidi
    // 0x1a582c: stur            x0, [fp, #-0x28]
    // 0x1a5830: LoadField: r4 = r0->field_f
    //     0x1a5830: ldur            x4, [x0, #0xf]
    // 0x1a5834: stur            x4, [fp, #-0x20]
    // 0x1a5838: asr             x5, x4, #1
    // 0x1a583c: stur            x5, [fp, #-0x18]
    // 0x1a5840: tbz             x5, #0x3f, #0x1a5858
    // 0x1a5844: mov             x2, x4
    // 0x1a5848: mov             x3, x5
    // 0x1a584c: r1 = 0
    //     0x1a584c: mov             x1, #0
    // 0x1a5850: r4 = const [0, 0x3, 0, 0x3, null]
    //     0x1a5850: ldr             x4, [PP, #0x410]  ; [pp+0x410] List(5) [0, 0x3, 0, 0x3, Null]
    // 0x1a5854: r0 = checkValidRange()
    //     0x1a5854: bl              #0x16580  ; [dart:core] RangeError::checkValidRange
    // 0x1a5858: ldur            x0, [fp, #-0x10]
    // 0x1a585c: ldur            x4, [fp, #-0x20]
    // 0x1a5860: r0 = AllocateUint8Array()
    //     0x1a5860: bl              #0x42a408  ; AllocateUint8ArrayStub
    // 0x1a5864: mov             x1, x0
    // 0x1a5868: ldur            x3, [fp, #-0x18]
    // 0x1a586c: ldur            x5, [fp, #-0x28]
    // 0x1a5870: r2 = 0
    //     0x1a5870: mov             x2, #0
    // 0x1a5874: r6 = 0
    //     0x1a5874: mov             x6, #0
    // 0x1a5878: stur            x0, [fp, #-0x20]
    // 0x1a587c: r0 = _slowSetRange()
    //     0x1a587c: bl              #0x339534  ; [dart:typed_data] __Uint8List&_TypedList&_IntListMixin&_TypedIntListMixin::_slowSetRange
    // 0x1a5880: ldur            x0, [fp, #-0x10]
    // 0x1a5884: LoadField: r1 = r0->field_f
    //     0x1a5884: ldur            x1, [x0, #0xf]
    // 0x1a5888: cmp             x1, NULL
    // 0x1a588c: b.ne            #0x1a5898
    // 0x1a5890: r3 = Null
    //     0x1a5890: mov             x3, NULL
    // 0x1a5894: b               #0x1a58a0
    // 0x1a5898: LoadField: r0 = r1->field_f
    //     0x1a5898: ldur            x0, [x1, #0xf]
    // 0x1a589c: mov             x3, x0
    // 0x1a58a0: ldur            x1, [fp, #-8]
    // 0x1a58a4: ldur            x2, [fp, #-0x20]
    // 0x1a58a8: r0 = sendData()
    //     0x1a58a8: bl              #0x1a58c4  ; [package:flutter_midi_command/flutter_midi_command.dart] MidiCommand::sendData
    // 0x1a58ac: r0 = Null
    //     0x1a58ac: mov             x0, NULL
    // 0x1a58b0: LeaveFrame
    //     0x1a58b0: mov             SP, fp
    //     0x1a58b4: ldp             fp, lr, [SP], #0x10
    // 0x1a58b8: ret
    //     0x1a58b8: ret             
    // 0x1a58bc: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a58bc: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a58c0: b               #0x1a5820
  }
  get _ onPacket(/* No info */) {
    // ** addr: 0x1a5d3c, size: 0x34
    // 0x1a5d3c: EnterFrame
    //     0x1a5d3c: stp             fp, lr, [SP, #-0x10]!
    //     0x1a5d40: mov             fp, SP
    // 0x1a5d44: AllocStack(0x8)
    //     0x1a5d44: sub             SP, SP, #8
    // 0x1a5d48: LoadField: r0 = r1->field_2f
    //     0x1a5d48: ldur            x0, [x1, #0x2f]
    // 0x1a5d4c: stur            x0, [fp, #-8]
    // 0x1a5d50: r1 = <List<int>>
    //     0x1a5d50: add             x1, PP, #0xd, lsl #12  ; [pp+0xd168] TypeArguments: <List<int>>
    //     0x1a5d54: ldr             x1, [x1, #0x168]
    // 0x1a5d58: r0 = _BroadcastStream()
    //     0x1a5d58: bl              #0x1a5d70  ; Allocate_BroadcastStreamStub -> _BroadcastStream<X0> (size=0x18)
    // 0x1a5d5c: ldur            x1, [fp, #-8]
    // 0x1a5d60: StoreField: r0->field_f = r1
    //     0x1a5d60: stur            x1, [x0, #0xf]
    // 0x1a5d64: LeaveFrame
    //     0x1a5d64: mov             SP, fp
    //     0x1a5d68: ldp             fp, lr, [SP], #0x10
    // 0x1a5d6c: ret
    //     0x1a5d6c: ret             
  }
  [closure] void <anonymous closure>(dynamic, List<int>) {
    // ** addr: 0x1a5e54, size: 0x60
    // 0x1a5e54: EnterFrame
    //     0x1a5e54: stp             fp, lr, [SP, #-0x10]!
    //     0x1a5e58: mov             fp, SP
    // 0x1a5e5c: AllocStack(0x8)
    //     0x1a5e5c: sub             SP, SP, #8
    // 0x1a5e60: SetupParameters([dynamic _ /* r0 */])
    //     0x1a5e60: ldr             x0, [fp, #0x18]
    //     0x1a5e64: ldur            x1, [x0, #0x27]
    // 0x1a5e68: CheckStackOverflow
    //     0x1a5e68: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a5e6c: cmp             SP, x16
    //     0x1a5e70: b.ls            #0x1a5eac
    // 0x1a5e74: ArrayLoad: r0 = r1[0]  ; List_8
    //     0x1a5e74: ldur            x0, [x1, #0x17]
    // 0x1a5e78: LoadField: r1 = r0->field_f
    //     0x1a5e78: ldur            x1, [x0, #0xf]
    // 0x1a5e7c: LoadField: r2 = r1->field_f
    //     0x1a5e7c: ldur            x2, [x1, #0xf]
    // 0x1a5e80: tst             x2, #0x1e
    // 0x1a5e84: b.ne            #0x1a5e9c
    // 0x1a5e88: ldr             x16, [fp, #0x10]
    // 0x1a5e8c: str             x16, [SP]
    // 0x1a5e90: mov             x1, x0
    // 0x1a5e94: r4 = const [0, 0x2, 0x1, 0x2, null]
    //     0x1a5e94: ldr             x4, [PP, #0x668]  ; [pp+0x668] List(5) [0, 0x2, 0x1, 0x2, Null]
    // 0x1a5e98: r0 = complete()
    //     0x1a5e98: bl              #0x3eab3c  ; [dart:async] _AsyncCompleter::complete
    // 0x1a5e9c: r0 = Null
    //     0x1a5e9c: mov             x0, NULL
    // 0x1a5ea0: LeaveFrame
    //     0x1a5ea0: mov             SP, fp
    //     0x1a5ea4: ldp             fp, lr, [SP], #0x10
    // 0x1a5ea8: ret
    //     0x1a5ea8: ret             
    // 0x1a5eac: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a5eac: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a5eb0: b               #0x1a5e74
  }
  _ connect(/* No info */) async {
    // ** addr: 0x1a6194, size: 0xf0
    // 0x1a6194: EnterFrame
    //     0x1a6194: stp             fp, lr, [SP, #-0x10]!
    //     0x1a6198: mov             fp, SP
    // 0x1a619c: AllocStack(0x28)
    //     0x1a619c: sub             SP, SP, #0x28
    // 0x1a61a0: SetupParameters(MidiTransport this /* r1 => r1, fp-0x10 */, dynamic _ /* r2 => r2, fp-0x18 */)
    //     0x1a61a0: stur            NULL, [fp, #-8]
    //     0x1a61a4: stur            x1, [fp, #-0x10]
    //     0x1a61a8: stur            x2, [fp, #-0x18]
    // 0x1a61ac: CheckStackOverflow
    //     0x1a61ac: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a61b0: cmp             SP, x16
    //     0x1a61b4: b.ls            #0x1a627c
    // 0x1a61b8: InitAsync() -> Future<void?>
    //     0x1a61b8: ldr             x0, [PP, #0x528]  ; [pp+0x528] TypeArguments: <void?>
    //     0x1a61bc: bl              #0x473b4  ; InitAsyncStub
    // 0x1a61c0: ldur            x0, [fp, #-0x10]
    // 0x1a61c4: LoadField: r3 = r0->field_7
    //     0x1a61c4: ldur            x3, [x0, #7]
    // 0x1a61c8: mov             x1, x3
    // 0x1a61cc: ldur            x2, [fp, #-0x18]
    // 0x1a61d0: stur            x3, [fp, #-0x20]
    // 0x1a61d4: r0 = connectToDevice()
    //     0x1a61d4: bl              #0x1a6dc0  ; [package:flutter_midi_command/flutter_midi_command.dart] MidiCommand::connectToDevice
    // 0x1a61d8: mov             x1, x0
    // 0x1a61dc: stur            x1, [fp, #-0x28]
    // 0x1a61e0: r0 = Await()
    //     0x1a61e0: bl              #0x14028  ; AwaitStub
    // 0x1a61e4: ldur            x0, [fp, #-0x18]
    // 0x1a61e8: ldur            x2, [fp, #-0x10]
    // 0x1a61ec: StoreField: r2->field_f = r0
    //     0x1a61ec: stur            x0, [x2, #0xf]
    //     0x1a61f0: ldurb           w16, [x2, #-1]
    //     0x1a61f4: ldurb           w17, [x0, #-1]
    //     0x1a61f8: and             x16, x17, x16, lsr #2
    //     0x1a61fc: tst             x16, HEAP, lsr #32
    //     0x1a6200: b.eq            #0x1a6208
    //     0x1a6204: bl              #0x428df0  ; WriteBarrierWrappersStub
    // 0x1a6208: ArrayLoad: r1 = r2[0]  ; List_8
    //     0x1a6208: ldur            x1, [x2, #0x17]
    // 0x1a620c: cmp             x1, NULL
    // 0x1a6210: b.eq            #0x1a6218
    // 0x1a6214: r0 = cancel()
    //     0x1a6214: bl              #0x3d80b8  ; [dart:async] _BufferingStreamSubscription::cancel
    // 0x1a6218: ldur            x1, [fp, #-0x20]
    // 0x1a621c: r0 = onMidiDataReceived()
    //     0x1a621c: bl              #0x1a6284  ; [package:flutter_midi_command/flutter_midi_command.dart] MidiCommand::onMidiDataReceived
    // 0x1a6220: stur            x0, [fp, #-0x18]
    // 0x1a6224: cmp             x0, NULL
    // 0x1a6228: b.ne            #0x1a6234
    // 0x1a622c: r0 = Null
    //     0x1a622c: mov             x0, NULL
    // 0x1a6230: b               #0x1a6254
    // 0x1a6234: ldur            x2, [fp, #-0x10]
    // 0x1a6238: r1 = Function '_onData@647507030':.
    //     0x1a6238: add             x1, PP, #0xd, lsl #12  ; [pp+0xd878] AnonymousClosure: (0x1a6f0c), in [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::_onData (0x1a6f44)
    //     0x1a623c: ldr             x1, [x1, #0x878]
    // 0x1a6240: r0 = AllocateClosure()
    //     0x1a6240: bl              #0x429a24  ; AllocateClosureStub
    // 0x1a6244: ldur            x1, [fp, #-0x18]
    // 0x1a6248: mov             x2, x0
    // 0x1a624c: r4 = const [0, 0x2, 0, 0x2, null]
    //     0x1a624c: ldr             x4, [PP, #0x3a8]  ; [pp+0x3a8] List(5) [0, 0x2, 0, 0x2, Null]
    // 0x1a6250: r0 = listen()
    //     0x1a6250: bl              #0x3beed8  ; [dart:async] _ForwardingStream::listen
    // 0x1a6254: ldur            x1, [fp, #-0x10]
    // 0x1a6258: ArrayStore: r1[0] = r0  ; List_8
    //     0x1a6258: stur            x0, [x1, #0x17]
    //     0x1a625c: ldurb           w16, [x1, #-1]
    //     0x1a6260: ldurb           w17, [x0, #-1]
    //     0x1a6264: and             x16, x17, x16, lsr #2
    //     0x1a6268: tst             x16, HEAP, lsr #32
    //     0x1a626c: b.eq            #0x1a6274
    //     0x1a6270: bl              #0x428dd0  ; WriteBarrierWrappersStub
    // 0x1a6274: r0 = Null
    //     0x1a6274: mov             x0, NULL
    // 0x1a6278: r0 = ReturnAsyncNotFuture()
    //     0x1a6278: b               #0x13ffc  ; ReturnAsyncNotFutureStub
    // 0x1a627c: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a627c: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a6280: b               #0x1a61b8
  }
  [closure] void _onData(dynamic, MidiPacket) {
    // ** addr: 0x1a6f0c, size: 0x38
    // 0x1a6f0c: EnterFrame
    //     0x1a6f0c: stp             fp, lr, [SP, #-0x10]!
    //     0x1a6f10: mov             fp, SP
    // 0x1a6f14: ldr             x0, [fp, #0x18]
    // 0x1a6f18: LoadField: r1 = r0->field_27
    //     0x1a6f18: ldur            x1, [x0, #0x27]
    // 0x1a6f1c: CheckStackOverflow
    //     0x1a6f1c: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a6f20: cmp             SP, x16
    //     0x1a6f24: b.ls            #0x1a6f3c
    // 0x1a6f28: ldr             x2, [fp, #0x10]
    // 0x1a6f2c: r0 = _onData()
    //     0x1a6f2c: bl              #0x1a6f44  ; [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::_onData
    // 0x1a6f30: LeaveFrame
    //     0x1a6f30: mov             SP, fp
    //     0x1a6f34: ldp             fp, lr, [SP], #0x10
    // 0x1a6f38: ret
    //     0x1a6f38: ret             
    // 0x1a6f3c: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a6f3c: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a6f40: b               #0x1a6f28
  }
  _ _onData(/* No info */) {
    // ** addr: 0x1a6f44, size: 0x258
    // 0x1a6f44: EnterFrame
    //     0x1a6f44: stp             fp, lr, [SP, #-0x10]!
    //     0x1a6f48: mov             fp, SP
    // 0x1a6f4c: AllocStack(0x40)
    //     0x1a6f4c: sub             SP, SP, #0x40
    // 0x1a6f50: SetupParameters(MidiTransport this /* r1 => r3, fp-0x10 */, dynamic _ /* r2 => r0, fp-0x18 */)
    //     0x1a6f50: mov             x3, x1
    //     0x1a6f54: mov             x0, x2
    //     0x1a6f58: stur            x1, [fp, #-0x10]
    //     0x1a6f5c: stur            x2, [fp, #-0x18]
    // 0x1a6f60: CheckStackOverflow
    //     0x1a6f60: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a6f64: cmp             SP, x16
    //     0x1a6f68: b.ls            #0x1a718c
    // 0x1a6f6c: LoadField: r4 = r3->field_37
    //     0x1a6f6c: ldur            x4, [x3, #0x37]
    // 0x1a6f70: stur            x4, [fp, #-8]
    // 0x1a6f74: LoadField: r2 = r0->field_7
    //     0x1a6f74: ldur            x2, [x0, #7]
    // 0x1a6f78: r1 = <int>
    //     0x1a6f78: ldr             x1, [PP, #0xa70]  ; [pp+0xa70] TypeArguments: <int>
    // 0x1a6f7c: r4 = const [0, 0x2, 0, 0x2, null]
    //     0x1a6f7c: ldr             x4, [PP, #0x3a8]  ; [pp+0x3a8] List(5) [0, 0x2, 0, 0x2, Null]
    // 0x1a6f80: r0 = List.from()
    //     0x1a6f80: bl              #0xbc168  ; [dart:core] List::List.from
    // 0x1a6f84: ldur            x1, [fp, #-8]
    // 0x1a6f88: mov             x2, x0
    // 0x1a6f8c: r0 = add()
    //     0x1a6f8c: bl              #0x3941d4  ; [dart:async] _BroadcastStreamController::add
    // 0x1a6f90: ldur            x0, [fp, #-0x18]
    // 0x1a6f94: LoadField: r3 = r0->field_7
    //     0x1a6f94: ldur            x3, [x0, #7]
    // 0x1a6f98: stur            x3, [fp, #-0x38]
    // 0x1a6f9c: LoadField: r0 = r3->field_f
    //     0x1a6f9c: ldur            x0, [x3, #0xf]
    // 0x1a6fa0: asr             x4, x0, #1
    // 0x1a6fa4: ldur            x0, [fp, #-0x10]
    // 0x1a6fa8: stur            x4, [fp, #-0x30]
    // 0x1a6fac: LoadField: r5 = r0->field_1f
    //     0x1a6fac: ldur            x5, [x0, #0x1f]
    // 0x1a6fb0: stur            x5, [fp, #-0x28]
    // 0x1a6fb4: LoadField: r6 = r0->field_2f
    //     0x1a6fb4: ldur            x6, [x0, #0x2f]
    // 0x1a6fb8: stur            x6, [fp, #-0x18]
    // 0x1a6fbc: r1 = -1
    //     0x1a6fbc: mov             x1, #-1
    // 0x1a6fc0: r7 = true
    //     0x1a6fc0: add             x7, NULL, #0x20  ; true
    // 0x1a6fc4: CheckStackOverflow
    //     0x1a6fc4: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a6fc8: cmp             SP, x16
    //     0x1a6fcc: b.ls            #0x1a7194
    // 0x1a6fd0: add             x8, x1, #1
    // 0x1a6fd4: stur            x8, [fp, #-0x20]
    // 0x1a6fd8: cmp             x8, x4
    // 0x1a6fdc: b.ge            #0x1a717c
    // 0x1a6fe0: ArrayLoad: r1 = r3[r8]  ; List_1
    //     0x1a6fe0: add             x16, x3, x8
    //     0x1a6fe4: ldrb            w1, [x16, #0x17]
    // 0x1a6fe8: lsl             x9, x1, #1
    // 0x1a6fec: stur            x9, [fp, #-8]
    // 0x1a6ff0: cmp             x1, #0xf0
    // 0x1a6ff4: b.ne            #0x1a7060
    // 0x1a6ff8: StoreField: r0->field_27 = r7
    //     0x1a6ff8: stur            x7, [x0, #0x27]
    // 0x1a6ffc: mov             x1, x5
    // 0x1a7000: r2 = 0
    //     0x1a7000: mov             x2, #0
    // 0x1a7004: r0 = length=()
    //     0x1a7004: bl              #0x12164  ; [dart:core] _GrowableList::length=
    // 0x1a7008: ldur            x0, [fp, #-0x28]
    // 0x1a700c: LoadField: r1 = r0->field_f
    //     0x1a700c: ldur            x1, [x0, #0xf]
    // 0x1a7010: ArrayLoad: r2 = r0[0]  ; List_8
    //     0x1a7010: ldur            x2, [x0, #0x17]
    // 0x1a7014: LoadField: r3 = r2->field_f
    //     0x1a7014: ldur            x3, [x2, #0xf]
    // 0x1a7018: asr             x2, x1, #1
    // 0x1a701c: stur            x2, [fp, #-0x40]
    // 0x1a7020: asr             x1, x3, #1
    // 0x1a7024: cmp             x2, x1
    // 0x1a7028: b.ne            #0x1a7034
    // 0x1a702c: mov             x1, x0
    // 0x1a7030: r0 = _growToNextCapacity()
    //     0x1a7030: bl              #0x106e8  ; [dart:core] _GrowableList::_growToNextCapacity
    // 0x1a7034: ldur            x0, [fp, #-0x28]
    // 0x1a7038: ldur            x2, [fp, #-8]
    // 0x1a703c: ldur            x1, [fp, #-0x40]
    // 0x1a7040: add             x3, x1, #1
    // 0x1a7044: lsl             x4, x3, #1
    // 0x1a7048: StoreField: r0->field_f = r4
    //     0x1a7048: stur            x4, [x0, #0xf]
    // 0x1a704c: ArrayLoad: r3 = r0[0]  ; List_8
    //     0x1a704c: ldur            x3, [x0, #0x17]
    // 0x1a7050: ArrayStore: r3[r1] = r2  ; List_8
    //     0x1a7050: add             x4, x3, x1, lsl #3
    //     0x1a7054: stur            x2, [x4, #0x17]
    // 0x1a7058: mov             x2, x0
    // 0x1a705c: b               #0x1a7160
    // 0x1a7060: mov             x0, x5
    // 0x1a7064: mov             x2, x9
    // 0x1a7068: cmp             x1, #0xf7
    // 0x1a706c: b.ne            #0x1a70fc
    // 0x1a7070: ldur            x3, [fp, #-0x10]
    // 0x1a7074: LoadField: r1 = r3->field_27
    //     0x1a7074: ldur            x1, [x3, #0x27]
    // 0x1a7078: tbnz            w1, #4, #0x1a70fc
    // 0x1a707c: LoadField: r1 = r0->field_f
    //     0x1a707c: ldur            x1, [x0, #0xf]
    // 0x1a7080: ArrayLoad: r4 = r0[0]  ; List_8
    //     0x1a7080: ldur            x4, [x0, #0x17]
    // 0x1a7084: LoadField: r5 = r4->field_f
    //     0x1a7084: ldur            x5, [x4, #0xf]
    // 0x1a7088: asr             x4, x1, #1
    // 0x1a708c: stur            x4, [fp, #-0x40]
    // 0x1a7090: asr             x1, x5, #1
    // 0x1a7094: cmp             x4, x1
    // 0x1a7098: b.ne            #0x1a70a4
    // 0x1a709c: mov             x1, x0
    // 0x1a70a0: r0 = _growToNextCapacity()
    //     0x1a70a0: bl              #0x106e8  ; [dart:core] _GrowableList::_growToNextCapacity
    // 0x1a70a4: ldur            x3, [fp, #-0x10]
    // 0x1a70a8: ldur            x0, [fp, #-0x28]
    // 0x1a70ac: ldur            x2, [fp, #-8]
    // 0x1a70b0: ldur            x1, [fp, #-0x40]
    // 0x1a70b4: r4 = false
    //     0x1a70b4: add             x4, NULL, #0x30  ; false
    // 0x1a70b8: add             x5, x1, #1
    // 0x1a70bc: lsl             x6, x5, #1
    // 0x1a70c0: StoreField: r0->field_f = r6
    //     0x1a70c0: stur            x6, [x0, #0xf]
    // 0x1a70c4: ArrayLoad: r5 = r0[0]  ; List_8
    //     0x1a70c4: ldur            x5, [x0, #0x17]
    // 0x1a70c8: ArrayStore: r5[r1] = r2  ; List_8
    //     0x1a70c8: add             x6, x5, x1, lsl #3
    //     0x1a70cc: stur            x2, [x6, #0x17]
    // 0x1a70d0: StoreField: r3->field_27 = r4
    //     0x1a70d0: stur            x4, [x3, #0x27]
    // 0x1a70d4: mov             x1, x0
    // 0x1a70d8: r0 = fromMidi()
    //     0x1a70d8: bl              #0x1a719c  ; [package:musical_instruments/core/usb/sysex_codec.dart] SysexCodec::fromMidi
    // 0x1a70dc: ldur            x1, [fp, #-0x18]
    // 0x1a70e0: mov             x2, x0
    // 0x1a70e4: r0 = add()
    //     0x1a70e4: bl              #0x3941d4  ; [dart:async] _BroadcastStreamController::add
    // 0x1a70e8: ldur            x1, [fp, #-0x28]
    // 0x1a70ec: r2 = 0
    //     0x1a70ec: mov             x2, #0
    // 0x1a70f0: r0 = length=()
    //     0x1a70f0: bl              #0x12164  ; [dart:core] _GrowableList::length=
    // 0x1a70f4: ldur            x2, [fp, #-0x28]
    // 0x1a70f8: b               #0x1a7160
    // 0x1a70fc: ldur            x0, [fp, #-0x10]
    // 0x1a7100: LoadField: r1 = r0->field_27
    //     0x1a7100: ldur            x1, [x0, #0x27]
    // 0x1a7104: tbnz            w1, #4, #0x1a715c
    // 0x1a7108: ldur            x3, [fp, #-0x28]
    // 0x1a710c: LoadField: r1 = r3->field_f
    //     0x1a710c: ldur            x1, [x3, #0xf]
    // 0x1a7110: ArrayLoad: r4 = r3[0]  ; List_8
    //     0x1a7110: ldur            x4, [x3, #0x17]
    // 0x1a7114: LoadField: r5 = r4->field_f
    //     0x1a7114: ldur            x5, [x4, #0xf]
    // 0x1a7118: asr             x4, x1, #1
    // 0x1a711c: stur            x4, [fp, #-0x40]
    // 0x1a7120: asr             x1, x5, #1
    // 0x1a7124: cmp             x4, x1
    // 0x1a7128: b.ne            #0x1a7134
    // 0x1a712c: mov             x1, x3
    // 0x1a7130: r0 = _growToNextCapacity()
    //     0x1a7130: bl              #0x106e8  ; [dart:core] _GrowableList::_growToNextCapacity
    // 0x1a7134: ldur            x2, [fp, #-0x28]
    // 0x1a7138: ldur            x1, [fp, #-8]
    // 0x1a713c: ldur            x3, [fp, #-0x40]
    // 0x1a7140: add             x4, x3, #1
    // 0x1a7144: lsl             x5, x4, #1
    // 0x1a7148: StoreField: r2->field_f = r5
    //     0x1a7148: stur            x5, [x2, #0xf]
    // 0x1a714c: ArrayLoad: r4 = r2[0]  ; List_8
    //     0x1a714c: ldur            x4, [x2, #0x17]
    // 0x1a7150: ArrayStore: r4[r3] = r1  ; List_8
    //     0x1a7150: add             x5, x4, x3, lsl #3
    //     0x1a7154: stur            x1, [x5, #0x17]
    // 0x1a7158: b               #0x1a7160
    // 0x1a715c: ldur            x2, [fp, #-0x28]
    // 0x1a7160: ldur            x1, [fp, #-0x20]
    // 0x1a7164: ldur            x0, [fp, #-0x10]
    // 0x1a7168: ldur            x3, [fp, #-0x38]
    // 0x1a716c: mov             x5, x2
    // 0x1a7170: ldur            x6, [fp, #-0x18]
    // 0x1a7174: ldur            x4, [fp, #-0x30]
    // 0x1a7178: b               #0x1a6fc0
    // 0x1a717c: r0 = Null
    //     0x1a717c: mov             x0, NULL
    // 0x1a7180: LeaveFrame
    //     0x1a7180: mov             SP, fp
    //     0x1a7184: ldp             fp, lr, [SP], #0x10
    // 0x1a7188: ret
    //     0x1a7188: ret             
    // 0x1a718c: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a718c: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a7190: b               #0x1a6f6c
    // 0x1a7194: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a7194: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a7198: b               #0x1a6fd0
  }
  _ listDevices(/* No info */) async {
    // ** addr: 0x1a75f8, size: 0x68
    // 0x1a75f8: EnterFrame
    //     0x1a75f8: stp             fp, lr, [SP, #-0x10]!
    //     0x1a75fc: mov             fp, SP
    // 0x1a7600: AllocStack(0x10)
    //     0x1a7600: sub             SP, SP, #0x10
    // 0x1a7604: SetupParameters(MidiTransport this /* r1 => r1, fp-0x10 */)
    //     0x1a7604: stur            NULL, [fp, #-8]
    //     0x1a7608: stur            x1, [fp, #-0x10]
    // 0x1a760c: CheckStackOverflow
    //     0x1a760c: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a7610: cmp             SP, x16
    //     0x1a7614: b.ls            #0x1a7658
    // 0x1a7618: InitAsync() -> Future<List<MidiDevice>>
    //     0x1a7618: add             x0, PP, #0xd, lsl #12  ; [pp+0xdb00] TypeArguments: <List<MidiDevice>>
    //     0x1a761c: ldr             x0, [x0, #0xb00]
    //     0x1a7620: bl              #0x473b4  ; InitAsyncStub
    // 0x1a7624: ldur            x0, [fp, #-0x10]
    // 0x1a7628: LoadField: r1 = r0->field_7
    //     0x1a7628: ldur            x1, [x0, #7]
    // 0x1a762c: r0 = devices()
    //     0x1a762c: bl              #0x1a7660  ; [package:flutter_midi_command/flutter_midi_command.dart] MidiCommand::devices
    // 0x1a7630: mov             x1, x0
    // 0x1a7634: stur            x1, [fp, #-0x10]
    // 0x1a7638: r0 = Await()
    //     0x1a7638: bl              #0x14028  ; AwaitStub
    // 0x1a763c: cmp             x0, NULL
    // 0x1a7640: b.ne            #0x1a7654
    // 0x1a7644: r1 = <MidiDevice>
    //     0x1a7644: add             x1, PP, #0xd, lsl #12  ; [pp+0xd798] TypeArguments: <MidiDevice>
    //     0x1a7648: ldr             x1, [x1, #0x798]
    // 0x1a764c: r2 = 0
    //     0x1a764c: mov             x2, #0
    // 0x1a7650: r0 = _GrowableList()
    //     0x1a7650: bl              #0x108d8  ; [dart:core] _GrowableList::_GrowableList
    // 0x1a7654: r0 = ReturnAsync()
    //     0x1a7654: b               #0x60c2c  ; ReturnAsyncStub
    // 0x1a7658: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a7658: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a765c: b               #0x1a7618
  }
  get _ onSetupChanged(/* No info */) {
    // ** addr: 0x1a7da8, size: 0x34
    // 0x1a7da8: EnterFrame
    //     0x1a7da8: stp             fp, lr, [SP, #-0x10]!
    //     0x1a7dac: mov             fp, SP
    // 0x1a7db0: CheckStackOverflow
    //     0x1a7db0: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x1a7db4: cmp             SP, x16
    //     0x1a7db8: b.ls            #0x1a7dd4
    // 0x1a7dbc: LoadField: r0 = r1->field_7
    //     0x1a7dbc: ldur            x0, [x1, #7]
    // 0x1a7dc0: mov             x1, x0
    // 0x1a7dc4: r0 = onMidiSetupChanged()
    //     0x1a7dc4: bl              #0x1a7ddc  ; [package:flutter_midi_command/flutter_midi_command.dart] MidiCommand::onMidiSetupChanged
    // 0x1a7dc8: LeaveFrame
    //     0x1a7dc8: mov             SP, fp
    //     0x1a7dcc: ldp             fp, lr, [SP], #0x10
    // 0x1a7dd0: ret
    //     0x1a7dd0: ret             
    // 0x1a7dd4: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x1a7dd4: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x1a7dd8: b               #0x1a7dbc
  }
  get _ onRawMidi(/* No info */) {
    // ** addr: 0x2062cc, size: 0x34
    // 0x2062cc: EnterFrame
    //     0x2062cc: stp             fp, lr, [SP, #-0x10]!
    //     0x2062d0: mov             fp, SP
    // 0x2062d4: AllocStack(0x8)
    //     0x2062d4: sub             SP, SP, #8
    // 0x2062d8: LoadField: r0 = r1->field_37
    //     0x2062d8: ldur            x0, [x1, #0x37]
    // 0x2062dc: stur            x0, [fp, #-8]
    // 0x2062e0: r1 = <List<int>>
    //     0x2062e0: add             x1, PP, #0xd, lsl #12  ; [pp+0xd168] TypeArguments: <List<int>>
    //     0x2062e4: ldr             x1, [x1, #0x168]
    // 0x2062e8: r0 = _BroadcastStream()
    //     0x2062e8: bl              #0x1a5d70  ; Allocate_BroadcastStreamStub -> _BroadcastStream<X0> (size=0x18)
    // 0x2062ec: ldur            x1, [fp, #-8]
    // 0x2062f0: StoreField: r0->field_f = r1
    //     0x2062f0: stur            x1, [x0, #0xf]
    // 0x2062f4: LeaveFrame
    //     0x2062f4: mov             SP, fp
    //     0x2062f8: ldp             fp, lr, [SP], #0x10
    // 0x2062fc: ret
    //     0x2062fc: ret             
  }
  _ sendRaw(/* No info */) {
    // ** addr: 0x2bb678, size: 0x78
    // 0x2bb678: EnterFrame
    //     0x2bb678: stp             fp, lr, [SP, #-0x10]!
    //     0x2bb67c: mov             fp, SP
    // 0x2bb680: AllocStack(0x10)
    //     0x2bb680: sub             SP, SP, #0x10
    // 0x2bb684: SetupParameters(MidiTransport this /* r1 => r0, fp-0x10 */)
    //     0x2bb684: mov             x0, x1
    //     0x2bb688: stur            x1, [fp, #-0x10]
    // 0x2bb68c: CheckStackOverflow
    //     0x2bb68c: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x2bb690: cmp             SP, x16
    //     0x2bb694: b.ls            #0x2bb6e8
    // 0x2bb698: LoadField: r3 = r0->field_7
    //     0x2bb698: ldur            x3, [x0, #7]
    // 0x2bb69c: stur            x3, [fp, #-8]
    // 0x2bb6a0: r1 = Null
    //     0x2bb6a0: mov             x1, NULL
    // 0x2bb6a4: r0 = Uint8List.fromList()
    //     0x2bb6a4: bl              #0xbbeec  ; [dart:typed_data] Uint8List::Uint8List.fromList
    // 0x2bb6a8: mov             x1, x0
    // 0x2bb6ac: ldur            x0, [fp, #-0x10]
    // 0x2bb6b0: LoadField: r2 = r0->field_f
    //     0x2bb6b0: ldur            x2, [x0, #0xf]
    // 0x2bb6b4: cmp             x2, NULL
    // 0x2bb6b8: b.ne            #0x2bb6c4
    // 0x2bb6bc: r3 = Null
    //     0x2bb6bc: mov             x3, NULL
    // 0x2bb6c0: b               #0x2bb6cc
    // 0x2bb6c4: LoadField: r0 = r2->field_f
    //     0x2bb6c4: ldur            x0, [x2, #0xf]
    // 0x2bb6c8: mov             x3, x0
    // 0x2bb6cc: mov             x2, x1
    // 0x2bb6d0: ldur            x1, [fp, #-8]
    // 0x2bb6d4: r0 = sendData()
    //     0x2bb6d4: bl              #0x1a58c4  ; [package:flutter_midi_command/flutter_midi_command.dart] MidiCommand::sendData
    // 0x2bb6d8: r0 = Null
    //     0x2bb6d8: mov             x0, NULL
    // 0x2bb6dc: LeaveFrame
    //     0x2bb6dc: mov             SP, fp
    //     0x2bb6e0: ldp             fp, lr, [SP], #0x10
    // 0x2bb6e4: ret
    //     0x2bb6e4: ret             
    // 0x2bb6e8: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x2bb6e8: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x2bb6ec: b               #0x2bb698
  }
  _ dispose(/* No info */) {
    // ** addr: 0x2d42ac, size: 0x58
    // 0x2d42ac: EnterFrame
    //     0x2d42ac: stp             fp, lr, [SP, #-0x10]!
    //     0x2d42b0: mov             fp, SP
    // 0x2d42b4: AllocStack(0x8)
    //     0x2d42b4: sub             SP, SP, #8
    // 0x2d42b8: SetupParameters(MidiTransport this /* r1 => r0, fp-0x8 */)
    //     0x2d42b8: mov             x0, x1
    //     0x2d42bc: stur            x1, [fp, #-8]
    // 0x2d42c0: CheckStackOverflow
    //     0x2d42c0: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x2d42c4: cmp             SP, x16
    //     0x2d42c8: b.ls            #0x2d42fc
    // 0x2d42cc: mov             x1, x0
    // 0x2d42d0: r0 = disconnect()
    //     0x2d42d0: bl              #0x1a49c8  ; [package:musical_instruments/core/usb/midi_transport.dart] MidiTransport::disconnect
    // 0x2d42d4: ldur            x0, [fp, #-8]
    // 0x2d42d8: LoadField: r1 = r0->field_2f
    //     0x2d42d8: ldur            x1, [x0, #0x2f]
    // 0x2d42dc: r0 = close()
    //     0x2d42dc: bl              #0x37ee10  ; [dart:async] _BroadcastStreamController::close
    // 0x2d42e0: ldur            x0, [fp, #-8]
    // 0x2d42e4: LoadField: r1 = r0->field_37
    //     0x2d42e4: ldur            x1, [x0, #0x37]
    // 0x2d42e8: r0 = close()
    //     0x2d42e8: bl              #0x37ee10  ; [dart:async] _BroadcastStreamController::close
    // 0x2d42ec: r0 = Null
    //     0x2d42ec: mov             x0, NULL
    // 0x2d42f0: LeaveFrame
    //     0x2d42f0: mov             SP, fp
    //     0x2d42f4: ldp             fp, lr, [SP], #0x10
    // 0x2d42f8: ret
    //     0x2d42f8: ret             
    // 0x2d42fc: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x2d42fc: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x2d4300: b               #0x2d42cc
  }
  _ MidiTransport(/* No info */) {
    // ** addr: 0x2e3090, size: 0x15c
    // 0x2e3090: EnterFrame
    //     0x2e3090: stp             fp, lr, [SP, #-0x10]!
    //     0x2e3094: mov             fp, SP
    // 0x2e3098: AllocStack(0x10)
    //     0x2e3098: sub             SP, SP, #0x10
    // 0x2e309c: r0 = false
    //     0x2e309c: add             x0, NULL, #0x30  ; false
    // 0x2e30a0: mov             x2, x1
    // 0x2e30a4: stur            x1, [fp, #-8]
    // 0x2e30a8: CheckStackOverflow
    //     0x2e30a8: ldr             x16, [THR, #0x48]  ; THR::stack_limit
    //     0x2e30ac: cmp             SP, x16
    //     0x2e30b0: b.ls            #0x2e31e4
    // 0x2e30b4: StoreField: r2->field_27 = r0
    //     0x2e30b4: stur            x0, [x2, #0x27]
    // 0x2e30b8: r1 = Null
    //     0x2e30b8: mov             x1, NULL
    // 0x2e30bc: r0 = MidiCommand()
    //     0x2e30bc: bl              #0x2e31ec  ; [package:flutter_midi_command/flutter_midi_command.dart] MidiCommand::MidiCommand
    // 0x2e30c0: ldur            x3, [fp, #-8]
    // 0x2e30c4: StoreField: r3->field_7 = r0
    //     0x2e30c4: stur            x0, [x3, #7]
    //     0x2e30c8: ldurb           w16, [x3, #-1]
    //     0x2e30cc: ldurb           w17, [x0, #-1]
    //     0x2e30d0: and             x16, x17, x16, lsr #2
    //     0x2e30d4: tst             x16, HEAP, lsr #32
    //     0x2e30d8: b.eq            #0x2e30e0
    //     0x2e30dc: bl              #0x428e10  ; WriteBarrierWrappersStub
    // 0x2e30e0: r1 = <int>
    //     0x2e30e0: ldr             x1, [PP, #0xa70]  ; [pp+0xa70] TypeArguments: <int>
    // 0x2e30e4: r2 = 0
    //     0x2e30e4: mov             x2, #0
    // 0x2e30e8: r0 = _GrowableList()
    //     0x2e30e8: bl              #0x108d8  ; [dart:core] _GrowableList::_GrowableList
    // 0x2e30ec: ldur            x2, [fp, #-8]
    // 0x2e30f0: StoreField: r2->field_1f = r0
    //     0x2e30f0: stur            x0, [x2, #0x1f]
    //     0x2e30f4: ldurb           w16, [x2, #-1]
    //     0x2e30f8: ldurb           w17, [x0, #-1]
    //     0x2e30fc: and             x16, x17, x16, lsr #2
    //     0x2e3100: tst             x16, HEAP, lsr #32
    //     0x2e3104: b.eq            #0x2e310c
    //     0x2e3108: bl              #0x428df0  ; WriteBarrierWrappersStub
    // 0x2e310c: r1 = <List<int>>
    //     0x2e310c: add             x1, PP, #0xd, lsl #12  ; [pp+0xd168] TypeArguments: <List<int>>
    //     0x2e3110: ldr             x1, [x1, #0x168]
    // 0x2e3114: r0 = _AsyncBroadcastStreamController()
    //     0x2e3114: bl              #0x1a65a0  ; Allocate_AsyncBroadcastStreamControllerStub -> _AsyncBroadcastStreamController<X0> (size=0x48)
    // 0x2e3118: StoreField: r0->field_1f = rZR
    //     0x2e3118: stur            xzr, [x0, #0x1f]
    // 0x2e311c: ldur            x2, [fp, #-8]
    // 0x2e3120: StoreField: r2->field_2f = r0
    //     0x2e3120: stur            x0, [x2, #0x2f]
    //     0x2e3124: ldurb           w16, [x2, #-1]
    //     0x2e3128: ldurb           w17, [x0, #-1]
    //     0x2e312c: and             x16, x17, x16, lsr #2
    //     0x2e3130: tst             x16, HEAP, lsr #32
    //     0x2e3134: b.eq            #0x2e313c
    //     0x2e3138: bl              #0x428df0  ; WriteBarrierWrappersStub
    // 0x2e313c: r1 = <List<int>>
    //     0x2e313c: add             x1, PP, #0xd, lsl #12  ; [pp+0xd168] TypeArguments: <List<int>>
    //     0x2e3140: ldr             x1, [x1, #0x168]
    // 0x2e3144: r0 = _AsyncBroadcastStreamController()
    //     0x2e3144: bl              #0x1a65a0  ; Allocate_AsyncBroadcastStreamControllerStub -> _AsyncBroadcastStreamController<X0> (size=0x48)
    // 0x2e3148: StoreField: r0->field_1f = rZR
    //     0x2e3148: stur            xzr, [x0, #0x1f]
    // 0x2e314c: ldur            x2, [fp, #-8]
    // 0x2e3150: StoreField: r2->field_37 = r0
    //     0x2e3150: stur            x0, [x2, #0x37]
    //     0x2e3154: ldurb           w16, [x2, #-1]
    //     0x2e3158: ldurb           w17, [x0, #-1]
    //     0x2e315c: and             x16, x17, x16, lsr #2
    //     0x2e3160: tst             x16, HEAP, lsr #32
    //     0x2e3164: b.eq            #0x2e316c
    //     0x2e3168: bl              #0x428df0  ; WriteBarrierWrappersStub
    // 0x2e316c: r1 = <void?>
    //     0x2e316c: ldr             x1, [PP, #0x528]  ; [pp+0x528] TypeArguments: <void?>
    // 0x2e3170: r0 = _Future()
    //     0x2e3170: bl              #0x2d2f0  ; Allocate_FutureStub -> _Future<X0> (size=0x28)
    // 0x2e3174: stur            x0, [fp, #-0x10]
    // 0x2e3178: StoreField: r0->field_f = rZR
    //     0x2e3178: stur            xzr, [x0, #0xf]
    // 0x2e317c: r0 = LoadStaticField(0x6b0)
    //     0x2e317c: ldr             x0, [THR, #0x70]  ; THR::field_table_values
    //     0x2e3180: ldr             x0, [x0, #0x6b0]
    // 0x2e3184: ldr             x16, [THR, #0x88]  ; THR::object_sentinel
    // 0x2e3188: cmp             x0, x16
    // 0x2e318c: b.ne            #0x2e3198
    // 0x2e3190: r2 = _current
    //     0x2e3190: ldr             x2, [PP, #0x358]  ; [pp+0x358] Field <Zone._current@5048458>: static late (offset: 0x6b0)
    // 0x2e3194: r0 = InitLateStaticField()
    //     0x2e3194: bl              #0x4288b8  ; InitLateStaticFieldStub
    // 0x2e3198: mov             x1, x0
    // 0x2e319c: ldur            x0, [fp, #-0x10]
    // 0x2e31a0: ArrayStore: r0[0] = r1  ; List_8
    //     0x2e31a0: stur            x1, [x0, #0x17]
    // 0x2e31a4: mov             x1, x0
    // 0x2e31a8: r2 = Null
    //     0x2e31a8: mov             x2, NULL
    // 0x2e31ac: r0 = _asyncComplete()
    //     0x2e31ac: bl              #0x2cb14  ; [dart:async] _Future::_asyncComplete
    // 0x2e31b0: ldur            x0, [fp, #-0x10]
    // 0x2e31b4: ldur            x1, [fp, #-8]
    // 0x2e31b8: StoreField: r1->field_3f = r0
    //     0x2e31b8: stur            x0, [x1, #0x3f]
    //     0x2e31bc: ldurb           w16, [x1, #-1]
    //     0x2e31c0: ldurb           w17, [x0, #-1]
    //     0x2e31c4: and             x16, x17, x16, lsr #2
    //     0x2e31c8: tst             x16, HEAP, lsr #32
    //     0x2e31cc: b.eq            #0x2e31d4
    //     0x2e31d0: bl              #0x428dd0  ; WriteBarrierWrappersStub
    // 0x2e31d4: r0 = Null
    //     0x2e31d4: mov             x0, NULL
    // 0x2e31d8: LeaveFrame
    //     0x2e31d8: mov             SP, fp
    //     0x2e31dc: ldp             fp, lr, [SP], #0x10
    // 0x2e31e0: ret
    //     0x2e31e0: ret             
    // 0x2e31e4: r0 = StackOverflowSharedWithoutFPURegs()
    //     0x2e31e4: bl              #0x42a844  ; StackOverflowSharedWithoutFPURegsStub
    // 0x2e31e8: b               #0x2e30b4
  }
}
