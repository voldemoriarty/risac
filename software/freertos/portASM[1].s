# 1 "portASM.S"
# 1 "<built-in>"
# 1 "<command-line>"
# 1 "portASM.S"
# 70 "portASM.S"
# 1 "freertos_risc_v_chip_specific_extensions.h" 1
# 60 "freertos_risc_v_chip_specific_extensions.h"
.macro portasmSAVE_ADDITIONAL_REGISTERS

 .endm


.macro portasmRESTORE_ADDITIONAL_REGISTERS

 .endm
# 71 "portASM.S" 2
# 89 "portASM.S"
.global xPortStartFirstTask
.global freertos_risc_v_trap_handler
.global pxPortInitialiseStack
.extern pxCurrentTCB
.extern ulPortTrapHandler
.extern vTaskSwitchContext
.extern Timer_IRQHandler
.extern pullMachineTimerCompareRegister
.extern pullNextTime
.extern uxTimerIncrementsForOneTick
.extern xISRStackTop



.align 8
.func
freertos_risc_v_trap_handler:
 addi sp, sp, -( 30 * 4 )
 sw x1, 1 * 4( sp )
 sw x5, 2 * 4( sp )
 sw x6, 3 * 4( sp )
 sw x7, 4 * 4( sp )
 sw x8, 5 * 4( sp )
 sw x9, 6 * 4( sp )
 sw x10, 7 * 4( sp )
 sw x11, 8 * 4( sp )
 sw x12, 9 * 4( sp )
 sw x13, 10 * 4( sp )
 sw x14, 11 * 4( sp )
 sw x15, 12 * 4( sp )
 sw x16, 13 * 4( sp )
 sw x17, 14 * 4( sp )
 sw x18, 15 * 4( sp )
 sw x19, 16 * 4( sp )
 sw x20, 17 * 4( sp )
 sw x21, 18 * 4( sp )
 sw x22, 19 * 4( sp )
 sw x23, 20 * 4( sp )
 sw x24, 21 * 4( sp )
 sw x25, 22 * 4( sp )
 sw x26, 23 * 4( sp )
 sw x27, 24 * 4( sp )
 sw x28, 25 * 4( sp )
 sw x29, 26 * 4( sp )
 sw x30, 27 * 4( sp )
 sw x31, 28 * 4( sp )

 csrr t0, mstatus
 sw t0, 29 * 4( sp )

 portasmSAVE_ADDITIONAL_REGISTERS

 lw t0, pxCurrentTCB
 sw sp, 0( t0 )

 csrr a0, mcause
 csrr a1, mepc

test_if_asynchronous:
 srli a2, a0, 32 - 1
 beq a2, x0, handle_synchronous
 sw a1, 0( sp )

handle_asynchronous:
# 206 "portASM.S"
 lw sp, xISRStackTop
 jal int_handler
 j processed_source

handle_synchronous:
 addi a1, a1, 4
 sw a1, 0( sp )

test_if_environment_call:
 li t0, 11
 bne a0, t0, is_exception
 lw sp, xISRStackTop
 jal vTaskSwitchContext
 j processed_source

is_exception:
 ebreak
 j is_exception

as_yet_unhandled:
 ebreak
 j as_yet_unhandled

processed_source:
 lw t1, pxCurrentTCB
 lw sp, 0( t1 )


 lw t0, 0( sp )
 csrw mepc, t0

 portasmRESTORE_ADDITIONAL_REGISTERS


 lw t0, 29 * 4( sp )
 csrw mstatus, t0

 lw x1, 1 * 4( sp )
 lw x5, 2 * 4( sp )
 lw x6, 3 * 4( sp )
 lw x7, 4 * 4( sp )
 lw x8, 5 * 4( sp )
 lw x9, 6 * 4( sp )
 lw x10, 7 * 4( sp )
 lw x11, 8 * 4( sp )
 lw x12, 9 * 4( sp )
 lw x13, 10 * 4( sp )
 lw x14, 11 * 4( sp )
 lw x15, 12 * 4( sp )
 lw x16, 13 * 4( sp )
 lw x17, 14 * 4( sp )
 lw x18, 15 * 4( sp )
 lw x19, 16 * 4( sp )
 lw x20, 17 * 4( sp )
 lw x21, 18 * 4( sp )
 lw x22, 19 * 4( sp )
 lw x23, 20 * 4( sp )
 lw x24, 21 * 4( sp )
 lw x25, 22 * 4( sp )
 lw x26, 23 * 4( sp )
 lw x27, 24 * 4( sp )
 lw x28, 25 * 4( sp )
 lw x29, 26 * 4( sp )
 lw x30, 27 * 4( sp )
 lw x31, 28 * 4( sp )
 addi sp, sp, ( 30 * 4 )

 mret
 .endfunc


.align 8
.func
xPortStartFirstTask:
# 289 "portASM.S"
 lw sp, pxCurrentTCB
 lw sp, 0( sp )

 lw x1, 0( sp )

 portasmRESTORE_ADDITIONAL_REGISTERS

 lw t0, 29 * 4( sp )
 csrrw x0, mstatus, t0

 lw x5, 2 * 4( sp )
 lw x6, 3 * 4( sp )
 lw x7, 4 * 4( sp )
 lw x8, 5 * 4( sp )
 lw x9, 6 * 4( sp )
 lw x10, 7 * 4( sp )
 lw x11, 8 * 4( sp )
 lw x12, 9 * 4( sp )
 lw x13, 10 * 4( sp )
 lw x14, 11 * 4( sp )
 lw x15, 12 * 4( sp )
 lw x16, 13 * 4( sp )
 lw x17, 14 * 4( sp )
 lw x18, 15 * 4( sp )
 lw x19, 16 * 4( sp )
 lw x20, 17 * 4( sp )
 lw x21, 18 * 4( sp )
 lw x22, 19 * 4( sp )
 lw x23, 20 * 4( sp )
 lw x24, 21 * 4( sp )
 lw x25, 22 * 4( sp )
 lw x26, 23 * 4( sp )
 lw x27, 24 * 4( sp )
 lw x28, 25 * 4( sp )
 lw x29, 26 * 4( sp )
 lw x30, 27 * 4( sp )
 lw x31, 28 * 4( sp )
 addi sp, sp, ( 30 * 4 )
 ret
 .endfunc
# 393 "portASM.S"
.align 8
.func
pxPortInitialiseStack:

 csrr t0, mstatus
 addi t1, x0, 0x188
 slli t1, t1, 4
 or t0, t0, t1

 addi a0, a0, -4
 sw t0, 0(a0)
 addi a0, a0, -(22 * 4)
 sw a2, 0(a0)
 addi a0, a0, -(6 * 4)
 sw x0, 0(a0)
 addi t0, x0, 0
chip_specific_stack_frame:
 beq t0, x0, 1f
 addi a0, a0, -4
 sw x0, 0(a0)
 addi t0, t0, -1
 j chip_specific_stack_frame
1:
 addi a0, a0, -4
 sw a1, 0(a0)
 ret
 .endfunc
