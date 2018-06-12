
.text
.type bit2, @function
.global bit2

bit2:
	push %rax
	
bit3:
	cmp $0, %rsi
	jz end
	shr %rsi
	jnc ein
	inc %rdi	
	jmp bit3
ein:
	movb (%rdi), %bl
	movb %bl, (%rax)
	inc %rax
	inc %rdi
	jmp bit3
	
	
end:
	pop %rax
	ret
