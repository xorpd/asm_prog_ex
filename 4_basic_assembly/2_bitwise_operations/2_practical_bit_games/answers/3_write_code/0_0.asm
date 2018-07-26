; Basic Assembly
; ==============
; 
; 0.0   Write a program that takes a number x as input, and returns:
;       - 0 if x is even.
;       - 1 if x is odd. 
;
; Answer: An integer is odd iff the LSB is 1.


format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    and     eax,1
    call    print_eax

    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
