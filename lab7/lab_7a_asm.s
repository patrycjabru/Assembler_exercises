#----------------------------------------------------------------
# Funkcja do programu lab_7a - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

	.text
	.type facta, @function
	.globl facta	

facta:	mov $1, %rax #zapisz 1 do rax

next:	cmp $1, %rdi #rdi to parametr, porównujemy z 1
	jbe f_e          #jeżeli mniejszy lub równy to skocz na koniec
	mul %rdi         #mnożenie rdi i rax
	dec %rdi         #zmniejsz rdi
	jmp next         #skocz na początek pętli

f_e:	ret          #zwróć wartość

