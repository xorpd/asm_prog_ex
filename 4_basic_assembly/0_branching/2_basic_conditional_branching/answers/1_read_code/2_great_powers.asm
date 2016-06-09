; Basic Assembly Answers
; ======================
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
;	ANSWER:
;
;		The function read_hex is called 1 time, so 1 input.
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
;		A number is inputted by the user and ecx is set to 1. Then ecx is added
;		with it's own number. The input by the user is decreased by 1 and checked
;		if the decrements result is 0. If not, we jump to lb1 label again and add
;		ecx again with it's own number. We decrease the number of the user again
;		and check if the result is 0. This continues until The number of the user
;		is zero. When we reach zero, we move the number of ecx to eax and print 
;		it.
;			
;		f(x) = 2^a
;       
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;
;	ANSWER:
;
;		1 -> 2
;		3 -> 8
;		4 -> 10
;		6 -> 40
;		8 -> 100
;		9 -> 200
;		F -> 8000
;		FF -> 0
;
; 5.    Given the input of 0, what is the output of this program?
;       Why does it take so long for the program to compute it?
;
;       Is it the right output?
;       If not, fix the program to give back the right output.
;
;	ANSWER:
;	
;		The program will first decrease 0 by 1 = -1. Then it will check if 
;		it is zero. Since we will decrease infinitely into the negative,
;		zero is never reached again and the program is in an infinite loop.
;		The output should be 1, because 2^0 = 1.
;
;		The program below is the one that is fixed. First check if the 
;		input of the user is already 0. If so, jump to the end. Introduce
;		an inc, followed by a dec, so eax is untouched but the ZF is set 
;		accordingly. Create a label lb2 and when eax is 0, jump to it. 

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; The program begins here:

    call    read_hex
    mov     ecx,1
	inc		eax
	dec		eax
	jz		lb2

lb1:
    add     ecx,ecx
    dec     eax
	jnz		lb1

lb2:
    mov     eax,ecx
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
