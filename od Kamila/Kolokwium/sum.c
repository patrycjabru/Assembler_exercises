//int sum(int a, int b);
//Suma liczb od mniejszego z parametrow (a, b) do wiekszego z tych parametrow. Np. Dla 3 i 5 fukcja zwraca 3+4+5

#include<stdio.h>

void main (int argc, char* argv[])
{
    int a = atoi(argv[1]),
        b = atoi(argv[2]);
        
    printf("Sum from %d to %d = %d\n", a, b, suma(a,b));
}
