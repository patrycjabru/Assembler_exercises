#include<stdio.h>
#include<stdlib.h>

extern int great(int a, int b, int c);

int main() {
  int a = 14;
  int b = 188;
  int c = 200;
	printf("%d\n",sizeof(a));
  printf("Największa liczba to: %d\n", great(a,b,c));
  return 0;
}
