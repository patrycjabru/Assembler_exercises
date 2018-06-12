.text
.type sum, @function
.global sum

sum:
	PUSHL %ebp
	MOVL %esp, %ebp

	MOVL 8(%ebp),%eax
	MOVL 12(%ebp),%ebx

	#eax = ecx, c = a 
	MOVL %eax, %ecx

	#edx = ebx, d = b
	MOVL %ebx, %edx
	
	#d+c = a + b, wynik w ecx
	ADD %edx,%ecx
	#b - a, wynik w ebx
	SUB %eax,%ebx
	#a*b ze znakiem, wynik zapisywany do eax
	IMUL %edx

	CMP %eax, %ebx
	JG b_wieksze
	CMP %eax, %ecx
	JG c_wieksze
	JMP koniec

b_wieksze:
	CMP %ebx, %ecx
	JMP c_wieksze
	#ustawienie wyniku B jako najwiekszego
	MOVL %ebx, %eax
	JMP koniec

c_wieksze:
	MOVL %ecx, %eax

koniec:
	MOVL %ebp,%esp
	POPL %ebp
ret
