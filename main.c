#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>
#include <math.h>

#include "lib.h"
extern int32_t intCmp(int32_t* a, int32_t* b);
extern int32_t* intClone(int32_t* a);
int main (void)
{  
    int32_t a = 4;
    int32_t* ap = (int32_t*)malloc(sizeof(int32_t));

    *ap = a;
    
    int32_t b = 5;
    int32_t* bp = (int32_t*)malloc(sizeof(int32_t));

    *bp = b;

    int32_t resultado = intCmp(ap, bp);
    printf("Resultado1:  %d \n", resultado);
    
    b = 4;
    *bp = b;

    int32_t resultado2 = intCmp(ap, bp);

    printf("Resultado2:  %d \n", resultado2);

    free(ap);
    free(bp);

    // for(int32_t i = 0; i < 3; i++){
    //     test1[i] = intCmp(bp, ap);
    //     printf("El test %d i es %d ", i, test1[i]);
    //     printf("\n");
    // }
    return 0;
}