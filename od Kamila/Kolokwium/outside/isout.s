

.data
	.equ x,8
	.equ a,12
	.equ b,16
.text
.type out,@function
.global out

	out:
		pushl %ebp
		movl %esp,%ebp
		
		movl a(%ebp),%eax
		movl b(%ebp),%ebx
		movl x(%ebp),%ecx
		
		
		cmpl %eax,%ebx
		jg b_wieksze
		jmp a_wieksze
		
		
	b_wieksze:
		xchgl %eax,%ebx
		
	a_wieksze:
		cmpl %eax,%ecx
		jg x_max
		
		cmpl %ebx,%ecx
		jl x_min
		
		movl $0,%eax
		jmp theend
		
		
		
	x_min:
		movl $-1,%eax
		jmp theend
		
	x_max:
		movl $1,%eax
		jmp theend
		
		
	theend:
		popl %ebp
		ret
		
