; Basic Assembly
; ==============
;
; 4.  Rotation using shifts.
; 
;     Implement the ror instruction using the shift instructions. You may use any
;     bitwise instruction for this task, except for the rotation instructions
;     (ror,rol).
;
; Example (8 bit): Rotate 11000101 3 bits to the right
;
; shr k=3 00011000
; shl k=5 10100000
; ================
; OR      10111000

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
 
    call    read_hex        ; k is first user input
    mov     ecx,eax
    mov     ebx,32d
    sub     ebx,eax         ; calculate 32-k

    call    read_hex        ; input number to rotate
    mov     edx,eax
    shr     edx,cl
    mov     cl,bl
    shl     eax,cl
    or      eax,edx

    call    print_eax

    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
