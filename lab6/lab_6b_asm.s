#----------------------------------------------------------------
# Funkcja do programu lab_6b - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

	.type fiba, @function
	.globl fiba

fiba:	push %rbp
	mov %rsp,%rbp

	sub $8,%rsp

	cmp $0, %rdi   #porównujemy z 0
	jz f_0

	cmp $1, %rdi   #porównujemy z 1
	jz f_1

	push %rdi

	sub $2,%rdi    #pomniejszone o 2  - nowy argument
	call fiba      #wywołanie funkcji rekurencyjnie
	mov %rax,-8(%rbp)  #zapisanie wyniku funkcji do zmiennej rbp

	pop %rdi       # odtwarzamy oryginalną wartość argumentu

	dec %rdi       #zmiejszamy o 1
	call fiba      #wywołanie funkcji
	add -8(%rbp),%rax  #dodajemy wynik do zmiennej lokalnej i przechodzimy do epilogu

f_e:	mov %rbp,%rsp  #zwalniamy pamięć zmiennej lokalnej rbp
	pop %rbp           
	ret                #zdjecie ze stosu adresu powrotu (powrot do głównego programu)

f_0:
	mov $0, %rax   #zwracamy 0
	jmp f_e

f_1:
	mov $1, %rax   #zwracamy 1
	jmp f_e



