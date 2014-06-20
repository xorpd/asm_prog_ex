; Basic Assembly
; ==============
; 
; Subroutines and the stack - CALL and RET
; ----------------------------------------
;
; Stack Balance
; @@@@@@@@@@@@@
;
; During the execution of your program, ESP decreases whenever a dword is pushed
; into the stack, and ESP increases whenever a dword is popped from the stack.
;
; A correct program will end with the same ESP value it began with. In this case
; we say that the stack is balanced.
;
; If a piece of code that you wrote does not end with a balanced stack, it means
; that it leaks stack space. If you execute that same piece of code many times,
; your stack will overflow and the program will crash. And this is only the good
; case of what could happen. Unbalanced stack could cause execution to move to
; arbitrary locations in memory, and such problems could be hard to trace.
;
; Hence stack balance is of high importance.
;
; The following code demonstrates how can you check for leaks in your program.
; We print the value of ESP before and after some piece of code, to make sure
; that it hasn't changed.
;
; -----------------------------------------------------------------------------
;
; 0.    Assemble and run this program.
;
; 1.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
; 2.    Explain the program's output.
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    my_arr          dd      5,8,143h,0,0fah,32h,45h,191h,14h,0,8h,13h,17h
    MY_ARR_LEN = ($ - my_arr) / 4

    cur_esp         db      'Current ESP value: ',0

; ===============================================
section '.text' code readable executable

start:

    ; Print the value of esp:
    mov     esi,cur_esp
    call    print_str
    mov     eax,esp
    call    print_eax

    ; Find maximum using get_max:
    mov     esi,my_arr
    mov     ecx,MY_ARR_LEN
    call    get_max
    call    print_eax

    ; Print again the value of esp:
    mov     esi,cur_esp
    call    print_str
    mov     eax,esp
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]


; ================================================
; Input:
;   esi -- address of array of dwords.
;   ecx -- Amount of dwords in the array.
; Output:
;   eax -- Largest dword in the array (Maximum).
;
get_max:
    xor     eax,eax     ; Initial maximum is zero.
    jecxz   .end_func
    push    edx         ; Keep edx to stack.
    xor     edx,edx     ; Iterator.
.iter:
    cmp     dword [esi + 4*edx],eax
    jbe     .skip_new_max
    ; We have a new maximum:
    mov     eax,dword [esi + 4*edx]
.skip_new_max:
    inc     edx
    cmp     edx,ecx
    jnz     .iter
    pop     edx         ; Restore edx from stack.
.end_func:
    ret

include 'training.inc'
