; Basic Assembly
; ==============
; 
; Bitwise operations - Practical bit games
; ----------------------------------------
;
; Endiana Jones returns
; @@@@@@@@@@@@@@@@@@@@@
;
; Take a look at the following code. Compare it with the previous code example
; (Endiana_Jones). Try to give it some inputs. Particularly, try out 11223344.
;
; This code example behaves exactly the same as the previous one
; (Endiana_Jones), however it is much shorter. We use a new instruction called
; BSWAP in this piece of code.
; 
; BSWAP is an mnemonic for Byte Swap. It reverses the four bytes contained in a
; dword.
;
; The order of bytes in a dword is also referred to as Endianity.
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    call    read_hex
    bswap   eax         ; Byte Swap
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
