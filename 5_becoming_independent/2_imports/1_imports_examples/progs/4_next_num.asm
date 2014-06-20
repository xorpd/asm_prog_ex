; Becoming independent
; ====================
; 
; Imports - Imports Examples
; --------------------------
; 
; Next Number
; @@@@@@@@@@@
;
; This program asks the user for a number. Then it increases the number by 1,
; and returns the result to the user together with a nice string.
;

format PE console
entry start

include 'win32a.inc' 

; Maximum size of input string we are willing to take:
MAX_INPUT_SIZE = 12

; ===============================================
section '.data' data readable writeable
    enter_number    db  'Please Enter a number: ',0
    next_num        db  'The next number is %u, Such a nice number...'
                    db  13,10,0

; ===============================================
section '.bss' readable writeable
    input_handle    dd  ?
    bytes_read      dd  ?
    number          dd  ?

    input_str       db  MAX_INPUT_SIZE+1 dup (?)
    ; Note: + 1 to leave room for the zero terminator.

; ===============================================
section '.text' code readable executable

start:
    ; Obtain input handle:
    push    STD_INPUT_HANDLE 
    call    [GetStdHandle]
    mov     dword [input_handle],eax

    ; Print 'Enter a number...' to the user:
    push    enter_number
    call    [printf]
    add     esp,4

    ; Read a line from the console:
    push    0                           ; lpPverlapped
    push    bytes_read                  ; lpNumberOfBytesRead
    push    MAX_INPUT_SIZE              ; nNumberOfBytesToRead
    push    input_str                   ; lpBuffer
    push    dword [input_handle]        ; hFile
    call    [ReadFile]

    ; Add a zero terminator:
    mov     edi,input_str
    add     edi,MAX_INPUT_SIZE
    mov     byte [edi],0
   
    ; Convert string to number:
    push    10                          ; base
    push    0                           ; endptr
    push    input_str                   ; nptr
    call    [strtoul]
    add     esp,4*3

    ; Keep the resulting number:
    mov     dword [number],eax  

    ; Increase number by 1:
    inc     dword [number]

    ; Print the new number to the user:
    push    dword [number]
    push    next_num
    call    [printf]
    add     esp,4*2

    ; Exit program:
    push    0
    call    [ExitProcess]

; ===============================================
section '.idata' import data readable

library kernel32,'kernel32.dll',\
        msvcrt,'msvcrt.dll'
 
import  kernel32,\
        ExitProcess,'ExitProcess',\
        GetStdHandle,'GetStdHandle',\
        ReadFile,'ReadFile'

import  msvcrt,\
        printf,'printf',\
        strtoul,'strtoul'
