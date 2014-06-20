; Basic Assembly
; ==============
; 
; Subroutines and the stack - Local state
; ---------------------------------------
; 
; Minggatu
; @@@@@@@@
;
; 0.    Assemble and run this program.
;
; 1.    Give the program some example inputs, and observe the output.
;
; 2.    Skim the code. Take a look at the functions and their descriptions.
;       Understand the dependencies between the functions (Which function calls
;       which function), and what is the special purpose of every function.
;
; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
;       Fill in briefly the Input, Output and Operation comments for every
;       function in the code.
;
; 4.    Bonus: What is the meaning of the output numbers? Can you find a closed
;       formula for those numbers?
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    wanted_elem     db  'Enter wanted element number: ',0
    elem_value      db  'Wanted element value: ',0

; ===============================================
section '.text' code readable executable

start:
    mov     esi,wanted_elem
    call    print_str
    call    read_hex

    push    eax
    call    calc_num
    add     esp,4

    mov     esi,elem_value
    call    print_str
    call    print_eax

    ; Exit the process:
    push    0
    call    [ExitProcess]

; ===============================================
; calc_num(index)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;   ?
;
calc_num:
    .index = 8
    push    ebp
    mov     ebp,esp

    push    ecx
    push    esi
    push    ebx

    mov     ecx,dword [ebp + .index]
    lea     ebx,[4*ecx]
    sub     esp,ebx
    mov     esi,esp

    xor     ebx,ebx
    mov     eax,1

.calc_next_num:
    ; Store the result into the array:
    mov     dword [esi + 4*ebx],eax
    
    inc     ebx
    push    ebx
    push    esi
    call    calc_next
    add     esp,4*2

    cmp     ebx,ecx
    jb      .calc_next_num
    
    mov     ecx,dword [ebp + .index]
    lea     ebx,[4*ecx]
    add     esp,ebx

    pop     ebx
    pop     esi
    pop     ecx

    pop     ebp
    ret

; ===============================================
; calc_next(arr_addr,arr_len)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;   ?
;
calc_next: 
    .arr_addr = 8
    .arr_len = 0ch
    push    ebp
    mov     ebp,esp

    push    ebx
    push    ecx
    push    esi
    push    edi
    push    edx

    mov     ecx,dword [ebp + .arr_len]
    jecxz   .arr_len_zero
    mov     esi,dword [ebp + .arr_addr]
    mov     edi,dword [ebp + .arr_addr]
    lea     edi,[edi + 4*ecx - 4]

    xor     ebx,ebx
.next_mul:
    mov     eax,dword [esi]
    mul     dword [edi]
    add     ebx,eax
    add     esi,4
    sub     edi,4
    loop    .next_mul

    mov     eax,ebx
    jmp     .end_func
.arr_len_zero:
    xor     eax,eax
.end_func:
    
    pop     edx
    pop     edi
    pop     esi
    pop     ecx
    pop     ebx

    pop     ebp
    ret

include 'training.inc'
