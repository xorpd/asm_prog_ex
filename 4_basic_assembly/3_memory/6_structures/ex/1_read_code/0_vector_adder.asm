; Basic Assembly
; ==============
; 
; Memory - Structures
; -------------------
;
; Vector Adder
; @@@@@@@@@@@@
; 
; 0.    Assemble and run this program.
;
; 1.    How many inputs does this program require? 
;       Try to give the program some inputs, and check out the results. 
;
; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
; 3.    Explain: Why is the bss section being used in this program, and not the
;       data section?

format PE console
entry start

include 'win32a.inc' 

; Point / Coordinate structure:
struct PNT
    x   dd  ?       ; X coordinate.
    y   dd  ?       ; Y coordinate.
ends

; ===============================================
section '.bss' readable writable

    v1      PNT     ?       ; Input Vector 1.
    v2      PNT     ?       ; Input Vector 2.
    rvec    PNT     ?       ; Result vector.
    
; ===============================================
section '.text' code readable executable

start:
    
    ; Read coordinates of the first vector:
    call    read_hex
    mov     dword [v1.x],eax
    call    read_hex
    mov     dword [v1.y],eax

    ; Read coordinates of the second vector:
    call    read_hex
    mov     dword [v2.x],eax
    call    read_hex
    mov     dword [v2.y],eax

    ; Add the two vectors:

    ; Copy first input vector:
    ; Note that we have to use an intermediate register, 
    ; as we can not directly mov memory to memory.
    mov     eax,dword [v1.x]
    mov     dword [rvec.x],eax
    mov     eax,dword [v1.y]
    mov     dword [rvec.y],eax

    ; Add second input vector:
    mov     eax,dword [v2.x]
    add     dword [rvec.x],eax
    mov     eax,dword [v2.y]
    add     dword [rvec.y],eax

    ; Print a delimiter: ("========")
    ; NOTE: This is a new subroutine. It can be found inside training.inc.
    call    print_delimiter

    ; Print the resulting vector:
    mov     eax, dword [rvec.x]
    call    print_eax
    mov     eax, dword [rvec.y]
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
