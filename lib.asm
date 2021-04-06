global intCmp
global intClone
global intDelete
global intPrint
global strCmp
global strClone
global strDelete
global strPrint
global strLen
global arrayNew
global arrayGetSize
global arrayAddLast
global arrayGet
global arrayRemove
global arraySwap
global arrayDelete
global listNew
global listGetSize
global listAddFirst
global listGet
global listRemove
global listSwap
global listClone
global listDelete
global listPrint
global cardNew
global cardGetSuit
global cardGetNumber
global cardGetStacked
global cardCmp
global cardClone
global cardAddStacked
global cardDelete
global cardPrint


section .text
extern malloc
extern free

; ** Int **

; int32_t intCmp(int32_t* a, int32_t* b)
intCmp:
    PUSH RBP
    MOV RBP, RSP
    SUB RSP, 32
    PUSH RBX

    MOV EBX, [EDI]
    CMP EBX, [ESI]
    JZ cero
    JG menosUno
    MOV EAX, 1
    JMP fin
    cero:
        MOV EAX, 0
        JMP fin
    menosUno:
        MOV EAX, -1
    fin:
        
    POP RBX
    ADD RSP, 32
    POP RBP
    ret



; int32_t* intClone(int32_t* a)
intClone:
    PUSH RBP
    MOV RBP, RSP

    mov rbx, rdi
    mov rdi, 4
    call malloc

    mov [rax], rbx

    POP RBP
ret

; void intDelete(int32_t* a)
intDelete:
    push RBP
    MOV RBP, RSP

    call free

    POP RBP
    ret

; void intPrint(int32_t* a, FILE* pFile)
intPrint:
ret

; ** String **

; int32_t strCmp(char* a, char* b)
strCmp:
ret

; char* strClone(char* a)
strClone:
ret

; void strDelete(char* a)
strDelete:
ret

; void strPrint(char* a, FILE* pFile)
strPrint:
ret

; uint32_t strLen(char* a)
strLen:
ret

; ** Array **

; array_t* arrayNew(type_t t, uint8_t capacity)
arrayNew:
ret

; uint8_t  arrayGetSize(array_t* a)
arrayGetSize:
ret

; void  arrayAddLast(array_t* a, void* data)
arrayAddLast:
ret

; void* arrayGet(array_t* a, uint8_t i)
arrayGet:
ret

; void* arrayRemove(array_t* a, uint8_t i)
arrayRemove:
ret

; void  arraySwap(array_t* a, uint8_t i, uint8_t j)
arraySwap:
ret

; void  arrayDelete(array_t* a)
arrayDelete:
ret

; ** Lista **

; list_t* listNew(type_t t)
listNew:
ret

; uint8_t  listGetSize(list_t* l)
listGetSize:
ret

; void listAddFirst(list_t* l, void* data)
listAddFirst:
ret

; void* listGet(list_t* l, uint8_t i)
listGet:
ret

; void* listRemove(list_t* l, uint8_t i)
listRemove:
ret

; void  listSwap(list_t* l, uint8_t i, uint8_t j)
listSwap:
ret

; list_t* listClone(list_t* l)
listClone:
ret

; void listDelete(list_t* l)
listDelete:
ret

; ** Card **

; card_t* cardNew(char* suit, int32_t* number)
cardNew:
ret

; char* cardGetSuit(card_t* c)
cardGetSuit:
ret

; int32_t* cardGetNumber(card_t* c) 
cardGetNumber:
ret

; list_t* cardGetStacked(card_t* c)
cardGetStacked:
ret

; int32_t cardCmp(card_t* a, card_t* b)
cardCmp:
ret

; card_t* cardClone(card_t* c)
cardClone:
ret

; void cardAddStacked(card_t* c, card_t* card)
cardAddStacked:
ret

; void cardDelete(card_t* c)
cardDelete:
ret

; void cardPrint(card_t* c, FILE* pFile)
cardPrint:
ret
