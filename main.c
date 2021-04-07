#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>
#include <math.h>
#include "lib.h"
extern int32_t intCmp(int32_t* a, int32_t* b);
extern int32_t* intClone(int32_t* a);
extern void intDelete(int32_t* a);
extern void intPrint(int32_t* a, FILE* pFile);


void test_intClone();
void test_intCmp();
void test_intPrint();

int main (void)
{  
    
    //--------a corregir-----------
    test_intPrint(); //Address 0x4e5304000000020 is not stack'd, malloc'd or (recently) free'd
    //-----------------------------
    test_intCmp();//agregar tests nuestros si pinta
    test_intClone();//         same
    return 0;
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
    
    FILE *fail = fopen("prueba_intPrint.txt", "a");
    int32_t a = 32;
    intPrint(&a, fail);

}