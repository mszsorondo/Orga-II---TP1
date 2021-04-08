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


section .data
formato: db '%d', 10, 0

section .text
extern malloc
extern free
extern fprintf
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
    SUB RSP, 24
    PUSH RBX

    mov ebx, [RDI]
    mov rdi, 4
    call malloc
    mov [rax], ebx

    POP RBX
    ADD RSP, 24
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
    PUSH RBP
    MOV RBP, RSP
    
    ;a en rdi
    ;pfile en rsi

    mov edx, [rdi]
    mov rdi, rsi
    mov rsi, formato
    call fprintf


    POP RBP
    RET

; ** String **

; int32_t strCmp(char* a, char* b)
strCmp:
    push rbp
    mov rbp, rsp
    ret

; char* strClone(char* a)
strClone:
    push rbp
    mov rbp, rsp  

    ;el puntero al inicio de la cadena -> rdi
    MOV rcx, 0
    
_ciclo:
    CMP byte [rdi + rcx], 48d
    JZ _terminoCadena
    INC rcx
    JMP _ciclo

_terminoCadena:
    CMP ecx, 0
    JZ _fin

    mov rdi, ecx
    call malloc
    MOV RBX, 0
    
_copiar:
    CMP ecx, rbx
    JLE _fin
    MOV r10, 0
    MOV r11, 0
    lea r10, [rax+rbx]
    lea r11, [rsi+rbx]
    cld
    mov rdi, r10
    mov rsi, r11
    rep MOVSB
    INC rbx
    JMP _copiar

_fin:
    pop rbp
    ret

; void strDelete(char* a)
strDelete:
push rbp
mov rbp, rsp
call free
pop rbp
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
