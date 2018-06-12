#miejsce na zmienne
.data 

#miejsce na kod
.text
.type fun, @function #deklaracja funkcji
.global fun #deklarujemy nasza funkcje jako globalna(punkt startowy programu)

	fun:
	push	%rbp #zapisujemy stos
	mov	%rsp,%rbp 
	
	movq	%rdi,%rax # przenosimy wskaznik na buf do rejestru z wynikiem
	
	petla:
	movzbl	(%rsi),%ebx # przenosimy a[i] do ebx
	cmpb	$0,%bl # sprawdzamy czy a[i] to koniec stringa
	je	koniec_1 # jesli tak to dopisujemy do buf reszte b
	movb	%bl,(%rdi) # jesli nie to przepisujemy a[i] do buf[j]
	
	incq	%rsi # zwiekszamy wskaznik po a (i++)
	incq	%rdi # zwiekszamy wskaznik po buf (j++)
	
	movzbl	(%rdx),%ebx # przenosimy b[k] do ebx
	cmpb	$0,%bl # sprawdzamy czy b[k] to koniec stringa
	je	koniec_2 #jesli tak to dopisujemy do buf reszte a
	movb	%bl,(%rdi) # jesli nie to przepisujemy b[k] do buf[j]
	
	incq	%rdx # zwiekszamy wskaznik po b (k++)
	incq	%rdi # zwiekszamy wskaznik po buf (j++)
	jmp	petla
	
	koniec_1: # petla analogiczna do powyzszej przepisujaca reszte b do buf
	movzbl	(%rdx),%ebx
	cmpb	$0,%bl
	je	koniec
	movb	%bl,(%rdi)
	
	incq	%rdx
	incq	%rdi
	jmp	koniec_1

	koniec_2: #petla analogiczna do powyzszej przepisujaca reszte a do buf
	movzbl	(%rsi),%ebx
	cmpb	$0,%bl
	je	koniec
	movb	%bl,(%rdi)
	
	incq	%rsi
	incq	%rdi
	jmp	koniec_2
	
	koniec:
	#mov	%rbp,%rsp 
	pop	%rbp # przywracamy pierwotny stan stosu
	ret	#wyjscie z funkcji




