 #miejsce na zmienne
.data 
#miejsce na kod
.text
.type encode, @function #deklaracja funkcji
.global encode #deklarujemy nasza funkcje jako globalna(punkt startowy programu)

encode:
    #rdi - buf, rsi - mask, rdx - operation, r15 - character
    mov     %rdi, %rax
    mov     %rcx, %r15 
    add     $48, %r15
    #sprawedzanie operacji 
    cmp     $1, %rdx
    je      usunCyfre
    cmp     $2, %rdx
    je      transpozycja
    cmp     $3, %rdx
    je      podmien
    jmp     nic
    
    
usunCyfre:
    movq    $1, %r8     #zapisujemy "jedynkę", którą będziemy sprawdzać maskę
    movq    $0, %rbx
    movb    (%rdi), %bl #zapisujemy poszególną cyfrę ze stringa do %rbx
    inc     %rdi        #przesuwamy wskaźnik

    cmp     $0, %rbx     #sprawdzamy koniec stringa
    je      koniec
    
    sub     $48, %rbx    #konwersja znaku na liczbe

    movb    %bl, %cl    #przenosimy z rbx do cl
    shl     %cl, %r8    #przesuwamy "1" o odpowiednią ilość znaków
    and     %rsi, %r8   #sprawdzamy bit odpowiadający danej cyfrze
    cmp     $0, %r8
    je      usunCyfre
    
    mov     %rdi, %r10  #wskaźnik wewnątrz pętli do przesuwania
    dec     %r10        #wskazuje teraz na aktualny element
    mov     %rdi, %r11  #drugi wskaźnik ma być do przodu względem pierwszego
    cmp     $0, (%rdi)
    jne     petla1
    movb    $0, (%r10)
    jmp     usunCyfre
    
    petla1:
        cmp     $0, (%r11)
        je      wstawZeroNaKoniec
        
        movb     (%r11), %bl    #rejestr pomocniczy przy kopiowaniu
        movb     %bl, (%r10)
        inc     %r10
        inc     %r11
        
        jmp petla1

    wstawZeroNaKoniec:
        movb    $0, (%r10)
        jmp     usunCyfre

transpozycja:
    movq    $1, %r8         #zapis "jedynki"
    movq    $0, %rbx        #zerowanie rejestru rbx 
    movb    (%rdi), %bl     #zapis kolejnego znaku do rbx 
    inc     %rdi            #inkrement wskaźnika
    
    cmp     $0, %rbx        #sprawdzamy koniec stringa
    je      koniec
    
    sub     $48, %rbx       #konwersja na liczbę
    
    movb    %bl, %cl        #przenosimy z rbx do cl
    shl     %cl, %r8        #przesuwamy "1" o odpowiednią ilość znaków
    
    
    and     %rsi, %r8 
    
    cmp     $0, %r8
    je      transpozycja
        
    movb    $9, %r10b
    sub     %cl, %r10b
    
    add     $48, %r10b
    
    
    dec     %rdi
    movb    %r10b, (%rdi)
    inc     %rdi
    
    jmp     transpozycja


podmien:
    movq    $1, %r8         #zapis "jedynki"
    movq    $0, %rbx        #zerowanie rejestru rbx 
    movb    (%rdi), %bl     #zapis kolejnego znaku do rbx 
    inc     %rdi            #inkrement wskaźnika
    
    cmp     $0, %rbx        #sprawdzamy koniec stringa
    je      koniec
    
    sub     $48, %rbx       #konwersja na liczbę
    
    movb    %bl, %cl        #przenosimy z rbx do cl
    shl     %cl, %r8        #przesuwamy "1" o odpowiednią ilość znaków
    
    
    and     %rsi, %r8 
    
    cmp     $0, %r8
    je      podmien
    
    dec     %rdi
    movb    %r15b, (%rdi)
    inc     %rdi
    
    jmp     podmien

nic:
    
    
koniec:
	ret	#wyjscie z funkcji




 
