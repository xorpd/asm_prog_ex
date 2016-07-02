; Basic Assembly Answers
; ======================
;
; Structured branching
; --------------------
;
; mx
; @@@
;
; 0.    Assemble and run this program.
;
; 1.    How many inputs does this program expect?
;
;	ANSWER:
;
;		It expects 1 input at the start, and based on that a number of other inputs.
;		The first input is a counter for the number of other inputs.
;
; 2.    Try to give different inputs to this program, and check the results.
;
;	ANSWER:
;
;		2,1,7 -> 7
;		1,1 -> 1
;		3,1,4,3 -> 4
;
; 3.    Read the program's code below, and try to understand what does it do. Try
;       to describe it as simply as you can.
;
;	ANSWER:
;
;		The first input determines how many other inputs the user must give. Those other
;		inputs are evaluated and the highest number is the output of the program.
;
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;
;	ANSWER:
;
;		3,1,2,3 -> 3
;		2,FFFF,8 -> FFFF
;
; 5.    Identify the different structured branching constructs inside this
;       code: Identify IF,FOR,WHILE and BREAK.
;
;	ANSWER:
;
;		The comments behind the code describe the branches.
;
;

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov     esi,eax
    mov     edx,0

looper:                     ; FOR: begin for loop
    call    read_hex
    cmp     eax,edx

    jbe     eax_is_smaller  ; IF: if construct
    mov     edx,eax         ; IF: then

eax_is_smaller:             ; IF: else
    dec     esi             ; FOR: decrement the counter
    jnz     looper          ; FOR: end for loop

    mov     eax,edx
    call    print_eax


    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
