#include <stdio.h>
.align 2
.section .text
.global main


sort:
addi sp, sp, -48
sd ra, 0(sp)
sd a0, 8(sp)
sd a1, 16(sp)
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 24(sp)
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 32(sp)
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 40(sp)
fld ft0, 16(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft1, t2
feq.d t0, ft0, ft1
beqz t0, .L0
li t2, 0 # 0.0
fmv.d.x ft1, t2
fmv.x.d a0, ft1
ld ra, 0(sp)
addi sp, sp, 48
ret
.L0:
li t2, 0 # 0.0
fmv.d.x ft1, t2
fsd ft1, 32(sp) # i
j .L3
.L2:
fld ft0, 32(sp)
la s0, .glob_list
fcvt.w.d a1, ft0
slli s1, a1, 3
add s0, s0, s1
fld ft0, (s0)
fld ft1, 32(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft2, t2
fadd.d ft1, ft1, ft2
la s0, .glob_list
fcvt.w.d a1, ft1
slli s1, a1, 3
add s0, s0, s1
fld ft1, (s0)
flt.d t1, ft1, ft0
beqz t1, .L1
fld ft1, 32(sp)
la s0, .glob_list
fcvt.w.d a1, ft1
slli s1, a1, 3
add s0, s0, s1
fld ft1, (s0)
fsd ft1, 40(sp) # tmp
fld ft1, 32(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fadd.d ft1, ft1, ft0
la s0, .glob_list
fcvt.w.d a1, ft1
slli s1, a1, 3
add s0, s0, s1
fld ft1, (s0)
fld ft0, 32(sp)
la s0, .glob_list
fcvt.w.d s1, ft0
slli s1, s1, 3
add s0, s0, s1
fsd ft1, (s0)
fld ft1, 40(sp)
fld ft0, 32(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft2, t2
fadd.d ft0, ft0, ft2
la s0, .glob_list
fcvt.w.d s1, ft0
slli s1, s1, 3
add s0, s0, s1
fsd ft1, (s0)
fld ft1, 24(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fadd.d ft1, ft1, ft0
fsd ft1, 24(sp) # count
.L1:
fld ft0, 32(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft1, t2
fadd.d ft0, ft0, ft1
fsd ft0, 32(sp) # i
.L3:
fld ft1, 32(sp)
fld ft0, 16(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft2, t2
fsub.d ft0, ft0, ft2
flt.d t0, ft1, ft0
bnez t0, .L2
fld ft1, 24(sp)
li t2, 0 # 0.0
fmv.d.x ft0, t2
feq.d t1, ft1, ft0
beqz t1, .L4
li t2, 0 # 0.0
fmv.d.x ft0, t2
fmv.x.d a0, ft0
ld ra, 0(sp)
addi sp, sp, 48
ret
.L4:
fld ft1, 8(sp)
fmv.x.d a0, ft1
fld ft1, 16(sp)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft2, t2
fsub.d ft1, ft1, ft2
fmv.x.d a1, ft1
addi sp, sp, -16
fsd ft0, 0(sp)
sd t0, 8(sp)
call sort
fld ft0, 0(sp)
ld t0, 8(sp)
addi sp, sp, 16
fmv.d.x ft0, a0
fsd ft0, 40(sp) # tmp
ld ra, 0(sp)
addi sp, sp, 48
li a0, 0
ret
main:
la a0, .glob_list
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 0(a0)
li t2, 4611686018427387904 # 2.0
fmv.d.x ft0, t2
fsd ft0, 8(a0)
li t2, 4613937818241073152 # 3.0
fmv.d.x ft0, t2
fsd ft0, 16(a0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fsd ft0, 24(a0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fsd ft0, 32(a0)
li t2, 4619567317775286272 # 7.0
fmv.d.x ft0, t2
fsd ft0, 40(a0)
li t2, 4618441417868443648 # 6.0
fmv.d.x ft0, t2
fsd ft0, 48(a0)
li t2, 4621256167635550208 # 9.0
fmv.d.x ft0, t2
fsd ft0, 56(a0)
li t2, 0 # 0.0
fmv.d.x ft0, t2
la a0, .glob_r
fsd ft0, (a0)
la t1, .glob_list
mv a0, t1
li t2, 4620693217682128896 # 8.0
fmv.d.x ft1, t2
fmv.x.d a1, ft1
addi sp, sp, -8
fsd ft0, 0(sp)
call sort
fld ft0, 0(sp)
addi sp, sp, 8
fmv.d.x ft0, a0
la s0, .glob_r
fsd ft0, (s0) # r
li t2, 0 # 0.0
fmv.d.x ft0, t2
la s0, .glob_r
fsd ft0, (s0) # r
j .L6
.L5:
la s0, .glob_r
fld ft1, (s0)
la s0, .glob_list
fcvt.w.d a1, ft1
slli s1, a1, 3
add s0, s0, s1
fld ft1, (s0)
la a0, .floatformat
fmv.x.d a1, ft1
call printf
la s0, .glob_r
fld ft1, (s0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fadd.d ft1, ft1, ft0
la s0, .glob_r
fsd ft1, (s0) # r
.L6:
la s0, .glob_r
fld ft0, (s0)
li t2, 4620693217682128896 # 8.0
fmv.d.x ft1, t2
flt.d t1, ft0, ft1
bnez t1, .L5

li a0, 0
li a7, 93
ecall


.section .data
.glob_list: .dword 0,0,0,0,0,0,0,0
.glob_r: .dword 0
.strformat: .string "%s\n"
.intformat: .string "%d\n"
.floatformat: .string "%f\n"
