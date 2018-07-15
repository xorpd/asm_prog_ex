; Basic Assembly
; ==============
;
; 0.1   Write a program that takes three numbers x,y,z as input, and returns:
;       - 0 if (x+y+z) is even.
;       - 1 if (x+y+z) is odd.
;
;       (Note that here + means arithmetic addition).
;       Do it without actually adding the numbers.
;       HINT: Use the XOR instruction.


format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov     ebx,eax
    call    read_hex
    mov     ecx,eax
    call    read_hex

    xor     eax,ecx
    xor     eax,ebx

    and     eax,1
    call    print_eax

    push    0
    call    [ExitProcess]

include 'training.inc'
