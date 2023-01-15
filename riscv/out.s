#include <stdio.h>
.align 2
.section .text
.global main


main:
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
la a0, .glob_x
fsd ft0, (a0)
li t2, 4611686018427387904 # 2.0
fmv.d.x ft0, t2
la a0, .glob_y
fsd ft0, (a0)
li t0, 1
la a0, .glob_z
fcvt.d.w fa0, t0
fsd fa0, (a0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
li t2, 4607182418800017408 # 1.0
fmv.d.x ft1, t2
feq.d t0, ft0, ft1
beqz t0, .L0
addi sp, sp, -40
li t2, 4636737291354636288 # 100.0
fmv.d.x ft1, t2
fsd ft1, 0(sp)
li t2, 4641240890982006784 # 200.0
fmv.d.x ft1, t2
fsd ft1, 8(sp)
li t2, 4643000109586448384 # 250.0
fmv.d.x ft1, t2
fsd ft1, 16(sp)
li t2, 4639481672377565184 # 150.0
fmv.d.x ft1, t2
fsd ft1, 24(sp)
li t2, 4626322717216342016 # 20.0
fmv.d.x ft1, t2
fsd ft1, 32(sp)
fld ft1, 0(sp)
fld ft0, 8(sp)
fadd.d ft1, ft1, ft0
la a0, .floatformat
fmv.x.d a1, ft1
call printf
fld ft1, 0(sp)
fld ft0, 8(sp)
fadd.d ft1, ft1, ft0
fld ft0, 16(sp)
fadd.d ft1, ft1, ft0
fld ft0, 24(sp)
fadd.d ft1, ft1, ft0
fld ft0, 32(sp)
fadd.d ft1, ft1, ft0
la a0, .floatformat
fmv.x.d a1, ft1
call printf
addi sp, sp, 40
.L0:
la a0, .glob_x
fld ft1, (a0)
la a0, .glob_y
fld ft0, (a0)
fadd.d ft1, ft1, ft0
la a0, .floatformat
fmv.x.d a1, ft1
call printf
la a0, .glob_z
fld ft1, (a0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fadd.d ft1, ft1, ft0
la t0, .glob_z
fsd ft1, (t0)
la a0, .glob_z
fld ft1, (a0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fadd.d ft1, ft1, ft0
la a0, .floatformat
fmv.x.d a1, ft1
call printf
la a0, .glob_z
fld ft1, (a0)
fsgnjn.d ft1, ft1, ft1
la a0, .floatformat
fmv.x.d a1, ft1
call printf
la a0, .glob_z
fld ft1, (a0)
fcvt.w.d t0, ft1
snez t0, t0
la a0, .boolformat
mv a1, t0
call printf
la a0, .glob_z
fld ft1, (a0)
li t2, 4611686018427387904 # 2.0
fmv.d.x ft0, t2
fsub.d ft1, ft1, ft0
la t0, .glob_z
fsd ft1, (t0)
la a0, .glob_z
fld ft1, (a0)
fcvt.w.d t0, ft1
snez t0, t0
la a0, .boolformat
mv a1, t0
call printf

li a0, 0
li a7, 93
ecall


.section .data
.glob_x: .dword 0
.glob_y: .dword 0
.glob_z: .dword 0
.strformat: .string "%s\n"
.boolformat: .string "%d\n"
.floatformat: .string "%f\n"
