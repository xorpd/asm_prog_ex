; 1.  Write a program that takes three numbers as input: x,y,z. Then it prints 1
;     to the console if x < y < z. It prints 0 otherwise.
; 
;     NOTE: The comparison should be in the unsigned sense. That means for
;     example: 0x00000003 < 0x7f123456 < 0xffffffff
;
;		ANSWER:
;
;			With subtraction we can compare if 1 number is larger then the other.
;			Subtract z from y and jump when the number is signed. Then subtract
;			y from x and jump when the number is signed.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
	call 	read_hex
	; store x in ebx
	mov		ebx, eax

	call 	read_hex
	; store y in ecx
	mov		ecx, eax

	call 	read_hex
	; store z in edx
	mov		edx, eax

	sub 	edx, ecx
	js		print_0

	sub 	ecx, ebx
	js		print_0

	call	print_1
	
print_0:
	mov		eax, 0
	call	print

print_1:
	mov		eax, 1
	call	print

print:
	call	print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
