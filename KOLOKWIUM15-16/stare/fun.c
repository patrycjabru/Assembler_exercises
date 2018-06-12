#include <stdio.h>
#include <stdlib.h>


char* fun(char* buf, char* a, char* b);
char* fun_c(char* buf, char* a, char* b)
{
    int counter = 0;
    for(int i=0;i<sizeof(a) && i<sizeof(b);i++) {
        buf[counter] = a[i];
        buf[counter+1] = b[i];
        counter += 2;
    }
    return buf;
}




void main( void )
{
    char *buf = malloc(2048);
    char *buf1 = malloc(2048);
    char* a = "bb";
    char* b = "ua";
    printf( "fun_c = %s fun = %s\n", fun_c(buf1,a,b), fun(buf,a,b));
    free(buf);
    free(buf1);
}

