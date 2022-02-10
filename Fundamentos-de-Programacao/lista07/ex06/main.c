/*
 6. Escreva um programa que leia um número real x e calcule o seguinte
 somatório (usando os n primeiros termos da série, onde n
 é um número dado):

 S = x - x/1² + x/2² - x/3²...

*/

#include <stdio.h>

int main (int argc, char *argv[]) {
    double x = 0;
    int n = 0;

    double soma = 0;
    int i = 2;

    printf("Calculadora de S = x - x/1^1 + x/2^2 - x/3^2 ... +- x/n^2\n\n");

    printf("Digite x:  ");
    scanf("%lf", &x);
    printf("Digite n:  ");
    scanf("%d", &n);

    while (i < n) {
        /*      i=0  i=1    i=2    i=3
            S = x - x/1² + x/2² - x/3²...

                    i=2    i=3
            S = 0 + x/2² - x/3²...

            enesimo termo = 
                1 se n = 0
                x / (i * i) se i par
                - x / (i * i) se i impar
        */
        if (i % 2 == 0) {
            soma += x / (i*i);
        }
        else {
            soma -= x / (i*i);
        }
    
        i++;
    }

    printf("S =  %.2f\n\n", soma);

    return 0;
}










