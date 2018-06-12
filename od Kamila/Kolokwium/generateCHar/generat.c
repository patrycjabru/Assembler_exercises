#include <stdio.h>

int main(){
	
	char * wsk= malloc(100);
	printf("%d\n",(int) wsk);
	printf("a%s\n",gen(1,'A',30,2,15,16,17));
	printf("ss%s\n",wsk);	
	
	return 0;
}
