#----------------------------------------------------------------
# Program lab_9b.s - Asemblery Laboratorium IS II rok
#----------------------------------------------------------------
#
#   to compile & link:  gcc -m32 -lm -o lab_9b lab_9b.s
#
#----------------------------------------------------------------

#pierwiastki rownania kwadratowego
#gdybysmy chcieli zrobic program w 64-bit to roznice tylko w printf (dane w rejestrach zamiast na stosie)
#ale inne niz normalnie

	.data
two:				# constant/variable
	.long		2
a:				# coefficients of equation
	.float		1.0
b:
	.float		-1.0
c:
	.float		-2.0
delta:				# delta
	.double		0.0
x1:				# roots of eqation
	.float		0.0
x2:
	.float		0.0

coeff_fmt_str:
	.asciz	"Coefficients of equation:\nA = %lf  B = %lf  C = %lf\n"
delta_fmt_str:
	.asciz	"Delta = %lf\n"
noroots_fmt_str:
	.asciz	"No real roots\n"
oneroot_fmt_str:
	.asciz	"One double root\n"
tworoots_fmt_str:
	.asciz	"Two roots\n"
roots_fmt_str:
	.asciz	"Roots of equation:\nX1 = %lf  X2 = %lf\n"

	
	.text
	.global main
	
main:
	FINIT			# FPU initialization

				#------------------------------
				#mimo ze float (4bajty), ale musimy umiescic 8, bo printf tego wymaga dla liczby zmiennoprzecinkowej
				#dlatego i tak musimy umiescic liczby typu double
	FLDS	c		# c -> ST(0)
	SUBL 	$8, %esp	# printf needs 8 bytes for floating point number
	FSTPL 	(%esp)		# ST(0) on stack
	FLDS	b		# b -> ST(0)
	SUBL	$8, %esp	# printf needs 8 bytes for floating point number
	FSTPL	(%esp)		# x on stack
	FLDS	a		# a -> ST(0)
	SUBL	$8, %esp	# printf needs 8 bytes for floating point number
	FSTPL	(%esp)		# x on stack
	PUSHL	$coeff_fmt_str	# address of coeff_fmt_str on stack
	CALL	printf
	ADDL	$28, %esp	# 8+8+8+4=28

				#------------------------------
	FLDS	b		# b -> ST(0), S - float (short)
	FMULS	b		# b^2, instr mnozenia: wart rejestru * zmienna z pamieci
	FLDS	a		# a -> ST(0), b^2 -> ST(1)
	FMULS 	c		# ac
	FADD	%ST(0)		# 2ac
	FADD	%ST(0)		# 4ac
				# problem z odejmowaniem i dzieleniem : kolejnosc ma znaczenie
				# przewidziano to: FSUB (a-b), FSUBR (b-a), FDIV, FDIVR
				# ale lepiej (latwiej) zmienic znak i dodac
	FCHS			# -4ac, change sign
	FADDP			# b^2-4ac -> ST(0)
	FSTPL	delta		# store result in variable

				#------------------------------
	FLDL	delta
	SUBL 	$8, %esp	# printf needs 8 bytes for a double
	FSTPL 	(%esp)		# delta from ST(0) to stack
	PUSHL	$delta_fmt_str	# address of delta_fmt_str on stack
	CALL	printf
	ADDL	$12, %esp	# 8+4=12

				#------------------------------
	FLDZ			# 0 -> ST(0)	
	FLDL	delta		# delta -> ST(0), 0 in ST(1)
	FCOMI	%ST(1)		# delta ? 0
	FFREE	%ST(1)		# free ST(1), zwolnienie pamieci rejestru
	FFREE	%ST(0)		# free ST(0)
	JZ	zero
	JNC	greater_0	#nie wystapilo przeniesienie

less_0:				#------------------------------
	PUSHL	$noroots_fmt_str	# address of noroots_fmt_str on stack
	CALL	printf
	ADDL	$4, %esp	# only address so 4 bytes
	JMP 	the_end

zero:				#------------------------------
	PUSHL	$oneroot_fmt_str	# address of oneroot_fmt_str on stack
	CALL	printf
	ADDL	$4, %esp	# only address so 4 bytes
	JMP	compute_roots

greater_0:			#------------------------------
	PUSHL	$tworoots_fmt_str	# address of tworoots_fmt_str on stack
	CALL	printf
	ADDL	$4, %esp	# only address so 4 bytes

compute_roots:			#------------------------------
	FLDL	delta		# delta -> ST(0)
	FSQRT			# sqrt( delta ) -> ST(0)
	FCHS			# -sqrt( delta )
	FSUBS	b		# -b - sqrt( delta ) -> ST(0)
	FDIVS	a		# ( -b - sqrt( delta ) ) / a -> ST(0)
	FIDIV	two		# ( -b - sqrt( delta ) ) / 2a -> ST(0)
	FSTPS	x1		# store first root in variable
				#------------------------------
	FLDL	delta		# delta -> ST(0)
	FSQRT			# sqrt( delta ) -> ST(0)
	FSUBS	b		# -b + sqrt( delta ) -> ST(0)
	FDIVS	a		# ( -b + sqrt( delta ) ) / a -> ST(0)
	FIDIV	two		# ( -b + sqrt( delta ) ) / 2a -> ST(0)
	FSTPS	x2		# store second root in variable

				#------------------------------
	FLDS	x2		# x2 -> ST(0)
	SUBL 	$8, %esp	# printf needs 8 bytes for floating point number
	FSTPL 	(%esp)		# ST(0) on stack
	FLDS	x1		# x1 -> ST(0)
	SUBL	$8, %esp	# printf needs 8 bytes for floating point number
	FSTPL	(%esp)		# x on stack
	PUSHL	$roots_fmt_str	# address of roots_fmt_str on stack
	CALL	printf
	ADDL	$20, %esp	# 8+8+4=20

the_end:			#------------------------------
	PUSHL	$0		# the end
	CALL	exit

