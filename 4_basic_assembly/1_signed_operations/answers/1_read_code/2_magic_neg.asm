; Basic Assembly Answers
; ======================
;
; Signed Operations
; -----------------
;
; Magic NEG
; @@@@@@@@@
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
;		-1 -> -1
;		FFFF -> FFFF
;		7FFFFFFF -> 7FFFFFFF
;
; 3.    Read the program's code below, and try to understand what does it do. Try
;       to describe it as simply as you can.
;
;	ANSWER:
;
;		The code takes the two's complement and adds 1. Then is performs the two's
;		complement again and adds one again. Since the two's complement is taking the
;		inverse of the binary and add 1, it means that the second increase, is
;		actualy a decrease. So we increase and decrease by 1, and negate two times.
;		This should always give us the same result.
;
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;
;	ANSWER:
;
;		-1FFF -> ffffe001
;		AEB -> AEB
;		-A -> FFFFFFF6
;		-9 -> FFFFFFF7
;

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    neg     eax
    inc     eax
    neg     eax
    inc     eax
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
