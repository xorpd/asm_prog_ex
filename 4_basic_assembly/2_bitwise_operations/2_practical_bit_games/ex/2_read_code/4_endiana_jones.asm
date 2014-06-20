; Basic Assembly
; ==============
; 
; Bitwise operations - Practical bit games
; ----------------------------------------
;
; Endiana Jones
; @@@@@@@@@@@@@
;
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;
; 2.    Try to give different inputs to this program, and check the results.
;       Particularly, check the following input: 11223344.
;
; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
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
    mov     ecx,4
pass_byte:
    shl     ebx,8
    mov     bl,al
    shr     eax,8
    loop    pass_byte

    mov     eax,ebx
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
