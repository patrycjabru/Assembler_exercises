#dane
.data
.equ a,8
.equ b,12
.equ c,16

.text
.type great,@function
.global great

#funkcja porównuje wartości z rejestrów eax i ebx, w eax przechowywana jest aktualnie największa liczba, w ebx liczba z nią porówywana
great:
#prolog funkcji
   pushl %ebp
   movl %esp,%ebp
   
#przenoszenie argumentów a i b do rejestrów eax i ebx w celu porównania
   movl a(%ebp),%eax
   movl b(%ebp),%ebx
   
   #porównanie
   cmpl %eax,%ebx
   jge b_wieksze #jeżeli b >= a, to skok do etykiety b_wieksze

#w przeciwnym przypadku (a > b) skok do porównania z c, aktualnie w rejestrze eax jest a, czyli aktualna wartość maksymalna
a_wieksze:
   jmp porownanie_c

#jezeli b >= a to b wstawiamy do rejestru eax jako największe i skaczemy do etykiety porownania z c
b_wieksze:
   movl b(%ebp),%eax
   jmp porownanie_c

#porównanie aktualnie największej liczby z c
porownanie_c:
   #przeniesienie c do rejestru ebx w celu porównania wartości z eax, w którym przechowywany jest aktualny max
   movl c(%ebp),%ebx
   #porównanie zawartości rejestrów eax (max) z ebx (c)
   cmp %eax,%ebx
   jge c_wieksze #jezeli c >= max to następuje skok do etykiety, w której wartość c jest przenoszona do eax, jako nowy max
   jmp koniec #w przeciwnym przypadku skok do etykiety kończącej program, wartość największa jest w eax

c_wieksze:
   #przeniesienie c do rejestru eax jako największa liczba w celu zwrócenia
   movl c(%ebp),%eax
   jmp koniec #skok bezwarunkowy do etykiety kończącej program
   
#w rejestrze eax znajduje się największa wartość, która zostanie zwrócona do programu w C
koniec:
#epilog funkcji
   popl %ebp

#powrót do programu w C
   ret
