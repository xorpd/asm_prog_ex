; 0.  
;   0.0 Write a program that takes the value n as input, and finds the sum of
;       all the odd numbers between 1 and 2n+1, inclusive.
;	
;		ANSWER:
;		
;			So 1 is the lower bound, and 2n+1 is the upper bound. So take some
;			examples of inputs (n) and upper bound results:
;	
;			1 -> range from 1 to 3
;			2 -> range from 1 to 5
;			4 -> range from 1 to 9
;		
;			Calculate some expected program outputs with gives ranges:
;
;			1 to 3 -> 1 + 3 = 0x4	
;			1 to 5 -> 1 + 3 + 5 = 0x9
;			1 to 9 -> 1 + 3 + 5 + 7 + 9 = 0x19
;
;			A possible way to make a program is to take the upper bound, 
;			and add the previous lower number and work down till and check 
;			if we reached 1 (or -1). In that case, output the result.


format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; Your program begins here:

    call    read_hex
	; calculate 2n+1
	; do eax times 2
	add		eax, eax
	; increase eax by 1
	inc		eax
	mov		ebx, eax		

lower_and_sum:
	dec		eax
	; when we reached zero, jump
	jz		print	
	dec		eax
	add		ebx, eax
	jmp		lower_and_sum
	
print:
	; move the sum to eax to print
	mov		eax, ebx
	call 	print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
