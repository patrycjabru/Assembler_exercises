###
# Zsumowanie elementów z przekątnej dwuwymiarowej, kwadratowej tablicy. Do funkcji jest przekazywany wskaźnik oraz "długość boku" kwadratowej tablicy.
###

	.text
	.type sumamatrix, @function
	.globl sumamatrix

sumamatrix: 
	pushl %ebp	
	movl  %esp, %ebp  	#PROLOG funkcji

	movl 12(%ebp), %ecx	#Bok	
	movl 8(%ebp), %ebx	#Wsk

	xor  %eax, %eax
	xor  %esi, %esi 	#tu wrzucimy offset
	
sumuj:
	movl (%ebx), %edx

	add  %esi, %edx	

	add  (%edx), %eax
	
	add  $4, %ebx	
	add  $4, %esi

	LOOP sumuj
	

	movl %ebp, %esp		#EPILOG FUNKCJI
	popl %ebp
	ret

