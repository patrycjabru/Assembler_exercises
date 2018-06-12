 
#include <stdio.h>
#include <stdlib.h>


int max_ind(int a, int b, int c, int d);
int max_ind_c(int a, int b, int c, int d)
{
    int numbers[] = {a,b,c,d};
    int maxValue = a;
    int index = 0;
    for (int i = 0; i<4; i++) {
        if (numbers[i]>maxValue) {
            maxValue = numbers[i];
            index=i;
        }
    }
    for (int i = 0;i<4;i++) {
        if (index!= i && maxValue == numbers[i])
            return 0;
    }
    
    index += 1;
    return index;
}




void main( void )
{
    int a = 80;
    int b = 1500;
    int c = 20;
    int d = 230;
    printf( "max_ind_c = %d max_ind = %d\n", max_ind_c(a,b,c,d), max_ind(a,b,c,d));
}

