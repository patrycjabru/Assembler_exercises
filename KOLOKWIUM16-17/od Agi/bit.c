


#include <stdio.h>
#include <stdlib.h>


char* bit(int a, char *b, char* c);


void main( void )
{
    char *a = malloc(2048);
    char *aa = malloc(2048);
    a = "abcd"; 
   // bit(0,aa,a);
	printf("ret: %s\n", bit(10,aa,a));
    printf("ohoo: %s\n", aa);
	

}
