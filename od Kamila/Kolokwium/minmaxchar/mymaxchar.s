.data
	.equ a,8
	.equ b,12
	.equ c,16
	.equ ident,20
	
	.text
	.type max,@function
	.global max
	
	max:
		pushl %ebp
		movl %esp,%ebp
		
		
		movl a(%ebp),%eax
		movl b(%ebp),%ebx
		movl c(%ebp),%ecx
		movl ident(%ebp),%edx
		
		cmpl %eax,%ebx
		jg b_wieksze
		
		cmpl %eax,%ecx
		jg c_wieksze
		movl $97, %ebx
		movl %ebx,(%edx)
		
		jmp theend
		

		b_wieksze:
			movl %ebx,%eax
			cmpl %eax,%ecx
			jg c_wieksze
			movl $'b', %ebx
			movl %ebx,(%edx)
			jmp theend
		
		c_wieksze:
			movl %ecx,%eax
			movl $99, %ebx
			movl %ebx,(%edx)
			jmp theend
		
		
		theend:
			popl %ebp
			ret
