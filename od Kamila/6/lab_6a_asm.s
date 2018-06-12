#----------------------------------------------------------------
# Funkcja do programu lab_6a - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

	.text
	.type facta, @function
	.globl facta	

facta:
	pushl %ebp		#PROLOG funkcji
	movl %esp, %ebp		#esp-wskaznik stosu, wskazuje na koniec, gdy zrobimy pushl
                        #wskaznik przesuwa sie do gory, zeby sie tam zmiescily nasze dane
                        #pop dziala w druga strone
                        #4(%esp)==esp+4
                        #ebp-uzywamy do wskazywania gdzie chcemy
                        #ale tam moze cos byc, dlatego zaczynamy program od pushl %ebp

	subl $4, %esp		#przesuwamy wskaznik stosu, aby zrobic miejsce dla zmiennych lokalnych

	movl 8(%ebp), %eax	#mozemy sie bez trudu odw do potrzebnych wartosci bo ebp jest odp zakotwiczony
				
	cmpl $1, %eax
	jbe f_1			#jump if below or equal

	movl %eax, -4(%ebp)	#zmienna lokalna nr 1
	dec %eax

	pushl %eax
	call facta
	addl $4, %esp		#"usuwamy arg ze stosu"

	mull -4(%ebp)		#mnozymy eax przez zmienna lokalna, wynik w eax
	jmp f_e

f_1:	
    movl $1, %eax

f_e:	
    movl %ebp, %esp		#odwracamy PROLOG funkcji: EPILOG FUNKCJI
	popl %ebp
	ret
				#jak usunac arg funkcji?? nie sa one nam do niczego potrzbne
				#po prostu przesuwamy wskaznik esp o odp ilosc bajtow
				#funkcja zwraca wartosc znajdujaca sie w eax
				