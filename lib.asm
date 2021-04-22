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
formato_3: db '{%s-',0
formato_4: db '%d-',0
formato_5: db '}', 0

formato_6: db "{",0
formato_7: db "-",0
formato_8: db "}",0
formato_9: db "[]", 0

formato_10: db "NULL", 0

section .text
extern malloc
extern free
extern fprintf
extern getDeleteFunction
extern getCloneFunction
extern listAddLast
extern listPrint
; ** Int **

; int32_t intCmp(int32_t* a, int32_t* b)
intCmp:
    PUSH RBP
    MOV RBP, RSP
    SUB RSP, 8
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
    ADD RSP, 8
    POP RBP
    ret



; int32_t* intClone(int32_t* a)
intClone:
    PUSH RBP
    MOV RBP, RSP
    SUB RSP, 8
    PUSH RBX

    mov ebx, [RDI]
    mov rdi, 4
    call malloc
    mov [rax], ebx

    POP RBX
    ADD RSP, 8
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
    sub rsp, 8
    push r12
    push r13
    push r14
    push r15
    push rbx
  

    
    call strLen

    mov r12, rax 

    mov r13, rsi 

    mov rsi, rdi 

    call strLen
    mov r14, rax 

    

    mov rsi, r13
    
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
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    add rsp, 8
    pop rbp
    ret

; char* strClone(char* a)
strClone:
    push rbp
    mov rbp, rsp  
    sub rsp, 8
    push r12
    

    mov rsi, rdi

    mov r12, rdi

    call strLen 

    mov rdi, rax
    inc rdi
    call malloc

    

    mov rcx, 0

.ciclo:
    mov dl, [r12+rcx]
    mov [rax+rcx], dl
    inc rcx
    cmp dl, 0
    jne .ciclo


.fin:
    pop r12
    add rsp, 8
    pop rbp
    ret


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
    push r12
    push r13
    

    mov r12, rdi
    mov r13, rsi

    call strLen
    cmp rax, 0
    je .vacia

    mov rax, 0
    mov rdx, r12
    mov rdi, r13
    mov rsi, formato_2 
    call fprintf
    jmp .fin

    .vacia:
    mov rax, 0
    mov rdi, r13
    mov rsi, formato_10
    call fprintf

    .fin:
    pop r13
    pop r12
    POP RBP
ret

; uint32_t strLen(char* a)
strLen:
    PUSH RBP
    MOV RBP , RSP
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
    push rbp
    mov rbp, rsp
    sub rsp, 8
    push rbx
    push r15
    push r14

    
    mov rbx, rdi
    mov r15, rsi

    


    mov rdi, 16
    call malloc
    
    mov dword [rax], ebx 
    mov byte [rax+4], 0
    mov byte [rax+5], r15b

    lea r15, [r15*8]
    mov r14, rax
    mov rdi, r15
    call malloc

   
    mov [r14+8], rax

    mov rax, r14
    pop r14
    pop r15
    pop rbx
    add rsp, 8
    pop rbp
ret

; uint8_t  arrayGetSize(array_t* a)
arrayGetSize:
    push rbp
    mov rbp, rsp

   
    mov rax, [rdi+4]

    pop rbp
ret

; void  arrayAddLast(array_t* a, void* data)
arrayAddLast:
  
    push rbp
    mov rbp, rsp
    push rbx
    push r15

    
    mov r9b, byte [rdi+4]
    cmp r9b, [rdi+5]
    je .fin


    mov rbx, rsi
    mov r15 ,rdi
    mov rdi, 0 
    mov edi, dword [r15]

    call getCloneFunction 
    mov rdi, rbx
    call rax
  
    mov rbx, [r15+8]
    mov rcx, 0

.ciclo:
    cmp cl, byte [r15+4]
    je .addN
    inc cl
    jmp .ciclo

.addN:
    mov [rbx+rcx*8], rax
    inc byte [r15+4]


