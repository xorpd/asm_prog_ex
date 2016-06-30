; 2. Write a program that takes the number n as input, and prints back all the
;    triples (a,b,c), such that a^2 + b^2 = c^2.
;
;    These are all the pythagorean triples not larger than n.
format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

;	n is the max. that a, b and c can get.
;	Create a loop that increases a.
;	Create a loop that increases b.
;	Create a loop that increases c.
;	Check if a^2 + b^2 = c^2, if so, print the triple
;   Limit of the program is max. n of 8 bits (ony 4 bits when negatives are
;	removed). For the sake of readablility.
;   When inserted a negative (8 bits) number, program just returns
start:
    call    read_hex

	mov		cl, al		; user input, capped to 8 bits

	mov		ch, cl		; a counter ch
	mov		bl, cl		; b counter bl
	mov		bh, cl		; c counter bh

	mov		esi, 0		; used to add a^2 and b^2

calculate:
	mov		edx, 0
	mov		eax, 0
	mov   al, ch
	mul   eax       ; a^2
	mov		esi, eax	; store a^2 in esi

	mov		edx, 0
	mov		eax, 0
	mov		al, bl
	mul   eax       ; b^2
	add		esi, eax	; a^2 + b^2

	mov		edx, 0
	mov		eax, 0
	mov		al, bh
	mul 	eax			; c^2 in eax
	cmp		esi, eax	; (a^2 + b^2) == (c^2)

	jnz		no_print	; IF pythagoras is valid

	mov		eax, 0		; THEN
	mov		al, ch
	call	print_eax
	mov		al, bl
	call	print_eax
	mov		al, bh
	call	print_eax

no_print:				; ELSE

	dec   ch
	jns   calculate

	mov 	ch, cl    ; restore a to n
	dec   bl
	jns   calculate

	mov 	bl, cl    ; restore b to n
	dec   bh
	jns   calculate

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
