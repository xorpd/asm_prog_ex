; 2. Find out a way to implement NEG using the SUB instruction (And some other
;    instructions that we have learned). Write a small piece of code which
;    demonstrates your conclusion.
;
;	ANSWER:
;
;	Subtract every number from 0xffffffff. This is the flipping of all bits.
;	Then add 1 to the result.
;

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:

	call 	read_hex

	mov		ebx, 0ffffffffh

	sub		ebx, eax
	inc		ebx
	mov		eax, ebx
	call 	print_eax

stop:
    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
