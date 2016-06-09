;	0.  Write a program the receives three numbers and sums those three numbers.
;		Then output the result.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; Your program begins here:
    call    read_hex    
	mov		ebx, eax
    call    read_hex    
	mov		edx, eax
    call    read_hex    
	add		eax, ebx
	add 	eax,edx
    call    print_eax   

  	; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'

