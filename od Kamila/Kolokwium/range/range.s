.data
	.equ x,8
	.equ a,12
	.equ b,16
	.equ c,20
	
	.text
	.type range,@function
	.global range
	
	range:
			pushl %ebp
			movl %esp,%ebp
			
			movl x(%ebp),%eax
			movl a(%ebp),%ebx
			movl b(%ebp),%ecx
			movl c(%ebp),%edx
			
			cmpl %eax,%ebx
			jle go_b
			movl $0,%eax
			jmp theend
			
		go_b:
			cmpl %eax,%ecx
			jle go_c
			movl $1,%eax
			jmp theend
		
		go_c:
			cmpl %eax,%edx
			jle go_end
			movl $2, %eax
			jmp theend
			
		go_end:
			movl $3, %eax
	#		jmp theend
			

			
	theend:
		popl %ebp
		ret
