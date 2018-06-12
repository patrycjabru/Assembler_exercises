#----------------------------------------------------------------
# Program lab_6c.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile&link: gcc -m32 -o lab_6c lab_6c.s
#  To run: 	    ./lab_6c
#
#----------------------------------------------------------------

	.data
fmt:
	.asciz	 "Value = %d\n"
value:
	.long	15
	
	.text
	.global main
	
main:
	movl value, %eax
	pushl %eax
	movl $fmt, %ebx
	pushl %ebx
	call printf
	subl $8, %esp
	nop
	pushl $0
	call exit
