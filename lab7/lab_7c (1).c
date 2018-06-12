 //---------------------------------------------------------------
// Program lab_7b - Asemblery Laboratorium IS II rok
//
// To compile&link: gcc -o lab_7c lab_7c.c lab_7c.s
// To run:          ./lab_7c
//
//---------------------------------------------------------------

#include <stdio.h>

long long minc( unsigned int a, unsigned int b, unsigned int c )
{
    if ( a < b ) {
        if ( a < c ) return a;
        return b;
    }
    if ( b < c ) 
        return b;
    return c;
}

long long mina( unsigned int a, unsigned int b, unsigned int c );


void main( void )
{
    int a = 3;
    int b = 2;
    int c = 1;
    printf( "MinC = %ld MinA = %ld\n", minc(a,b,c), mina(a,b,c) );
}
