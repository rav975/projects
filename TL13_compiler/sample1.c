
/*-- C Code --*/

#include<stdio.h>
#include<stdlib.h>
#include<stdbool.h>

void main() {
int N;
int SQRT;
scanf("%d", &N);
SQRT = 0;
while(((SQRT * SQRT) <= N)) {
SQRT = (SQRT + 1);
}
SQRT = (SQRT - 1);
printf("%d\n",SQRT);
}
