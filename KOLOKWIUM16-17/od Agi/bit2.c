

#include <stdio.h>
#include <stdlib.h>


char* bit2( char *b, int a, char* c);


void main( void )
{
    char *a = malloc(2048);
    char *aa = malloc(2048);
    a = "abcd"; 
   // bit(0,aa,a);
	printf("ret: %s\n", bit2(a,14, aa));

    printf("ohoo: %s\n", aa);
	

}
