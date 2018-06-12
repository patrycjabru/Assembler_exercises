#----------------------------------------------------------------
# Program LAB_5.S - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_5.o lab_5.s
#  To link:    ld -o lab_5 lab_5.o
#  To run:     ./lab_5
#
#----------------------------------------------------------------


.equ	read_64,	0x00	# read data from file function
.equ	write_64,	0x01	# write data to file function
.equ	exit_64,	0x3C	# exit program function

.equ	tooval,	-1
.equ	errval,	-2
.equ    stderr,2
.equ    stdout,1
.equ    stdin,0

	.data
	
buffer:			# buffer for file data
	.space		1024, 0
bufsize:		# size of buffer
	.quad		( . - buffer )
b_read:			# size of read data
	.quad		0
errmsg:			# file error message
	.ascii	"File error!\n"
errlen:
	.quad		( . - errmsg )
toomsg:			# file too big error message
	.ascii	"File too big!\n"
toolen:
	.quad		( . - toomsg ) 
promptmsg:
	.ascii	"String:\n"
promptlen:
	.quad		( . - promptmsg ) 
befmsg:
	.ascii	"Before:\n"
beflen:
	.quad		( . - befmsg ) 
aftmsg:
	.ascii	"After:\n"
aftlen:
	.quad		( . - aftmsg ) 

	.text
	.global _start
	
_start:
	NOP

	MOV	$write_64,%rax	# write function
	MOV	$stdout,%rdi	# file handle in RDI
	MOV	$promptmsg,%rsi	# RSI points to message
	MOV	promptlen,%rdx	# bytes to be written
	SYSCALL
	
	MOV	$read_64,%rax	# read function
	MOV	$stdin,%rdi	# file handle in RDI
	MOV	$buffer,%rsi	# RSI points to data buffer
	MOV	bufsize,%rdx	# bytes to be read
	SYSCALL

	CMP	$0,%rax
	JL	error		# if RAX<0 then something went wrong

	MOV	%rax,b_read	# store count of read bytes

	CMP	bufsize,%rax	# whole file was read ?
	JE	toobig		# probably not

	MOV	$write_64,%rax	# write function
	MOV	$stdout,%rdi	# file handle in RDI
	MOV	$befmsg,%rsi	# RSI points to message
	MOV	beflen,%rdx	# bytes to be written
	SYSCALL

	MOV	$write_64,%rax	# write function
	MOV	$stdout,%rdi	# file handle in RDI
	MOV	$buffer,%rsi	# offset to first character
	MOV	b_read,%rdx	# count of characters
	SYSCALL

	MOV	$buffer,%rsi
	MOV	%rsi,%rdi
	MOV	b_read,%rcx
	CLD
next:
	LODSB			# al := MEM[ rsi ]; rsi++ #wczytywanie danych z pamięci do rejestru. 
                    #Bez suffixu LODS. Suffixu nie można pominąć
                    #Możliwe suffixy
                    #B - rej AL
                    #W - rej AX
                    #L - rej EAX
                    #Q - rej RAX
                    
    #Zamiana wielkości liter                
    
	#CMPB	$'A', %al
	#JB skip
	#CMPB	$'Z', %al
	#JA skip
	
	#OR	$0x20, %al
	#SUB $0x20,%al   #zamienia małe litery na duże - 0x20 to 32 dziesiętnie, 20 szesnastkowo
	#Opercja iloczynu logicznego - operujemy tylko na jednym bicie
	#AND $0xDF, %al     #0xDF to 101111b w zapisie szesnastkowym 
	
	CMPB $'0', %al         #zamiana cyfr na #
	JB skip
	CMPB $'9', %al
	JBE change_digit
        
	CMPB $'A', %al         #zamiana wielkości liter
	JB skip
	CMPB $'z', %al
	JA skip
	CMPB $'Z', %al
	JBE change
	CMPB $'a', %al
	JB skip
	
	
	
change:
    XOR $0x20,%al
    JMP skip
    
change_digit:
    MOV $'#', %al
    
skip:	STOSB			# MEM[ rdi ] := al; rdi++ 
                        #wczytanie danych z rejestru do pamięci
                        #Suffixy analogicznie jak przy LODSB
	LOOP next

	MOV	$write_64,%rax	# write function
	MOV	$stdout,%rdi	# file handle in RDI
	MOV	$aftmsg,%rsi	# RSI points to message
	MOV	aftlen,%rdx	# bytes to be written
	SYSCALL

	MOV	$write_64,%rax	# write function
	MOV	$stdout,%rdi	# file handle in RDI
	MOV	$buffer,%rsi	# offset to first character
	MOV	b_read,%rdx	# count of characters
	SYSCALL

	MOV	b_read,%rdi
	JMP	theend

toobig:
	MOV	$write_64,%rax	# write function
	MOV	$stderr,%rdi	# file handle in RDI
	MOV	$toomsg,%rsi	# RSI points to toobig message
	MOV	toolen,%rdx	# bytes to be written
	SYSCALL
	MOV	$tooval,%rdi
	JMP	theend

error:
	MOV	$write_64,%rax	# write function
	MOV	$stderr,%rdi	# file handle in RDI
	MOV	$errmsg,%rsi	# RSI points to file error message
	MOV	errlen,%rdx	# bytes to be written
	SYSCALL
	MOV	$errval,%rdi

theend:
	MOV	$exit_64,%rax	# exit program function
	SYSCALL
	
	
	#ClearDirection - zeruje flagę kierunku odczytu danych
	#SetDirection - ustawia na 1 flagę kierunku
	#Jeżeli dana ma np 4 bajty to używając mov musielibyśmy o tym pamiętać. 
	
	#Na początku rdi i rsi wskazują na początek tablicy.
	#W kolejnej iteracji RSI jest zwiększany (bo znacznik kierunku = 0)
	#Po modyfikacji komórki RDI jest zwiększany.
	#RSI i RDI ponownie wskazują na to samo miejsce. 
	
	#Jeśli korzystalibyśmy z dwóch obszarów pamięci to RSI wskazywaloby na komórkę odczytywanej tablicy, a RSI na zapisywanej.
	
	#CMPS - porówananie danych w dwóch rejestracjach.
	#MOVS - przeniesienie wartości z jednego rejestru do drugiego.
	
	#REP - licznik potwórzeń w rejestrze rdx.
