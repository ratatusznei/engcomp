/*
 7. A série harmônica é definida por:

 inf
 ∑   1/n = 1 + 1/2 + 1/3...
 n=1


 Escreva um programa que calcule a série harmônica. O programa deve mostrar, 
 a cada termo calculado, o valor do termo e o valor total do somatório até 
 aquele momento. Os termos devem parar de ser calculados quando o seu valor 
 for inferior a uma constante MIN_TERMO, que deve ser definida como 
 uma macro. Por exemplo, se MIN_TERMO for 0.2, os 5 primeiros termos da série
 devem ser calculados, e o programa deve mostrar na tela a seguinte saída
 (sem nos preocuparmos com o número de casas decimais):

    1.0000 1.0000
    0.5000 1.5000
    0.3333 1.8333
    0.2500 2.0833
    0.2000 2.2833

*/

#include <stdio.h>

#define MIN_TERMO 0.1

int main (int argc, char *argv[]) {
    double soma = 0;
    double termo = MIN_TERMO;
    int n = 1;

    printf("Termo\tSoma\n");        
    while (termo >= MIN_TERMO) {
        termo = 1.0/(n++);
        soma += termo;

        printf("%.4f\t%.4f\n", termo, soma);
    }

    putchar('\n');

    return 0;
}










