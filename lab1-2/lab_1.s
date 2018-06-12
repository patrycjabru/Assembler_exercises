#----------------------------------------------------------------
# Program lab_1.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_1.o lab_1.s
#  To link:    ld -o lab_1 lab_1.o
#  To run:     ./lab_1
#
#----------------------------------------------------------------

	.equ	write_64, 1	# write data to file function (64bit)         #napis musi być w pamięci
    .equ	exit_64, 60	# exit program function (64bit)
	.equ	stdout, 0x01	# handle to stdout

	.data
	
starttxt:			# first message
	.ascii	"Start\n"                       #rezerwacja miejsca w pamięci na napis
endtxt:				# second message
	.ascii	"Finish\n"
arg1:				# first argument
	.byte		1                           #rezerwacja miejsca o rozmiarze 1 bajta
arg2:				# second argument
	.word		2                           #rezerwacja miejsca o rozmiarze 2 bajtów
arg3:				# third argument
	.long		3                           #rezerwacja miejsca o rozmiarze 4 bajtów
result:				# result
	.long		0	

	.equ	startlen, endtxt - starttxt     #equ to coś jak #define - przypisuje wartość do wyrażenia, endtxt - adres początu następnego napisu, starttxt - adres początku pierwszego napisu
	.equ	endlen, arg1 - endtxt
 
	.text
	.global _start
	
_start:
	MOV	$write_64,%rax                     #Uogólniona instrukcja przeniesienia danych z jednego miejsca w drugie. Ostatnia litera polecania (lub jej brak) mówi jaka porcja danych ma być przeniesiona. Jeśli z argumentu (rejestru) wynika co mamy przenieść to suffix można sobie darować. 
	MOVQ	$stdout,%rdi              #rejesstry mają określoną wielkość 
	MOV	$starttxt,%rsi
	MOVQ	$startlen,%rdx        #8 bajtów
	SYSCALL                       #wywołanie funkcji systemu operacyjnego

	NOP

	MOVB	arg1,%al              #movb - 1 bajt
	MOVW	arg2,%bx              #movw - 2 bajty
	MOVL	arg3,%ecx             #4 bajty
	ADD	%ebx,%eax                 #wynik zostanie zapisany w drugim argumencie
	SUB	%ecx,%eax
	MOVL	%eax,result           #przeniesienie wyniku do result

	NOP

	MOV	$write_64,%rax
	MOVQ	$stdout,%rdi
	MOV	$endtxt,%rsi
	MOVQ	$endlen,%rdx
	SYSCALL

	NOP

theend:
	MOV	$exit_64,%rax
	SYSCALL

