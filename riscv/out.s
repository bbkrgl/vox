#include <stdio.h>
.align 2
.section .text
.global main


main:
li t2, 4621819117588971520 # 10.0
fmv.d.x ft0, t2
la a0, .glob_x
fsd ft0, (a0)
li t2, 4624633867356078080 # 15.0
fmv.d.x ft0, t2
la a0, .glob_y
fsd ft0, (a0)
li t2, 4636737291354636288 # 100.0
fmv.d.x ft0, t2
la t0, .glob_y
fsd ft0, (t0)
li t2, 4636737291354636288 # 100.0
fmv.d.x ft0, t2
la t0, .glob_y
fsd ft0, (t0)
li t2, 4636737291354636288 # 100.0
fmv.d.x ft0, t2
la t0, .glob_y
fsd ft0, (t0)
li t2, 4652007308841189376 # 1000.0
fmv.d.x ft0, t2
la t0, .glob_y
fsd ft0, (t0)
la a0, .glob_x
fld ft0, (a0)
la a0, .glob_y
fld ft1, (a0)
fadd.d ft0, ft0, ft1
la a0, .floatformat
fmv.x.d a1, ft0
call printf
j .L2
.L1:
la a0, .glob_x
fld ft1, (a0)
la a0, .floatformat
fmv.x.d a1, ft1
call printf
la a0, .glob_x
fld ft1, (a0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fsub.d ft1, ft1, ft0
la t0, .glob_x
fsd ft1, (t0)
	addi sp, sp, 0
.L2:
la a0, .glob_x
fld ft0, (a0)
li t2, 4617315517961601024 # 5.0
fmv.d.x ft1, t2
flt.d t0, ft1, ft0
bnez t0, .L1
li t2, 0 # 0.0
fmv.d.x ft1, t2
la t0, .glob_x
fsd ft1, (t0)
j .L4
.L3:
la a0, .glob_x
fld ft0, (a0)
la a0, .floatformat
fmv.x.d a1, ft0
call printf
	addi sp, sp, 0
la a0, .glob_x
fld ft0, (a0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft1, t2
fadd.d ft0, ft0, ft1
la t0, .glob_x
fsd ft0, (t0)
.L4:
la a0, .glob_x
fld ft1, (a0)
li t2, 4613937818241073152 # 3.0
fmv.d.x ft0, t2
flt.d t0, ft1, ft0
bnez t0, .L3
li t2, 4621819117588971520 # 10.0
fmv.d.x ft0, t2
la t0, .glob_x
fsd ft0, (t0)
j .L6
.L5:
la a0, .glob_x
fld ft0, (a0)
la a0, .floatformat
fmv.x.d a1, ft0
call printf
	addi sp, sp, 0
la a0, .glob_x
fld ft0, (a0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft1, t2
fsub.d ft0, ft0, ft1
la t0, .glob_x
fsd ft0, (t0)
.L6:
la a0, .glob_x
fld ft0, (a0)
fcvt.w.d t1, ft0
bnez t1, .L5

li a0, 0
li a7, 93
ecall


.section .data
.glob_x: .dword 0
.glob_y: .dword 0
.strformat: .string "%s\n"
.boolformat: .string "%d\n"
.floatformat: .string "%f\n"
