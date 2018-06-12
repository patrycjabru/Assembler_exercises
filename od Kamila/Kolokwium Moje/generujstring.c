// Ma generować stringa złożonego z n znaków c. Jeśli inc = 0 znaki mają być takie same, w przeciwnym przypadku znaki mają się zwiększać o 1. s jest buforem do zapisania wygenerowanego stringa, miejsce na niego powinno być zarezerwowane w programie w C

#include <stdio.h>
#include <stdlib.h>

//char * generate_str(char * s, int c, int n, int inc);

int main() {
	int n = 10;
	char *start = malloc(n * sizeof(char));
	printf("Wynik = %s\n", (char*)generate_str(start, 'F', n, 1));
}
