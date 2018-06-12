
	
	.data
		.equ arg1,8
		.equ arg2,12
		
	.text
	.type sum,@function
	.global sum
	
	sum:
		pushl %ebp
		movl %esp,%ebp
		
		movl arg1(%ebp),%eax
		movl arg2(%ebp),%ebx
		cmp %eax,%ebx
		jg b_wieksze
		xchgl %eax, %ebx
		
	b_wieksze:
		xorl %ecx,%ecx
		movl %ebx,%ecx
		subl %eax,%ecx 
		
	loop:
		addl %eax,%ebx
		incl %eax
		
		Loop loop
	koniec:
		movl %ebx,%eax
		popl %ebp
		
		ret
