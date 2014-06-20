; Basic Assembly
; ==============
; 
; Strings
; -------
;
; String Subroutines
; @@@@@@@@@@@@@@@@@@
;
; Meet the subroutines print_str and read_line, which will allow you to read
; strings and print strings to the console. Both of those subroutines are
; written inside the training.inc include file.
;
; -     print_str: This subroutine writes to the console the string pointer by the
;       esi register. It continues to print until it encounters a null
;       terminator, so be sure to add a null terminator in the end of your
;       strings.
;
; -     read_line: This subroutine reads one line from the console, and writes
;       it to memory, beginning from address edi. In ecx you should specify the
;       maximum amount of bytes that you are willing to read. This is important,
;       as usually you only have a limited space in your buffer. Any byte beyond
;       the first ecx bytes will be discarded.
;
; Note that both of those subroutines do not change the registers.
;
;
; 0.    Assemble the program and run it.
;
; 1.    Read the code below. Make sure that you understand how it works.
;       Particularly notice how the print_str and read_line subroutines are
;       being used.
;
; 2.    Try to give input of empty string (Just press return without feeding in
;       any characters), or input of a string which is too long. Observe the
;       results that you get.
;


format PE console
entry start

include 'win32a.inc' 

MAX_USER_STR = 20h

; ===============================================
section '.data' data readable writeable
    ex_str          db      'Example string.',0
    please_enter    db      'Please enter a string:',13,10,0

section '.bss' readable writeable
    user_str        db      MAX_USER_STR    dup (?)

; ===============================================
section '.text' code readable executable

start:
    ; Print example string to console.
    mov     esi,ex_str
    call    print_str

    ; Request a string from the user:
    mov     esi,please_enter
    call    print_str

    ; Read a line from the user.
    mov     ecx,MAX_USER_STR    ; Not longer that MAX_USER_STR bytes.
                                ; If longer, only the first MAX_USER_STR bytes
                                ; will be taken. The rest will be discarded.

    mov     edi,user_str        ; Destination buffer.
    call    read_line

    ; Print the line back to the user.
    mov     esi,user_str
    call    print_str

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
