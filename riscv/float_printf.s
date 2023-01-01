#include <stdio.h>
	.balign 4
	.section .text
	.global main
main:
	la 	a0, prompt
	la 	a1, _l1
	fld 	fa5, (a1)
	fsw 	fa5, (a1)
	fmv.x.d	a1, fa5
	call 	printf
	flt.s 	t0, ft0, ft1
	li 	a0, 0
	li 	a7, 93
	ecall	

	.section .data
helloworld: .ascii "Hello World\n"
prompt: .asciz "%f\n"
_l1: .double 0.5
_l2: .double 0.5
_l3: .word 0

