; Becoming Independent
; ====================
; 
; Debugging
; ---------
; 
; Safe
; @@@@
;
; 0     Read the main comment of this program.
;
; 1.    Assemble and run this program. Give the program an example input, and
;       observe the program's operation.
;
; 2.    Skim the code. Take a look at the functions and their descriptions.
;
; 3.    The program expects a correct password as input. Use a debugger to
;       quickly obtain an example for a correct password.
;

; This program reads a password from the user, checks the validity of the
; password and finally prints back a message to the user regarding the success
; of the login attempt.

format PE console
entry start

include 'win32a.inc' 

PASS_LEN = 9h

; ===============================================
section '.data' data readable writeable
    please_enter    db  'Enter secret hex password: ',0

    pass_correct    db  'Password is correct. Well done!',13,10,0
    pass_invalid    db  'Invalid password.',13,10,0

; ===============================================
section '.text' code readable executable

start:
    ; Ask for a secret hex password from the user:
    mov     esi,please_enter
    call    print_str

    ; Read the hex password from the user:
    call    read_hex

    ; Check the password number:
    call    check_pass
    jnz     .incorrect_password
    ; Correct password:
    mov     esi,pass_correct
    jmp     .end_check
.incorrect_password:
    ; Incorrect password:
    mov     esi,pass_invalid
.end_check:
    call    print_str

    ; Exit the process:
	push	0
	call	[ExitProcess]

; =========================================
; check_pass
; 
; Operation: 
;   Check if a password number is correct or incorrect.
;
; Input:
;   eax     -   password number (32 bits)
;
; Output:
;   ZF = 0  :   Invalid password number.
;   ZF = 1  :   Correct password.
; 
check_pass:
    push    edx

    mov     edx,eax
    and     eax,0ffffh
    call    transform_num
    shr     edx,16
    cmp     eax,edx

    pop     edx
    ret

; ===========================================
; tranform_num
;
; Operation:
;   A transformation function. Transforms a 16 bit number into another 16 bit
;   number.
;
; Input:
;   ax  -   A number to transform.
;
; Output:
;   ax  -   The resulting number from the transformation.
; 
transform_num:
    push    edx

    add     ax,0ab34h
    ror     ax,3
    sub     ax,0beefh
    shr     ax,1
    xor     ax,0ababh
    add     ax,5b3ah
    mov     dx,ax
    ror     dx,5
    xor     ax,dx

    pop     edx
    ret

include 'training.inc'
