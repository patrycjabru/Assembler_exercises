####
## mamy 4 liczby, ma zwrócić różnicę max i min
####

	.text
	.type maximin, @function
	.globl maximin

#NA ODWRÓT SA NA STOSIE! ALE I TAK DZIAŁA

maximin: 			#MAX - eax, MIN - edx
	pushl %ebp	
	movl  %esp, %ebp  	#PROLOG funkcji

	MOVL 20(%ebp), %edx
	cmpl %edx, 16(%ebp)
	JA   bmax

	MOVL 20(%ebp), %eax
	MOVL 16(%ebp), %edx	
	JMP  cmaxtest
	
bmax:
	MOVL 16(%ebp), %eax
	MOVL 20(%ebp), %edx

cmaxtest:
	cmpl %eax, 12(%ebp)
	JA   cmax

	cmpl %edx, 12(%ebp)
	JB   cmin
	JMP  dmaxtest

cmax:
	MOVL 12(%ebp), %eax	
	JMP dmaxtest

cmin:
	MOVL 12(%ebp), %edx

dmaxtest:
	cmpl %eax, 8(%ebp)
	JA   dmax

	cmpl %edx, 8(%ebp)
	JB   dmin
	JMP  final
dmax:
	MOVL 8(%ebp), %eax	
	JMP  final

dmin:
	MOVL 8(%ebp), %edx
	
final:
	SUB  %edx, %eax 

	movl %ebp, %esp		#EPILOG FUNKCJI
	popl %ebp
	ret
