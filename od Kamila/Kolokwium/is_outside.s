#is_outside(x,a,b)
#
# Funkcja zwraca:
# 1 jeżeli x>max(a,b)
# -1 jeżeli x<min(a,b)
# 0 jeżeli x>=min(a,b) & x<=max(a,b) (czyli po prostu w innym wypadku)
#rej: rdi, rsi, rdx, rcx


    .text
    .type is_outsidea, @function
    .global is_outsidea
    
is_outsidea:
    cmp %rsi, %rdx          #porownujemy a z b
    ja  cmpX
    
    mov %rsi, %rcx
    mov %rdx, %rsi
    mov %rcx, %rdx
    
cmpX:                   #na tym etapie w rdx mamy max(a,b), zaczynamy badac jak sie do nich ma x
    cmp %rdi, %rsi
    ja  minX            #x < min(a,b)
    
cmpX2:
    cmp %rdi, %rdx
    jb  maxX            #x>max(a,b)
    
    mov $0, %rax
    ret

minX:
    mov $(-1), %rax
    ret
    
maxX:
    mov $1, %rax
    ret
    
