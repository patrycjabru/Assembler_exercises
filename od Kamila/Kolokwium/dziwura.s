.type maxdiff @function
.global maxdiff

maxdiff:
	PUSHL	%ebp		#prolog
	MOVL	%esp, %ebp	#funkcji
	MOVL	8(%esp), %eax
	MOVL	12(%esp), %ebx
	MOVL	16(%esp), %ecx
	MOVL	20(%esp), %edx
	CMP	%eax, %ebx
	JGE	check_1		#if ebx >= eax
	JB 	check_2		#if eax < ebx
check_1:
	MOVL 	12(%esp), %eax	#W eax najwieksza wartosc 
	MOVL	8(%esp), %ebx	#W ebx najmniejsza wartosc
	JMP	cont
check_2:
	MOVL	8(%esp), %eax
	MOVL	12(%esp), %ebx
	JMP	cont
cont:
	CMP	%eax, %ecx
	JGE	check_3		#if ecx >= eax
	JB	check_4		#if eax < ecx
check_3:
	MOVL	16(%esp), %eax	#Zapis nowej najwiekszej wartosci w eax, kolejne check'i analogicznie
	JMP	cont2
check_4:	
	JMP	cont2		#Jesli eax jest wiekszy niz ecx, wartosc eax nie zostaje podmieniona
				#Kolejne check'i analogicznie
cont2:
	CMP	%eax, %edx
	JGE	check_5		#if edx >= eax
	JB	check_6		#if eax < edx
check_5:
	MOVL	20(%esp), %eax
	JMP	min
check_6:
	JMP	min
min:
	CMP	%ebx, %ecx
	JBE	check_8		#if ecx <= ebx
	JG	check_7		#if ecx > ebx
check_7:	
	JMP	cont3		#Jesli ebx jest mniejsze niz ecx, wartosc eax nie zostaje podmieniona
				#Kolejne check'i analogicznie
check_8:	
	MOVL	16(%esp), %ebx	#Zapis najmniejszej wartosci w ebx, kolejne check'i analogicznie
	JMP	cont3
cont3:
	CMP	%ebx, %edx	#if edx <= ebx
	JBE	check_10	#if edx > ebx
	JG	check_9
check_9:
	JMP	end
check_10:
	MOVL	20(%esp), %ebx
	JMP	end	
end:
	SUB	%ebx, %eax	#eax = ebx - eax
	MOVL	%ebp, %esp	#epilog
	POP	%ebp		#funkcji
	RET
	