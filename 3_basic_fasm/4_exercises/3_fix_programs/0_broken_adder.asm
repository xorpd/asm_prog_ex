; Basic fasm
; ==========
; 
; Fix Programs
; ------------
;
; Broken Adder
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

    ; Read two numbers:
    call    read_hex    
    mov     esi,al
    call    read_hex

    ; Add the two numbers, to get their sum.
    add     eax,esi

    ; Output the sum:
    call    print_eax   

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
