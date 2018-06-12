# Gębarowski Kamil 275721

# WSZYSTKO DZIAŁA

# string A zamiennie ze stringiem B, zapisane do bufora
# RDI - bufor
# RSI - ciąg A
# RDX - ciąg B

.text
	.type combine_str, @function
	.globl combine_str

combine_str: 
	MOV   %RDI, %R8  	#przerzucamy adres początkowy RDI do rejestru pomocniczego
	
main_loop:			#główna pętla

	#literka z ciągu A
	CMPB  $0, (%RSI)
	JE    fill_with_b	#jeżeli ciąg A się skończył, wypełniamy resztę B	
	CALL  put_sign_a	#funkcja wstawiająca znak
	
	#literka z ciągu B
	CMPB  $0, (%RDX)
	JE    fill_with_a	#jeżeli ciąg B się skończył, wypełniamy resztę A		
	CALL  put_sign_b	#funkcja wstawiająca znak
	
	JMP   main_loop
	
fill_with_a:			#dopełnienie znakami z ciągu A - analogicznie jak wyżej
	CMPB  $0, (%RSI)
	JE    finish	
	CALL  put_sign_a	
	
	JMP   fill_with_a	
	
fill_with_b:			#dopełnienie znakami z ciągu B - analogicznie jak wyżej
	CMPB  $0, (%RDX)
	JE    finish	
	CALL  put_sign_b	
	
	JMP   fill_with_b
	
finish:
	MOV   $0, %RAX		
	STOSB			#dodajemy znak '\0' na koniec ciągu znaków
	
	MOV   %R8, %RAX 	#przenosimy adres początkowy RDI do RAX
	
	RET
	
	
	.type put_sign_a,@function
put_sign_a: 
	MOV   (%RSI), %RAX	#przenosimy pojedyńczy znak do RAX
	STOSB			#dopisujemy ten znak do bufora
	INC   %RSI		#przesuwamy się w tablicy A do następnego znaku
	RET
	
	.type put_sign_b,@function
put_sign_b: 
	MOV   (%RDX), %RAX	#przenosimy pojedyńczy znak do RAX
	STOSB			#dopisujemy ten znak do bufora
	INC   %RDX		#przesuwamy się w tablicy B do następnego znaku
	RET
	