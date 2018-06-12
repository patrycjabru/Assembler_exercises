#miejsce na zmienne
.data 

#miejsce na kod
.text
.type suma, @function #deklaracja funkcji
.global suma #deklarujemy nasza funkcje jako globalna(punkt startowy programu)

suma:
    #rdi - wsk, rsi - bok
    movq    $0, %rax
    movq    $0, %r9         #przesunięcie w wierszu
    
    petla:
    mov     (%rdi), %r8     #wskaźnik do pierwszego wiersza
    add     %r9, %r8
    add     (%r8), %rax
    add     $8, %rdi
    add     $4, %r9
    dec     %rsi
    cmp     $0, %rsi
    je      koniec
    jmp     petla
    

koniec:    
	ret	#wyjscie z funkcji




