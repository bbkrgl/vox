#include <stdio.h>
	.balign 4
	.section .text
	.global main
main:
	la 	a0, prompt
	li 	t2, 4607182418800017408 # 1.0
	fmv.d.x ft0, t2
	fmv.x.d	a1, ft0
	mv 	a1, sp
	call 	printf
	flt.s 	t0, ft0, ft1

	li 	a0, 0
	li 	a7, 93
	ecall	

	.section .data
helloworld: .ascii "Hello World\n"
prompt: .asciz "%d\n"
_l1: .double 0.5
_l2: .double 0.5
_l3: .word 0

