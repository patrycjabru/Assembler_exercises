#----------------------------------------------------------------
# Program lab_0c.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_0c.o lab_0c.s
#  To link:    ld -o lab_0c lab_0c.o
#  To run:     ./lab_0c
#
#----------------------------------------------------------------

	.equ	kernel,0x80	#Linux system functions entry 
				#nadanie wartosci symbolowi
	.equ	write,0x04	#write data to file function
	.equ	exit,0x01	#exit program function

	.data
	
starttxt:			#first message
	.ascii	"Start\n"	#zarezerwowac tyle miejsca ile znakow w arg
endtxt:				#last message
	.ascii	"Finish\n"
gurutxt:
	.ascii	"A jem assembler guru\n"	#other message

	.text
	.global _start
	
_start:
	MOVL	$write,%eax	#write first message, funkcja
	MOVL	$1,%ebx		#do ebx id pliku
	MOVL	$starttxt,%ecx	#tekst do ecx, adres lancucha znakow
	MOVL	$6,%edx		#liczba znakow
	INT	$kernel

	NOP			#no operation, instrukcja pusta, zabiera czas

	MOVL	$write,%eax	#write other message
	MOVL	$1,%ebx
	MOVL	$gurutxt,%ecx
	MOVL	$21,%edx
	INT	$kernel

	NOP

	MOVL	$write,%eax	#write last message
	MOVL	$1,%ebx
	MOVL	$endtxt,%ecx
	MOVL	$7,%edx
	INT	$kernel

	NOP

theend:
	MOVL	$exit,%eax	#exit program
	INT	$kernel
