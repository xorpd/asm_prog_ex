; 0.
;   0.1 Write a program that does the same, except that it multiplies the four
;       bytes. (All the bytes are considered to be unsigned).
;
;   ANSWER:
;
;       Because max input is FC05FC01 (= FF * FF * FF * FF), max. result will fit in
;       a 32 bit register. Every multiplication is saved in edx:eax (but only eax,
;       since max. result is 32 bit), so we can take every outcome and multiply it
;       with the next param.

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:

    call    read_hex

    mov     esi, 65536  ; the divisor
    mov     ecx, eax    ; copy of the user input
    sub     ebx, ebx    ; temp register to isolate the 8 bit registers in
    sub     edi, edi    ; answer register

    sub     edx, edx    ; clear mul registers
    sub     eax, eax    ; clear mul registers
    mov     al, cl      ; param 1 to eax
    mov     bl, ch      ; param 2 to ebx

    mul     ebx         ; param 1 * param 2

    mov     edi, eax    ; store the result temp. in edi
    mov     eax, ecx    ; user input back in eax
    div     esi

    mov     ecx, eax    ; shifted user input to ebx
    mov     eax, edi    ; multiplication result back to eax
    mov     edx, 0      ; clear edx
    mov     ebx, 0      ; clear ebx

    mov     bl, cl
    mul     ebx         ; (param 1 * param 2) * param 3

    mov     bl, ch
    mul     ebx         ; (param 1 * param 2 * param 3) * param 4

    call    print_eax

    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
