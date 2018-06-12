#max of a, b, c
#rej: rdi, rsi, rdx, rcx
#wynik:rax

    .text 
    .type maxa, @function
    .global maxa
    
maxa:
    mov     %rdi, %rax      #na pozatku pierwsza liczba jest najwieksza, przenosimy ja do rax(wynik)
    cmp     %rax, %rsi      #porownujemy pierwsza liczbe z druga
    jb      cmp2            #jesli druga liczba jest mniejsza to w rax juz jest max(a,b), mozna porownywac z c
           
    mov     %rsi, %rax      #jesli druga liczba byla wieksza to ona teraz jest naszym maximum w rax
    
cmp2:   
    cmp     %rax, %rdx      #porownujemy max(a,b) z c
    jb      fun_ret     
    
    mov     %rdx, %rax      #c bylo najwieksze
    
fun_ret:                    #powrot z funkcji
    ret
