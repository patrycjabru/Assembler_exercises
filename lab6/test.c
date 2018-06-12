//---------------------------------------------------------------
// Program lab_6b - Asemblery Laboratorium IS II rok
//
// To compile&link: gcc -o test test.c test.s
// To run:          ./test
//
//---------------------------------------------------------------

#include <stdio.h>

long long sumc( unsigned int a, unsigned int b, unsigned int c )
{
    return (a+b+c);
}

long long suma( unsigned int a, unsigned int b, unsigned int c);

void main( void )
{
    unsigned int a = 2;
    unsigned int b = 24;
    unsigned int c = 32;
    printf("SumC: %d\n",sumc(a,b,c));
    printf("SumA: %d\n",suma(a,b,c));
}
