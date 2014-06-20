; Basic fasm
; ==========
; 
; Fix Programs
; ------------
;
; Lame Formula
; @@@@@@@@@@@@
; 
; 0.    Try to assemble and find out the assembly error message.
;
; 1.    Fix the code to make the assembly process succeed.
;
; 2.    Run the program. Make sure that the program behaves correctly.
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; The program begins here:

    ; Read three numbers a,b,c:
    call    read_hex    ; a
    mov     ebx,eax
    call    read_hex    ; b
    mov     ecx,eax
    call    read_hex    ; c

    mult    ecx         ; b * c
    add     eax,ebx     ; (b * c) + a

    ; Output the result (b * c) + a
    call    print_eax   

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
