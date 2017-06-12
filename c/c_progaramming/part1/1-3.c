#include <stdio.h>

/*  当fahr=0, 20, ……, 300时，打印华氏温度与摄氏温度对照表;
 *  浮点数，标题版本    */
main()
{
    float fahr, celsius;
    int lower, upper, step;
    char f[]="华氏度", c[]="摄氏度";

    lower = 0;      /*  温度表的下限    */
    upper = 300;    /*  温度表的上限    */
    step = 20;      /*  步长    */
    printf("%6s %15s\n", f, c);
    fahr = lower;
    while (fahr <= upper) {
        celsius = (5.0/9.0) * (fahr-32.0);
        printf("%6.0f %12.1f\n", fahr, celsius);
        fahr = fahr + step;
    }
}
