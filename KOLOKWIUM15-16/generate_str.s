
.text
.type generate_str, @function
.global generate_str	


generate_str:
    #rdi - s, rsi - c, rdx - n, rcx - inc
    #rsp - góra stosu

    mov %rdi, %rax
	
	cmp $0, %rcx
	je zero
	jmp niezero
	
zero:
    cmp $0, %rdx
    je koniec
    mov %rsi, (%rdi)
    inc %rdi
    dec %rdx
    jmp zero
    
niezero:
	cmp $0, %rdx
    je koniec
    mov %rsi, (%rdi)
    inc %rdi
    inc %rsi
    dec %rdx
    jmp niezero
	
koniec:# przywracamy pierwotny stan stosu
    movb $0, (%rdi)
    ret #wyjscie z funkcji






