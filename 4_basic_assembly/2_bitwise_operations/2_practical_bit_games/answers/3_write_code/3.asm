; Basic Assembly
; ==============
;
; 3.  Sum of distances:
;    
;     For a binary number x, we define the "sum of 1 distances" to be the sum of
;     distances between every two "1" bits in x's binary representation.
;
;     Small example (8 bits):
; 
;       x = {10010100}_2
;            7  4 2
;      
;       The total sum of distances: (7-4) + (7-2) + (4-2) = 3 + 5 + 2 = 10
;
;     Create a program that takes a number x (of size 4 bytes) as input, and
;     outputs x's "sum of 1 distances".
;
; Based on SO: 
; https://stackoverflow.com/questions/32470046/calculating-sum-of-all-the-distance/32470309#32470309

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov     ecx,32d
    xor     edx,edx

; count the number of ones in a number
sum_bits:
    mov     ebx,eax
    and     ebx,1
    add     edx,ebx
    ror     eax,1
    loop    sum_bits

; calculate the sum of all 1 distances
    mov     ebx,edx     ; ebx is remaining 1 bits to check
    mov     ecx,32d
    xor     edx,edx     ; the previous position of 1
    xor     esi,esi     ; the index
    xor     edi,edi     ; contains the sequential sums

rotate:
    shl     eax,1
    jc      position
    loop    rotate
    jmp     exit

position:
    cmp     edx,0
    jz      start_one
    sub     edx,ecx         ; calculate distance
    jmp     calc

start_one:
    mov     edx,ecx         ; move the first one position to edx
    loop    rotate

; calculate i*(n-i)*distance
; i ... index (esi), n ... sum of all ones, distances respectively to i
calc:
    inc     esi
    dec     ebx
    jz      exit
    imul    edx,esi
    imul    edx,ebx
    add     edi,edx
    mov     edx,ecx
    loop    rotate

exit:
    mov     eax,edi
    call    print_eax
    
    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
