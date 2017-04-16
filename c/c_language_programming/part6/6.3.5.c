#include <stdio.h>
void main()
{
    int a[][4]={1,2,3,4,5,6,7,8};
    int i,j,i0=0,j0=0,max;
    max=a[0][0];
    for (i=0;i<2;i++)
        for (j=0;j<4;j++)
            if (a[i][j]>max)
            {
                max=a[i][j];
                i0=i;
                j0=j;
                printf ("i0=%d,j0=%d\n",i0,j0);
            }
    printf ("a[%d][%d]=%d\n",i0,j0,max);
}
