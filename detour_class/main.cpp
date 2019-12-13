#include <stdio.h>

extern void init();
extern void assign(int,int);
extern void process();
extern int get();

int main(){

  int temp;

  init();

  assign(1,1);
  process();
  temp = get();
  printf("get : %d\n",temp);

  assign(1,1);
  process();
  temp = get();
  printf("get : %d\n",temp);

  assign(1,1);
  process();
  temp = get();
  printf("get : %d\n",temp);

  assign(1,1);
  process();
  temp = get();
  printf("get : %d\n",temp);

  return 0;

}
