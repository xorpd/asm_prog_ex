;  0.1 Write a program that takes the value m as input. It then receives m
;      consecutive numbers from the user, sums all those numbers and prints back
;      the total sum to the console.
;		
;		ANSWER:
;			
;			Read the first number m. Then create a loop that asks for m numbers
;			of user input. Sum all those numbers and output that to 
;			the screen. (we don't check invalid inputs)

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
	call 	read_hex
	; store m in ecx
	mov		ecx, eax
	; clear ebx
	mov		ebx, 0
	
read_more_hex:
	call 	read_hex
	add		ebx, eax
	dec		ecx
	jnz		read_more_hex

print:
	mov		eax, ebx
	call	print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
