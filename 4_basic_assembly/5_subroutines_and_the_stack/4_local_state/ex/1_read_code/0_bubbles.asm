; Basic Assembly
; ==============
; 
; Subroutines and the stack - Local state
; ---------------------------------------
; 
; Bubbles
; @@@@@@@
;
; 0.    Assemble and run this program.
;
; 1.    Observe the output.
;
; 2.    Skim the code. Take a look at the functions and their descriptions.
;       Understand the dependencies between the functions (Which function calls
;       which function), and what is the special purpose of every function.
;
; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
;       For every function: Fill in the Input, Output and Operation. Be brief
;       and to the point.
;
; 4.    How can you reverse the final output of the program, with minimum amount
;       of changes to the code below?
;
; 5.    What is the complexity of this algorithm? (How many operations does it
;       take to execute this algorithm for an array of size N elements?)
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    nums        dd  8,15h,141h,0a2h,31h,14h,31h,82h,34h,55h
    NUMS_LEN = ($ - nums) / 4

    initial_arr     db  'Initial array:',13,10,0
    array_sorted    db  'Array sorted:',13,10,0


; ===============================================
section '.text' code readable executable

start:

    mov     esi,initial_arr
    call    print_str

    push    NUMS_LEN
    push    nums
    call    print_arr
    add     esp,4*2

    push    NUMS_LEN
    push    nums
    call    sort_arr
    add     esp,4*2

    mov     esi,array_sorted
    call    print_str

    push    NUMS_LEN
    push    nums
    call    print_arr
    add     esp,4*2

    ; Exit the process:
	push	0
	call	[ExitProcess]

; ================================================
; print_arr(arr_addr,arr_len)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;   ?
;
print_arr:
    .arr_addr = 8h
    .arr_len = 0ch
    push    ebp
    mov     ebp,esp

    push    esi
    push    ecx

    mov     ecx,[ebp + .arr_len]
    jecxz   .no_elements
    mov     esi,[ebp + .arr_addr]

.print_element:
    mov     eax,dword [esi]
    call    print_eax
    add     esi,4
    loop    .print_element

.no_elements:
    pop     ecx
    pop     esi

    pop     ebp
    ret

; ================================================
; sort_arr(arr_addr,arr_len)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;   ?
;
sort_arr:
    .arr_addr = 8h
    .arr_len = 0ch
    push    ebp
    mov     ebp,esp

    push    esi
    push    edi
    push    ecx
    push    ebx

    mov     esi,dword [ebp + .arr_addr]
    mov     ecx,dword [ebp + .arr_len]
    lea     ebx,[esi + 4*ecx] 

    jecxz   .no_elements
.outer_iter:
    mov     edi,esi
.inner_iter:
    push    edi
    push    esi
    call    compare_and_swap
    add     esp,4*2
    add     edi,4
    cmp     edi,ebx
    jb      .inner_iter
    add     esi,4
    cmp     esi,ebx
    jb      .outer_iter
.no_elements:

    pop     ebx
    pop     ecx
    pop     edi
    pop     esi

    pop     ebp
    ret


; ===============================================
; compare_and_swap(x_addr,y_addr)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;   ?
;
compare_and_swap:
    .x_addr = 8h
    .y_addr = 0ch
    push    ebp
    mov     ebp,esp

    push    esi
    push    edi
    push    eax

    mov     esi, dword [ebp + .x_addr]
    mov     edi, dword [ebp + .y_addr]
    mov     eax, dword [esi]
    cmp     eax,dword [edi]
    jae     .x_above_equal
    ; We only swap in the case where y > x:
    push    edi
    push    esi
    call    swap
    add     esp,4*2
.x_above_equal:

    pop     eax
    pop     edi
    pop     esi

    pop     ebp
    ret

; =================================================
; swap(x_addr,y_addr)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;   ?
;
swap:
    .x_addr = 8h
    .y_addr = 0ch
    push    ebp
    mov     ebp,esp

    push    esi
    push    edi

    mov     esi,dword [ebp + .x_addr]
    mov     edi,dword [ebp + .y_addr]

    push    dword [esi]
    push    dword [edi]
    pop     dword [esi]
    pop     dword [edi]

    pop     edi
    pop     esi

    pop     ebp
    ret

include 'training.inc'
