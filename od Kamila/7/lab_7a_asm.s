#----------------------------------------------------------------
# Funkcja do programu lab_7a - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

#tryb 64-bit, inne przekazywanie argumentow
#bardziej wykorzystywane rejestry niz stos pamieci
#8 nowych rejestrow uniwersalnych, ale i tak moze ich braknac
#mozna sobie radzic roznie
#arg przekazywane [rzez rejestry: RDI, RSI, RDX, RCX, R8, R9
#kolejne arg laduja po kolei (od lewej)
#nadmiarowe (od 7) laduja na stosie, jak w 32-bit, albo przy uzywaniu zmiennych lokalnych
#rejestry ktore istnialy wczesniej sa czescia nowych rejestrow, nowe rejestry:R8..R15
## aby przyspieszyc: pod CISC jest RISC, miedzy: tlumaczenie mikrokodem, na ciag prostszych instrukcji
## zrobiono tak zeby zachowac kompatybilnosc wsteczna
#zwracana wartosc znajduje sie w RAX

	.text
	.type facta, @function
	.globl facta	

facta:	mov $1, %rax 	#tam bedzie wynik

next:	cmp $1, %rdi	#porownujemy arg, nie musimy sie bawic stosem
	jbe f_e
	mul %rdi	#mnozymy rax * rdi, wynik w rax
	dec %rdi
	jmp next

f_e:	ret

