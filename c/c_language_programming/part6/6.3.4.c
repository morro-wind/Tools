#include <stdio.h>
void main()
{
    char ch[3];
    int i,j,k;
    for (i=0;i<3;i++)
        ch[i]='$';
    for (i=0;i<5;i++)
    {
        for (j=0;j<i;j++)
            printf("%c",'#');
        for (k=0;k<3;k++)
            printf("%c",ch[k]);
        printf("\n");
    }
}
