#----------------------------------------------------------------
# Program lab_4a.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_4a.o lab_4a.s
#  To link:    ld -o lab_4a lab_4a.o
#  To run:     ./lab_4a
#
#----------------------------------------------------------------
				##NOWE FUNKCJE! 
	.equ	kernel,	0x80	# Linux system functions entry
	.equ	create,	0x08	# create file function
	.equ	close,	0x06	# close file function
	.equ	write,	0x04	# write data to file function
	.equ	exit,	0x01	# exit program function
	.equ    stderr,	0x02
	.equ	mode,	0x1FF	# attributes for file creating 0x180=0600
				#w systemie jest maska praw dostepu, dlatego mamy ograniczenia
				#trzeba by zmienic umask na 000 zeby robic co chcemy

	.equ	errval,	2

	.data
	
file_n:				# file name (0 terminated)
	.string	"testfile.txt"	#rozni sie od ascii: zawiera bajt 0
				#ktory wyznacza koniec ciagu znakow (potrzebne do funk create i open)
				#moznaby uzyc ascii, ale trzeba dolozyc 0

file_h:				# file handle
	.long		0

txtline:			# text to be written to file
	.ascii	"A line of text\n"

txtlen:				# size of written data
	.long		( . - txtline )

errmsg:				# file error message
	.ascii	"File error!\n"

errlen:
	.long		( . - errmsg )

allokmsg:			# All OK message
	.ascii	"\nAll is OK - too hard to believe!\n"

alloklen:
	.long		( . - allokmsg )

	.text
	.global _start
	
_start:
	NOP
	MOVL	$create,%eax	# create function
	MOVL	$file_n,%ebx	# EBX points to file name
	MOVL	$mode,%ecx	# mode of created file in ECX
	INT	$kernel		#zwraca file_handle (l.calk ident plik) do %eax
	
	CMP	$0,%eax		#compare, jump if lower
	JL	error		# if EAX<0 then something went wrong

	MOVL	%eax,file_h	# store file handle returned in EAX

	MOVL	$write,%eax	# write function
	MOVL	file_h,%ebx	# file handle in EBX
	MOVL	$txtline,%ecx	# ECX points to data buffer
	MOVL	txtlen,%edx	# bytes to be written
	INT	$kernel		#write tez moze wyrzucic blad: 
				#l.zapisanych bajtow!=l.bajtow do zapisu

	CMP	%edx,%eax
	JNZ	error		# if EAX<>EDX then something went wrong

	MOVL	$close,%eax	# close function
	MOVL	file_h,%ebx	# file handle in EBX
	INT	$kernel		#jak wiele funkcji, gdy blad ustawia najbardziej znaczacy bit

	CMP	$0,%eax
	JL	error		# if EAX<0 then something went wrong

all_ok:
	MOVL	$write,%eax	# write function
	MOVL	$stderr,%ebx	# file handle in EBX
	MOVL	$allokmsg,%ecx	# ECX points to All OK message
	MOVL	alloklen,%edx	# bytes to be written
	INT	$kernel

	XOR	%ebx,%ebx
	JMP	theend

error:
	MOVL	$write,%eax	# write function
	MOVL	$stderr,%ebx	# file handle in EBX
	MOVL	$errmsg,%ecx	# ECX points to file error message
	MOVL	errlen,%edx	# bytes to be written
	INT	$kernel

	MOVL	$errval,%ebx

theend:
	MOVL	$exit,%eax	# exit program function
	INT	$kernel
