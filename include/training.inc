
; ==============[read_hex]========================
; Reads hex number from console,
; and returns the resulting number in eax.
read_hex:
    .read_hex_bytes_read = -4
    .read_hex_buffer     = -20

    .MAX_BYTES_TO_READ = 12

    push    ebp
    mov     ebp,esp

    ; Keep some room for locals:
    sub     esp,16+4

    push    edx
    push    ebx
    push    ecx
    push    edi
    
    lea     edi,[ebp + .read_hex_buffer]
    mov     ecx,.MAX_BYTES_TO_READ
    call    read_line

    ; Terminate the last byte, just in case:
    add     edi,.MAX_BYTES_TO_READ
    dec     edi
    mov     byte [edi],0

    ; Attempt to convert the buffer to a number:
    push    10h     ; Hexadecimal base.
    push    0

    lea     ecx,[ebp + .read_hex_buffer]
    push    ecx
    call    [strtoul]
    add     esp,4*3

    ; Result is inside eax.
    pop     edi
    pop     ecx
    pop     ebx
    pop     edx

    add     esp,16+4
    pop     ebp
    ret

; ================[print_eax]====================
; Prints eax to console:

print_eax:
    pushad      ; Keep all registers.

; Skip over the data:
    jmp     .print_eax_after_data
    .print_eax_fmt   db          "%x",10,13,0
.print_eax_after_data:

    push    eax     ; The argument.
    push    .print_eax_fmt
    call    [printf]
    add     esp,8
    popad           ; Restore all registers.
    ret

; ===============[print_eax_binary]================
; Prints eax to console, as a list of binary digits.
print_eax_binary:
    pushad      ; Keep all registers.
    jmp     .print_eax_binary_after_data
    .print_eax_binary_fmt   db      "%x",0
    .new_line               db      13,10,0
.print_eax_binary_after_data:

    mov     ecx,32d ; We print 32 digits.
.print_digit:
    rol     eax,1
    mov     edx,eax
    and     edx,1

    push    ecx     ; Keep ecx and eax.
    push    eax

    ; Print one digit:
    push    edx     ; Digit to be printed.
    push    .print_eax_binary_fmt
    call    [printf]
    add     esp,8

    pop     eax     ; Restore eax and ecx.
    pop     ecx

    loop    .print_digit

    ; Finally print a new line character sequence:
    push    .new_line
    call    [printf]
    add     esp,4

    popad
    ret

; ================[print_delimiter]====================
; Prints a delimiter to the console.
print_delimiter:
    pushad      ; Keep all registers.

; Skip over the data:
    jmp     .print_delimiter_after_data
    .print_delimiter_fmt   db          "========",10,13,0
.print_delimiter_after_data:

    push    .print_delimiter_fmt
    call    [printf]
    add     esp,4
    popad           ; Restore all registers.
    ret

; ================[print_str]====================
; Print the string pointed by esi to the console.
; The string must be null terminated.
print_str:
    jmp     .print_str_after_data
    .safeFormatString db "%s",0
.print_str_after_data:
    pushad      ; Keep all registers.
    push    esi
    push    .safeFormatString
    call    [printf]
    add     esp,8
    popad           ; Restore all registers.
    ret

; ================[read_line]=====================
; Read a string from console into location edi. Adds a null terminator in the
; end of the string.
; ecx marks the size of destination buffer (Including zero terminator).
;
; NOTES:
; - Discards any characters beyond the first ecx characters.
; - Will not keep the 0dh,0ah sequence.
; - This function assumes that the newline sequence is 0dh,0ah. (Windows).
;

read_line:
    .bytes_read = -4
    .buff_size = -8
    .buff_left_size = -0ch
    .buff_ptr = -10h
    .dummy_dw = -14h

    push    ebp
    mov     ebp,esp
    
    ; Keep room for locals:
    sub     esp,4*5

    pushad

    ; Keep the size of destination buffer:
    mov     dword [ebp + .buff_size],ecx
    mov     dword [ebp + .buff_left_size],ecx

    ; Keep the address of destination buffer:
    mov     dword [ebp + .buff_ptr],edi

    ; Get the Standard input handle:
    push    STD_INPUT_HANDLE  ; -10
    call    [GetStdHandle]
    mov     ebx,eax

    ; If buff_size == 0, we don't care about reading bytes.
    ; We just consume one line from the console.
    cmp     dword [ebp + .buff_size],0
    jz      .discard_loop

    ; Read bytes from console.
    ; Terminate on one of the following conditions:
    ; - An 0xd character (new line) was found.
    ; - The destination buffer is full.
.read_byte:
    ; Read bytes from the standard input handle:
    push    0
    lea     ecx, [ebp + .bytes_read]
    push    ecx
    push    1       ; Read one byte.
    mov     ecx, dword [ebp + .buff_ptr]
    push    ecx
    push    ebx
    call    [ReadFile]

    mov     edi, dword [ebp + .buff_ptr]
    inc     dword [ebp + .buff_ptr]
    dec     dword [ebp + .buff_left_size]

    ; Check if a new line character (0xd) was found:
    ; If so, exit the loop:
    cmp     byte [edi],0dh
    jz      .exit_read_loop

    ; Check if we have reached to the maximal capacity of our buffer:
    cmp     dword [ebp + .buff_left_size],0
    jnz     .read_byte
.exit_read_loop:

    ; Set null terminator:
    mov     byte [edi],0

    ; Discard loop:
    ; We discard all the characters until we arrive at the 0ah character.
    ; 0ah is the second character in the 0dh,0ah windows' newline sequence.
.discard_loop:
    push    0
    lea     ecx, [ebp + .bytes_read]
    push    ecx
    push    1       ; Read one byte.
    lea     ecx, [ebp + .dummy_dw]
    push    ecx
    push    ebx
    call    [ReadFile]

    cmp     byte [ebp + .dummy_dw],0ah
    jnz     .discard_loop

    popad

    add     esp,4*5
    pop     ebp
    ret
    
; ====================================
; Imports section:
section '.idata' import data readable
 
library kernel,'kernel32.dll',\
        msvcrt,'msvcrt.dll'
 
import  kernel,\
        ExitProcess,'ExitProcess',\
        GetStdHandle,'GetStdHandle',\
        ReadFile,'ReadFile'

import  msvcrt,\
        printf, 'printf',\
        strtoul, 'strtoul'

