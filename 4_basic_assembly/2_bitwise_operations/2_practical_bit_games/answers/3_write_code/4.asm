; Basic Assembly
; ==============
;
; 4.  Rotation using shifts.
; 
;     Implement the ror instruction using the shift instructions. You may use any
;     bitwise instruction for this task, except for the rotation instructions
;     (ror,rol).

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov     esi,eax
    call    read_hex
    mov     ecx,eax     ; User defines k

rotate:                 ; Loops k times
    shr     esi,1
    jc      one_to_msb
    loop    rotate
    jmp     exit

one_to_msb:
    mov     ebx,080000000h
    or      esi,ebx
    loop    rotate

exit:
    mov     eax,esi
    call    print_eax
    
    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
