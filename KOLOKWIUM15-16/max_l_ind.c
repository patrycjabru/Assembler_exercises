 
 
#include <stdio.h>
#include <stdlib.h>


long long max_l_ind(long long* tab, long long n, long long* even_count, long long* neg_count);
long long max_l_ind_c(long long* tab, long long n, long long* even_count, long long* neg_count)
{
    int onesInBinary[n];
    for (int i = 0; i<n; i++){
        onesInBinary[i] = 0;
    }
    even_count=0;
    neg_count=0;
    for(int i = 0; i < n; i++) {
        if (tab[i] % 2 == 0) {
            even_count = even_count + 1;
        }
        if (tab[i] < 0 ) {
            neg_count++;
        }
        
        long long num = tab[i];
        while (num > 0) {
            if (num%2 == 1)
                onesInBinary[i]++;
            num = num / 2;
        }
    }
    int index = 0;
    for (int i = 0; i < n; i++) {
        if (onesInBinary[i] > onesInBinary[index])
            index = i;
    }
    return index;
}




void main( void )
{
    long long tab[7] = {-10,2,-1,4,5,-6,-7};
    long long* a = malloc(sizeof(long long));
    long long* b = malloc(sizeof(long long));
    
    long long* a1 = malloc(sizeof(long long));
    long long* b1 = malloc(sizeof(long long));
    int n = 7;
    long long max_c = max_l_ind_c(tab,n,a,b);
    long long max = max_l_ind(tab,n,a1,b1);
    printf("C: %ld, %d, %d, \nASM: %ld, %ld, %ld", *a, *b, max_c, *a1, *b1, max);
}

