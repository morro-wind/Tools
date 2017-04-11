#include <stdio.h>
void main ()
{
   static int a[][3]={{0},{1,2},{3,4,5}};
   printf ("%d,%d,%d\n",a[0][1],a[2][2],a[1][2]);
   printf ("%d\n",a[1][1]*a[2][20]+a[2][1]);
}
