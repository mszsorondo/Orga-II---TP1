#include "lib.h"

funcCmp_t* getCompareFunction(type_t t) {
    switch (t) {
        case TypeInt:      return (funcCmp_t*)&intCmp; break;
        case TypeString:   return (funcCmp_t*)&strCmp; break;
        case TypeCard:     return (funcCmp_t*)&cardCmp; break;
        default: break;
    }
    return 0;
}
funcClone_t* getCloneFunction(type_t t) {
    switch (t) {
        case TypeInt:      return (funcClone_t*)&intClone; break;
        case TypeString:   return (funcClone_t*)&strClone; break;
        case TypeCard:     return (funcClone_t*)&cardClone; break;
        default: break;
    }
    return 0;
}
funcDelete_t* getDeleteFunction(type_t t) {
    switch (t) {
        case TypeInt:      return (funcDelete_t*)&intDelete; break;
        case TypeString:   return (funcDelete_t*)&strDelete; break;
        case TypeCard:     return (funcDelete_t*)&cardDelete; break;
        default: break;
    }
    return 0;
}
funcPrint_t* getPrintFunction(type_t t) {
    switch (t) {
        case TypeInt:      return (funcPrint_t*)&intPrint; break;
        case TypeString:   return (funcPrint_t*)&strPrint; break;
        case TypeCard:     return (funcPrint_t*)&cardPrint; break;
        default: break;
    }
    return 0;
}


/** Array **/

void  arrayPrint(array_t* a, FILE* pFile) {

    funcPrint_t* printear = getPrintFunction(a->type);
    fprintf(pFile, "[");
    for(int i = 0; i < a->size; i++){
        printear(arrayGet(a, i), pFile);
        if(i != (a->size-1))
            fprintf(pFile, ",");
    }
    fprintf(pFile, "]");

}

/** Lista **/

void listAddLast(list_t* l, void* data){
    funcClone_t* clonar = getCloneFunction(l->type);
    void* clonedData = clonar(data);

    listElem_t* nuevoNodo = (listElem_t*) malloc(24);

    if(l->size == 0){
        l->first = nuevoNodo;
        l->last = nuevoNodo;
        nuevoNodo->next = NULL;
        nuevoNodo->prev = NULL;
    } else{
        nuevoNodo->prev = l->last;
        nuevoNodo->next = NULL;
        l->last->next = nuevoNodo;
    }
    nuevoNodo->data = clonedData;
    l->last = nuevoNodo;
    l->size++;
}

/*void listPrint(list_t *l, FILE *pFile)
{
    fprintf(pFile, "[");
    if (l != NULL)
    {
        for (uint8_t i = 0; i < l->size; i++)
        {
            void *item = listGet(l, i);
            funcPrint_t *func = getPrintFunction(l->type);
            func(item, pFile);
            if (i != l->size - 1)
                fprintf(pFile, ",");
        }
    }
    fprintf(pFile, "]");
}*/

void listPrint(list_t* l, FILE* pFile) {
    fprintf(pFile, "[");
    if(l != NULL){
        for(uint8_t i = 0; i < l->size; i++){
            funcPrint_t *printear = getPrintFunction(l->type);
            void* item = listGet(l, i);
            printear(item, pFile);
            if(i != (l->size-1))
            fprintf(pFile, ",");
        }
    }
    fprintf(pFile, "]");
}


/** Game **/

game_t* gameNew(void* cardDeck, funcGet_t* funcGet, funcRemove_t* funcRemove, funcSize_t* funcSize, funcPrint_t* funcPrint, funcDelete_t* funcDelete) {
    game_t* game = (game_t*)malloc(sizeof(game_t));
    game->cardDeck = cardDeck;
    game->funcGet = funcGet;
    game->funcRemove = funcRemove;
    game->funcSize = funcSize;
    game->funcPrint = funcPrint;
    game->funcDelete = funcDelete;
    return game;
}
int gamePlayStep(game_t* g) {
    int applied = 0;
    uint8_t i = 0;
    while(applied == 0 && i+2 < g->funcSize(g->cardDeck)) {
        card_t* a = g->funcGet(g->cardDeck,i);
        card_t* b = g->funcGet(g->cardDeck,i+1);
        card_t* c = g->funcGet(g->cardDeck,i+2);
        if( strCmp(cardGetSuit(a), cardGetSuit(c)) == 0 || intCmp(cardGetNumber(a), cardGetNumber(c)) == 0 ) {
            card_t* removed = g->funcRemove(g->cardDeck,i);
            cardAddStacked(b,removed);
            cardDelete(removed);
            applied = 1;
        }
        i++;
    }
    return applied;
}
uint8_t gameGetCardDeckSize(game_t* g) {
    return g->funcSize(g->cardDeck);
}
void gameDelete(game_t* g) {
    g->funcDelete(g->cardDeck);
    free(g);
}
void gamePrint(game_t* g, FILE* pFile) {
    g->funcPrint(g->cardDeck, pFile);
}
