/*testujacy w c, nazwisko.c nazwisko.s
long max(long a, long b, long c, char *ident)
a<>b<>c
funkcja zwraca najwieksza liczbe
ident zwraca literke*/
#include <stdio.h>
#include <stdlib.h>

long max(long a, long b, long c, char *ident);


int main(void){
int a = 7;
int b = 90;
int c = 25;
char* ident = malloc(1);
*ident = 'k';
printf("%d\n%c\n", max(a, b, c, ident), *ident);

return 0;
}
