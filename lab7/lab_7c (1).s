#----------------------------------------------------------------
# Funkcja do programu lab_7b - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

	.type mina, @function
	.global mina

mina:	
    #rdi - a,rsi - b,rdx - c
cmpAwithB:              #porownaj a z b
    cmp %rdi, %rsi      
    ja cmpAwithC        #jeżeli a<b to porównaj a z c
    
cmpBwithC:              #jeżeli a>b to porównaj b z c
    cmp %rsi, %rdx      #porównujemy b z c 
    ja retB             #jeżeli b<c to zwróć b
    
retC:                   #w przeciwnym wypadku (b>c a>b) zwróć c
    mov %rdx, %rax
    ret
retB:
    mov %rsi, %rax
    ret
cmpAwithC:              #a<b to porównaj a z c
    cmp %rdi, %rdx      #porównujemy a z c
    ja retA             #jeśli a jest mniejsze to zwróć a
    jmp retC            #w przeciwnym wypadku zwróć c
retA:
    mov %rdi, %rax
    ret
    
