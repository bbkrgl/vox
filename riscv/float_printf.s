#include <stdio.h>
	.balign 4
	.section .text
	.global main
main:
	la 	a0, prompt
	li 	t2, 4607182418800017408 # 1.0
	la 	t0, _l2
	fld ft0, (t0)
	#fmv.d.x ft0, t2
	fmv.x.d	a1, ft0
	call 	printf

	la 	a0, promptd
	li a1, 5
	la a2, _listpointer
	sd a1, (a2)
	call 	printf

	addi sp, sp, -16
	mv a1, sp
	

	li 	a0, 0
	li 	a7, 93
	ecall	

	.section .data
helloworld: .ascii "Hello World\n"
prompt: .asciz "%f\n"
promptd: .asciz "%d\n"
_l1: .double 0.5
_l2: .dword 4607182418800017408
_l4: .double 0.5, 0.4
_listpointer: .dword 0
