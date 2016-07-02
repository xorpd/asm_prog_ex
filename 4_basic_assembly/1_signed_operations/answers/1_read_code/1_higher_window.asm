; Basic Assembly Answers
; ======================
;
; Signed Operations
; -----------------
;
; Higher Window
; @@@@@@@@@@@@@@
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
;		1 -> 0
;		FFF -> 0
;		F0000000 -> 1
;		FFFFFFFF -> 1
;		7FFFFFFF -> 0
;
; 3.    Read the program's code below, and try to understand what does it do. Try
;       to describe it as simply as you can.
;
;	ANSWER:
;
;		It will read one input, and outputs a 1 when it is a signed number, and it
;		will output a 0 when it is not a signed number.
;
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;
;	ANSWER:
;
;		-10 -> 1
;		-10000 -> 1
;		-FFFFFFFF -> 0
;		FFFFFFFF -> 1
;		F1 -> 0
;
; 5.    How could you implement this program without the cdq instruction? Write
;       your implementation as a new program, and make sure that it has the same
;       results.
;
;	ANSWER:
;
;		See the program below.
;

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    cmp     eax,0
    js      eax_is_signed
    mov     eax,0
    call    print_eax
    jmp     end_if
eax_is_signed:
    mov     eax,1
    call    print_eax
end_if:

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
