; Basic Assembly
; ==============
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
; 2.    Try to give different inputs to this program, and check the results.
;
; 3.    Read the program's code below, and try to understand what does it do. Try
;       to describe it as simply as you can.
;       
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
; 
; 5.    Identify the different structured branching constructs inside this
;       code: Identify IF,FOR,WHILE and BREAK.
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

looper:
    call    read_hex
    cmp     eax,edx

    jbe     eax_is_smaller
    mov     edx,eax

eax_is_smaller:
    dec     esi
    jnz     looper

    mov     eax,edx
    call    print_eax
    

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
