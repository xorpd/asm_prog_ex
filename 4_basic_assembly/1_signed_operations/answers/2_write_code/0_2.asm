;  0.2 Write a program that finds every double word (4 bytes) that satisfies the
;      following condition: When decomposed into 4 bytes, if we multiply those
;      four bytes, we get the original double word number.

;	ANSWER:
;
;		Take 1 32 bit register and start at 0. Split it in 8 bit registers (via
;		division by 2^16) and multiply those values. Check if the result is the same
;		as the first result. After that increase the 32 bit register and do it
;		again.
;

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:


    mov		esi, 0x10101010     ; counter for iterating over all registers

again:
    sub     ebx, ebx    ; temp register to isolate the 8 bit registers in
    sub     ecx, ecx    ; clear
    sub     edi, edi    ; answer register
    sub     edx, edx    ; clear mul registers
    sub     eax, eax    ; clear mul registers

    mov     ecx, esi    ; user input in ecx

    mov     al, cl      ; param 1 to eax
    mov     bl, ch      ; param 2 to ebx
    mul     ebx         ; param 1 * param 2

    mov     edi, eax    ; store the result temp. in edi
    mov     eax, ecx    ; user input back in eax
    mov     ebx, 65536
    div     ebx

    mov     ecx, eax    ; shifted user input to ecx
    mov     eax, edi    ; multiplication result back to eax
    sub     edx, edx    ; clear edx
    sub     ebx, ebx    ; clear ebx

    mov     bl, cl
    mul     ebx         ; (param 1 * param 2) * param 3

    mov     bl, ch
    mul     ebx         ; (param 1 * param 2 * param 3) * param 4

    cmp     eax, esi    ; compare the result with the counter of all registers

    jnz     no_print    ; if they are not the same, no_print

    call    print_eax
no_print:
    cmp     esi, 0xffffffff
    jz      stop        ; when we have reached zero, stop

    inc     esi         ; when 0 not is reached, decrease with 1 and jump to again
    jmp     again

stop:
    ; Exit the process:
    push    0
    call    [ExitProcess]

    include 'training.inc'
