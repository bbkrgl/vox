#include <stdio.h>
.align 2
.section .text
.global main


main:
li t2, 4607182418800017408 # 1.0
fmv.d.x ft0, t2
li t2, 4607182418800017408 # 1.0
fmv.d.x ft1, t2
fadd.d ft0, ft0, ft1
la a0, .floatformat
fmv.x.d a1, ft0
call printf
li t2, 4617315517961601024 # 5.0
fmv.d.x ft0, t2
li t2, 4617991057905706598 # 5.6
fmv.d.x ft1, t2
fadd.d ft0, ft0, ft1
la a0, .floatformat
fmv.x.d a1, ft0
call printf
li t2, 4617315517961601024 # 5.0
fmv.d.x ft0, t2
li t2, 4617991057905706598 # 5.6
fmv.d.x ft1, t2
fdiv.d ft0, ft0, ft1
la a0, .floatformat
fmv.x.d a1, ft0
call printf
li t2, 4617315517961601024 # 5.0
fmv.d.x ft0, t2
li t2, 4617991057905706598 # 5.6
fmv.d.x ft1, t2
fmul.d ft0, ft0, ft1
la a0, .floatformat
fmv.x.d a1, ft0
call printf
li t2, 4617315517961601024 # 5.0
fmv.d.x ft0, t2
li t2, 4617991057905706598 # 5.6
fmv.d.x ft1, t2
fsub.d ft0, ft0, ft1
la a0, .floatformat
fmv.x.d a1, ft0
call printf
li t2, 4617315517961601024 # 5.0
fmv.d.x ft0, t2
li t2, 4617991057905706598 # 5.6
fmv.d.x ft1, t2
fsub.d ft0, ft0, ft1
fsgnjn.d ft0, ft0, ft0
la a0, .floatformat
fmv.x.d a1, ft0
call printf
li t2, 4617315517961601024 # 5.0
fmv.d.x ft0, t2
li t2, 4617991057905706598 # 5.6
fmv.d.x ft1, t2
fsub.d ft0, ft0, ft1
li t2, 4617315517961601024 # 5.0
fmv.d.x ft1, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft2, t2
li t2, 4636737291354636288 # 100.0
fmv.d.x ft3, t2
fdiv.d ft2, ft2, ft3
fadd.d ft1, ft1, ft2
fmul.d ft0, ft0, ft1
li t2, 4620130267728707584 # 7.5
fmv.d.x ft1, t2
fadd.d ft0, ft0, ft1
la a0, .floatformat
fmv.x.d a1, ft0
call printf
li t0, 1
li t1, 0
or t0, t0, t1
la a0, .boolformat
mv a1, t0
call printf
li t0, 0
li t1, 0
or t0, t0, t1
la a0, .boolformat
mv a1, t0
call printf
li t0, 1
li t1, 0
and t0, t0, t1
la a0, .boolformat
mv a1, t0
call printf
li t0, 1
li t1, 1
and t0, t0, t1
la a0, .boolformat
mv a1, t0
call printf
la a0, .strformat
la a1, .S0
call printf
li t2, 4617315517961601024 # 5.0
fmv.d.x ft0, t2
li t2, 4616189618054758400 # 4.0
fmv.d.x ft1, t2
fle.d t0, ft0, ft1
xori t0, t0, 1
la a0, .boolformat
mv a1, t0
call printf
li t2, 4617315517961601024 # 5.0
fmv.d.x ft1, t2
li t2, 4617315517961601024 # 5.0
fmv.d.x ft0, t2
flt.d t0, ft1, ft0
xori t0, t0, 1
la a0, .boolformat
mv a1, t0
call printf
li t2, 4616189618054758400 # 4.0
fmv.d.x ft0, t2
li t2, 4617315517961601024 # 5.0
fmv.d.x ft1, t2
flt.d t0, ft0, ft1
xori t0, t0, 1
la a0, .boolformat
mv a1, t0
call printf
li t2, 4637314315056893133 # 108.2
fmv.d.x ft1, t2
li t2, 4637314315056893133 # 108.2
fmv.d.x ft0, t2
feq.d t0, ft1, ft0
la a0, .boolformat
mv a1, t0
call printf
li t2, 4637314315056893133 # 108.2
fmv.d.x ft0, t2
li t2, 4637314315056893133 # 108.2
fmv.d.x ft1, t2
feq.d t0, ft0, ft1
xori t0, t0, 1
la a0, .boolformat
mv a1, t0
call printf
li t0, 1
xori t0, t0, 1
la a0, .boolformat
mv a1, t0
call printf
li t0, 0
xori t0, t0, 1
la a0, .boolformat
mv a1, t0
call printf
la a0, .strformat
la a1, .S1
call printf
li t2, 4617315517961601024 # 5.0
fmv.d.x ft1, t2
li t2, 4617991057905706598 # 5.6
fmv.d.x ft0, t2
fmul.d ft1, ft1, ft0
li t2, 4628574517030027264 # 28.0
fmv.d.x ft0, t2
feq.d t0, ft1, ft0
la a0, .boolformat
mv a1, t0
call printf

li a0, 0
li a7, 93
ecall


.section .data
.S0: .string "AAA"
.S1: .string "fdaihfas"
.strformat: .string "%s\n"
.boolformat: .string "%d\n"
.floatformat: .string "%f\n"

