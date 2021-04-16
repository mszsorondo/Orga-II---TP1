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
formato_2: db '%s', 10, 0

section .text
extern malloc
extern free
extern fprintf
extern getDeleteFunction
extern getCloneFunction
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
    push r12
    push r13
    push r14
    push r15
    ;a en rdi
    ;b en rsi

    ;b entra en rsi, strLen calcula su longitud
    call strLen

    mov r12, rax ;guardamos la longitud de b en r11

    mov r13, rsi ;guardamos rsi

    mov rsi, rdi ;pasamos a a rsi para calcular su longitud

    call strLen
    mov r14, rax ;guardamos la longitud de a en r10

    ;en este punto tenemos:
    ;longitud de a en r10
    ;longitud de b en r11
    ;a* en rdi
    ;b* en r12

    mov rsi, r13
    ;recuperamos b* a rsi

    inc r14
    inc r12
    CMP r14, r12
    JLE .minA
    mov rcx, r12
    mov rbx, 0
.ciclo:
    mov al, byte [rdi+rbx]
    CMP al, byte [rsi+rbx]
    JG .aEsMayor
    JL .bEsMayor
    inc rbx
    CMP rcx, rbx
    JG .ciclo

    cmp r14, r12
    JG .aEsMayor
    JL .bEsMayor
    mov RAX, 0
    jmp .fin

.aEsMayor:
    MOV rax, -1
    jmp .fin

.bEsMayor:
    mov rax, 1
    jmp .fin

.minA:
    mov rcx, r14
    mov rbx, 0
    JMP .ciclo

.fin:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret

; char* strClone(char* a)
strClone:
    push rbp
    mov rbp, rsp  
    ;a en rdi

    mov rsi, rdi

    call strLen ; devuelve en rax la longitud

    mov rdi, rax
    inc rdi
    call malloc

    ;en rax tenemos el puntero a la nueva memoria creada
    ;en rcx está la longitud
    ;en rsi está el puntero al inicio de la string a copiar

    mov rcx, 0

.ciclo:
    mov dl, [rsi+rcx]
    mov [rax+rcx], dl
    inc rcx
    cmp dl, 0
    jne .ciclo


.fin:
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
    PUSH RBP
    MOV RBP, RSP
    ;a esta en rdi, pfile en rsi

    mov rdx, rdi
    mov rdi, rsi
    mov rsi, formato_2 
    call fprintf

    POP RBP
ret

; uint32_t strLen(char* a)
strLen:
    PUSH RBP
    MOV RBP , RSP
    ;a en rdi
    MOV RCX, 0
.comp:
    CMP byte [RDI+RCX], 0
    JE .fin
    
    inc RCX
    jmp .comp

.fin:
    mov rax, rcx
    POP RBP
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
    push rbp
    mov rbp, rsp
    ;type en rdi
    
    sub rsp, 8
    push rbx
    
    mov rbx, 0
    mov ebx, edi; ebx guarda el tipo para mallocear
    
    mov rdi, 24
    call malloc
    ;en rax esta el puntero a list
    mov dword [rax], ebx
    mov dword [rax+4], 0
    mov qword [rax+8], 0
    mov qword [rax+16], 0

    
    pop RBX
    add rsp, 8
    pop rbp
ret

; uint8_t  listGetSize(list_t* l)
listGetSize:
    push rbp
    mov rbp, rsp

    mov rax, 0
    mov eax, dword [rdi + 4]


    pop rbp
ret

; void listAddFirst(list_t* l, void* data)
listAddFirst:
    push rbp
    mov rbp, rsp
    sub rsp, 8
    push r12
    push r13
    push r14
    ;me guardo el puntero a la lista y a data para que cuando llame a funciones no se modifiquen
    mov r12, rdi
    mov r13, rsi


    ;obtener el tipo de la lista, ponerlo en r8
    ;comparamos el tipo contra o 0, o 1, o 2 o 3
    ;y llamamos a la función que clona que corresponde en consecuencia
    
    mov rdi, [rdi]
    call getCloneFunction

    mov rdi, r13
    call rax
    mov r15, rax

    ; asumo que se debe hacer una copia de data y no del valor al que apunta
