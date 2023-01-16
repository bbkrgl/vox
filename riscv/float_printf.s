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

	addi sp, sp, -160
	mv a2, sp
	li t0, 1
	fcvt.d.w ft0, t0
	li t1, 2
	fcvt.d.w ft1, t1
	fsd ft0, (a2)
	fsd ft1, 8(a2)
	fsd ft1, 16(a2)
	fsd ft1, 24(a2)
	fsd ft1, 32(a2)
	vsetivli t0, 10, e64
	vle64.v v0, (a2)
	
	la a0, promptd
	mv a1, t0
	call 	printf

	li 	a0, 0
	li 	a7, 93
	ecall	

	.section .data
helloworld: .ascii "Hello World\n"
prompt: .asciz "%f\n"
promptd: .asciz "%d\n"
_l1: .double 0.5
_l2: .dword 4607182418800017408
_l4: .dword 0, 0, 0, 0
_listpointer: .dword 0
