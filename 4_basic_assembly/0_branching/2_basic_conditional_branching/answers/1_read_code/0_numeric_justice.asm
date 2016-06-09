; Basic Assembly Answers
; ======================
; 
; Basic Conditional Branching
; ---------------------------
;
; Read Code
; ---------
;
; Numeric Justice
; @@@@@@@@@@@@@@@
; 
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;
;	ANSWER:
;	
;		Two, because the function read_hex is called two times.
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
;	ANSWER:
;	
;		Two inputs are read from console and subtracted from each other. When the
;		result of the subtraction is not 0, we jump to l1, which then sets eax to 0 
;		and prints eax. If the result of the subtraction is 0, we set eax to 1 and 
;		print eax. The program prints 1 when the numbers are the same and 0 when
;		the numbers are not the same (limited to 8 hex characters).
;
;		f(x) = b - a
;       
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;	
;	ANSWER:
;	
;		1,1 -> 1
;		1,9 -> 0
;		FFFF,FFFF -> 1

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
    jnz     l1

    mov     eax,1
    call    print_eax
    jmp     l2

l1:
    mov     eax,0
    call    print_eax
l2:

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
