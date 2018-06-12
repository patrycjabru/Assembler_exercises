#----------------------------------------------------------------
# Program lab_0a.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_0a.o lab_0a.s
#  To link:    ld -o lab_0a lab_0a.o
#  To run:     ./lab_0a
#
#----------------------------------------------------------------
				#dyrektywy(z . przed),
	.data			#od tego momentu deklaracje danych
	
dummy:				# some data
	.byte	0x00		#deklaraja typu(jakby), adres, gdzie dane(ale jakie?), nie ma kontroli typu
				#tu: rezerwujemy miejsce o rozmiarze 1byte, nadajemu mu wart 0
				#odwolujemy sie do danych przez etykiety(symbol od literki, koniec :)
				#etykieta = adres, tu:etykieta dummy:

	.text			#skonczyl sie obszar danych, teraz bedzie kod
	.global _start		# entry point
				#wskazuje elementy globalne, tu:_start, etykieta do poczatku programu (trzeba wskazac)
				#sys operac musi widziec zeby ogarnac
				#_start = main(w C)
	
_start:
	JMP	_start		#skok bezwarunkowy, arg = miejsce gdzie, tu:_start
				#ten program bedzie sie krecil w kolko
				#procesor pobiera zawartosc, interpretuje, po skompletowania danych akcja jest wykonywana
				#tu: wykonuje skok, i tak w kolko(pobiera i wykonuje), nie ma go jak zatrzymac
				#gdyby dac cos innego to procesor czytal by to, co jest w nast komorce pamieci(niezaleznie co tam jest)
				#czyli zaczalby cos magicznego sobie wykonywac skads tam
				#dzieki temu skokowi zabezpieczamy proc przed "spacerami"
