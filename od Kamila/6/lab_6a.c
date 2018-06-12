//---------------------------------------------------------------
// Program lab_6a - Asemblery Laboratorium IS II rok
//
// To compile&link: gcc -m32 -o lab_6a lab_6a.c lab_6a_asm.s
// To run:          ./lab_6a
//
//---------------------------------------------------------------

#include <stdio.h>

int fact( unsigned int k )
{
	if( k <= 1 )
		return 1;
	else
		return k * fact( k - 1 );
}

void main( int argc, char* argv[] )
{
 int i;

 for( i = 1; i <= atoi(argv[1]); i++ )
   printf( "Fact(%d) = %12d FactA = %12d\n", i, fact(i), facta(i) );
}

/*
 * w systemie 32-bit parametry sa przekazywane przez stos (bo rejestry np moglyby sie skonczyc
 * -m32 zeby program byl w wersij 32-bitowej
 * 
 */