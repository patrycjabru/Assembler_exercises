#----------------------------------------------------------------
# Funkcja do programu lab_6a - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

	.text
	.type facta, @function
	.globl facta	

facta:	mov $1, %rax

	cmp %rax, %rdi
	jbe f_e

	push %rdi

	dec %rdi
	call facta

	pop %rdi

	mul %rdi

f_e:	ret

#Zwracamy w rejestrze rax
#Argumenty są liczbami całkowitymi lub wskaźnikami i jest ich nie więcej niż 6 są przekazywane w rejestrach: rdi, rsi, rcx, rdx, r8 ....
#Jeśli więcej niż 6 to kolejne znajdują się na stosie.
#Jeśli są zmiennoprzecinkowe to w innych rejestrach.
#r12 - r15 nie mogą zostać zmienione!
#Pozostałe można modyfikować
