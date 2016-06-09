; 	2.  Write a program that receives a number x as input, and outputs to the
;    	console the following values: x+1, x^2 , x^3, one after another.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; Your program begins here:
    call    read_hex    
	mov		ebx, eax
	inc 	eax 		; x+1
    call    print_eax   
	
	mov 	eax, ebx	
	mul		eax			; x^2
    call    print_eax   

	mul		ebx			; x^3
    call    print_eax   

  	; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'

