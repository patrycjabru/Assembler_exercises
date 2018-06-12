#include <stdio.h>
#include <stdlib.h>


unsigned long check_div(long a, long b, long c);

void main( void )
{
    long a = 10;
    long b = 1;
    long c = 10;
    unsigned long wynik = check_div(a,b,c);
    int tab[64];
    for (int i = 63; i>=0; i--) {
        tab[i] = wynik % 2;
        wynik = wynik/2;
    }
    printf( "check_div = ");
    for (int i = 0; i< 64; i++) {
        printf("%d",tab[i]);
    }
    printf( "\n");
}

