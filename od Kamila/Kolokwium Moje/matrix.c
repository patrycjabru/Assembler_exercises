////
// Zsumowanie elementów z przekątnej dwuwymiarowej, kwadratowej tablicy. Do funkcji jest przekazywany wskaźnik oraz "długość boku" kwadratowej tablicy.
////
// To compile&link: gcc -m32 -o matrix matrix.c matrix.s
// To run:          ./matrix

#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int testuj(int**, int);

int main() {
	srand(time(0));
	int i, j;
	int bok = 4;
	int** wsk = malloc(bok * sizeof(int*));
	for (i = 0; i < bok; i++)
		wsk[i] = malloc(bok * sizeof(int));
	for (i = 0; i < bok; i++) for (j = 0; j < bok; j++) wsk[i][j] = 0;
	for (i = 0; i < bok; i++) {
		wsk[i][i] = rand() % 10;
		printf("tab[%d][%d] = %d\n", i, i, wsk[i][i]);
	}
	printf("Wynik               = %d\n", sumamatrix(wsk, bok));	
	printf("Wynik (weryfikacja) = %d\n", testuj(wsk, bok));	
}

int testuj(int** w, int b) {
	int i, wynik = 0;
	for (i = 0; i < b; i++) wynik += w[i][i];
	return wynik;
}
