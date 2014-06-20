; Basic Assembly
; ==============
; 
; Bitwise operations - Practical bit games
; ----------------------------------------
;
; print_eax_binary
; @@@@@@@@@@@@@@@@
;
; Meet the new subroutine print_eax_binary.
; This subroutine prints eax to the screen as 32 separate bits.
; It should be very useful for you in the following exercises.
;
; You can find the print_eax_binary subroutine inside training.inc. We have
; not yet learned all that it needed to understand the contents of this
; subroutine, but you can still look at it and try to understand how it
; works. I assure you that in the end of this course you will be able to read
; and understand all of the subroutines in this file.
;
; The following program reads a number from the console using the read_hex
; subroutine, and then prints it back to the console, this time as binary
; digits, using the print_eax_binary function.
; 
; 0.    Assemble and run this program.
;       
; 1.    Try to give the program different inputs, and look at the output. 
;
;       Make sure to try out negative inputs too (You may use the minus sign
;       when giving the input)
; 

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    call    print_eax
    call    print_eax_binary

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
