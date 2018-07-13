; Basic Assembly
; ================
; 
;
; 7.  Bonus: Convert Gray into binary.
;     
;     In the "Gray" Exercise at the code reading section, we have learned that in
;     order to find the Gray code of a number x, we should shift the number x by
;     1, and xor the result with the original x value.
;
;     In high level pseudo code: 
;       (x >> 1) XOR x.
;
;     In assembly code:
;       mov   ecx,eax
;       shr   ecx,1
;       xor   eax,ecx
;
;
;     Find a way to reconstruct x from the expression (x >> 1) XOR x.
;     Write a program that takes a gray code g as input, and returns the
;     corresponding x such that g = (x >> 1) XOR x.
;
;    NOTE that You may need to use a loop in your program.

; Example:
; 1101 to Gray:
; 1101 shr: 0110 xor: 1101 XOR 0110 = 1011
; 
; Reverse:
; Take 1011 and XOR with shr 1011 till 0:
; 
;     1011    1110    1100
; XOR 0101    0010    0001
; -------------------------
;     1110    1100    1101 (orig)
;
; Reference: 
; https://en.wikipedia.org/wiki/Gray_code#Converting_to_and_from_Gray_code

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov     ecx,eax
    
l1:
    cmp     ecx,0
    je      end_l1
    shr     ecx,1
    xor     eax,ecx
    jmp     l1

end_l1:
    call    print_eax

    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
