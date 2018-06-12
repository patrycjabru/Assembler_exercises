
.text
.type generate_str, @function
.global generate_str	


generate_str:
    #rdi - s, rsi - c, rdx - n, rcx - inc
    #rsp - góra stosu
	push	%rbp #zapisujemy stos
	mov	%rsp,%rbp 
	
	movq	%rdi,%rax # przepisujemy wskaznik do stringa do rejestru ktory jest 'zwracany'
	xchgq	%rdx,%rcx # zamieniamy miejscami %rcx i %rdx bo potrzebujemy licznik petli w %rcx
	
	petla:
	movq	%rsi,(%rdi) # zapisujemy stringa z argumentu c do zarezerwowanej przestrzeni
	incq	%rdi # przesuwamy wskaznid do zarezerwowanej przestrzeni o jedej znak
	cmpq	$0,%rdx # sprawdzamy argument inc
	je	inc_0 # inc == 0 ->inc_0
	add	$1,%rsi # inc != 0 to inkrementujemy c
	inc_0:
	loop	petla

	

	mov	%rbp,%rsp 
	pop	%rbp # przywracamy pierwotny stan stosu
ret #wyjscie z funkcji






#generate_str:
    #rdi - s, rsi - c, rdx - n, rcx - inc, r8, r9 -args
    #rax - ret
#    mov %rdi, %rax;
    
#    cmp $0, %rcx
#    je flagZero
#    jmp flagNonZero
    
    
#flagZero:
#loop1:
#    mov %rsi, (%rdi)
#    add $8, %rdi
#    dec %rdx
#    cmp $0, %rdx
#    jne loop1
#    ret
    
#flagNonZero:
#    ret
