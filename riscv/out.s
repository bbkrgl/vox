#include <stdio.h>
.align 2
.section .text
.global main


main:
la a0, .glob_x
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fsd ft0, 0(a0)
li t2, 4611686018427387904 # 2.0
fmv.d.x ft0, t2
fsd ft0, 8(a0)
li t2, 4613937818241073152 # 3.0
fmv.d.x ft0, t2
fsd ft0, 16(a0)
li t2, 4616189618054758400 # 4.0
fmv.d.x ft0, t2
fsd ft0, 24(a0)
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 32(a0)
li t2, 0 # 0.0
fmv.d.x ft0, t2
la t0, .glob_i
fsd ft0, (t0) # i
j .L1
.L0:
la a0, .glob_i
fld ft1, (a0)
la a0, .glob_x
fcvt.w.d a1, ft1
slli a1, a1, 3
add a0, a0, a1
fld ft1, (a0)
la a0, .floatformat
fmv.x.d a1, ft1
call printf
la a0, .glob_i
fld ft1, (a0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fadd.d ft1, ft1, ft0
la t0, .glob_i
fsd ft1, (t0) # i
.L1:
la a0, .glob_i
fld ft0, (a0)
li t2, 4616189618054758400 # 4.0
fmv.d.x ft1, t2
flt.d t0, ft0, ft1
bnez t0, .L0
li t2, 0 # 0.0
fmv.d.x ft1, t2
la a0, .glob_x
fcvt.w.d a1, ft1
slli a1, a1, 3
add a0, a0, a1
li t2, 4636737291354636288 # 100.0
fmv.d.x ft0, t2
fsd ft0, (a0)
li t2, 4611686018427387904 # 2.0
fmv.d.x ft0, t2
la a0, .glob_x
fcvt.w.d a1, ft0
slli a1, a1, 3
add a0, a0, a1
li t2, 0 # 0.0
fmv.d.x ft1, t2
fsd ft1, (a0)
li t2, 4613937818241073152 # 3.0
fmv.d.x ft1, t2
la a0, .glob_x
fcvt.w.d a1, ft1
slli a1, a1, 3
add a0, a0, a1
li t1, 1
fcvt.d.w fa0, t1
fsd fa0, (a0)
li t2, 0 # 0.0
fmv.d.x ft1, t2
la t0, .glob_i
fsd ft1, (t0) # i
j .L3
.L2:
la a0, .glob_i
fld ft0, (a0)
la a0, .glob_x
fcvt.w.d a1, ft0
slli a1, a1, 3
add a0, a0, a1
fld ft0, (a0)
la a0, .floatformat
fmv.x.d a1, ft0
call printf
la a0, .glob_i
fld ft0, (a0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft1, t2
fadd.d ft0, ft0, ft1
la t0, .glob_i
fsd ft0, (t0) # i
.L3:
la a0, .glob_i
fld ft1, (a0)
li t2, 4616189618054758400 # 4.0
fmv.d.x ft0, t2
flt.d t1, ft1, ft0
bnez t1, .L2
li t2, 0 # 0.0
fmv.d.x ft0, t2
la t0, .glob_i
fsd ft0, (t0) # i
j .L5
.L4:
la a0, .glob_i
fld ft1, (a0)
la a0, .glob_x
fcvt.w.d a1, ft1
slli a1, a1, 3
add a0, a0, a1
fld ft1, (a0)
fcvt.w.d t3, ft1
snez t3, t3
la a0, .boolformat
mv a1, t3
call printf
la a0, .glob_i
fld ft1, (a0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fadd.d ft1, ft1, ft0
la t0, .glob_i
fsd ft1, (t0) # i
.L5:
la a0, .glob_i
fld ft0, (a0)
li t2, 4617315517961601024 # 5.0
fmv.d.x ft1, t2
flt.d t2, ft0, ft1
bnez t2, .L4
li t2, 0 # 0.0
fmv.d.x ft1, t2
la a0, .glob_x
fcvt.w.d a1, ft1
slli a1, a1, 3
add a0, a0, a1
fld ft1, (a0)
fcvt.w.d t3, ft1
snez t3, t3
beqz t3, .L13
addi sp, sp, -48
li t2, 0 # 0.0
fmv.d.x ft1, t2
fsd ft1, 0(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft1, t2
fsd ft1, 8(sp)
li t2, 4611686018427387904 # 2.0
fmv.d.x ft1, t2
fsd ft1, 16(sp)
li t2, 4613937818241073152 # 3.0
fmv.d.x ft1, t2
fsd ft1, 24(sp)
li t2, 4616189618054758400 # 4.0
fmv.d.x ft1, t2
fsd ft1, 32(sp)
li t2, 4617315517961601024 # 5.0
fmv.d.x ft1, t2
fsd ft1, 40(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft1, t2
la a0, .glob_x
fcvt.w.d a1, ft1
slli a1, a1, 3
add a0, a0, a1
fld ft1, (a0)
fcvt.w.d t3, ft1
snez t3, t3
beqz t3, .L8
addi sp, sp, -48
li t2, 0 # 0.0
fmv.d.x ft1, t2
fsd ft1, 0(sp)
li t2, 4617315517961601024 # 5.0
fmv.d.x ft1, t2
fsd ft1, 8(sp)
li t2, 4616189618054758400 # 4.0
fmv.d.x ft1, t2
fsd ft1, 16(sp)
li t2, 4613937818241073152 # 3.0
fmv.d.x ft1, t2
fsd ft1, 24(sp)
li t2, 4611686018427387904 # 2.0
fmv.d.x ft1, t2
fsd ft1, 32(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft1, t2
fsd ft1, 40(sp)
li t2, 0 # 0.0
fmv.d.x ft1, t2
fsd ft1, 0(sp) # ii
j .L7
.L6:
fld ft0, 0(sp)
fcvt.w.d a1, ft0
slli a1, a1, 3
addi a0, sp, 8
add a0, a0, a1
fld ft0, (a0)
la a0, .floatformat
fmv.x.d a1, ft0
call printf
fld ft0, 0(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft1, t2
fadd.d ft0, ft0, ft1
fsd ft0, 0(sp) # ii
.L7:
fld ft1, 0(sp)
li t2, 4616189618054758400 # 4.0
fmv.d.x ft0, t2
flt.d t3, ft1, ft0
bnez t3, .L6
addi sp, sp, 48
.L8:
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 0(sp) # ii
j .L10
.L9:
fld ft1, 0(sp)
fcvt.w.d a1, ft1
slli a1, a1, 3
addi a0, sp, 8
add a0, a0, a1
fld ft1, (a0)
la a0, .floatformat
fmv.x.d a1, ft1
call printf
fld ft1, 0(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fadd.d ft1, ft1, ft0
fsd ft1, 0(sp) # ii
.L10:
fld ft0, 0(sp)
li t2, 4616189618054758400 # 4.0
fmv.d.x ft1, t2
flt.d t4, ft0, ft1
bnez t4, .L9
li t2, 0 # 0.0
fmv.d.x ft1, t2
fsd ft1, 0(sp) # ii
j .L12
.L11:
fld ft0, 0(sp)
la a0, .glob_x
fcvt.w.d a1, ft0
slli a1, a1, 3
add a0, a0, a1
fld ft0, (a0)
la a0, .floatformat
fmv.x.d a1, ft0
call printf
fld ft0, 0(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft1, t2
fadd.d ft0, ft0, ft1
fsd ft0, 0(sp) # ii
.L12:
fld ft1, 0(sp)
li t2, 4616189618054758400 # 4.0
fmv.d.x ft0, t2
flt.d t5, ft1, ft0
bnez t5, .L11
addi sp, sp, 48
.L13:

li a0, 0
li a7, 93
ecall


.section .data
.glob_x: .dword 0,0,0,0,0
.glob_i: .dword 0
.strformat: .string "%s\n"
.boolformat: .string "%d\n"
.floatformat: .string "%f\n"
