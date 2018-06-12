#----------------------------------------------------------------
# Program lab_9a.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#   to compile & link:  gcc -m32 -lm -o lab_9a lab_9a.s
#
#----------------------------------------------------------------

#obliczenia zmiennoprzecinkowe
#nowy typ, pojawil sie pozno -> inna komunikacja
#jednostka zlozona z 8 rejestrow (w stosie)
#long, double - 10 bajtow, rozna precyzja i zakres
#std: dokl 80 bitow, mozna wymusic 32bit (float)
#rejestry nie maja sztywnych nazw, a polozenie wzgledem wyroznionego rejestru
#wierzcholek stosu: ST(0), kolejne: ST(1), ST(2) itd
#stos jest zapetlony: 8 danych a pozniej nadpisuje
#stos powiazany z ONP
#jakbysmy chcieli 10 bajtow to rezerwujemy dyrektywa space

#liczymy pierwiastki na dwa sposoby, poprzez instrukcje
# i poprzez wzor Newtona: a(K+1) = 1/2 (aK + x/aK), a0=x
#metody sa zbiezne

#zadanie domowe, spr zbieznosci metody, poprzez dodanie zmiennej zwiekszanej przy petli
# okaze sie ze jest szybko zbiezna

	.data
i:				# loop counter
	.long		1
x:				# function argument
	.double		0.0	# 8 bajtow; float (4 bajty)
				# jakbysmy chcieli 10 bajtow to rezerwujemy dyrektywa space
sqr_a:				# function result
	.double		0.0
sqr_b:				# function result
	.double		0.0
two:				# constant
	.long		2
fmt_str:
	.asciz	"Square root of %lf = %.20lf\n"

	
	.text
	.global main
	
main:
	FINIT			# FPU initialization, init jedn zmiennoprzecinkowej
				#czysci rejestry, std tryb pracy, wsk stosu na pierwszy rejestr
next:
	FILD	i		# i -> ST(0),  F - floating point, I - int, LD - load
				#po wczytaniu robi sie zmiennoprzecinkowe
	FSTPL	x		# ST(0) -> x & pop from stack, ST - store,P - pop, L - double; S - float
				#------------------------------
	FLDL	x		# function argument -> ST(0)
	FSQRT			# sqrt( ST(0) ) -> ST(0)
	FSTPL	sqr_a		# ST(0) -> sqr_a  & pop from stack
				#------------------------------
	FLDL	sqr_a		# load & display first result
	CALL	disp		# mamy policzony pierwszy pierwiastek
	
				#------------------------------
	FLDL	x		# first approximation (a0) -> ST(0)
iter:	FLDL	x		# function argument -> ST(0), ak in ST(1)
	FDIV	%ST(1), %ST(0)	# ST(0)/ST(1) -> ST(0)    x/ak
	FADD	%ST(1), %ST(0)	# ST(0)+ST(1) -> ST(0)    ak+x/ak
	FIDIV	two		# ST(0)/two -> ST(0)      (ak+x/ak)/2
				# uzywamy zmiennej two, bo jedn zmiennoprzecinkowa nie zezwala na uzycie stalej
				# inaczej musielibysmy policzyc wart w jedn zmiennop.
				# jest instr ktora wczytuje 0, albo 1, pi, e, ale nie dwa: 1+1 = 2
	FCOMI	%ST(1)		# ST(1) ? ST(0) : ak ? ak+1
				# porownujemy, wynik w znacznikach proc
	FSTP	%ST(1)		# ST(0) -> ST(1) & pop from stack
				# juz nie potrzebujemy a0
	JNZ	iter		# test of convergence, jump if not zero, aK == a(K+1) => koniec iteracji
	FSTPL	sqr_b		# ST(0) -> sqr_b & pop from stack
				#------------------------------
	FLDL	sqr_b		# load & display second result
	CALL	disp
	INCL	i		# next argument, zwiekszamy i
	CMPL	$10, i		# enough ?, spr czy chcemy jeszcze liczyc pierwiastki
	JBE	next
				#------------------------------
	PUSHL	$0		# the end
	CALL	exit
	

	.type	disp, @function	# printf( fmt_str, x, ST(0) )
disp:
				#printf potrzebuje dane na stosie w odp kolejnosci
				# 
	SUBL 	$8, %esp	# printf needs 8 bytes for floating point number
				# proc nie dalby rady wrzucic tego na raz
	FSTPL 	(%esp)		# ST(0) on stack
	FLDL	x
	SUBL	$8, %esp	# printf needs 8 bytes for floating point number
	FSTPL	(%esp)		# x on stack
	PUSHL	$fmt_str	# address of fmt_str on stack
	CALL	printf
	ADDL	$20, %esp	# 8+8+4=20, usuwamy niepotrzebe rzeczy ze stosu
	RET