.s_listElem_create:
    ; un nodo contiene tres punteros asique debo tener 24 bytes de memoria reservada
    mov rdi, 24
    call malloc
    mov [rax], r15 ; muevo a los primeros 8 bytes del nodo el puntero a data

    
    lea rsi, [r12+8]
    lea rdi, [rax+8]
    movsq ; el siguiente del nuevo es el primero actual
    mov qword [rax+16], 0
     ; incrementamos el tamanio de la lista
; debo hacer que el anterior del primero sea el nodo recien creado
.update_prev:
    cmp byte [r12+4], 0
    jne .noEstabaVacia 
    mov [r12+16], rax ; si estaba vacia entonces el ultimo nodo de la lista tambien sera el nuevo
    jmp .actualizarPrimero

.noEstabaVacia:
    
; el primer elemento es apuntado por el offset 8 de la lista, cuyo inicio apuntado por r12
    mov r14, [r12+8] ; tengo en r14 la direccion del viejo primer nodo
    mov [r14+16], rax; el proximo del viejo primer nodo sera la dir del nuevo CORREGIR
.actualizarPrimero:
    mov [r12+8], rax ; en rax tenemos el inicio del nuevo nodo
    inc byte [r12+4]
    ;CREO QUE FALTA ALGO
.fin:
    add rsp, 8
    pop r14
    pop r13
    pop r12
    pop rbp
    ret

; void* listGet(list_t* l, uint8_t i)
listGet:
; rdi -> lista
; rsi = i > rsi>= [rdi+4]? > si es asi devolver cero en rax, sino...
;pedir i veces el next

; setear rcx a cero > setear un iterador en [rdi+8] > cmp rcx con i > 
push rbp
mov rbp, rsp

mov r9,0
mov r9d, dword [rdi+4]

cmp rsi, r9
JGE .finInvalido
mov rax, 0

mov rcx, 0 
mov rax, [rdi+8]
.ciclo:
    cmp rcx, rsi
    JE .fin
    mov rax, [rax+8]
    inc rcx
    jmp .ciclo



.finInvalido:
    mov rax, 0
    jmp .fin
.fin:

pop rbp
ret

; void* listRemove(list_t* l, uint8_t i)
listRemove:
push rbp
mov rbp, rsp
sub rsp,8
push r15
push r14
push r13
push r12
push rbx

mov r15, rdi
mov r14, rsi
call listGet

; si esta fuera, saltar al fin y delvolver cero
cmp dword [r15+4], r14d
JLE .fin

;si es el ultimo, actualizar solo .siguienteDelAnterior -> deletear actual
mov r10d, dword [r15+4]
dec r10d
cmp r10d, r14d
JE .esElUltimo; DEBUGGEAR!!!!

;si es el primero, actualizar solo .anteriorDelsiguiente -> deletear actual
cmp r14, 0
JE .esElprimero
;sino, hacer ambos -> deletear actual

; si pasas por aca, es porque no es ni el primero ni el ultimo y esta dentro
mov r11, 2
jmp .siguienteDelAnterior


.esElprimero:
mov r11, 1
jmp .anteriorDelSiguiente

.esElUltimo:
mov r11, 0

.siguienteDelAnterior:
mov r8, [rax+8]; siguiente
mov r9, [rax+16]; anterior
mov rsi, r8; el siguiente
lea rdi, [r9+8]
movsq
cmp r11, 0
je .fin

.anteriorDelSiguiente:
mov r8, [rax+16]; anterior
mov r9, [rax+8]; siguiente
lea rdi, [r9+16]
mov rsi, r8
movsq

.fin:
.deletearActual:
mov rdi, rax 
mov rbx, [rdi]; en rbx guardo puntero data
call free
mov rax, rbx

