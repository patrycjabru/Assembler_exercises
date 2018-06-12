//---------------------------------------------------------------
// Program lab_6b - Asemblery Laboratorium IS II rok
//
// To compile&link: gcc -m32 -o lab_6b lab_6b.c lab_6b_asm.s
// To run:          ./lab_6b
//
//---------------------------------------------------------------

#include <stdio.h>

int fib( unsigned int k )
{
	if( k == 0 )
		return 0;
	else if( k == 1 )
		return 1;
	else
		return fib( k - 2 ) + fib( k - 1 );
}


void main(  int argc, char* argv[] )
{
 int i;

 for( i = 0; i <= atoi(argv[1]); i++ )
   printf( "Fib(%2d) = %d FibA= %d\n", i, fib( i ), fiba( i ) );
}
