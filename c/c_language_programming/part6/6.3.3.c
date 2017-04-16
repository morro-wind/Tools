#include <stdio.h>
double d[][2]={{2,5},{3,6}};
void main()
{
    d[0][1]=3*d[0][0];
    d[1][1]=d[0][0]+d[1][0];
    printf("%.2lf\n",d[0][0]);
    printf("%.2lf\n",d[0][1]);
    printf("%.2lf\n",d[1][1]);
    printf("%.2lf\n",d[0][1]+d[1][1]);
}
