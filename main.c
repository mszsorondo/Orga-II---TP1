#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>
#include <math.h>
#include "lib.h"




void test_intClone();
void test_intCmp();
void test_intPrint();
void test_cardNew();

int main (void){  
    //test_strClone();

    /*char* a = "abc";
    char* b = "ab";

    bool test = CstrCmp(a,b);

    printf("El resultado de la comparación fueE: %d \n", test);*/

    test_cardNew();

    
    /*test_intPrint();
    test_intCmp();
    test_intClone();*/
    return 0;
}

void test_cardNew(){
    char* suit1 = "espada";

    int32_t num1 = 5;

    card_t* carta1 = cardNew(suit1, &num1);

    printf("El palo de la carta es: %s y el numero es: %d\n", cardGetSuit(carta1), *cardGetNumber(carta1));

    cardDelete(carta1);

    //cardDelete(carta1);
    // resta imprimir el numero

}

void test_strClone()
{
    char* test = "espada";

    char* resultado = strClone(test);

    printf("El resultado de la copia de string es: %s\n", resultado);

    strDelete(resultado);

}

void test_intClone(){
    int32_t a = 4;

    int32_t* resultado = intClone(&a);

    printf("La dirección reservada es: %p y su valor es: %d\n", resultado, *resultado);

    intDelete(resultado);

}

void test_intCmp(){
    int32_t a = 4;
    int32_t* ap = (int32_t*)malloc(sizeof(int32_t));

    *ap = a;

    int32_t b = 5;
    int32_t* bp = (int32_t*)malloc(sizeof(int32_t));

    *bp = b;

    int32_t resultado = intCmp(ap, bp);
    printf("Resultado1:  %d \n", resultado);


    int32_t resultado2 = intCmp(bp, ap);

    printf("Resultado2:  %d \n", resultado2);

    b = 4;
    *bp = b;

    int32_t resultado3 = intCmp(ap, bp);

    printf("Resultado2:  %d \n", resultado3);

    free(ap);
    free(bp);
}



void test_intPrint(){
    FILE* pFile = fopen("prueba_intPrint.txt", "a+");
    int32_t a = 32;
    intPrint(&a, pFile);

    fclose(pFile);
}

/*int32_t CstrCmp(char* a, char*b){


    uint32_t aSize = strLen(a);
    uint32_t bSize = strLen(b);

    uint32_t min = 0;

    if(aSize < bSize)
        min = aSize;
    else
        min = bSize;
    for(int i = 0; i < min; i++)
    {
        if(a[i] > b[i])
            return -1;
        else if(a[i] < b[i])
            return 1;
    }
    if (aSize>bSize)
        return -1;
    else if(aSize<bSize)
        return 1;

    return 0;
}*/