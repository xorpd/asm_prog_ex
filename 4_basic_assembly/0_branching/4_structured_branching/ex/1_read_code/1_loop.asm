; Basic Assembly
; ==============
; 
; Structured branching
; --------------------
;
; loop
; @@@@
; 
; The loop instruction is a great addition to your vocabulary of known
; instructions. It's signature is:
;
;   loop    label
;
; It is equivalent in operation to the following two instructions:
; 
;   dec     ecx
;   jnz     label
;
; The following program is going to make use of the loop instruction.
; 
;
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;
; 2.    Try to give different inputs to this program, and check the results.
;
; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can.
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
    mov     ecx,eax
    mov     esi,0

again:
    mov     eax,ecx
    mul     eax
    add     esi,eax
    loop    again       ; The new loop instruction:
                        ; It is equivalent to those two instructions:
                        ; dec   ecx
                        ; jnz   again

    mov     eax,esi
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
