; Basic Assembly
; ==============
; 
; Strings
; -------
;
; Lexic
; @@@@@
;
; 0.    Assemble and run this program.
;
; 1.    Try to give the program different inputs, and observe the output.
;
; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
; 3.    Explain the program's output.
;

format PE console
entry start

include 'win32a.inc' 

MAX_STR = 40h

; ===============================================
section '.data' data readable writeable
    enter_first     db      'Please enter the first string: ',0
    enter_second    db      'Please enter the second string: ',0

    strings_equal   db      'Strings are equal!',0
    first_greater   db      'First string is greater.',0
    second_greater  db      'Second string is greater.',0

; ===============================================
section '.bss' readable writeable
    str1   db       MAX_STR     dup (?)
    str2   db       MAX_STR     dup (?)

; ===============================================
section '.text' code readable executable

start:
    ; Please enter first string:
    mov     esi,enter_first
    call    print_str

    ; Read first string from user:
    mov     ecx,MAX_STR
    mov     edi,str1
    call    read_line

    ; Please enter second string:
    mov     esi,enter_second
    call    print_str

    ; Read second string from user:
    mov     ecx,MAX_STR
    mov     edi,str2
    call    read_line

    mov     esi,str1
    mov     edi,str2

    ; Compare the two strings at esi and edi:
    ; Return the string to be printed at eax.
    mov     eax,strings_equal
next_byte:
    mov     dl,byte [esi]
    cmpsb
    jz      chars_equal
    ja      first_bigger
    jb      second_bigger

chars_equal:
    test    dl,dl
    jnz     next_byte
    jmp     finish_cmp

first_bigger:
    mov     eax,first_greater
    jmp     finish_cmp
    
second_bigger:
    mov     eax,second_greater
finish_cmp:


    ; Print the result:
    mov     esi,eax
    call    print_str

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