.fin:


    pop r15
    pop rbx
    pop rbp

ret

; void* arrayGet(array_t* a, uint8_t i)
arrayGet:
    push rbp
    mov rbp, rsp
    
    mov r8, rsi
    cmp byte [rdi+4],r8b
    jle .retCero

    mov r9, [rdi+8]
    
    mov rax, [r9+rsi*8]
    jmp .fin

.retCero:
    mov rax,0

.fin:
    pop rbp

ret

; void* arrayRemove(array_t* a, uint8_t i)
arrayRemove:
    push rbp
    mov rbp, rsp
    sub rsp, 8
    push r12
    push r13
    push r14
    push r15
    push rbx

    mov r12, rdi
    mov r13, rsi

    call arrayGet
    mov r14, rax

    mov r15, 0
    mov r15b, byte[r12+4]
    dec r15b

    cmp sil, r15b
    jg .outOfRange


    cmp r13b, 0
    jl .outOfRange

    mov rbx, 0
    mov rbx, r13
    inc r15b
.ciclo:
    cmp bl, r15b
    JE .delete
    mov rdi, r12
    mov rsi, r13
    lea rdx, [r13+1]
    call arraySwap
    inc bl
    inc r13
    jmp .ciclo

.outOfRange:
    mov rax, 0
    jmp .fin


.delete:
    dec byte [r12+4]
    mov rax, r14


.fin:
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    add rsp, 8
    pop rbp
    ret

; void  arraySwap(array_t* a, uint8_t i, uint8_t j)
arraySwap: 
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15
    
    mov r10, rsi
    cmp r10b, byte [rdi+4]
    jge .fin
    cmp dl, byte [rdi+4]
    jge .fin

    cmp dl, 0 
    jl .fin

    cmp r10b, 0
    jl .fin


    mov r15, rdi
    mov r12, rsi
    mov r13, rdx

    call arrayGet
  
    mov r14, rax
    mov rdi, r15
    mov rsi, r13
    call arrayGet
 
    mov r9, rax

    mov r15, [r15+8] 
    mov [r15+r12*8], r9
    mov [r15+r13*8], r14

.fin:

    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
ret

; void  arrayDelete(array_t* a)
arrayDelete:
    push rbp
    mov rbp, rsp     
    sub rsp, 8
    push rbx
    push r12
    push r13

    mov r12, rdi
    mov rbx, 0
    mov rax, [rdi + 4]
    mov bl, al

    .ciclo:
    mov rdi, r12
    cmp bl, 0
    je .fin
    dec rbx
    mov rsi, 0
    mov rsi, rbx
    call arrayRemove
    mov r13, rax
    mov rdi, [r12]
    call getDeleteFunction
    mov rdi, r13
    call rax
    jmp .ciclo

    .fin:
    mov rdi, r12
    mov rsi, rdi
    mov rdi, [rdi+8]
    call free
    mov rdi, rsi
    call free
    
    pop r13
    pop r12
    pop rbx
    add rsp, 8
    pop rbp
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
    mov ebx, edi
    
    mov rdi, 24
    call malloc

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

    cmp rdi, 0
    je .listaInvalida

    mov rax, 0
    mov eax, dword [rdi + 4]
    jmp .fin

    .listaInvalida:
    mov rax, 0

.fin:
pop rbp
ret

; void listAddFirst(list_t* l, void* data)
listAddFirst:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15

    mov r12, rdi
    mov r13, rsi


    
    mov rdi, [rdi]
    call getCloneFunction

    mov rdi, r13
    call rax
    mov r15, rax

    
.s_listElem_create:
    
    mov rdi, 24
    call malloc
    mov [rax], r15 

    
    lea rsi, [r12+8]
    lea rdi, [rax+8]
    movsq 
    mov qword [rax+16], 0
    

.update_prev:
    cmp byte [r12+4], 0
    jne .noEstabaVacia 
    mov [r12+16], rax 
    jmp .actualizarPrimero

