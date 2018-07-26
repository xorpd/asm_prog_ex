; Basic Assembly
; ==============
;
; 6.  Bonus: Identifying powers of two.
;   
;     6.2   Try to write that program again, this time without any loops.
;           
;           HINT: try to decrease the original number by 1.
; 
; Reference: http://aggregate.ee.engr.uky.edu/MAGIC/#Is%20Power%20of%202
; x is a power of 2 iff (x AND (x-1)) == 0
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    cmp     eax,0     ; make sure that x != 0 
    jz      exit

    mov     ebx,eax
    sub     ebx,1
    and     eax,ebx

compare:
    cmp     eax,0
    jz      pow2
    mov     eax,0
    jmp     exit

pow2:
    mov     eax,1

exit:
    call    print_eax

    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
