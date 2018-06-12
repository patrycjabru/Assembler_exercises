#include <stdio.h>
#include <stdlib.h>


int main()
{
  char* wsk = malloc(100);
  sprintf(wsk, "%s", "abc  def   gh ijk");
 
  printf("%s\n", wsk);
 
  //0 - bez zamiany na duze litery; 1 - zamiana na duze litery
  printf("%s\n", usun_spacje(wsk, 1));
 
  free(wsk);
  return 0;
}
