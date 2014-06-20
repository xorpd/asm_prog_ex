; Basic Assembly
; ==============
; 
; Signed Operations
; -----------------
;
; Magic NEG
; @@@@@@@@@
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

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    neg     eax
    inc     eax
    neg     eax
    inc     eax
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
