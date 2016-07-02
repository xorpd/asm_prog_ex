; Basic Assembly Answers
; ======================
;
; Signed Operations
; -----------------
;
; Diva
; @@@@
;
; 0.    Assemble and run this program.
;
; 1.    How many inputs does this program expect?
;
;	ANSWER:
;
;		Two.
;
; 2.    Try to give different inputs to this program, and check the results.
;
;	ANSWER:
;
;		4,2 -> 2
;		8,1 -> 1
;
; 3.    Read the program's code below, and try to understand what does it do. Try
;       to describe it as simply as you can.
;
;	ANSWER:
;
;		The program reads 2 inputs and goes to divide them. First  it reads the
;		dividend, second the divisor. This program only divides the whole numbers,
;		not taking into account the remainder.
;
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;
;	ANSWER:
;
;		5,3 -> 1
;		1,8 -> 0
;		-6,2 -> ffffffffd
;		-F,-2 -> 7
;
; 5.    What happens if you try to give the program negative values? (Note that
;       you may just use the minus symbol, for example: -10.
;       Is the result correct? What happens if both of the of the arguments are
;       negative?
;
;	ANSWER:
;
;		The program deals with signed numbers and the quotient is the signed answer.
;		The resut is correct as we can see in our previous examples. When both
;		arguments are negative, the quotient is positive (- / - = +)
;
; 6.    Try to change the "cdq" instruction to "mov edx,0", and check what
;       results do you get now. Do you still get correct results for negative
;       numbers?
;
;	ANSWER:
;
;		5,3 -> 1
;		1,8 -> 0
;		-6,2 -> 7ffffffd
;		-F,-2 -> 80000008
;
;		No, the results are not good.
;
; 7.    Implement the "cdq" instruction yourself, using an IF style
;       conditional (With CMP and the relevant JCC instruction).
;       Make sure that you get the same results as in the original program.
;
;	ANSWER:
;
;		See the instructions below.
;

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov     esi,eax
    call    read_hex
    mov     edi,eax

    mov     eax,esi

    mov     ebx, 0                  ; needed for the comparison
    cmp     eax, ebx                ; check if eax is signed
    js      is_smaller_than_zero
    mov     edx, 0
    jmp     end_if

is_smaller_than_zero:
    mov     edx, 0xffffffff

end_if:
    idiv    edi

    call    print_eax


    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
