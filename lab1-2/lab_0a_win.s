#----------------------------------------------------------------
# Program lab_0a.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#  To compile: as -o lab_0a.o lab_0a.s
#  To link:    ld -o lab_0a lab_0a.o
#  To run:     ./lab_0a
#
#----------------------------------------------------------------
# od # komentarze
# wyrażenia zaczynające się kropką - dyrektywy assemblera

	.data              # jakieś dane
	
dummy:				   # some data # etykieta (adres tam, gdzie ma być wartość 00 na starcie), działa trochę jak nazwa zmiennej.
	.byte	0x00       # Rezerwujemy miejsce o rozmiarze 1 bajt i nadalejemy wartość, te wartoci pojawiają się w momencie startu programu.

	.text              # Oznacza że tutaj zaczyna się kod programu, pozwala na ochronę kodu przed modyfikacją.
	.global _start	   # entry point # Oznacza, że symbol wymieniony jako argument tej dyrektywy jest globalny. Musi być globalny, aby program uruchomić. 
	
_start:                # etykieta (tożsama z adresem)
	JMP	_start
