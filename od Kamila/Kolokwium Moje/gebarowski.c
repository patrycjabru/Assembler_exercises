// Gębarowski Kamil 275721

// WSZYSTKO DZIAŁA

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
	char *a = "AAaa1234567890";
	char *b = "BBbbx";
	char *bufor = malloc((strlen(a) + strlen(b) + 1) * sizeof(char));
	printf("A     = %s\nB     = %s\n", a, b);
	printf("Wynik = %s\n", combine_str(bufor, a, b));	
}
