;	1.  Write a program that receives two numbers a,b and calculates their integral
;		average.

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
	add		eax, ebx
	mov		edx, 0		; make sure that edx is 0, since it is used in 32 bit division
	mov		ecx, 2		; divide by 2
	div		ecx
    call    print_eax   

  	; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'

