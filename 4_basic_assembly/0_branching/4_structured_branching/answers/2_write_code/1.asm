; 1. Write a program that takes the number n as input, and prints back all the
;    pairs (x,y) such that x < y < n.
;

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

;	Make a loop that loops from x to y and prints all combinations. Place that loop
;	inside another loop that goes from y to n and also prints all combinations.
start:
    call    read_hex

	mov 	ebx, eax 	; save user input
	mov 	edx, 1		; y counter

loop_y:
	mov 	ecx, 0		; x	counter

loop_x:
print_x_y:
  mov   eax, ecx
	call 	print_eax	; print x

  mov   eax, edx
	call 	print_eax 	; print y

next_x:
	inc 	ecx

	cmp 	ecx, edx
	jnz   loop_x 		; if x !== y

next_y:
	inc 	edm

	cmp 	edx, ebx
	jnz   loop_y 		; if y !== n

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
