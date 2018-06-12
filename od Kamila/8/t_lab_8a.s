#----------------------------------------------------------------
# Program lab_8a.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
# Tworzenie pliku wykonywalnego:
#	gcc -m32 -o t_lab_8a t_lab_8a.s
#
#----------------------------------------------------------------

#pobieranie arg przez program z lini polecen
#program umieszcza arg na stosie(od gory): argc, argv[], 0, env[],0 : kazda wart ma 4 bajty
#argc - wartosc, argv i env - wskazniki
#arhv[0] - nazwa programu
#nie wiemy ile jest arg, musimy uzyc petli while, uzywamy do tego 0, ktore sa jak wskazniki null
#aby zczytac odp ilosc argv uzywamy argc, do zczytywania wart zmiennych lokalnych (env) konieczne jest koncowe 0
#nie uzywamy gcc, bo nie zaczyna sie od main, uzywamy as bo zaczyna sie od _start
#ale as & ld nie sa tak inteligentne, trzeba podawac biblioteki
#

	.data
argc:
	.asciz "argc = %d\n"
args:
	.asciz "%s\n"
sep:
	.asciz "----------------------------\n"

	.text
	.global main

main:
				#skoro jest main to mamy esp 'wycelowany' gdzie indziej
				#wyzej, bo nizej obszar jest zajety
				#na wierzcholku jest adres powrotu z funkcji main
				#do naszego kodu dolaczanu jest start-up code:
				#dolaczone biblioteki itp , wywolanie call main
				#klasycznie przez jump, ale main inaczej
				#jak sie dobrac tam gdzie chcemy?
				#nie wiemy ile jest tych smieci
				#funkcja main moze miec arg, program z zewnatrz nie wie czy program je chce, 
				#wiec zawsze je wsadza na stos(na gore)
				
	

	mov 4(%esp), %ecx	# argc is here

	push %ecx
	pushl $argc
	call printf		# display value of argc
				#printf wyswietla wartosc ze stosu
				#dwa parametru: wielkosc i wartosc (?)
				#po wywolaniu trzeba je usunac
	add $4, %esp
	pop %ecx

	movl 8(%esp),%ebp		# use ebp as a pointer
#	addl $4, %ebp		# address of argv[0]
next:
	pushl %ecx		# preserve counter

	pushl (%ebp)
	pushl $args
	call printf		# display value of argv[i]
	addl $8,%esp

	popl %ecx		# restore counter

	addl $4,%ebp		# address of argv[i+1]
	loop next

	pushl $sep
	call printf		# display separator
	addl $4,%esp

	movl 12(%esp),%ebp		# skip zero/NULL
next1:
	cmpl $0,(%ebp)		# is env[i] == NULL
	je finish		# yes

	pushl (%ebp)		# no
	pushl $args
	call printf		# displays value of env[i]
	addl $8,%esp

	addl $4,%ebp		# address of env[i+1]
	jmp next1

finish:
	pushl $0		# this is the end...
	call exit

