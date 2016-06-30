; Basic Assembly Answers
; ======================
;
; Structured branching
; --------------------
;
; Pasta
; @@@@@
;
; You are given a piece of spaghetti code, and you are going to understand it
; and then fix it, to be a normal readable piece of code.
;
; Enjoy your food :)
;
;
; 0.    Assemble and run this program.
;
; 1.    How many inputs does this program expect?
;
;	ANSWER:
;
;		One.
;
; 2.    Try to give different inputs to this program, and check the results.
;
;	ANSWER:
;
;		0 -> (inifinite loop?)
;		1 -> 1
;		2 -> 3
;		3 -> 6
;		ff -> 659a
;		ffffffff -> (inifinite loop?)
;		fffffff -> 5999999a
;
; 3.    Read the program's code below, and try to understand what does it do.
;       Try to describe it as simply as you can.
;
;	ANSWER:
;
;		The program takes a user input, check if it is divisible by 5 with a
;		remainder. When it is, the value is stored. Then the user input is decreased
;		by 1 and again check if it is divisible by 5. When there is a remainder the
;		current user input is added to the result. This continues until the user input
;		is 0. The sum is printed.
;
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;
;	ANSWER:
;
;		4 -> a
;		5 -> a
;		6 -> 10
;		-1 -> inifinite loop
;
; 5.    Try to think about a better design for this code:
;       What kinds of loops are you going to use?
;       What kind of branches are you going to use?
;
;       Make the changes to the code. Make sure your new code has no
;       intersecting branches. Also make sure that it is readable, and well
;       commented. Finally, make sure that it has exactly the same output as the
;       original code.
;
;	ANSWER:
;
;		Remove the "discard last" function, only add the user input to ebx when
;		we have a remainder.
;
;
;

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov     ecx,eax				; user input in ecx

    mov     ebx,0

iters:                    ; LOOP START
    mov     esi,5d
    mov     eax,ecx				; eax = user input
    mov     edx,0
    div     esi           ; user input / 5
    cmp     edx,0

    jz      dec_continue  ; IF we have no remainder
    add     ebx,ecx				; ELSE add user input to ebx

dec_continue:           ; THEN
    dec     ecx         ; decrease user input
    jnz     iters				; LOOP END

    mov     eax,ebx
    call    print_eax

end_prog:

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
