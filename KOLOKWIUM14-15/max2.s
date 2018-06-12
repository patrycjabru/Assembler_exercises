 
#miejsce na zmienne
.data 

#miejsce na kod
.text
.type max2, @function #deklaracja funkcji
.global max2 #deklarujemy nasza funkcje jako globalna(punkt startowy programu)

max2:
    #rdi - a, rsi - b
    movq    $0, %rax
    
suma:
    mov     %rdi, %r8
    mov     %rsi, %r9
    add     %r9, %r8        #w r8 suma
    
iloczyn:
    mov     %rdi, %r10
    mov     %rsi, %r11
    imul     %r11, %r10     #w r10 iloczyn

    
roznica:
    sub     %rsi, %rdi      #w rdi roznica
    
max:
    mov     %r8, %rax       #suma w rax
    cmp     %rax, %r10
    jg      zwrocIloczyn
    dalej:
    
   
    
    cmp     %rax, %rdi
    jg      zwrocRoznice
    jmp     koniec
    
zwrocIloczyn:
    mov     %r10, %rax
    jmp     dalej
    
zwrocRoznice:
    mov     %rdi, %rax

koniec:    
	ret	#wyjscie z funkcji




