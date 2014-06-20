; Basic Assembly
; ==============
; 
; Bitwise operations - Practical bit games
; ----------------------------------------
;
; Party
; @@@@@
;
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;
; 2.    Try to give different inputs to this program, and check the results.
;       Particularly: Check the results you get for the following inputs:
;       0,1,2,4,8,ffffffff
;
; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;       
; 4.    What is the largest output that you have managed to get from the program?
;       What is the largest possible output? Can you find a way to reach it?
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    call    read_hex

    xor     ebx,ebx     ; Zero ebx.
    mov     ecx,32d

xor_bit:
    mov     esi,eax
    and     esi,1
    xor     ebx,esi
    ror     eax,1
    loop    xor_bit

    mov     eax,ebx
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
