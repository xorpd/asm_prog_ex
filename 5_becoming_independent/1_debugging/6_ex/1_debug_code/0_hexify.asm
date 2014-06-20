; Becoming Independent
; ====================
; 
; Debugging
; ---------
; 
; hexify
; @@@@@@
;
; 0     Read the main comment of this program.
;
; 1.    Assemble and run this program. Give the program an example input, and
;       observe the program's operation.
;
; 2.    Skim the code. Take a look at the functions and their descriptions.
;
; 3.    The code contains a few errors. Find those errors and fix them, so that
;       the program runs correctly. Use a debugger for this task. You may need
;       to add/remove/change a few instructions in this program.
;

; The program reads a decimal number from the user, and converts it to its
; hexadecimal representation.

format PE console
entry start

include 'win32a.inc' 

MAX_NUM_STR = 9h

; ===============================================
section '.data' data readable writeable
    please_enter    db  'Please enter a decimal number: ',0
    hex_result      db  'Your number in hex: ',0

; ===============================================
section '.bss' readable writeable
    num_str         db  MAX_NUM_STR dup (?)

; ===============================================
section '.text' code readable executable

start:
    ; Ask for a string from the user:
    mov     esi,please_enter
    call    print_str

    ; Read the decimal number from the user, as string:
    mov     ecx,MAX_NUM_STR
    mov     edi,num_str
    call    read_line

    ; Convert the decimal number string into an integer number:
    push    num_str
    call    str_to_dec_num
    add     esp,4

    mov     esi,hex_result
    call    print_str
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

; =========================================
; str_to_dec_num(num_str)
; 
; Operation: 
;   Converts a string of decimal digits into a number.
;   NOTES: 
;   - The reading of decimal digits will stop whenever a character that is not a
;     decimal digit is encountered.
;   - If the resulting number is bigger than 32 bits, a wraparound will
;     occur.
;
; Input:
;   num_str - Address of the string. The string could be terminated by a NULL
;             terminator, or any character which is not a decimal digit.
;
; Output:
;   eax will contain the resulting number.
; 
str_to_dec_num:
    .num_str = 8
    enter   0,0
    push    esi
    push    ecx

    xor     ecx,ecx
    mov     esi,dword [ebp + .num_str]

.read_char:
    lodsb
    ; Check if we got a digit. If it is not a digit, break from the loop.
    cmp     al,'0'
    jb      .end_loop
    cmp     al,'9'
    ja      .end_loop
    
    ; Multiply ecx by 10 (To advance one decimal digit).
    lea     ecx,[5 * ecx]
    add     ecx,ecx
    
    ; Add the decimal digit to the total number so far:
    movzx   eax,al
    add     ecx,eax
    sub     ecx,'0'

    jmp     .read_char
.end_loop:

    mov     eax,ecx     ; Store result inside eax.

    pop     ecx
    pop     esi
    leave
    ret

include 'training.inc'
