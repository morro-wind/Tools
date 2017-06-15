#include <stdio.h>

/*  当fahr=0, 20, ……， 300时，打印华氏温度与摄氏温度对照表;
 *  浮点数版本  */
main()
{
    float fahr, celsius;
    int lower, upper, step;

    lower = 0;      /*  温度表的下限    */
    upper = 300;    /*  温度表的上限    */
    step = 20;      /*  步长    */

    fahr = lower;
    while (fahr <= upper) {
        celsius = (5.0/9.0) * (fahr-32.0);
        /*  %3.0f表明待打印的浮点数（fahr）至少占3个字符宽
         *  且不带小数点和小数部分
         *  %6.1f表明另一个待打印的数（celsius）至少占6个字符宽
         *  且小数后面有1位数字 */
        printf("%3.0f %6.1f\n", fahr, celsius);
        fahr = fahr + step;
    }
}
