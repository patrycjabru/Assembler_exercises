#include <stdio.h>

extern char* usun(char *w,int l);
int main(){
	  char* wsk = malloc(100);
  sprintf(wsk, "%s", "a  d ASD   D");
 
		printf("%s\n", wsk);
		//char * l = "abc  def   gh ijk";
	//	printf("%ld",(int) l);
		
		printf("%d\n",(int) wsk);
		printf("%s\n",usun(wsk,1));

		return 0;
}
