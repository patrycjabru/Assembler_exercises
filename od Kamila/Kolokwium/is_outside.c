// int is_outside(int x, int a, int b)
//
// Funkcja zwraca:
// 1 jeżeli x>max(a,b)
// -1 jeżeli x<min(a,b)
// 0 jeżeli x>=min(a,b) & x<=max(a,b) (czyli po prostu w innym wypadku)

//gcc -o is_out is_outside.c is_outside.s

#include <stdio.h>

void main (int argc, char* argv[])
{
    int i = atoi(argv[1]),
        j = atoi(argv[2]),
        k = atoi(argv[3]);    
   printf("Is outside x, a, b : %d \n",is_outsidea(i,j,k));
}

