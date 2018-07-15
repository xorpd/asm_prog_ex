; Basic Assembly
; ==============
;
; 6.  Bonus: Identifying powers of two.
;    
;     6.0   Find the binary representation of the following numbers:
;           1,2,4,8,16,32 (Decimal representation).
;           What do all those binary representations have in common?
;
;     Answer: dec | bin
;               1 | 1
;               2 | 10
;               4 | 100
;               8 | 1000
;              16 | 10000
;              32 | 100000 
;              They all have only one bit set to 1, all the others are 0. 
;      
;     6.1   Write a program that takes a number x and finds out if this number is
;           a power of 2. It outputs 1 if the number is a power of 2, and 0
;           otherwise.
;
; This answer is based on counting 1 bits. More on counting bits: 
; http://graphics.stanford.edu/~seander/bithacks.html#CountBitsSetNaive
; Another solution would be:
; http://aggregate.ee.engr.uky.edu/MAGIC/#Is%20Power%20of%202

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov     ecx,32d
    xor     ebx,ebx

rotate:
    ror     eax,1
    jc      count_ones
    loop    rotate
    jmp     compare

count_ones:
    inc     ebx
    loop    rotate

compare:
    cmp     ebx,1
    jz      print1
    mov     eax,0
    jmp     exit

print1:
    mov     eax,1

exit:
    call    print_eax

    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
