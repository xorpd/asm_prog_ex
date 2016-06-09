;  3.1   Write a program that takes a number n as input, and prints back to the
;        console all the primes that are larger than 1 but not larger than n.
;
;		ANSWER:
;
;			Start at 1 (we can't divide by zero) and go up to n. For every n, 
;			divide by all previous numbers > 2 and check if we have a prime. 
;
;			Use code from the previous exercise.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
	call 	read_hex

	; original user input in ebx, because we are gonna use eax in division
	mov 	ebx, eax

	; use a counter for next_n, start at 0
	mov 	esi, 0

next_n:
	inc		esi
	mov		edx, esi
	sub		edx, ebx
	jz 		exit

	; counter for do_division
	mov 	ecx, esi

do_division:
	dec 	ecx

	; when ecx < 2, just print and continue
	mov		edx, ecx
	sub		edx, 2
	js		print_esi

	; clear edx for division
	mov 	edx, 0
	mov 	eax, esi

	; edx:eax / ecx, result is stored in edx:eax (remainder:quotient)
	div		ecx

	; set the flags
	sub		edx, 0
	jnz		do_division

	; if no prime is found, go to next_n
	jmp		next_n

print_esi:
	mov		eax, esi
	call	print_eax
	jmp		next_n

exit:
    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
