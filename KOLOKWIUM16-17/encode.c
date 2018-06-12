 
#include <stdio.h>
#include <stdlib.h>


char* encode(char* buf, unsigned int mask, int operation, int character);

void main( void )
{
    char *buf = malloc(2048);
    buf[0]='4';
    buf[1]='2';
    buf[2]='3';
    buf[3]='4';
    buf[4]='5';
    buf[5]='0';
    buf[6]='7';
    buf[7]='8';
    buf[8]='9';
    buf[9]='0';
    buf[10]=0;
    unsigned int mask = 1023; //100
    int operation = 2;
    int character = 1;
    printf("%s\n",buf);
    char* output = encode(buf,mask,operation,character);
    printf("%s\n",output);
    free(buf);
}

 
