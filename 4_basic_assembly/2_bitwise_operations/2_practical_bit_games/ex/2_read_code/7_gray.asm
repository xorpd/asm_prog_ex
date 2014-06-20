; Basic Assembly
; ==============
; 
; Bitwise operations - Practical bit games
; ----------------------------------------
;
; Gray
; @@@@
;
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;
; 2.    The input of this program corresponds to the amount of output printed.
;       Give it an input number of size about 0x10, and look at the result.
;
; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;       
; 4.    Look at some output of the program. Pay attention to the following:
;       -   Every two consecutive numbers differ by at most one bit.
;           Try to understand why.
;
; 5.    Bonus: Write a program that "verifies" that every two consecutive
;       numbers on this list differ by at most one bit. check out all the
;       possible dwords.
;
; 6.    This list of numbers is called Gray Code. It is an alternative ;
;       method to count, in which every two consecutive numbers differ by only
;       one bit. 
;       
;       It has many interesting uses. Search and read about it a bit.
;
        

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    call    read_hex
    mov     esi,eax
    xor     ecx,ecx     ; Zero ecx.

show_one_num:
    mov     eax,ecx
    shr     eax,1
    xor     eax,ecx
    call    print_eax_binary
    
    inc     ecx
    cmp     ecx,esi
    jnz     show_one_num

    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
