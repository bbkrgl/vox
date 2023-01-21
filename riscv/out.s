#include <stdio.h>
.align 2
.section .text
.global main


y:
addi sp, sp, -88
sd ra, 0(sp)
fsd ft0, 8(sp)
sd a0, 16(sp)
sd a1, 24(sp)
sd a2, 32(sp)
sd a3, 40(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fsd ft0, 48(sp)
li t2, 4611686018427387904 # 2.0
fmv.d.x ft0, t2
fsd ft0, 56(sp)
li t2, 4613937818241073152 # 3.0
fmv.d.x ft0, t2
fsd ft0, 64(sp)
li t2, 4616189618054758400 # 4.0
fmv.d.x ft0, t2
fsd ft0, 72(sp)
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 80(sp)
fmv.d.x ft0, a0
li t2, 0 # 0.0
fmv.d.x ft1, t2
flt.d t0, ft1, ft0
beqz t0, .L0
addi sp, sp, -64
sd ra, 0(sp)
fsd ft0, 8(sp)
fsd ft1, 16(sp)
sd t0, 24(sp)
sd a0, 32(sp)
sd a1, 40(sp)
sd a2, 48(sp)
sd a3, 56(sp)
fmv.d.x ft1, a0
la a0, .floatformat
fmv.x.d a1, ft1
call printf
ld ra, 0(sp)
fld ft0, 8(sp)
fld ft1, 16(sp)
ld t0, 24(sp)
addi sp, sp, 64
.L0:
li t2, 4613937818241073152 # 3.0
fmv.d.x ft1, t2
fsd ft1, 16(sp) # a
li t2, 0 # 0.0
fmv.d.x ft1, t2
fsd ft1, 80(sp) # i
j .L3
.L2:
addi sp, sp, -32
fsd ft1, 0(sp)
fsd ft0, 8(sp)
sd t0, 16(sp)
sd t1, 24(sp)
fld ft1, 112(sp)
fcvt.w.d a1, ft1
slli a1, a1, 3
addi a0, sp, 80
add a0, a0, a1
fld ft1, (a0)
la a0, .floatformat
fmv.x.d a1, ft1
call printf
fld ft1, 0(sp)
fld ft0, 8(sp)
ld t0, 16(sp)
ld t1, 24(sp)
addi sp, sp, 32
fld ft1, 80(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fadd.d ft1, ft1, ft0
fsd ft1, 80(sp) # i
.L3:
fld ft1, 80(sp)
li t2, 4616189618054758400 # 4.0
fmv.d.x ft0, t2
flt.d t0, ft1, ft0
beqz t0, .L1
fld ft0, 16(sp)
li t2, 4611686018427387904 # 2.0
fmv.d.x ft1, t2
flt.d t1, ft0, ft1
and t0, t0, t1
.L1:
bnez t0, .L2
la a0, .glob_x
fld ft1, (a0)
fmv.x.d a0, ft1
ld ra, 0(sp)
addi sp, sp, 88
ret
ld ra, 0(sp)
fld ft0, 8(sp)
addi sp, sp, 88
li a0, 0
ret
f:
addi sp, sp, -72
sd ra, 0(sp)
fsd ft0, 8(sp)
sd a0, 16(sp)
sd a1, 24(sp)
li t2, 4636737291354636288 # 100.0
fmv.d.x ft0, t2
fsd ft0, 32(sp)
li t2, 4611686018427387904 # 2.0
fmv.d.x ft0, t2
fsd ft0, 48(sp)
li t2, 4613937818241073152 # 3.0
fmv.d.x ft0, t2
fsd ft0, 56(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fsd ft0, 64(sp)
li t2, 4616189618054758400 # 4.0
fmv.d.x ft0, t2
fsd ft0, 72(sp)
fmv.d.x ft0, a0
li t2, 0 # 0.0
fmv.d.x ft2, t2
flt.d t1, ft2, ft0
beqz t1, .L4
addi sp, sp, -48
sd ra, 0(sp)
fsd ft0, 8(sp)
fsd ft2, 16(sp)
sd t1, 24(sp)
sd a0, 32(sp)
sd a1, 40(sp)
fmv.d.x ft2, a0
la a0, .floatformat
fmv.x.d a1, ft2
call printf
ld ra, 0(sp)
fld ft0, 8(sp)
fld ft2, 16(sp)
ld t1, 24(sp)
addi sp, sp, 48
.L4:
li t2, 4613937818241073152 # 3.0
fmv.d.x ft2, t2
fsd ft2, 16(sp) # a
li t2, 4617315517961601024 # 5.0
fmv.d.x ft2, t2
fsd ft2, 32(sp) # x
li t2, 0 # 0.0
fmv.d.x ft2, t2
fsd ft2, 40(sp) # i
j .L6
.L5:
addi sp, sp, -24
fsd ft0, 0(sp)
fsd ft2, 8(sp)
sd t1, 16(sp)
fld ft0, 64(sp)
fcvt.w.d a1, ft0
slli a1, a1, 3
addi a0, sp, 72
add a0, a0, a1
fld ft0, (a0)
la a0, .floatformat
fmv.x.d a1, ft0
call printf
fld ft0, 0(sp)
fld ft2, 8(sp)
ld t1, 16(sp)
addi sp, sp, 24
fld ft0, 40(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft2, t2
fadd.d ft0, ft0, ft2
fsd ft0, 40(sp) # i
.L6:
fld ft2, 40(sp)
li t2, 4616189618054758400 # 4.0
fmv.d.x ft0, t2
flt.d t1, ft2, ft0
bnez t1, .L5
li t2, 4611686018427387904 # 2.0
fmv.d.x ft0, t2
fmv.x.d a0, ft0
ld ra, 0(sp)
addi sp, sp, 80
ret
ld ra, 0(sp)
fld ft0, 8(sp)
addi sp, sp, 72
li a0, 0
ret
fibonnacci:
addi sp, sp, -24
sd ra, 0(sp)
fsd ft0, 8(sp)
sd a0, 16(sp)
fmv.d.x ft2, a0
li t2, 4611686018427387904 # 2.0
fmv.d.x ft3, t2
flt.d t2, ft2, ft3
beqz t2, .L7
addi sp, sp, -40
sd ra, 0(sp)
fsd ft2, 8(sp)
fsd ft3, 16(sp)
sd t2, 24(sp)
sd a0, 32(sp)
la a0, .strformat
la a1, .S0
call printf
li t2, 4607182418800017408 # 1.0
fmv.d.x ft3, t2
fmv.x.d a0, ft3
ld ra, 0(sp)
addi sp, sp, 40
ret
ld ra, 0(sp)
fld ft2, 8(sp)
fld ft3, 16(sp)
ld t2, 24(sp)
addi sp, sp, 40
.L7:
la a0, .strformat
la a1, .S1
call printf
fld ft4, 16(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft5, t2
fsub.d ft4, ft4, ft5
fmv.x.d a0, ft4
call fibonnacci
fmv.d.x ft2, a0
fld ft5, 16(sp)
li t2, 4611686018427387904 # 2.0
fmv.d.x ft6, t2
fsub.d ft5, ft5, ft6
fmv.x.d a0, ft5
call fibonnacci
fmv.d.x ft4, a0
fadd.d ft2, ft2, ft4
fmv.x.d a0, ft2
ld ra, 0(sp)
addi sp, sp, 24
ret
ld ra, 0(sp)
fld ft0, 8(sp)
addi sp, sp, 24
li a0, 0
ret
main:
li t2, 4621819117588971520 # 10.0
fmv.d.x ft0, t2
la a0, .glob_x
fsd ft0, (a0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
la a0, .glob_z
fsd ft0, (a0)
la a0, .glob_xx
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 0(a0)
li t2, 4611686018427387904 # 2.0
fmv.d.x ft0, t2
fsd ft0, 8(a0)
li t2, 4613937818241073152 # 3.0
fmv.d.x ft0, t2
fsd ft0, 16(a0)
li t2, 4617315517961601024 # 5.0
fmv.d.x ft0, t2
fsd ft0, 24(a0)
la a0, .glob_x
fld ft4, (a0)
la a0, .floatformat
fmv.x.d a1, ft4
call printf
li t2, 4607182418800017408 # 1.0
fmv.d.x ft5, t2
fmv.x.d a0, ft5
li t2, 4611686018427387904 # 2.0
fmv.d.x ft5, t2
fmv.x.d a1, ft5
li t2, 4613937818241073152 # 3.0
fmv.d.x ft5, t2
fmv.x.d a2, ft5
li t2, 4616189618054758400 # 4.0
fmv.d.x ft5, t2
fmv.x.d a3, ft5
call y
fmv.d.x ft4, a0
la t0, .glob_x
fsd ft4, (t0) # x
li t2, 0 # 0.0
fmv.d.x ft5, t2
fmv.x.d a0, ft5
li t2, 4613937818241073152 # 3.0
fmv.d.x ft5, t2
fmv.x.d a1, ft5
call f
fmv.d.x ft4, a0
la t0, .glob_z
fsd ft4, (t0) # z
la a0, .glob_x
fld ft4, (a0)
la a0, .floatformat
fmv.x.d a1, ft4
call printf
li t2, 4617315517961601024 # 5.0
fmv.d.x ft5, t2
fmv.x.d a0, ft5
call fibonnacci
fmv.d.x ft4, a0
la a0, .floatformat
fmv.x.d a1, ft4
call printf

li a0, 0
li a7, 93
ecall


.section .data
.glob_x: .dword 0
.glob_z: .dword 0
.glob_xx: .dword 0,0,0,0
.S0: .string "Fibo return"
.S1: .string "Fibo case"
.strformat: .string "%s\n"
.intformat: .string "%d\n"
.floatformat: .string "%f\n"
