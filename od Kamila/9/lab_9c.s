#----------------------------------------------------------
# Funkcja do programu lab_9c
#
# Compute Pi (Leibniz formula) using SSE instructions
#----------------------------------------------------------

#SIMD - single instr multi-data
#SSE - umozliwia SIMD, nowy twor
# rejestry XMMn 128-bit => mozna naraz wiele danych przetrawiac
#printf w 64-bit korzysta z rejestrow XMM, w przypadku liczby zmiennoprzecinkowych

#probujemy wyznaczyc pi, wyk Leibniz'a: 1-1/3+1/5-1/7+....=pi/4

	.data
	.align 16

denom:	
	.double	1.0, 3.0	# first & second denominators
numer:	
	.double	4.0, -4.0	# first & second numerators
add4:	
	.double	4.0, 4.0	# difference between denominators
zero:	
	.double	0.0, 0.0	# sums starting values

	.text
	.type fun_a, @function
	.global fun_a

	
				#liczyby po dwa skladniki, uzywamy dwoch sum
fun_a:
	shr $1, %rdi		# two terms are computed in parallel
	inc %rdi		# half of iterations is enough

	movdqa	denom, %xmm6	# denominators to xmm6
	movdqa	numer, %xmm2	# numerators to xmm2, tu liczymy, dlatego kopia w xmm4
	movdqa	add4, %xmm3	# differences to xmm3
	movdqa	%xmm2, %xmm4	# numerators to xmm4
	movdqa	zero, %xmm5	# zeros to xmm5

next:
	divpd	%xmm6, %xmm2	# xmm2 /= xmm6
	addpd	%xmm2, %xmm5	# xmm5 += xmm2
	movdqa	%xmm4, %xmm2	# xmm2 = xmm4, przywracamy org liczniki
	addpd	%xmm3, %xmm6	# xmm6 += xmm3, zwiekszamy mianowniki

	dec %rdi
	jnz next

	haddpd	%xmm5, %xmm5	# horizontal sums of low & high parts
	movsd	%xmm5, %xmm0	# low part to xmm0

	ret			# that's all

