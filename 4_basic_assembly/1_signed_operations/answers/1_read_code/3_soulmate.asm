; Basic Assembly Answers
; ======================
;
; Signed Operations
; -----------------
;
; Soulmate
; @@@@@@@@
;
; 0.    Assemble and run this program.
;
; 1.    What are the numbers found by the program? Try to guess.
;
;	ANSWER:
;
;		It looks like the negation (two's complement) of both numbers must be
;		the same, then they are printed.
;
; 2.    Read the code below, and try to understand the meaning of the numbers
;       returned by the program.
;
;	ANSWER:
;
; 		We start searching at 0ffffffffh and decrease by 1. We negate every number
;		and check if they are the same. If they are, print it.
;
; 3.    Why does it take the program so long to complete? How many iterations
;       does the main loop goes through?
;
;	ANSWER:
;
;		From ffffffffh to 0. That are 2^32 iterations.
;

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:

    mov     ecx,0ffffffffh

iters:
    mov     eax,ecx
    neg     eax
    cmp     eax,ecx
    jnz     not_equal
    mov     eax,ecx
    call    print_eax
not_equal:
    dec     ecx
    cmp     ecx,0ffffffffh
    jnz     iters

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
