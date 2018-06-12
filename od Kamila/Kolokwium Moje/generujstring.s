## Ma generować stringa złożonego z n znaków c. Jeśli inc = 0 znaki mają być takie same, w przeciwnym przypadku znaki mają się zwiększać o 1. s jest buforem do zapisania wygenerowanego stringa, miejsce na niego powinno być zarezerwowane w programie w C
## char * generate_str(char * s, int c, int n, int inc);

	.text
	.type generate_str, @function
	.globl generate_str

generate_str: 
	pushl %ebp	
	movl  %esp, %ebp  	#PROLOG funkcji
	
	CALL  exec	

	movl  %ebp, %esp		#EPILOG FUNKCJI
	popl  %ebp
	ret


.type exec,@function
exec: 
	mov   8(%ebp), %esi
	mov   %esi,%edi		#przenosimy wskaźnik do esi
	mov   %edi, %edx

	mov   12(%ebp), %eax	#do eax przerzucamy znak, który być może będzie się zmieniał
	mov   16(%ebp), %ecx	#n dla loopa

loop:
	STOSB			#przenosimy 1 znak z eax do esi
	
	CMP   $0, 20(%ebp)	#sprawdzamy, czy zwiększyć znak o 1
	JE    lend
	ADD   $1, %eax
lend:
	LOOP   loop
	
	mov   %edx, %eax        #przenosimy adres początkowy edi do eax	

	ret

