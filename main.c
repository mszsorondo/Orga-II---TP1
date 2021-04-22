#include <stdio.h>
#include <stdlib.h>
#include <ctype.h>
#include <string.h>
#include <assert.h>
#include <math.h>
#include "lib.h"

void test_casoList();
void test_casoArray();

int main (void){  
    
    test_casoList();
    test_casoArray();
    
}

void test_casoList(){
    list_t * mazo = listNew(3);

    int32_t a = 5;
    int32_t b = 1;
    int32_t c = 3;
    int32_t d = 9;
    int32_t e = 6;


    card_t * card1 = cardNew("espada", &a);
    card_t * card2 = cardNew("basto", &b);
    card_t * card3 = cardNew("copa", &c);
    card_t * card4 = cardNew("oro", &d);
    card_t * card5 = cardNew("espada", &e);
    
    
    listAddFirst(mazo, card1);
    listAddFirst(mazo, card2);
    listAddFirst(mazo, card3);
    listAddFirst(mazo, card4);
    listAddFirst(mazo, card5);

    FILE * pFile = fopen("print CASO LIST", "w");
    listPrint(mazo, pFile);
    card_t* cartaCualquiera = listGet(mazo, 3);

    card_t * carta1b = listGet(mazo,1);
    cardAddStacked(carta1b, cartaCualquiera);
    listPrint(mazo, pFile);
    fclose(pFile);
    listDelete(mazo);

    cardDelete(card1);
    cardDelete(card2);
    cardDelete(card3);
    cardDelete(card4);
    cardDelete(card5);


}


void test_casoArray(){
    array_t* mazo = arrayNew(3, 5);
    
    int32_t a = 5;
    int32_t b = 1;
    int32_t c = 3;
    int32_t d = 9;
    int32_t e = 6;


    card_t * card1 = cardNew("espada", &a);
    card_t * card2 = cardNew("espada", &b);
    card_t * card3 = cardNew("espada", &c);
    card_t * card4 = cardNew("espada", &d);
    card_t * card5 = cardNew("espada", &e);
    
    arrayAddLast(mazo, card1);
    arrayAddLast(mazo, card2);
    arrayAddLast(mazo, card3);
    arrayAddLast(mazo, card4);
    arrayAddLast(mazo, card5);


    FILE* pFile = fopen("prueba_arrayPrint", "w");
    arrayPrint(mazo, pFile);

    
    cardAddStacked(arrayGet(mazo, 1), arrayGet(mazo, 2));

    arrayPrint(mazo, pFile);
    fclose(pFile);
    arrayDelete(mazo);
    cardDelete(card1);
    cardDelete(card2);
    cardDelete(card3);
    cardDelete(card4);
    cardDelete(card5);
    
    
    
}