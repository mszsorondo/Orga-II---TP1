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
void test_strCmp();
void test_cardCmpASuitGreaterEqualNum();
void test_listNew();
void listAddLast(list_t* l, void*data);


int main (void){  
    //test_strClone();
    //test_strCmp();
    /*char* a = "abc";
    char* b = "ab";


    bool test = CstrCmp(a,b);

    printf("El resultado de la comparación fueE: %d \n", test);*/

    //test_cardNew();
    //test_cardCmp();
    
    //test_listAddFirst();
    
    //test_listGet();

    //test_listRemove();

    //test_listSwap();

    //test_listPrint();

    //test_listNew_typeTest();
    //test_listGetSize();


    /*test_intPrint();
    test_intCmp();
    test_intClone();*/

    test_arrayRemove();
    //test_arraySwap();
    //test_arrayNew();
    //test_arrayGetSize();
    //test_arrayAddLast();
}


void test_arraySwap(){
    array_t* arr1 = arrayNew(1,10);
    
    int32_t fst = 88;
    int32_t snd = 4;
    int32_t trd = 8;
    int32_t a = 9;
    int32_t b = 10;
    arrayAddLast(arr1, &fst);
    arrayAddLast(arr1, &snd);
    arrayAddLast(arr1, &trd);
    arrayAddLast(arr1, &a);
    arrayAddLast(arr1, &b);

    for(int i = 0; i < arr1->size; i++){
        int32_t* aux = arrayGet(arr1, i);
        printf("%d ", *aux);
    }
    printf("\n");

    arraySwap(arr1, 1, 4);

    arraySwap(arr1, -1, 3);

    arraySwap(arr1, 1, -3);

    arraySwap(arr1, 1, 25);

    arraySwap(arr1, 25, 1);

    for(int i = 0; i < arr1->size; i++){
        int32_t* aux = arrayGet(arr1, i);
        printf("%d ", *aux);
    }
    printf("\n");

    arrayDelete(arr1);

}

void test_arrayAddLast(){
    array_t* arr1 = arrayNew(1,4);
    
    int32_t fst = 88;
    int32_t snd = 4;
    int32_t trd = 8;
    arrayAddLast(arr1, &fst);
    arrayAddLast(arr1, &snd);
    arrayAddLast(arr1, &trd);
    int32_t* primero = arrayGet(arr1, 0);
    int32_t* segundo = arrayGet(arr1, 1);
    int32_t* tercero = arrayGet(arr1, 2);
    printf("El tamanio del array deberia ser 3 y es: %d \n", arrayGetSize(arr1));
    printf("El primer elemento es: %d \n", *primero);
    printf("El segundo elemento es: %d \n", *segundo);
    printf("El tercer elemento es: %d \n", *tercero);
    int32_t cua = 47;
    int32_t qui = 9;

    int32_t* cuarto = arrayGet(arr1, 3);
    arrayAddLast(arr1, &cua);
    arrayAddLast(arr1, &qui);

    printf("El tamanio del array deberia ser 4 y es: %d \n", arr1->size);

    arrayDelete(arr1);



    array_t* strArr = arrayNew(2,3);

    arrayAddLast(strArr,"un pete");
    arrayAddLast(strArr,"los + potros de FCEyN");

    printf("El tamanio del array es: %d \n",arrayGetSize(strArr));

    printf("Quien es mati? %s\n", arrayGet(strArr,0));

    printf("Somos %s\n", arrayGet(strArr,1));

    arrayDelete(strArr);

    

}
void test_arrayGetSize(){
    array_t* arr1 = arrayNew(1,4);
    array_t* arr2 = arrayNew(2, 7);

    printf("El tamanio del array es: %d \n", arrayGetSize(arr1));
    printf("El tamanio del array es: %d \n", arrayGetSize(arr2));
}

void test_arrayNew(){
    array_t* arr1 = arrayNew(1,4);
    array_t* arr2 = arrayNew(2, 7);

    printf("El tipo del array es %d y su capacidad es %d\n", arr1->type, arr1->capacity);
    
    printf("El tipo del array es %d y su capacidad es %d\n", arr2->type, arr2->capacity);
    
}

void test_listPrint(){
    FILE* pFile = fopen("prueba_listPrint.txt", "a+");
    int32_t numA = 36;
    list_t* listaA = listNew(1);
    listAddFirst(listaA, &numA);

    int32_t numB = 4;
    listAddFirst(listaA, &numB);

    int32_t numC = 299;
    listAddFirst(listaA, &numC);

    int32_t numX = 349;
    listAddFirst(listaA, &numX);

    int32_t numD = 292;
    listAddFirst(listaA, &numD);

    int32_t numE = 290;
    listAddFirst(listaA, &numE);

    listPrint(listaA, pFile);

    listDelete(listaA);

    fclose(pFile);
}

void test_listSwap(){
    int32_t numA = 36;
    list_t* listaA = listNew(1);
    listAddFirst(listaA, &numA);

    int32_t numB = 4;
    listAddFirst(listaA, &numB);

    int32_t numC = 299;
    listAddFirst(listaA, &numC);

    int32_t numX = 349;
    listAddFirst(listaA, &numX);

    int32_t numD = 292;
    listAddFirst(listaA, &numD);

    int32_t numE = 290;
    listAddFirst(listaA, &numE);

    for(int i = 0; i < listaA->size; i++){
        printf("%d ",*(int*)listGet(listaA, i) );
    }
    printf("\n");

    listSwap(listaA, 5, 0);

    for(int i = 0; i < listaA->size; i++){
        printf("%d ",*(int*)listGet(listaA, i) );
    }
    printf("\n");

    int32_t numQ = 999;

    listAddLast(listaA, &numQ);

    for(int i = 0; i < listaA->size; i++){
        printf("%d ",*(int*)listGet(listaA, i) );
    }
    printf("\n");

    listDelete(listaA);


}

