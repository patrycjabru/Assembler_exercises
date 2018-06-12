

.text
.type bit, @function
.global bit

bit:
	push %rax
	
bit2:
	cmp $0, %rdi
	jz end
	shr %rdi
	jnc ein
	inc %rdx	
	jmp bit2
ein:
	movb (%rdx), %bl
	movb %bl, (%rax)
	inc %rax
	inc %rdx
	jmp bit2
	
	
end:
	pop %rax
	ret
