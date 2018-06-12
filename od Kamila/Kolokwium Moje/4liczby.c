////
// mamy 4 liczby, ma zwrócić różnicę max i min
////
// To compile&link: gcc -m32 -o 4liczby 4liczby.c 4liczby.s
// To run:          ./4liczby

#include <stdio.h>
#include <time.h>
#include <stdlib.h>

int testuj(int, int, int, int);

int main() {
	srand(time(0));
	int a = rand() % 10;
	int b = rand() % 10;
	int c = rand() % 10;
	int d = rand() % 10;
	printf("A = %d\nB = %d\nC = %d\nD = %d\n", a, b, c, d);
	printf("Wynik               = %d\n", maximin(a, b, c, d));	
	printf("Wynik (weryfikacja) = %d\n", testuj(a, b, c, d));	
}

int testuj(int a, int b, int c, int d) {
	int max, min;
	if (b > a) {
		max = b;
		min = a;
	} 
	else {
		max = a;
		min = b;
	}
	if (c > max) max = c;
	if (c < min) min = c;
	if (d > max) max = d;
	if (d < min) min = d;
	return max - min;
}
