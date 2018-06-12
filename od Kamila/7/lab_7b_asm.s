#----------------------------------------------------------------
# Funkcja do programu lab_7b - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

	.type fiba, @function
	.globl fiba

fiba:	
	mov $0, %rbx
	mov $1, %rcx	

	cmp %rbx, %rdi		#czy liczymy dla 0?
	jz	f_0
	cmp %rcx, %rdi		#czy liczymy dla 1?
	jz	f_1

next:				#petla typu do while (spr warunek po petli), bo spec warunki obslugujemy wczesniej
	mov %rbx, %rax		#pierwszy wyraz przenosimy do rax
	add %rcx, %rax		#dodajemy drugi wyraz
	mov %rcx, %rbx		#aktualizacja wynikow
	mov %rax, %rcx
	dec %rdi		#zmniejszenie arg
	cmp $1, %rdi		#spr warunku arg>1
	ja next	

f_e:	ret

f_0:
	mov %rbx, %rax
	jmp f_e

f_1:
	mov %rcx, %rax
	jmp f_e
