 #miejsce na zmienne
.data 

#miejsce na kod
.text
.type encode, @function #deklaracja funkcji
.global encode #deklarujemy nasza funkcje jako globalna(punkt startowy programu)

encode:
    #rdi - buf, rsi - mask, rdx - operation, rcx - character
    mov %rdi, %rax
    movb (%rdi), %r9b
    movb %r9b, (%rdi)
koniec:
	ret	#wyjscie z funkcji




 
