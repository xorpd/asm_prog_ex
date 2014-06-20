; Basic Assembly
; ==============
; 
; Subroutines and the stack - CALL and RET
; ----------------------------------------
;
; Rec Adder
; @@@@@@@@@
;    
; 0.    Assemble and run this program.
;
; 1.    Try to give the program different inputs, and observe the output.
;       Give some small numbers as input in the beginning.
;
; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
;       Take out a pen and a paper, and find out what happens to the stack
;       during this program.
;
; 3.    Explain the program's output.
;
; 4.    Try to give the program large numbers as input. What happens? Why?
;       Evaluate the size of the stack using this experiment.
;
; NOTE: 
;       The technique employed in this code where a function calls itself is
;       called Recursion.
;
;       This example is very inefficient, but serves as an example for a
;       Recursive function.
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    enter_first     db  'Enter first number: ',0
    enter_second    db  'Enter second number: ',0
    result_is       db  'The result is: ',0

; ===============================================
section '.text' code readable executable

start:
    mov     esi,enter_first
    call    print_str
    call    read_hex
    mov     ecx,eax

    mov     esi,enter_second
    call    print_str
    call    read_hex

    call    adder

    mov     esi,result_is
    call    print_str
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

; =================================================
; Input: ?
; Output: ?
;
adder:
    jecxz   .end_func
    dec     ecx
    inc     eax
    call    adder
.end_func:
    ret

include 'training.inc'
