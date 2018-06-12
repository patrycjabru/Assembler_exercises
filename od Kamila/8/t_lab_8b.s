#----------------------------------------------------------------
# Program lab_8b.s - Asemblery Laboratorium IS II rok
#
# Tworzenie pliku wykonywalnego:
#	gcc -o t_lab_8b t_lab_8b.s
#	
#----------------------------------------------------------------

#tak samo jak w 32. tylko wart na stosie maja po 8 bajtow, a nie 4
#wiec uzywamy rejestrow z R, i iterujemy po 8

	.data
argc_s:
	.asciz "argc = %d\n"
args_s:
	.asciz "%s\n"
sep_s:
	.asciz "----------------------------\n"
argc:
	.quad 0			#data 8 bajtowa
argv:
	.quad 0
env: 
	.quad 0

	.text
	.global main

main:

#	mov 8(%rsp), %eax	# argc is here
	mov %rdi, argc
	mov %rsi, argv
	mov %rdx, env

	mov argc, %rsi
	mov $argc_s,%rdi
	mov $0, %al
	call printf		# display value of argc
				#w 64-bit prinft dostaje arg w rejestrach

	mov argv, %rbp		# use rbp as a pointer
#	add $8, %rbp		# *argv[] is here
	mov argc, %rcx

next:
	push %rcx		# preserve counter

	mov (%rbp), %rsi
	mov $args_s, %rdi
	mov $0, %al
	call printf		# display value of argv[i]

	pop %rcx		# restore counter

	add $8,%rbp		# address of argv[i+1]
	loop next

	mov $sep_s, %rdi
	mov $0, %al
	call printf		# display separator

	mov env, %rbp		# *env[] is here - skip zero/NULL

next1:
	cmpl $0,(%rbp)		# is env[i] == NULL
	je finish		# yes

	mov (%rbp), %rsi	# no
	mov $args_s, %rdi
	mov $0, %al
	call printf		# displays value of env[i]

	add $8,%rbp		# address of env[i+1]
	jmp next1

finish:
	mov $0,%rdi		# this is the end...
	call exit

