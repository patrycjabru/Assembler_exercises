#----------------------------------------------------------------
# Program lab_0b.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_0b.o lab_0b.s
#  To link:    ld -o lab_0b lab_0b.o
#  To run:     ./lab_0b
#
#----------------------------------------------------------------

	.data
	
dummy:				# some data
	.byte	0x00

	.text
	.global _start		# entry point
	
_start:
	MOV	$1, %eax	# exit function; mov=funkcja przeniesienia, 1.arg-zrodlowy, 2.arg-docelowy, $-stala
				#najpierw musimy przeniesc do rej eax funkcje, ktora chcemy przerwac
				#funkcja numer $1 to funkcja przerwania programu
				#nast wywolujemy przerwanie numer 80
	INT	$0x80		# system interrupt, trzeba podac numer przerwania (każdy numer odpowiada za coś innego)
				#eax-rejestr odpowiadajacy za to, co chcemy przerwać
				#gdyby byly jeszcze jakies instr to one sie nie wykonaja (ale skompiluja)
