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
	.equ	write,0x04	#write data to file function
	.equ	exit,0x01	#exit program function #numer 1 - stdout
    #equ to odpowiednik #define z C
	.data
	
starttxt:			#first message
	.ascii	"Start\n"
endtxt:				#last message
	.ascii	"Finish\n"
gurutxt:
	.ascii	"A jem assembler guru\n"	#other message

	.text
	.global _start
	
_start:
	MOVL	$write,%eax	#write first message a rejestrze eax 
	MOVL	$1,%ebx #tu ma być argument w rejestrze ebx???
	MOVL	$starttxt,%ecx #gdzie dane sie zaczynają, podajemy adres danych do rejestru ecx
	MOVL	$21,%edx #ile tych danych jest, zapisujemy w rejestrze edx
	INT	$kernel

	NOP

	MOVL	$write,%eax	#write other message
	MOVL	$1,%ebx
	MOVL	$gurutxt,%ecx
	MOVL	$21,%edx
	INT	$kernel

	NOP

	MOVL	$write,%eax	#write last message
	MOVL	$1,%ebx
	MOVL	$endtxt,%ecx
	MOVL	$10,%edx
	INT	$kernel

	NOP

theend:
	MOVL	$exit,%eax	#exit program
	INT	$kernel
