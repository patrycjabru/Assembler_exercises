#----------------------------------------------------------------
# Program lab_1.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_1.o lab_1.s
#  To link:    ld -o lab_1 lab_1.o
#  To run:     ./lab_1
#
#----------------------------------------------------------------

	.equ	kernel,0x80	#Linux system functions entry
	.equ	write,0x04	#write data to file function
	.equ	exit,0x01	#exit program function
	.equ	stdout,0x01	#handle to stdout

	.data
	
starttxt:			#first message
	.ascii	"Start\n"
endtxt:				#second message
	.ascii	"Finish\n"
arg1:				#first argument
	.byte		1	#.byte:miejsce 1bajtu
arg2:				#second argument
	.word		2	#.word:rezerwuje miejsce 2 bajtow
arg3:				#third argument
	.long		3	#.long:miejsce 4 bajtow
result:				#result
	.long		0	

.equ	startlen, endtxt - starttxt		#2.arg- wyrazenie(zwykle sa stale):odejmujemy etykiety(adresy),
						#odejmujac adresy kolejnych zmiennych dostajemy dlugosc(wielkosc) pierwszego elementu
						#warunek: dane sa umieszczane w pamieci w kolejnosci deklaracji, i nie ma przerw
.equ	endlen, arg1 - endtxt
 
	.text
	.global _start
	
_start:
	MOVL	$write,%eax			#1.blok:wypisanie pierwszego tekstu
	MOVL	$stdout,%ebx
	MOVL	$starttxt,%ecx
	MOVL	$startlen,%edx
	INT	$kernel
	NOP					#nic nie robi, pojawi sie w kodzie maszynowym, mozna odetchnac(posprawdzac)
						#al-rejestr 8bitowy, bx-rejestr 16bitowy,mozemy naprawic bledy kompilacji zmieniajac argumenty
						#nie jest to dobry sposob(mamy rozne smiecie), ew mozna wyzerowac
						#kazdy rejestr sklada sie z ew mniejszych porcji ecx=(16bitow)+cx=(16bitow)+cl+(8bit)=(16bitow)+(8bit)+ch
	XOR	%eax,%eax
	XOR	%ebx,%ebx
	MOVB	arg1,%al			#2.blok:przetwarzanie danych
	MOVW	arg2,%bx			#MOVx: x-sufixy okreslajace wielkosc przenoszonych danych(czasem niekonieczne, ale lepiej)
	MOVL	arg3,%ecx			#przenosimy dane do rejestrow, zeby sprawniej sie do nich dostawac, przy operacjach
						#poza tym, niektorych operacji dwuarg nie da sie wykonac gdy oba arg w pamieci
						#$:musi byc przed nie zmienna, jesli mamy symbol do danej w pamieci(zmiennej)-$skutkuje uzykasniem adresu
	ADD	%ebx,%eax			#ten z lewej:arg zrodlowy. ten drugi:docelowy, rezultat nadpisuje jeden z elementow; eax+=ebx
	SUB	%ecx,%eax			#analogicznie: eax-=ecx
	MOVL	%eax,result
	NOP
	MOVL	$write,%eax			#3.blok:wypisanie ost tekstu
	MOVL	$stdout,%ebx
	MOVL	$endtxt,%ecx
	MOVL	$endlen,%edx
	INT	$kernel
	NOP
theend:						#4.blok:zakonczenie pracy
	MOVL	$exit,%eax
	INT	$kernel
