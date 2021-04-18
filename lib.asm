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
formato: db '%d', 0
formato_2: db '%s', 0

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

    MOV EBX, [RDI]
    CMP EBX, [RSI]
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
;estructura... 1. type (a4 bytes) 2. uint_8t size 
;3. uint_8t capacity 4. puntero al espacio de memoria 
;que contiene los punteros a los valores
;campos:  4 bytes para type, 1 byte para size,
;1 byte para capacity, dejo 2 bytes libres en el medio 
; luego 8 bytes para el puntero a data. TOTAL 16 bytes
; array_t* arrayNew(type_t t, uint8_t capacity)
arrayNew:
    push rbp
    mov rbp, rsp
    push rbx
    push r15

    ; type en rdi, capacity en rsi
    mov rbx, rdi
    mov r15, rsi; preservo los parametros de entrada

    ;falta hacer que data (rax+8) apunte a un espacio
    ;nuevo


    mov rdi, 16
    call malloc
    ; tenemos en rax el puntero al inicio de la estructura

    mov dword [rax], ebx ; ponemos el type
    ; en rax + 4 tenemos el tamanio, rax+5 capacidad
    mov byte [rax+4], 0; tamanio inicial
    mov byte [rax+5], r15b

   
    mov rcx, r15
    mov r15,rax 

    mov rdi, rcx
    call malloc

    ; tengo el puntero a los punteros de los elementos del arreglo en RAX
    ; los quiero en el octavo byte en adelante de la estructura (r15)

    mov [r15+8], rax

    mov rax, r15; necesito recuperar en rax el puntero al inicio de 
    ;la estructura

    pop r15
    pop rbx
    pop rbp
ret

; uint8_t  arrayGetSize(array_t* a)
arrayGetSize:
    push rbp
    mov rbp, rsp
    
    ; en rdi tenemos el puntero al array

    mov rax, [rdi+4]



    pop rbp
ret

; void  arrayAddLast(array_t* a, void* data)
arrayAddLast:
    ; tenemos que 1. copiar el dato (con el getClone)
    ; 2. recorrer [a+8] hasta llegar a la posicion size
    ; 3. escribir el puntero data en la posicion
    push rbp
    mov rbp, rsp
    push rbx
    push r15

    ; 0. COMPARAR SIZE CON CAPACITY!!!
    mov r9b, byte [rdi+4]
    cmp r9b, [rdi+5]
    je .fin


    ; tenemos en RDI el puntero al arreglo
    ; tenemos en RSI el puntero al valor del elemento
    mov rbx, rsi; resguardamos data
    mov r15 ,rdi; 
    mov rdi, 0 ; quiero limpiar tambien la parte alta de rdi
    mov edi, dword [r15]

    call getCloneFunction ; tenemos en rax el puntero a la funcion clone
    mov rdi, rbx; quiero a data como parametro
    call rax; ya esta clonado el valor y tengo su puntero en RAX
    ; resta agregarlo a la posicion size desde [r15+8]
    mov rbx, [r15+8]
    mov r9, 0

.ciclo:
    cmp r9b, byte [r15+4]
    je .addN
    inc r9
    jmp .ciclo

.addN:
    mov [rbx+r9], rax
    inc byte [r15+4]


.fin:


    pop r15
    pop rbx
    pop rbp

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
mov rax, [rax]
pop rbp
ret

; void* listRemove(list_t* l, uint8_t i)
listRemove:
push rbp
mov rbp, rsp

;list en rdi
;i en rsi
mov r12, rdi
mov r13, rsi

call listGetAux
mov r14, rax

cmp rax, 0
JE .fin

cmp r13, byte 0
JE .iEsElPrimero

mov r15, qword 0
mov r15b, byte [r12+4]
dec r15b
cmp r15b, r13b
JE .iEsElUltimo

.iEsIntermedio:
	mov r8, r13
	dec r8 				;obtengo el i anterior al que me piden

	mov rdi, r12		;paso la lista
	mov rsi, r8			;paso el i del elemento anterior al que hay q borrar
	call listGetAux
	mov r15, rax     	;guardo en r9 el nodo anterior al que hay que borrar

	mov rdi, r12		;vuelvo a pasar la lista
	ADD r8, 2			;ahora r8 vale el i sigueinte al nodo que hay q borrar
	mov rsi, r8			;paso el i q corresponde al elemento sigueinte al que debe ser borrado
	call listGetAux
	mov rbx, rax

	mov [r15+8], rbx		;al nodo anterior, le seteo el puntero a next = al nodo siguiente
	mov [rbx+16], r15	;al nodo sigueinte, le seteo el puntero a prev = al nodo anterior
	jmp .final

.iEsElPrimero:			;si i es el primero, al siguiente del primero tengo que apuntar el puntero prev a 0 
	mov r8, r13			;ademas, hay que setear como primer elemento de la lista al siguiente del primero
	inc r8
	mov rdi, r12		
	mov rsi, r8
	call listGetAux
	mov rbx, rax

	mov qword [rbx+16], 0 ;apuntamos a 0 el prev del nuevo primero		
	mov [r12+8], rbx		;el primero de la lista ahora es rax
	jmp .final

.iEsElUltimo:
	mov r8, r15
	dec r8				;r8 apunta al anterior del ultimo
	mov rdi, r12
	mov rsi, r8
	call listGetAux 		;en rax está el anterior del ultimo
	mov rbx, rax

	mov qword [rbx+8], 0 ;el siguiente del nuevo ultimo apunta a 0
	mov [r12+16], rbx
	jmp .final

.final:
dec byte [r12+4]

mov r15, [r14]

mov rdi, r14
call free

mov rax, r15

.fin:
pop rbp
ret

; void  listSwap(list_t* l, uint8_t i, uint8_t j)
listSwap:
push rbp
mov rbp, rsp

mov r12, rdi
mov r13, rsi
mov r14, rdx

mov r15, qword 0
mov r15b, byte [rdi+4]
dec r15b

cmp r15b, r13b
jl .fin

cmp r15b, r14b
jl .fin


call listGetAux
mov r13, rax

mov rdi, r12
mov rsi, rdx
call listGetAux
mov r14, rax

;en r13 está el iesimo
;en r14 está el jesimo
mov r9, [r14]

mov r15, [r13]
mov [r14], r15

mov r15, r9
mov [r13], r15


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



;auxiliares
listGetAux:
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