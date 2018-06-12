  //---------------------------------------------------------------
// Program lab_7b - Asemblery Laboratorium IS II rok
//
// To compile&link: gcc -o zad1 zad1.c zad1.s
// To run:          ./zad1
//
//---------------------------------------------------------------

#include <stdio.h>

long max_diff_c(long a, long b, long c, long d)
{
    long min=a;
    long max=a;
    if (b<a && b<c && b<d) min = b;
    if (c<a && c<b && c<d) min = c;
    if (d<a && d<b && d<c) min = d;
    
    if (b>a && b>c && b>d) max = b;
    if (c>a && c>b && c>d) max = c;
    if (d>a && d>b && d>c) max = d;
    
    return max-min;
}

long max_diff(long a, long b, long c, long d);


void main( void )
{
    long a = 70;
    long b = 8;
    long c = 555;
    long d = 4000;
    printf( "max_diff_c = %d max_diff = %d\n", max_diff_c(a,b,c,d), max_diff(a,b,c,d) );
}

