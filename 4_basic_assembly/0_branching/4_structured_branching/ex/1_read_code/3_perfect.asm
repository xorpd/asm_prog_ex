; Basic Assembly
; ==============
; 
; Structured branching
; --------------------
;
; Perfect
; @@@@@@@
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
;       (Hint: Search about Perfect numbers on the web.)
;
; 4.    Add comments to the code, to make it more readable.
;       
; 5.    Pick some random inputs and verify your predictions about what this
;       program does.
; 
; 6.    Identify the different structured branching constructs inside this
;       code: Identify IF,FOR,WHILE and BREAK.
; 
; 7.    Try to give the program input of 0x100000. Why does it take the program
;       so long to finish the calculation?

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    
    call    read_hex
    mov     esi,eax
    mov     ecx,2

iters:
    mov     edi,1
    mov     ebx,0

sum_divisors:
    mov     eax,ecx
    mov     edx,0
    div     edi
    cmp     edx,0
    jnz     non_divisible
    add     ebx,edi
non_divisible:
    inc     edi
    cmp     edi,ecx
    jnz     sum_divisors

    cmp     ebx,ecx
    jnz     not_perfect
    mov     eax,ecx
    call    print_eax

not_perfect:
    inc     ecx
    cmp     ecx,esi
    jnz     iters

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
