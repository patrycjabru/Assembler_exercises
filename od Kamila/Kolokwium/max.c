
//Oba programy trzeba było napisać w C z wywołaniem funkcji napisanej w asemblerze, która stanowiła zasadniczą część programu
//Funkcja w asemblerze ma zwracać największą z podanych liczb:
//int greatest(int a, int b, int c)

//gcc -o max max.c max.s

#include <stdio.h>

void main(int argc, char* argv[])
{
    int i = atoi(argv[1]),
        j = atoi(argv[2]),
        k = atoi(argv[3]);
    printf("Max of %d, %d, %d = %d \n",i ,j ,k, maxa(i,j,k) );
}

