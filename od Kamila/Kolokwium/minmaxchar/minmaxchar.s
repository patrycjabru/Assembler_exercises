.data

.text

.global max

max:
pushl %ebp
movl %esp, %ebp

movl 8(%ebp), %eax #a
movl 12(%ebp), %ebx #b
movl 16(%ebp), %ecx #c
movl 20(%ebp), %edx #adres ident

cmp %eax, %ebx
ja a_mniejsze_b #! a>b
cmp %eax, %ecx
ja a_b_mniejsze_c #! a>c i a>b
movl $97, %ebx
movl %ebx, (%edx)
jmp koniec

a_mniejsze_b: #a<b
cmp %ebx, %ecx
ja a_b_mniejsze_c #! b>a i b>c
movl %ebx, %eax
movl $98, %ebx
movl %ebx, (%edx)
jmp koniec

a_b_mniejsze_c: #a<b<c
movl %ecx, %eax
movl $99, %ebx
movl %ebx, (%edx)
jmp koniec

koniec:
movl %ebp, %esp
popl %ebp
ret
