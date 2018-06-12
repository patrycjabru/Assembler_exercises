#----------------------------------------------------------------
# Program LAB_3.S - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_3.o lab_3.s
#  To link:    ld -o lab_3 lab_3.o
#  To run:     ./lab_3
#
#---------------------------------------------------------------- 

	.equ	kernel,	0x80
	.equ	exit,	0x01
	.equ	stdout,	0x01
	.equ	write,	0x04
	.equ	dig0,	'0'

#----------------------------------------------------------------

	.data

table:					# table of items
	.long	10,70,50,90,60,80,40,20,0,30,15	#elementy tablicy oddzielamy ',', etykieta do pierwszego elementu
count:					# count of items
	.long	( . - table ) >> 2	#'.' - adres bierzacej pozycji, w trakcie kompilowania, tu:etykieta count
					#mamy wielkosc w bajtach, zeby miec ilosc el musimy podzielic przez wielk el (4)
					#mozemy  tez, jak tu, przesunac w prawo
events:	
	.long	0
item:	
	.string	"Item "
line_no:	
	.string	"   "
itemval:	
	.string	" = "
number:	
	.string	"     \n"
before:	
	.string	"\nBefore:\n"
after:	
	.string	"\nAfter:\n"
dataend:

	.equ	item_len, before - item
	.equ	bef_len, after - before
	.equ	aft_len, dataend - after

#----------------------------------------------------------------

	.text
	.global _start

_start:
	NOP
	MOVL	$write,%eax	# display message
	MOVL	$stdout,%ebx
	MOVL	$before,%ecx
	MOVL	$bef_len,%edx
	INT	$kernel

	CALL	disp_table	# display content of table

	CALL	do_something	# do something with table

	MOVL	$write,%eax	# display message
	MOVL	$stdout,%ebx
	MOVL	$after,%ecx
	MOVL	$aft_len,%edx
	INT	$kernel

	CALL	disp_table	# display content of table

	MOVL	events,%ebx	# exit program
	MOVL	$exit,%eax
	INT	$kernel

#----------------------------------------------------------------
#
#	Function:	do_something
#	Parameters:	none
#

	.type do_something,@function

do_something:				#sort babelkowe
	MOVL	count,%edx		# outer loop counter
	MOVL	$0,events
outer:		
	DEC	%edx
	XOR	%esi,%esi		# data index
	MOV	%edx,%ecx		# inner loop counter
inner:		
	MOVL	table(,%esi,4),%eax
	CMPL	table+4(,%esi,4),%eax
	JBE	noswap
	XCHGL	table+4(,%esi,4),%eax
	MOVL	%eax,table(,%esi,4)
	INCL	events
noswap:		
	INC	%esi			# next element
	LOOP	inner			# { ecx--; if( ecx ) goto inner }
	CMPL	$1,%edx
	JNZ	outer

	RET

#----------------------------------------------------------------
#
#	Function:	disp_table
#	Parameters:	none
#

	.type disp_table,@function

disp_table:
	XOR	%esi,%esi		# data index, zerujemy index tablicy
	MOVL	count,%ecx		# data count

disp_item:
	PUSH	%rcx
	
	MOVL	table(,%esi,4),%ebx	# get data; adres pierw el, %esi-index, 4-wielkosc elementu
					#z table(esi*4) pobieramy element
	CALL	make_string		# convert to string

	MOVL	$write,%eax		# call write function
	MOVL	$stdout,%ebx
	MOVL	$item,%ecx		#!!!wyk ecx!!, petla nieskonczona
	MOVL	$item_len,%edx
	INT	$kernel

	POP	%rcx
	INC	%esi			# next element; esi++
	LOOP	disp_item		# { ecx--; if( ecx ) goto disp_item } !!!! wykorzystanie ecx!!!!

	RET				# return to main program

#----------------------------------------------------------------
#
#	Function:	make_string
#	Parameters:	%esi - index of element
#			%ebx - value of element
#

	.type make_string,@function

make_string:
	MOVL	$0x20202020,number	#zerujemy(zamieniamy na spacje) 4(pierwsze) bajty zmiennej number
	MOVW	$0x2020,line_no
	MOV	%esi,%eax		# convert index of table element to string
	MOVL	$line_no + 2,%edi	#w line_no pojawi sie index tablicy w formie znakowej
					#'+2' bo to miejsce ostatniego znaku indexu
	CALL	n2str

	MOV	%ebx,%eax		# convert value of table element to string
	MOVL	$number + 4,%edi	#w edi arg miejsce ost cyfry wyniku
	CALL	n2str

	RET				# return to disp_table function

#----------------------------------------------------------------
#
#	Function:	n2str
#	Parameters:	%eax - value
#			%edi - address of last character
#

	.type n2str,@function
n2str:				#zmieniamy liczby na stringi, uzywajac systemu 10.
	PUSH	%rbx		# save register on stack, zeby zachowac wartosc, co by nam nie znikly przy dzieleniu
				#rbx,rdx (zamiast ebx,edx), bo musimy wsadzac, zdejmowac odpowiednia wielkosc
	PUSH	%rdx		# save register on stack
	MOVL	$10,%ebx	# divisor in EBX, dividend in EAX
nextdig:			
				#przy dzieleniu potrzebujemy 64bit dzielna, potrzebujemy wiec dwoch rejestrow
	XOR	%edx,%edx	# EDX = 0, bardziej znaczaca czesc dzielnej
	DIV	%ebx		# EDX:EAX div EBX
				#dostaniemy w %eax iloraz, a w %edx(%dl) reszte
	ADDB	$dig0,%dl	# convert remainder(reszte) (in EDX) to character, %dl-ost bajt %edx
	MOVB	%dl,(%edi)	# *(EDI) = character (decimal digit), edi wskazuje adres gdzie zapisac zmienna w pamieci
	CMPL	$0,%eax		# quotient in EAX , warunek zakonczenia algorytmu
				#dostaniemy w eax iloraz, a w edx reszte
				#porownaj (cmp dzieli arg), jesli tak - JZ, jesli nie - dalej
	JZ	empty		#jump if zero
	DEC	%edi		# EDI--, zmniejszamy zawartosc edi, zeby kolejny znak pojawil sie przed poprzednim
				#zapis liczby dziesitnej od prawej do lewej
	JMP	nextdig		
empty:		
	POP	%rdx		# restore register from stack
	POP	%rbx		# restore register from stack

	RET			# return to make_string function

#----------------------------------------------------------------
