
	.equ char,8
	.equ c,12
	.equ n,16
	.equ inc,20
	
	.text
	.type gen,@function
	.global gen
	
	gen:
		push %rbp
		mov %rsp,%rbp
	
		
		mov char(%rbp),%rsi
		mov %rsi,%rdi
		
		xorl %eax,%eax
		xorl %ebx,%ebx
		xorl %ecx,%ecx
		xorl %edx,%edx	
		
		movb c(%rbp),%bl
		
		movl inc(%rbp),%edx
		
		mov n(%rbp),%ecx
		
		
		
		loop:
			mov %bl,%al
			ADD %edx, %ebx
			STOSB
		
		LOOP loop
		movl char(%rbp),%eax
		
	theend:
		STOSB
		
		pop %rbp
		ret
