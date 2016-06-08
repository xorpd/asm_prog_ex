; Basic Assembly Answers
; ======================
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
;	ANSWER:
;
;		Two inputs, because read_hex is called two times.
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
;		Two numbers a and b are given by user input. b is subtracted from a and 
;		when the carry flag is set, this means that a is larger than b, the
;		output will be 1 and else the output will be 0. This function checks
;		if a is larger than b and vice versa.
;       
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;
;       Question: How does this program work with signed numbers, like
;       0xffffffff?
;
;	ANSWER:
;
;		FF,FF 		-> 0
;		4,1			-> 1
;		FFFFFFFF,0	-> 1
;
;		This program doesn't care about signed numbers. The carry flag is simply
;		set when a calculation results in a carry or borrow. It is up to the user
;		to work with signed numbers, although the carry flag tells us nothing 
;		about signed numbers.
;
; 5.    Give better names to the labels in the program, so that it would be
;       easier to read and understand. Make sure that the program still
;       assembles and runs correctly after your modifications.
;
;	ANSWER:
;		
;		The program below is modified.

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
    jc      first_largest

second_largest_or_equal:
    mov     eax,0
    call    print_eax
    jmp     end_program
    
first_largest:
    mov     eax,1
    call    print_eax

end_program:
    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
