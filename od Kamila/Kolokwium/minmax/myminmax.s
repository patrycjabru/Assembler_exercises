.data
	.equ arg1,8
	.equ arg2,12
	.equ arg3,16
	
.text
.type great,@function
.global great

great:
		pushl %ebp
		movl %esp, %ebp
	 
		movl arg1(%ebp),%eax
		movl arg2(%ebp),%ebx
		
		
		cmp %eax,%ebx
		jg b_wieksze
		movl arg3(%ebp),%ebx
		
		cmp %eax,%ebx
		jg c_wieksze
		jmp theend
	 
	 b_wieksze:
		movl %ebx, %eax
		movl arg3(%ebp),%ebx
		cmp %eax,%ebx
		jg c_wieksze
		jmp theend
		
		
	c_wieksze:
		movl %ebx,%eax
		
	 
	 
	 theend:
		movl %ebp, %esp
		popl %ebp
	
		ret
	
                                                   ,
