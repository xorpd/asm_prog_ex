; Basic Assembly
; ==============
;
; 2.  Bit reverse:
;
;     Write a program that takes a number (of size 4 bytes) x as input, and then
;     reverses all the bits of x, and outputs the result. By reversing all bits we
;     mean that the bit with original location i will move to location 31-i.
; 
;     Small example (for the 8 bit case):
;
;       if x == {01001111}_2, then the output is {11110010}_2.
;
;       In this example we reversed only 8 bits. Your program will be able to
;       reverse 32 bits.
;
; More ways to reverse bits can be found here:
; http://graphics.stanford.edu/~seander/bithacks.html#BitReverseObvious

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    ; mov     eax,01001111b
    mov     ecx,32d
    xor     ebx,ebx

rotate:
    rcr     eax,1       ; shift LSB into the carry bit
    rcl     ebx,1       ; move that carry bit into LSB and shift the others up
    loop    rotate

    mov     eax,ebx
    call    print_eax

    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
