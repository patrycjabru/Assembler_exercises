
	.equ char,8
	.equ switch,12
	
	.text
	.type usun,@function
	.global usun
	
	usun:
		PUSHL %ebp
		movl %esp,%ebp
		XORL %eax,%eax
		movl char(%ebp),%esi
		movl %esi,%edi
		movl switch(%ebp),%ecx
		
		movl $0,%ebx
		
		petla:
			LODSB
			
			CMPB $0,%al
			je koniec
		
			CMPB $' ',%al
			je spacja
			XOR %ebx,%ebx
			#INC %al
			#ORB	$0x20, %al
			#movb $'c',%al
			#ANDB $0x20,%al
			jmp skip
			
			
			
		
		
		spacja:
			CMP $0,%ebx
			jbe jedna_spacja
			INC %ebx
			jmp loop
			
		jedna_spacja:
			INC %ebx
			
		skip:
			STOSB
		
		loop:
			jmp petla
		
		koniec:
			STOSB
			MOVL char(%ebp),%eax
			popl %ebp
			ret
		
		
		
	
