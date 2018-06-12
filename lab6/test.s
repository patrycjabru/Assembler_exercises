#----------------------------------------------------------------
# Funkcja do programu lab_6b - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------

	.type suma, @function
	.globl suma

suma:	
    mov %rsi, %rax
    add %rdi, %rax
    add %rdx, %rax
    ret


