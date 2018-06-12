 
#miejsce na zmienne
.data 

#miejsce na kod
.text
.type fun, @function #deklaracja funkcji
.global fun #deklarujemy nasza funkcje jako globalna(punkt startowy programu)

fun:
    #rdi - buf, rsi - a, rdx - b
    mov     %rdi, %rax
    
pierwszy:
    mov     (%rsi), %bl
    mov     %bl, (%rdi)
    inc     %rdi
    inc     %rsi
    
drugi:
    mov     (%rdx), %bl
    mov     %bl, (%rdi)
    inc     %rdi
    inc     %rdx
    
porownaj:
    cmp     $0, (%rsi)
    je      porownajDrugi
    cmp     $0, (%rdx)
    je      koniec
    jmp     pierwszy
    
#porownajPierwszy:
#    cmp     $0, (%rdx)
#    je porownajDrugi
    
porownajDrugi:
    cmp     $0, (%rsi)
    je      koniec
    jmp     drugi
    
koniec:    
	ret	#wyjscie z funkcji




