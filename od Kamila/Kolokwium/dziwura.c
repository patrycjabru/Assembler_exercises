//Autor: Jakub Dziwura
//Wszystko dziala poprawnie
//Należy dolaczyc stdlib.h i stdio.h
//Funkcja atoi - char* to int
//Kompilacja: gcc -m32 dziwura.c dziwura.s -o dziwura
//Program przyjmuje 4 parametry w terminalu, przykladowe wywolanie: ./dziwura 1 2 3 4
#include "stdio.h"
#include "stdlib.h"

extern long maxdiff(long,long,long,long);

int main(int argc, char* argv[])
{
  printf("Wynik maxdiff: %ld\n",maxdiff(atoi(argv[1]),atoi(argv[2]),atoi(argv[3]),atoi(argv[4])));
  return 0; 
}