void test_listRemove(){
    int32_t numA = 36;
    list_t* listaA = listNew(1);
    listAddFirst(listaA, &numA);

    int32_t numB = 4;
    listAddFirst(listaA, &numB);

    int32_t numC = 299;
    listAddFirst(listaA, &numC);

    int32_t numX = 349;
    listAddFirst(listaA, &numX);

    int32_t numD = 292;
    listAddFirst(listaA, &numD);

    int32_t numE = 290;
    listAddFirst(listaA, &numE);

    int i = 4;

    int* removed = listRemove(listaA, i);

    printf("El valor del elemento %d removido es: %d \n", i, *removed);

    printf("El siguiente del first de la lista es: %d\n", *(int*)listaA->last->prev->data);

    printf("El anterior del last es: %d\n", *(int*)listaA->last->prev->data);

    listDelete(listaA);
    intDelete(removed);


}

void test_listGet(){
    int32_t numA = 36;
    list_t* listaA = listNew(1);
    listAddFirst(listaA, &numA);

    int32_t numB = 4;
    listAddFirst(listaA, &numB);

    int32_t numC = 299;
    listAddFirst(listaA, &numC);

    int32_t numX = 349;
    listAddFirst(listaA, &numX);

    int32_t numD = 292;
    listAddFirst(listaA, &numD);

    int32_t numE = 290;
    listAddFirst(listaA, &numE);

    int i = 5;

    int* resultado = listGet(listaA, i);


    printf("El valor %d es %d \n", i, *resultado);

    listDelete(listaA);
}


void test_listAddFirst(){
    int32_t numA = 36;
    list_t* listaA = listNew(1);
    listAddFirst(listaA, &numA);

    int32_t numB = 4;
    listAddFirst(listaA, &numB);

    int32_t numC = 299;
    listAddFirst(listaA, &numC);

    int valor = *(int*)listaA->first->data;

    int sigValor = *(int*)listaA->first->next->data;

    int antSeg = *(int*)listaA->first->next->prev->data;

    int antUlt = *(int*)listaA->last->prev->data;

    printf("El tamanio de la lista es %d y su primer elemento es %d \n", listaA->size, valor);

    printf("El tamanio de la lista es %d y su segundo elemento es %d \n", listaA->size, sigValor);
    
    printf("El anterior elemento del segudo es %d \n", antSeg);

    printf("El anterior elemento del ultimo es %d \n", antUlt);

    listDelete(listaA);


    char* stringTest = "HolaMArqueXJAjajajaj$(!$)=";

    list_t* listaB = listNew(2);

    listAddFirst(listaB, stringTest);

    printf("El tamaño de la lista es %d y su primer elemento es: %s \n", listaB->size, listaB->first->data);

    listDelete(listaB);

}

void test_listGetSize(){
    type_t tipo = 2; 
    
    list_t* lista1 = listNew(tipo);

    printf("La lista es de largo %x \n", lista1->size); //fefff8c8 con tipo 0 4e53040 con tipo 2
 
}
void test_listNew_typeTest(){
    type_t tipo = 2; 
    
    list_t* lista1 = listNew(tipo);

    printf("\n La lista es de tipo %x \n", lista1->type); //fefff8c8 con tipo 0 4e53040 con tipo 2
}

void test_cardNew(){
    char* suit1 = "espada";

    int32_t num1 = 8;

    card_t* carta1 = cardNew(suit1, &num1);

    printf("El palo de la carta es: %s y el numero es: %d\n", cardGetSuit(carta1), *cardGetNumber(carta1));

    cardDelete(carta1);

    //cardDelete(carta1);
    // resta imprimir el numero

}

void test_strCmp(){
    char* a  = "asd";
    char* b = "asd";

    int32_t res = strCmp(a,b);

    printf("La comparacion da : %d \n", res);
}

void test_cardCmp(){

    test_cardCmpEqualSuitEqualNum();
    test_cardCmpASuitGreaterEqualNum();
    


}

void test_cardCmpASuitGreaterEqualNum(){
    char* suit1 = "oro";

    int32_t num1 = 8;

    card_t* carta1 = cardNew(suit1, &num1);

    char* suit2 = "espada";

    int32_t num2 = 8;

    card_t* carta2 = cardNew(suit2, &num2);

    int resultado = cardCmp(carta1, carta2);

    printf("El resultado es: %d \n", resultado);

    cardDelete(carta1);
    cardDelete(carta2);
}
void test_cardCmpEqualSuitEqualNum(){
    char* suit1 = "espada";

    int32_t num1 = 8;

    card_t* carta1 = cardNew(suit1, &num1);

    char* suit2 = "espada";

    int32_t num2 = 8;

    card_t* carta2 = cardNew(suit2, &num2);

    int resultado = cardCmp(carta1, carta2);

    printf("El resultado es: %d \n", resultado);

    cardDelete(carta1);
    cardDelete(carta2);
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