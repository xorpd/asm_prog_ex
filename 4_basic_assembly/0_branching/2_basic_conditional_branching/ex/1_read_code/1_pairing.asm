; Basic Assembly
; ==============
; 
; Basic Conditional Branching
; ---------------------------
;
; Read Code
; ---------
;
; Pairing
; @@@@@@@
; 
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;
; 2.    Try to give different inputs to this program, and check the results.
;
; 3.    Read the program's code below, and try to understand it. 
;       Try to describe it as simply as you can.
;       
;       Note that the relevant part of the code is from the "start" label until
;       the [ExitProcess] call invocation. You do not need to read the input and
;       output subroutines.
;       
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; The program begins here:

    call    read_hex
    mov     ecx,eax
    call    read_hex
    mov     edx,eax
    call    read_hex
    mov     esi,eax
    call    read_hex
    add     eax,ecx
    add     edx,esi
    sub     eax,edx

    jnz     g1

    mov     eax,1
    call    print_eax
    jmp     g2

g1:
    mov     eax,0
    call    print_eax
g2:

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
