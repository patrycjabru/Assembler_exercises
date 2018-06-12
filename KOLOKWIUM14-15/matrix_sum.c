/* Wielkosc tablicy ustawia sie za pomoca stalej BOK */

#include <stdio.h>
#include <stdlib.h>

#define BOK 6

int suma(int **wsk, int bok);
int main()
{
  int i, k, licznik = 1;
  int** wsk = malloc(BOK * sizeof(int*));

  for(i = 0; i < BOK; ++i)
  {
    wsk[i] = malloc(BOK * sizeof(int));
  }

  for(i = 0; i < BOK; ++i)
  {
    for(k = 0; k < BOK; ++k)
    {
      wsk[i][k] = licznik;
      ++licznik;

      printf("%d\t", wsk[i][k]);
    }

    printf("\n");
  }

  printf("Suma przekatnej to: %d\n", suma(wsk, BOK));

  for(i = 0; i < BOK; ++i)
  {
    free(wsk[i]);
  }
  free(wsk);

  return 0;
} 