.noEstabaVacia:
    
    mov r14, [r12+8] 
    mov [r14+16], rax
.actualizarPrimero:
    mov [r12+8], rax 
    inc byte [r12+4]
    
.fin:
    pop r15
    pop r14
    pop r13
    pop r12
    pop rbp
    ret

; void* listGet(list_t* l, uint8_t i)
listGet:

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
    JE .finValido
    mov rax, [rax+8]
    inc rcx
    jmp .ciclo

.finInvalido:
    mov rax, 0
    jmp .fin

.finValido:
    mov rax, [rax]
    jmp .fin

.fin:
    pop rbp
    ret

; void* listRemove(list_t* l, uint8_t i)
listRemove:
    push rbp
    mov rbp, rsp
    sub rsp, 8
    push r12
    push r13
    push r14
    push r15
    push rbx

    mov r12, rdi
    mov r13, 0
    mov r13, rsi

    call listGetAux
    mov r14, rax

    cmp rax, 0
    JE .fin


    cmp r13b, 0
    JE .iEs0

    mov r9b, r13b
    inc r9b
    cmp r9b, byte [r12+4]
    je .iEsElUltimo


    cmp byte [r12+4], 1
    JNE .iEsIntermedio

.iEs0:
    cmp byte [r12+4], 1
    JE .iEsElUnico
    jne .iEsElPrimero

    mov r15, qword 0
    mov r15b, byte [r12+4]
    dec r15b
    cmp r15b, r13b
    JE .iEsElUltimo

.iEsElUnico:
    mov qword [r12+8], 0
    mov qword [r12+16], 0
    jmp .final

.iEsIntermedio:
	dec r13		        

	mov rdi, r12		
	mov rsi, r13			
	call listGetAux
	mov r15, rax     	

	mov rdi, r12		
	ADD r13, 2			
	mov rsi, r13			
	call listGetAux
	mov rbx, rax

	mov [r15+8], rbx		
	mov [rbx+16], r15	
	jmp .final

.iEsElPrimero:			
				        
	inc r13
	mov rdi, r12		
	mov rsi, r13
	call listGetAux
	mov rbx, rax

	mov qword [rbx+16], 0	
	mov [r12+8], rbx		
	jmp .final

.iEsElUltimo:
	
	dec r13				
	mov rdi, r12
	mov rsi, r13	
    call listGetAux 	
	mov rbx, rax

	mov qword [rbx+8], 0 
	mov [r12+16], rbx
	jmp .final

.final:
    dec byte [r12+4]

    mov r15, [r14]

    mov rdi, r14
    call free

    mov rax, r15

.fin:

    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    add rsp, 8
    pop rbp
    ret

; void  listSwap(list_t* l, uint8_t i, uint8_t j)
listSwap:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    push r14
    push r15

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

    mov r9, [r14]

    mov r15, [r13]
    mov [r14], r15

    mov r15, r9
    mov [r13], r15


.fin:        
    pop r15
    pop r14 
    pop r13
    pop r12
    pop rbp
    ret

; list_t* listClone(list_t* l)
listClone:
    push rbp
    mov rbp, rsp
    
    push r15
    push r14
    push r13
    push r12

    mov r13, rdi
    
    mov rdi, 0
    mov rdi, [r13]
    call listNew
    mov r12, rax

    mov r15, 0
    mov r14, 0
    mov r14b, byte [r13+4]
    dec r14b
.ciclo:
    cmp r15b, r14b
    JG .fin
    mov rdi, r13
    mov rsi, r15
    call listGet

    mov rdi, r12
    mov rsi, rax
    call listAddLast

    inc r15b

    jmp .ciclo

.fin:
    mov rax, r12
    pop r12
    pop r13
    pop r14
    pop r15
    pop rbp

    ret


