//#include <stdio.h>
//#include <stdlib.h>
#include <stdio.h>
void main()
{
    int i, n, m, numdoll=0;
    double u[n], s = 0;
    scanf("%d",&n);
    if (n<1)
        printf("error \n");
    else if (n>20)
        printf("error \n");
    else if ( n>=1&&n<=20 )
    {
        while ( scanf("%lf", &u[numdoll]) != EOF && getchar() != '\n' )
            numdoll++;
        for ( i=0; i<n; i++ )
            //printf("%lf \n",u[i]);
            s+=u[i];
        if ( s>=20 )
        {
            if ( s<30 )
            {
                s+=8;
                printf ("%.2lf \n",s);
            }
            else if ( s<40 )
            {
                s+=5;
                printf ("%.2lf \n",s);
            }
            else
                printf ("%.2lf \n",s);
        }
        else if ( s<20 )
            printf ("error \n");
        return;
    }
    //printf ("error \n");
}
