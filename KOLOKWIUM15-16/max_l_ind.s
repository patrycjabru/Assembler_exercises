 
.data
    
.text
.type max_l_ind, @function
.global max_l_ind	

max_l_ind:
    #rdi - tab*, rsi - n, rdx - even_count*, rcx - neg_count*, r8, r9 -args
    #rax - ret
	push	%rbp #zapisujemy stos
	mov	%rsp,%rbp 
	
	mov %rsi, %r9  #zapisujemy ilosć elementów tablicy
	movq    $0, %rax   #zerowanie wartości zwracanej
	
	putValuesOnStack:
    push	(%rdi)
    add     $8, %rdi
    dec     %r9
    cmp     $0, %r9
    jne     putValuesOnStack
    
    #decq	%rdi
    movq     $0, (%rdx)
    movq     $0, (%rcx)       #ustawia na 0 zmienne even_count i neg_count
    movq     $0, %r8
    
    mov      %rsi, %r9
getFromStack:
    pop     %r10
    cmp     $0, %r10
    jl      incNeg
modPart:                   #modulo part
    mov     %r10, %r11
    and     $1, %r11
    cmp     $0, %r11
    je      incEven
onesPart:
    #liczba w r10
    mov $0, %r15        #licznik jedynek
    shifting:
        mov     %r10, %r13      #przepisuje liczbę do rejestru r13
        and     $1, %r13        #oblicza modulo 2 z liczby
        cmp     $1, %r13        #porównuje obliczone moduo z 1
        je      incOnesCounter  #jeśli tak - zwiększ licznik jedynek (r15)
        shift:
        shr     $1, %r10
        cmp     $0, %r10
        jne     shifting
        jmp     checkIfGreater
    incOnesCounter:
        inc     %r15
        jmp     shift           #skocz do dalszej części pętli shifting
    checkIfGreater:
        cmp     %r8, %r15
        jg      change
        jmp     checkLoopCounter
        
    change:
        mov %r15, %r8
        mov %r9, %rax
checkLoopCounter:
    decq    %r9
    cmp     $0, %r9
    jg      getFromStack
    jmp     end
    
incNeg:
    incq     (%rcx) 
	jmp     modPart
incEven:
    incq     (%rdx)
    jmp     onesPart
    
end:



    
	mov	%rbp,%rsp 
	pop	%rbp # przywracamy pierwotny stan stosu
ret #wyjscie z funkcji