pop rbx
pop r12
pop r13
pop r14
pop r15
add rsp, 8
pop rbp
ret

; void  listSwap(list_t* l, uint8_t i, uint8_t j)
listSwap:
    push rbp
    mov rbp, rsp

.checkRange:
    cmp esi, dword [rdi+4]
    JGE .fin
    cmp edx, dword [rdi+4]
    JGE .fin

    mov r15, rdi; para preservar la lista
    mov r14, rdx; para preservar j

    call listGet
    ;tengo en rax el i-esimo elemento
    mov rbx, rax ; lo paso a rbx
    mov rsi, r14
    mov rdi, r15 ;recupero la lista en rdi

    call listGet
    ; tengo en rax el j-esimo elemento
    mov r8, rax; a esta altura tengo en rbx el iesimo y en r8 el jesimo 

    ;COMPLETAR...


.fin:        

    pop rbp
ret

; list_t* listClone(list_t* l)
listClone:
ret


; void listDelete(list_t* l)
listDelete:
push rbp
mov rbp, rsp

mov r12, rdi

mov rdi, [rdi]
call getDeleteFunction; tenemos en rax la funcion que deletea data
mov r13, rax

mov rdi, r12
call listGetSize; en rax tenemos el size

mov rcx, 0
mov r14, [r12+16] ; en r14 tenemos el puntero al ultimo nodo

.borrarNodo:
    cmp rcx, rax
    je .fin
    cmp r14, 0
    je .fin
    mov rdi, [r14]
    call r13 ; data esta liberado ACA
    mov r15, r14
    mov r14, [r14+16] ; y ahora tengo el previo en r14
    mov rdi, r15
    call free
    inc rcx
    jmp .borrarNodo

.fin:
mov rdi, r12
call free
pop rbp
ret

; ** Card **

; card_t* cardNew(char* suit, int32_t* number)
cardNew:
    PUSH RBP
    MOV RBP, RSP
    ; R9, R10 SE CONSERVAN
    ; en RDI esta el puntero a char
    ; en RSI esta el puntero a number
    push r12
    push r13
    push r14
    push r15
    mov r12, rdi
    mov r13, rsi

    call strClone
    mov r14, rax

    mov rdi, r13
    call intClone
    mov r15, rax


    mov rdi, 24
    call malloc

    mov [rax], r14
    mov [rax+8], r15
    mov qword [rax+16], 0

    pop r15
    pop r14
    pop r13
    pop r12
    POP RBP
    RET

; char* cardGetSuit(card_t* c)
cardGetSuit:
push rbp
mov rbp, rsp

mov rax, [rdi]

pop rbp
ret

; int32_t* cardGetNumber(card_t* c) 
cardGetNumber:
push rbp
mov rbp, rsp

mov rax, [rdi+8]

pop rbp
ret

; list_t* cardGetStacked(card_t* c)
cardGetStacked:
ret

; int32_t cardCmp(card_t* a, card_t* b)
cardCmp:
push rbp
mov rbp, rsp
push r12
push r13
;a en rdi
;b en rsi

mov r12, rdi
mov r13, rsi

mov rdi, [rdi]
mov rsi, [rsi]
call strCmp

cmp rax, 0
JNE .fin

mov rdi, [r12+8]
mov rsi, [r13+8]
call intCmp

.fin:
pop r13
pop r12
pop rbp
ret

; card_t* cardClone(card_t* c)
cardClone:
ret

; void cardAddStacked(card_t* c, card_t* card)
cardAddStacked:
ret

; void cardDelete(card_t* c)
cardDelete:
PUSH RBP
    MOV RBP, RSP
    ;RDI PUNTERO A CARD

    MOV RSI, RDI
    MOV RDI, [RSI]
    CALL free

    
    MOV RDI, [RSI+8]
    CALL free


    MOV RDI, RSI
    CALL free


    POP RBP

ret

; void cardPrint(card_t* c, FILE* pFile)
cardPrint:
ret
