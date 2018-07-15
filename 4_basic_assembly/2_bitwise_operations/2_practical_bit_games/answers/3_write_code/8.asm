; Basic Assembly
; ==============
;
; 8.  Bonus: Addition using bitwise operations.
;
;     8.0   You are given two bits a,b. Show that their arithmetic sum is of the
;           form (a AND b, a XOR b).
; 
;           Example:
; 
;           1 + 0 = 01
;           And indeed: 0 = 1 AND 0, 1 = 1 XOR 0.
;           
;           a | b | a + b | a AND b | a XOR b | (a AND b), (a XOR b)
;          ---------------------------------------------------------
;           0 | 0 | 00    | 0       | 0       | 00
;           0 | 1 | 01    | 0       | 1       | 01
;           1 | 0 | 01    | 0       | 1       | 01
;           1 | 1 | 10    | 1       | 0       | 10
;
;     8.1   Write a program that gets as inputs two numbers x,y (Each of size 4
;           bytes), and calculates their arithmetic sum x+y using only bitwise
;           instructions. (ADD is not allowed!).
; 
;           HINT: Try to divide the addition into 32 iterations.
;                 In each iteration separate the immediate result and the carry
;                 bits that are produced from the addition.
;
; Reference: http://www.cs.inf.ethz.ch/37-023/vorl/Arithmetic-operations.tn.pdf
;           slide 3.
;
; Example: sum 0011 and 0110
;
;     0011          0011        0101        0101        0001        0001
; XOR 0110      AND 0110    XOR 0100    AND 0100    XOR 1000    AND 1000
; ---------  -----------    --------    ---------   --------    --------
;     0101          0010        0001        0100        1001        0000
;                                                       ====

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov     ebx,eax
    call    read_hex
    mov     ecx,32d

l1:
    mov     edx,eax
    xor     eax,ebx         ; save xor (add) in eax
    and     ebx,edx         ; save and (carry) in ebx
    shl     ebx,1           ; shift carry left
    loop    l1

    call    print_eax
    
    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
