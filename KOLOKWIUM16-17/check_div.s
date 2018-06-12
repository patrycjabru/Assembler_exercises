 
#miejsce na zmienne
.data 

#miejsce na kod
.text
.type check_div, @function #deklaracja funkcji
.global check_div #deklarujemy nasza funkcje jako globalna(punkt startowy programu)

check_div:
    #rdi - a, rsi - b, rdx - c
    #ax - co dzielę
    #bx - przez co
    #div bx
    #wynik w ax-całość, dx-modulo
    
    cmp     $0, %rdx
    je      zero

    
    movq    $64, %rbx    #licznik 
    movq    $0, %r9      #tu zapisywanie wyniku
niezero:
    cmp     $0, %rbx
    je      przepiszWynik
    
    mov     %rdi, %rax   #a do rax
    movq    $0, %rdx
    div     %rbx
    dec     %rbx
    cmp     $0, %rdx
    je      dopiszJeden
    jmp     dopiszZero
    
dopiszJeden:
    shl     $1, %r9
    or      $1, %r9
    jmp     niezero

dopiszZero:
    shl     $1, %r9
    jmp     niezero
    
zero:
    mov     %rdi, %rax  #a do rax
    mov     %rsi, %rbx  #b do rbx
    
    div     %rbx
    
    cmp     $0, %rdx
    je      zwroc1
    movq    $0, %rax
    jmp     koniec

zwroc1:
    movq    $1, %rax
    jmp koniec
    
    
przepiszWynik:
    mov     %r9, %rax
koniec:    
	ret	#wyjscie z funkcji




