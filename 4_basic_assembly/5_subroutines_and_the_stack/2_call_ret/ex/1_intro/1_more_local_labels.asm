; Basic Assembly
; ==============
; 
; Subroutines and the stack - CALL and RET
; ----------------------------------------
;
; More Local labels
; @@@@@@@@@@@@@@@@@
;
; 0.    Assemble and run this program.
;
; 1.    Try to give the program different inputs, and observe the output.
;
; 2.    Skim the code. Take a look at the functions and their descriptions.
;       Understand the dependencies between the functions (Which function calls
;       which function), and what is the special purpose of every function.
;
; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
; 4.    Explain the program's output.
;
; 5.    Note that we use the same local label name '.sum_loop' twice.
;       We use it once inside the calc_sum function, and we use it again inside
;       the calc_sum_squares functions.
;
;       In the first case the full name of the label is 'calc_sum.sum_loop'. In
;       the second case the full name of the label is
;       'calc_sum.calc_sum_squares'.
; 

format PE console
entry start

include 'win32a.inc' 


; ===============================================
section '.data' data readable writeable
    enter_num       db  'Enter n: ',0
    sum_is          db  'Total sum: ',0
    sum_sq_is       db  'Total sum of squares: ',0

; ===============================================
section '.text' code readable executable

start:
    mov     esi,enter_num
    call    print_str

    call    read_hex
    mov     ecx,eax

    call    calc_sum
    ; Print: Total sum: ____
    mov     esi,sum_is
    call    print_str
    call    print_eax

    call    calc_sum_squares
    ; Print: Total sum of squares: ____
    mov     esi,sum_sq_is
    call    print_str
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

; ===============================================================
; Input:
;   ecx -- the number n.
; Output:
;   eax -- The sum of all numbers from 1 to n.
;          1 + 2 + 3 + 4 + ... + n
;

; Note that calc_sum is a global label.
calc_sum:
    push    ecx     ; Save ecx to stack.
    xor     eax,eax
    jecxz   .loop_done  ; Refers to calc_sum.loop_done.
    ; NOTE: .sum_loop is a local label.
    ; Its full name is calc_sum.sum_loop.
.sum_loop:
    add     eax,ecx
    loop    .sum_loop   ; Refers to calc_sum.sum_loop.
    ; note: .loop_done is a local label.
    ; its full name is 'calc_sum.loop_done'.
.loop_done:
    pop     ecx         ; Restore ecx from stack.
    ret

; ===============================================================
; Input:
;   ecx -- the number n.
; Output:
;   eax -- The sum of all squares of number from 1 to n.
;          1^2 + 2^2 + 3^2 + ... + n^2.
;

; Note that calc_sum_squares is a global label.
calc_sum_squares:
    push    ecx     ; Save registers to stack.
    push    edi
    push    edx

    xor     edi,edi
    jecxz   .loop_done  ; Refers to calc_sum_squares.loop_done.
    ; note: .sum_loop is a local label.
    ; its full name is calc_sum_squares.sum_loop
.sum_loop:
    mov     eax,ecx
    mul     ecx
    add     edi,eax
    loop    .sum_loop   ; Refers to calc_sum_squares.sum_loop
    ; note: .loop_done is a local label.
    ; its full name is 'calc_sum_squares.loop_done'.
.loop_done:
    mov     eax,edi

    pop     edx         ; Restore registers from stack.
    pop     edi
    pop     ecx
    ret

include 'training.inc'
