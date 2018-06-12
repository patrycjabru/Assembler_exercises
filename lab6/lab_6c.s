#----------------------------------------------------------------
# Program lab_6c.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile&link: gcc -o lab_6c lab_6c.s
#  To run: 	    ./lab_6c
#
#----------------------------------------------------------------

	.data
fmt:
	.asciz	 "Value = %ld\n"
value:
	.quad	15
	
	.text
	.global main
	
main:
    push %rax
	mov value, %rsi
	mov $fmt, %rdi
	mov $0, %rax
	call printf

	mov $0,%rdi
	call exit

	#W rax liczba rejestrów zmiennoprzecinkowych - w tym wypadku 0, bo wyświetlamy liczbę całkowitą
	#Printf dostaje dwa argumenty: liczbę i łańcuch znaków. Liczba jest w rsi, łańcuch w rdi.
	#Kolejna wartość powinna być w rejestrze rdx, a później w rcx, r8, r9. Kolejne na stosie.
	
	#Kod zakończenia w rejestrze rdi. 
