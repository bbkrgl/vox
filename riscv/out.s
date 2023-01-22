#include <stdio.h>
.align 2
.section .text
.global main


main:
li t2, 0 # 0.0
fmv.d.x ft0, t2
la a0, .glob_i
fsd ft0, (a0)
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
la a0, .glob_y
li t2, 4617315517961601024 # 5.0
fmv.d.x ft0, t2
fsd ft0, 0(a0)
li t2, 4618441417868443648 # 6.0
fmv.d.x ft0, t2
fsd ft0, 8(a0)
li t2, 4619567317775286272 # 7.0
fmv.d.x ft0, t2
fsd ft0, 16(a0)
li t2, 4620693217682128896 # 8.0
fmv.d.x ft0, t2
fsd ft0, 24(a0)
la a0, .glob_z
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 0(a0)
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 8(a0)
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 16(a0)
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 24(a0)
la a0, .glob_z1
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 0(a0)
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 8(a0)
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 16(a0)
li t2, 0 # 0.0
fmv.d.x ft0, t2
fsd ft0, 24(a0)
la t0, .glob_x
la t1, .glob_y
la s0, .glob_z
li s2, 4
.L0:
vsetvli s1, s2, e64
vle64.v v0, (t0)
vle64.v v1, (t1)
vfadd.vv v0, v0, v1
vse64.v v0, (s0)
sub s2, s2, s1
slli s3, s1, 3
add t0, t0, s3
add t1, t1, s3
add s0, s0, s3
bgtz s2, .L0
la t1, .glob_z
la t2, .glob_y
la s0, .glob_z1
li s2, 4
.L1:
vsetvli s1, s2, e64
vle64.v v0, (t1)
vle64.v v1, (t2)
vfmul.vv v0, v0, v1
vse64.v v0, (s0)
sub s2, s2, s1
slli s3, s1, 3
add t1, t1, s3
add t2, t2, s3
add s0, s0, s3
bgtz s2, .L1
li t2, 0 # 0.0
fmv.d.x ft0, t2
la s0, .glob_i
fsd ft0, (s0) # i
j .L3
.L2:
la s0, .glob_i
fld ft1, (s0)
la a0, .glob_z1
fcvt.w.d a1, ft1
slli a1, a1, 3
add a0, a0, a1
fld ft1, (a0)
la a0, .floatformat
fmv.x.d a1, ft1
call printf
la s0, .glob_i
fld ft1, (s0)
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
fadd.d ft1, ft1, ft0
la s0, .glob_i
fsd ft1, (s0) # i
.L3:
la s0, .glob_i
fld ft0, (s0)
li t2, 4616189618054758400 # 4.0
fmv.d.x ft1, t2
flt.d t2, ft0, ft1
bnez t2, .L2

li a0, 0
li a7, 93
ecall


.section .data
.glob_i: .dword 0
.glob_x: .dword 0,0,0,0
.glob_y: .dword 0,0,0,0
.glob_z: .dword 0,0,0,0
.glob_z1: .dword 0,0,0,0
.strformat: .string "%s\n"
.intformat: .string "%d\n"
.floatformat: .string "%f\n"
