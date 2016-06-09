; 	3.  Write a program that receives two numbers a,b as input, and outputs the
;		remainder of dividing a by b.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; Your program begins here:
    call    read_hex    
	mov		ebx, eax	; store a temporarily in ebx
    call    read_hex    
	mov		ecx, eax	; store b temporarily in ecx
	mov		eax, ebx	; move a to eax
	mov		edx, 0		; set edx to 0, since it is used in 32bit division
	div		ecx
	mov		eax, edx	; move the remainder to eax for ouput

    call    print_eax   

  	; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'

