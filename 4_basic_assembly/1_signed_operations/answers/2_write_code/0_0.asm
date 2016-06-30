; 0.
;   0.0 Write a program that takes a double word (4 bytes) as an argument, and
;       then adds all the 4 bytes. It returns the sum as output. Note that all the
;       bytes are considered to be of unsigned value.
;
;       Example: For the number 03ff0103 the program will calculate 0x03 + 0xff +
;       0x01 + 0x3 = 0x106, and the output will be 0x106
;
;       HINT: Use division to get to the values of the highest two bytes.
;
;	ANSWER:
;
;		4 bytes is 32 bits. Read a number in eax. The first param is in al, the
;		second is in ah. Then perform a bitshift of 16 bits to the right. This is
;		the same as dividing by 2^16 = 65536. Read the third and fourth params out
;		of al and ah respectively.

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:

    call    read_hex

    mov     esi, 65536  ; the divisor
    sub     ebx, ebx    ; temp register to isolate the 8 bit registers in
    sub     ecx, ecx    ; sum register, set 0 to zero

    mov     bl, al
    add     ecx, ebx    ; do 32 bit calculation, so overflow is taken into account

    mov     bl, ah
    add     ecx, ebx

    mov     edx, 0      ; clear the edx register
    div     esi

    mov     bl, al
    add     ecx, ebx

    mov     bl, ah
    add     ecx, ebx

    mov     eax, ecx

    call    print_eax

    ; Exit the process:
    push    0
    call    [ExitProcess]

include 'training.inc'
