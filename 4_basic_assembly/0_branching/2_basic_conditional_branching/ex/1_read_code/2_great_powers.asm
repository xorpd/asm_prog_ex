; Basic Assembly
; ==============
; 
; Basic Conditional Branching
; ---------------------------
;
; Read Code
; ---------
;
; Great Powers
; @@@@@@@@@@@@
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
;
; 5.    Given the input of 0, what is the output of this program?
;       Why does it take so long for the program to compute it?
;
;       Is it the right output?
;       If not, fix the program to give back the right output.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; The program begins here:

    call    read_hex
    mov     ecx,1

lb1:
    add     ecx,ecx
    dec     eax
    jnz     lb1

    mov     eax,ecx
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
