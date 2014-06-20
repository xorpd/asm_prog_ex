; Becoming independent
; ====================
; 
; Imports - Imports Examples
; --------------------------
; 
; Console Echo
; @@@@@@@@@@@@
;
; This program demonstrates writing to the console and reading from the console
; using Windows API functions.
; 
; Demonstrates usage of GetStdHandle, ReadFile, WriteFile API functions from
; kernel32.dll.
; 

format PE console
entry start

include 'win32a.inc' 

; Maximum size of input string we read from the console:
MAX_INPUT_SIZE = 20h

; ==============================================
section '.bss' readable writeable
    input_handle    dd  ?
    output_handle   dd  ?

    bytes_read      dd  ?   ; Amount of bytes read
    bytes_written   dd  ?   ; Amount of bytes written

    ; The input string we read from the console:
    input_str       db  MAX_INPUT_SIZE dup (?)

; ===============================================
section '.text' code readable executable

start:
    ; Obtain input handle:
    push    STD_INPUT_HANDLE 
    call    [GetStdHandle]
    mov     dword [input_handle],eax

    ; Obtain output handle:
    push    STD_OUTPUT_HANDLE
    call    [GetStdHandle]
    mov     dword [output_handle],eax

    ; Read a line from the console:
    push    0                           ; lpOverlapped
    push    bytes_read                  ; lpNumberOfBytesRead
    push    MAX_INPUT_SIZE              ; nNumberOfBytesToRead
    push    input_str                   ; lpBuffer
    push    dword [input_handle]        ; hFile
    call    [ReadFile]

    ; Write the line we have just read back to the console:
    push    0                           ; lpOverlapped
    push    bytes_written               ; lpNumberOfBytesWritten
    push    dword [bytes_read]          ; nNumberOfBytesToWrite
    push    input_str                   ; lpBuffer
    push    dword [output_handle]       ; hFile
    call    [WriteFile]

    ; Exit process:
	push	0                           ; uExitCode
	call	[ExitProcess]

; ===============================================
section '.idata' import data readable

library kernel32,'kernel32.dll'

import  kernel32,\
        GetStdHandle,'GetStdHandle',\
        ReadFile,'ReadFile',\
        WriteFile,'WriteFile',\
        ExitProcess,'ExitProcess'