; void listDelete(list_t* l)
listDelete:
    push rbp
    mov rbp, rsp
    sub rsp, 8
    push r12
    push r13
    push r14
    push r15
    push rbx

    mov r12, rdi 

    mov rdi, [rdi] 
    call getDeleteFunction
    mov r13, rax       

    mov rdi, r12
    call listGetSize

    mov r14, [r12+16]

    mov rbx, 0

.borrarNodo:
    cmp bl, byte [r12+4]
    je .fin
    cmp r14, 0
    je .fin
    mov rdi, [r14]
    call r13
    mov r15, r14
    mov r14, [r14+16]
    mov rdi, r15
    call free
    inc bl
    jmp .borrarNodo

.fin:
    mov rdi, r12
    call free
    pop rbx
    pop r15
    pop r14
    pop r13
    pop r12
    add rsp, 8
    pop rbp
    ret


; ** Card **

; card_t* cardNew(char* suit, int32_t* number)
cardNew:
    PUSH RBP
    MOV RBP, RSP
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
    push rbp
    mov rbp, rsp

    mov rax, [rdi+16]

    pop rbp
    ret

; int32_t cardCmp(card_t* a, card_t* b)
cardCmp:
    push rbp
    mov rbp, rsp
    push r12
    push r13

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
    push rbp
    mov rbp, rsp

    push r12
    push r13

    mov r12, rdi

    mov rdi, [r12]
    mov rsi, [r12+8]
    call cardNew
    mov r13, rax 

    cmp qword [r12+16], 0
    JE .noHayLista

    mov rdi, [r12+16] 
    call listClone
    mov [r13+16], rax 

.noHayLista:
    mov rax, r13

    pop r13
    pop r12
    pop rbp
    ret

; void cardAddStacked(card_t* c, card_t* card)
cardAddStacked:
    push rbp
    mov rbp, rsp
    push r12
    push r15
    
    mov r15, rdi
    mov r12, rsi

    cmp qword [r15+16], 0   
    jne .insertarElemento  

    mov rdi, 0
    mov rdi, 3
    call listNew 
    mov [r15+16], rax

.insertarElemento:
    mov rdi, [r15+16]
    mov rsi, r12
    call listAddFirst

    pop r15
    pop r12
    pop rbp
    ret

; void cardDelete(card_t* c)
cardDelete:
    PUSH RBP
    MOV RBP, RSP
    PUSH r12
    sub rsp, 8
    

    mov r12, rdi

    cmp qword [r12+16], 0
    je .fin

    mov rdi, [r12+16]
    call listDelete
.fin:
    mov rdi, [r12]
    call strDelete

    mov rdi, [r12+8]
    call intDelete

    mov rdi, r12
    call free

    add rsp, 8
    pop r12
    POP RBP

    ret

; void cardPrint(card_t* c, FILE* pFile)
cardPrint:
    push rbp
    mov rbp, rsp
    push r12
    push r13

    mov r12, rdi
    mov r13, rsi
    
    mov rax, 0
    mov rdi, r13
    mov rsi, formato_6
    call fprintf
    
    mov rax, 0
    mov rdi, [r12 + 0]
    mov rsi, r13
    call strPrint

    mov rax, 0
    mov rdi, r13
    mov rsi, formato_7
    call fprintf

    mov rax, 0
    mov rdi, [r12 + 8]
    mov rsi, r13
    call intPrint

    mov rax, 0
    mov rdi, r13
    mov rsi, formato_7
    call fprintf

    mov rax, 0

    mov rdi, [r12 + 16]
    mov rsi, r13
    call listPrint

    mov rax, 0
    mov rdi, r13
    mov rsi, formato_8
    call fprintf
.fin:
    pop r13
    pop r12
    pop rbp
    ret

;auxiliares
listGetAux:

    push rbp
    mov rbp, rsp

    mov r9,0
    mov r9d, dword [rdi+4]

    cmp rsi, r9
    JGE .finInvalido
    cmp rsi, 0
    JL .finInvalido


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