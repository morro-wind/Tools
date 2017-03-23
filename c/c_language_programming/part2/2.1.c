#include <stdio.h>
void main ()
{
    int a,b,c;
    printf ("Enter a b c: ");
    scanf ("%d%d%d" , &a,&b,&c);
    printf ("%d,%d,%d\n",a+b,b+c,a+b+c);
}
