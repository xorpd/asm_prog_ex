; Basic Assembly
; ==============
; 
; Basic Conditional Branching
; ---------------------------
;
; Read Code
; ---------
;
; simp cmp
; @@@@@@@@
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
;       Question: How does this program work with signed numbers, like
;       0xffffffff?
;
; 5.    Give better names to the labels in the program, so that it would be
;       easier to read and understand. Make sure that the program still
;       assembles and runs correctly after your modifications.

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
    sub     eax,ecx
    jc      b1

s1:
    mov     eax,0
    call    print_eax
    jmp     c1
    
b1:
    mov     eax,1
    call    print_eax

c1:
    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
