# int sum(int a, int b);
# Suma liczb od mniejszego z parametrow (a, b) do wiekszego z tych parametrow. Np. Dla 3 i 5 fukcja zwraca 3+4+5

#rej: rdi, rsi, rdx, rcx; wynik: rax

    .text
    .type suma, @function
    .global suma
    
suma:
    mov $0, %rax            #poczatek sumy: 0->wynik
    
    cmp %rdi, %rsi          #sprawdzamy ktora z zadanych liczb jest wieksza
    ja  fun
    
    mov %rdi, %rdx
    mov %rsi, %rdi
    mov %rdx, %rsi
    
fun:                        #na tym etapie max (a,b) jest w rsi
    add %rdi, %rax          #dodajemy mniejsza z liczb
    inc %rdi                #zwiekszamy liczbe, ktora dodajemy
    cmp %rdi, %rsi          #sprawdzamy czy liczby juz sa rowne (warunek przerwania petli)
    jae  fun
    
    ret                     #powrot z funkcji
