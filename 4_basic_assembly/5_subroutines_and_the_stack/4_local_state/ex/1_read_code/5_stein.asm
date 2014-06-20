; Basic Assembly
; ==============
; 
; Subroutines and the stack - Local state
; ---------------------------------------
; 
; Stein
; @@@@@
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
; 4.    Follow the contents of the stack as stein is being executed.
;       Hint: You can print the contents of a and b to the console at every
;       invocation of the stein function.
;
; 5.    Bonus: What is the complexity of this algorithm? How many invocations of
;       stein are expected for an initial pair of numbers (a,b)?
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    enter_two       db  'Enter two numbers:',13,10,0
    result          db  'Result: ',0
; ===============================================
section '.text' code readable executable

start:
    ; Ask for two numbers:
    mov     esi,enter_two
    call    print_str

    ; Read two numbers:
    call    read_hex
    mov     edx,eax
    call    read_hex

    ; Calculate result:
    push    eax
    push    edx
    call    stein
    add     esp,2*4

    ; Print result:
    mov     esi,result
    call    print_str
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

; ===========================================================
; stein(a,b)
;
; Input:
;   ?
; Output:
;   ?
; Operations:
;   ?
;
stein:
    .a = 8
    .b = 0ch
    enter   0,0
    push    esi
    push    edi
    push    ecx
    push    ebx

    mov     esi,[ebp + .a]
    mov     edi,[ebp + .b]

    mov     eax,esi
    test    edi,edi
    jz      .end_func

    mov     eax,edi
    test    esi,esi
    jz      .end_func

    xor     ebx,ebx

    mov     ecx,esi
    not     ecx
    and     ecx,1
    shr     esi,cl
    add     ebx,ecx

    mov     ecx,edi
    not     ecx
    and     ecx,1
    shr     edi,cl
    add     ebx,ecx

    test    ebx,ebx
    jnz     .not_both_odd

    cmp     esi,edi
    jae     .a_bigger_equal
    xchg    esi,edi         ; Exchanges the contents of esi,edi
.a_bigger_equal:

    sub     esi,edi
    shr     esi,1
.not_both_odd:
    
    push    edi
    push    esi
    call    stein
    add     esp,4*2

    mov     ecx,ebx
    shr     ecx,1
    shl     eax,cl

.end_func:
    pop     ebx
    pop     ecx
    pop     edi
    pop     esi

    leave
    ret

include 'training.inc'
