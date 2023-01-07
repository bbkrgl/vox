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
li t2, 4616189618054758400 # 4.0
fmv.d.x ft0, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft1, t2
fadd.d ft0, ft0, ft1
li t2, 4618441417868443648 # 6.0
fmv.d.x ft1, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft2, t2
fadd.d ft1, ft1, ft2
fmul.d ft0, ft0, ft1
li t2, 4616189618054758400 # 4.0
fmv.d.x ft1, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft2, t2
fadd.d ft1, ft1, ft2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft2, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft3, t2
fadd.d ft2, ft2, ft3
fmul.d ft1, ft1, ft2
fadd.d ft0, ft0, ft1
li t2, 4616189618054758400 # 4.0
fmv.d.x ft1, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft2, t2
fadd.d ft1, ft1, ft2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft2, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft3, t2
fadd.d ft2, ft2, ft3
fmul.d ft1, ft1, ft2
li t2, 4616189618054758400 # 4.0
fmv.d.x ft2, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
fadd.d ft2, ft2, ft3
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
fadd.d ft1, ft1, ft2
fadd.d ft0, ft0, ft1
li t2, 4616189618054758400 # 4.0
fmv.d.x ft1, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft2, t2
fadd.d ft1, ft1, ft2
li t2, 4616189618054758400 # 4.0
fmv.d.x ft2, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
fadd.d ft2, ft2, ft3
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
fadd.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
li t2, 4616189618054758400 # 4.0
fmv.d.x ft4, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
fadd.d ft3, ft3, ft4
fadd.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
li t2, 4616189618054758400 # 4.0
fmv.d.x ft4, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
fadd.d ft3, ft3, ft4
li t2, 4616189618054758400 # 4.0
fmv.d.x ft4, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
li t2, 4616189618054758400 # 4.0
fmv.d.x ft5, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
fmul.d ft5, ft5, ft6
fadd.d ft4, ft4, ft5
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
fadd.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
li t2, 4616189618054758400 # 4.0
fmv.d.x ft4, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
fadd.d ft3, ft3, ft4
fadd.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4616189618054758400 # 4.0
fmv.d.x ft4, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
li t2, 4616189618054758400 # 4.0
fmv.d.x ft5, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
fmul.d ft5, ft5, ft6
fadd.d ft4, ft4, ft5
li t2, 4616189618054758400 # 4.0
fmv.d.x ft5, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
fmul.d ft5, ft5, ft6
li t2, 4616189618054758400 # 4.0
fmv.d.x ft6, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
li t2, 4618441417868443648 # 6.0
fmv.d.x ft7, t2
addi sp, sp, -8
fsd ft0, (sp)
li t2, 4620693217682128896 # 8.0
fmv.d.x ft0, t2
fadd.d ft7, ft7, ft0
fmul.d ft6, ft6, ft7
fadd.d ft5, ft5, ft6
fadd.d ft4, ft4, ft5
li t2, 4616189618054758400 # 4.0
fmv.d.x ft5, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
fmul.d ft5, ft5, ft6
li t2, 4616189618054758400 # 4.0
fmv.d.x ft6, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
li t2, 4618441417868443648 # 6.0
fmv.d.x ft7, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft0, t2
fadd.d ft7, ft7, ft0
fmul.d ft6, ft6, ft7
fadd.d ft5, ft5, ft6
li t2, 4616189618054758400 # 4.0
fmv.d.x ft6, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
li t2, 4618441417868443648 # 6.0
fmv.d.x ft7, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft0, t2
fadd.d ft7, ft7, ft0
fmul.d ft6, ft6, ft7
li t2, 4616189618054758400 # 4.0
fmv.d.x ft7, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft0, t2
fadd.d ft7, ft7, ft0
li t2, 4618441417868443648 # 6.0
fmv.d.x ft0, t2
addi sp, sp, -8
fsd ft1, (sp)
li t2, 4620693217682128896 # 8.0
fmv.d.x ft1, t2
fadd.d ft0, ft0, ft1
fmul.d ft7, ft7, ft0
fadd.d ft6, ft6, ft7
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
li t2, 4616189618054758400 # 4.0
fmv.d.x ft5, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
fmul.d ft5, ft5, ft6
fadd.d ft4, ft4, ft5
li t2, 4616189618054758400 # 4.0
fmv.d.x ft5, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
fmul.d ft5, ft5, ft6
li t2, 4616189618054758400 # 4.0
fmv.d.x ft6, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
li t2, 4618441417868443648 # 6.0
fmv.d.x ft7, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft0, t2
fadd.d ft7, ft7, ft0
fmul.d ft6, ft6, ft7
fadd.d ft5, ft5, ft6
fadd.d ft4, ft4, ft5
li t2, 4616189618054758400 # 4.0
fmv.d.x ft5, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
fmul.d ft5, ft5, ft6
li t2, 4616189618054758400 # 4.0
fmv.d.x ft6, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
li t2, 4618441417868443648 # 6.0
fmv.d.x ft7, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft0, t2
fadd.d ft7, ft7, ft0
fmul.d ft6, ft6, ft7
fadd.d ft5, ft5, ft6
li t2, 4616189618054758400 # 4.0
fmv.d.x ft6, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
li t2, 4618441417868443648 # 6.0
fmv.d.x ft7, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft0, t2
fadd.d ft7, ft7, ft0
fmul.d ft6, ft6, ft7
li t2, 4616189618054758400 # 4.0
fmv.d.x ft7, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft0, t2
fadd.d ft7, ft7, ft0
li t2, 4618441417868443648 # 6.0
fmv.d.x ft0, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft1, t2
fadd.d ft0, ft0, ft1
fmul.d ft7, ft7, ft0
fadd.d ft6, ft6, ft7
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
li t2, 4616189618054758400 # 4.0
fmv.d.x ft4, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
fadd.d ft3, ft3, ft4
li t2, 4616189618054758400 # 4.0
fmv.d.x ft4, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
li t2, 4616189618054758400 # 4.0
fmv.d.x ft5, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
fmul.d ft5, ft5, ft6
fadd.d ft4, ft4, ft5
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
fld ft1, (sp)
addi sp, sp, 8
fmul.d ft1, ft1, ft2
li t2, 4616189618054758400 # 4.0
fmv.d.x ft2, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
fadd.d ft2, ft2, ft3
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
fadd.d ft1, ft1, ft2
li t2, 4616189618054758400 # 4.0
fmv.d.x ft2, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
fadd.d ft2, ft2, ft3
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
fadd.d ft2, ft2, ft3
fadd.d ft1, ft1, ft2
fld ft0, (sp)
addi sp, sp, 8
fmul.d ft0, ft0, ft1
li t2, 4618441417868443648 # 6.0
fmv.d.x ft1, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft2, t2
fadd.d ft1, ft1, ft2
fmul.d ft0, ft0, ft1
li t2, 4616189618054758400 # 4.0
fmv.d.x ft1, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft2, t2
fadd.d ft1, ft1, ft2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft2, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft3, t2
fadd.d ft2, ft2, ft3
fmul.d ft1, ft1, ft2
fadd.d ft0, ft0, ft1
li t2, 4616189618054758400 # 4.0
fmv.d.x ft1, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft2, t2
fadd.d ft1, ft1, ft2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft2, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft3, t2
fadd.d ft2, ft2, ft3
fmul.d ft1, ft1, ft2
li t2, 4616189618054758400 # 4.0
fmv.d.x ft2, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
fadd.d ft2, ft2, ft3
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
fadd.d ft1, ft1, ft2
fadd.d ft0, ft0, ft1
li t2, 4616189618054758400 # 4.0
fmv.d.x ft1, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft2, t2
fadd.d ft1, ft1, ft2
li t2, 4616189618054758400 # 4.0
fmv.d.x ft2, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
fadd.d ft2, ft2, ft3
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
fadd.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
li t2, 4616189618054758400 # 4.0
fmv.d.x ft4, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
fadd.d ft3, ft3, ft4
fadd.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
li t2, 4616189618054758400 # 4.0
fmv.d.x ft4, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
fadd.d ft3, ft3, ft4
li t2, 4616189618054758400 # 4.0
fmv.d.x ft4, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
li t2, 4616189618054758400 # 4.0
fmv.d.x ft5, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
fmul.d ft5, ft5, ft6
fadd.d ft4, ft4, ft5
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
fadd.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
li t2, 4616189618054758400 # 4.0
fmv.d.x ft4, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
fadd.d ft3, ft3, ft4
fadd.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
li t2, 4616189618054758400 # 4.0
fmv.d.x ft4, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
fadd.d ft3, ft3, ft4
li t2, 4616189618054758400 # 4.0
fmv.d.x ft4, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
li t2, 4618441417868443648 # 6.0
fmv.d.x ft5, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
fmul.d ft4, ft4, ft5
li t2, 4616189618054758400 # 4.0
fmv.d.x ft5, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
fadd.d ft5, ft5, ft6
li t2, 4618441417868443648 # 6.0
fmv.d.x ft6, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft7, t2
fadd.d ft6, ft6, ft7
fmul.d ft5, ft5, ft6
fadd.d ft4, ft4, ft5
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
fmul.d ft1, ft1, ft2
li t2, 4616189618054758400 # 4.0
fmv.d.x ft2, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
fadd.d ft2, ft2, ft3
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
fadd.d ft1, ft1, ft2
li t2, 4616189618054758400 # 4.0
fmv.d.x ft2, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
fadd.d ft2, ft2, ft3
li t2, 4618441417868443648 # 6.0
fmv.d.x ft3, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
fmul.d ft2, ft2, ft3
li t2, 4616189618054758400 # 4.0
fmv.d.x ft3, t2
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
fadd.d ft3, ft3, ft4
li t2, 4618441417868443648 # 6.0
fmv.d.x ft4, t2
li t2, 4620693217682128896 # 8.0
fmv.d.x ft5, t2
fadd.d ft4, ft4, ft5
fmul.d ft3, ft3, ft4
fadd.d ft2, ft2, ft3
fadd.d ft1, ft1, ft2
fmul.d ft0, ft0, ft1
la a0, .floatformat
fmv.x.d a1, ft0
call printf
li t0, 1
bnez t0, .L0
li t1, 0
or t0, t0, t1
.L0:
la a0, .boolformat
mv a1, t0
call printf
li t0, 0
bnez t0, .L1
li t1, 0
or t0, t0, t1
.L1:
la a0, .boolformat
mv a1, t0
call printf
li t0, 1
beqz t0, .L2
li t1, 0
and t0, t0, t1
.L2:
la a0, .boolformat
mv a1, t0
call printf
li t0, 1
beqz t0, .L3
li t1, 1
and t0, t0, t1
.L3:
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
flt.d t0, ft1, ft0
la a0, .boolformat
mv a1, t0
call printf
li t2, 4617315517961601024 # 5.0
fmv.d.x ft1, t2
li t2, 4617315517961601024 # 5.0
fmv.d.x ft0, t2
fle.d t0, ft0, ft1
la a0, .boolformat
mv a1, t0
call printf
li t2, 4616189618054758400 # 4.0
fmv.d.x ft0, t2
li t2, 4617315517961601024 # 5.0
fmv.d.x ft1, t2
fle.d t0, ft1, ft0
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
bnez t0, .L6
li t2, 4617315517961601024 # 5.0
fmv.d.x ft0, t2
li t2, 4617991057905706598 # 5.6
fmv.d.x ft1, t2
fmul.d ft0, ft0, ft1
li t2, 4628855992006737920 # 29.0
fmv.d.x ft1, t2
feq.d t1, ft0, ft1
beqz t1, .L5
li t2, 4617315517961601024 # 5.0
fmv.d.x ft1, t2
li t2, 4617991057905706598 # 5.6
fmv.d.x ft0, t2
fmul.d ft1, ft1, ft0
li t2, 4628574517030027264 # 28.0
fmv.d.x ft0, t2
addi sp, sp, -8
sd t0, (sp)
feq.d t0, ft1, ft0
bnez t0, .L4
li t2, 4617315517961601024 # 5.0
fmv.d.x ft0, t2
li t2, 4617991057905706598 # 5.6
fmv.d.x ft1, t2
fmul.d ft0, ft0, ft1
li t2, 4628855992006737920 # 29.0
fmv.d.x ft1, t2
addi sp, sp, -8
sd t1, (sp)
feq.d t1, ft0, ft1
or t0, t0, t1
.L4:
ld t1, (sp)
addi sp, sp, 8
and t1, t1, t0
.L5:
ld t0, (sp)
addi sp, sp, 8
or t0, t0, t1
.L6:
beqz t0, .L7
li t2, 4617315517961601024 # 5.0
fmv.d.x ft1, t2
li t2, 4617991057905706598 # 5.6
fmv.d.x ft0, t2
fmul.d ft1, ft1, ft0
li t2, 4628574517030027264 # 28.0
fmv.d.x ft0, t2
feq.d t1, ft1, ft0
xori t1, t1, 1
and t0, t0, t1
.L7:
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
