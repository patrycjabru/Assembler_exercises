 
  //---------------------------------------------------------------
// Program lab_7b - Asemblery Laboratorium IS II rok
//
// To compile&link: gcc -o zad1 zad1.c zad1.s
// To run:          ./zad1
//
//---------------------------------------------------------------

#include <stdio.h>
#include <stdlib.h>

char* generate_str_c(char* s, int c, int n, int inc)
{
    if (inc == 0) {
        for (int i=0; i<n; i++) {
            char cc = c;
            s[i] = cc;
        }
        return s;
    }
    for (int i=0; i<n; i++) {
            char cc = c + i;
            s[i] = cc;
        }
        return s;
}

char* generate_str(char* s, int c, int n, int inc);


void main( void )
{
    char *s = malloc(2048);
    char *s1 = malloc(2048);
    int c = 'a';
    int n = 7;
    int inc = 10;
    printf( "generate_str_c = %s generate_str = %s\n", generate_str_c(s1,c,n,inc), generate_str(s,c,n,inc));
    free(s);
    free(s1);
}

 
