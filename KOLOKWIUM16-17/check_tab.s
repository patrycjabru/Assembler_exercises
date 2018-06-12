 
#miejsce na zmienne
.data 

#miejsce na kod
.text
.type check_tab, @function #deklaracja funkcji
.global check_tab #deklarujemy nasza funkcje jako globalna(punkt startowy programu)

check_tab:
    #rdi - tab*, rsi - n, rdx - max*
    
    movq    $0, %rax    #ustawiam na zero wartość wyjściową
    mov     %rdi, %r9   #aktualny wskaźnik na komórkę tablicy
   
    movq    %rsi, %r14  #zachowujemy ilość elemetów tablicy
petla:
    cmp     $0, %rsi    #sprawdzamy licznik
    je      przygotowanie
    
    movq    $1, %rbx     #nasza "jedynka" którą będziemy wpisywać
    mov     (%r9), %rcx  #zapisujemy aktualną komórkę tablicy w cl
    
    cmp     $31, %rcx
    jl      podwojne
    dalej1:
    
    shl     %cl, %rbx    #przesuwamy "jedynkę" na odpowiednią pozycję
    or      %rbx, %rax   #wpisujemy jedynkę do wyniku
    add     $4, %r9     #zwiększamy iterator tablicy
    dec     %rsi        #zmniejszamy licznik
    
    jmp petla
    
    
podwojne:
    shl     $31, %rbx
    sub    $31, %cl
    jmp     dalej1

przygotowanie:
    movq    %r14, %rsi
    movq    $0, %r14    #ilość wystąpień maksymalnej liczby
    movq    $0, %r15    #liczba która wystąpiła najwięcej razy
dalej:
    
    cmp     $0, %rsi
    je      koniec
    
    mov     %rsi, %r10  #w r10 nowy pod-iterator
    mov     %rdi, %r11  #w r11 nowy pod-wskaźnik do tablicy
    movq    $1, %r13    #licznik wystąpień danej liczby
    dec     %rsi        #zmiejszamy licznik
    mov     (%rdi), %r12 #aktualna liczba
    add     $4, %rdi
    petla2:
        cmp     $0, %r10
        je      sprawdz
        dec     %r10
        
        add     $4, %r11
        mov     (%r11), %r9
        

        
        cmp     %r9, %r12
        je      dodaj
        wroc:
        
        
        jmp     petla2
        
sprawdz:
    cmp     %r13, %r14  #dana liczba i maksymalna liczba (ilość wystąpień)
    jl      zamien
    jmp     dalej
    
zamien:
    mov     %r13, %r14
    mov     %r12, %r15
    jmp     dalej
        
dodaj:
    inc     %r13
    jmp     wroc
        
        
    


koniec:   
    mov     %r14, (%rdx)
	ret	#wyjscie z funkcji




 
