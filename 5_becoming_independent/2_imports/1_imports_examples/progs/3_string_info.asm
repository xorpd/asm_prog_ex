; Becoming independent
; ====================
; 
; Imports - Imports Examples
; --------------------------
; 
; String Info
; @@@@@@@@@@@
;
; This program calculates the length of a string using the strlen function, from
; msvcrt.dll. It uses printf to print the result to the console. The printf
; function is also from msvcrt.dll.
;
; Note that strlen and printf are not Windows API functions. They are utility
; functions from the Microsoft Visual C Run-Time Library.
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    my_str  db  'I am just a small string in the big world.',0

    ssize   db  'The length of my_str is 0x%x characters.',13,10
            db  'Its first character is: %c.',13,10,0

; ===============================================
section '.text' code readable executable

start:
    ; Calculate the length of my_str string:
    push    my_str
    call    [strlen]
    add     esp,4

    ; Get the first byte of my_str:
    movzx   edx,byte [my_str]

    ; Print a nice summary to the user:
    push    edx
    push    eax
    push    ssize
    call    [printf]
    add     esp,4*3

    ; Exit program:
    push    0
    call    [ExitProcess]

; ===============================================
section '.idata' import data readable

library kernel32,'kernel32.dll',\
        msvcrt,'msvcrt.dll'
 
import  kernel32,\
        ExitProcess,'ExitProcess'

import  msvcrt,\
        strlen,'strlen',\
        printf,'printf'
