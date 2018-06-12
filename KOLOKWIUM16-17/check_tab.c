 
#include <stdio.h>
#include <stdlib.h>


unsigned int check_tab(int* tab, int n, int* max);

void main( void )
{
    int *tab = malloc(sizeof(int)*7);
    tab[0]=5;
    tab[1]=5;
    tab[2]=5;
    tab[3]=3;
    tab[4]=5;
    tab[5]=32;
    tab[6]=31;
    int n = 7;
    int *max = malloc(sizeof(int));
    unsigned int wynik = check_tab(tab,n,max);
    int tab2[64];
    for (int i = 63; i>=0; i--) {
        tab2[i] = wynik % 2;
        wynik = wynik/2;
    }
    printf( "check_tab = ");
    for (int i = 0; i< 64; i++) {
        printf("%d",tab2[i]);
    }
    printf( "\n");
    printf("max %d\n",*max);
}

