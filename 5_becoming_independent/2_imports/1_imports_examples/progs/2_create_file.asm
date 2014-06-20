; Becoming independent
; ====================
; 
; Imports - Imports Examples
; --------------------------
; 
; Create File
; @@@@@@@@@@@
;
; This program reads a line from the console, and creates a file that contains
; that line.
;
; Demonstrates using the CreateFile API function from kernel32.dll
; 

format PE console
entry start

include 'win32a.inc' 

; Maximum size of input string we read from the console:
MAX_INPUT_SIZE = 20h

; ===============================================
section '.data' data readable writeable
    filename           db  'my_file.txt',0

; ==============================================
section '.bss' readable writeable
    input_handle    dd  ?
    file_handle     dd  ?

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

    ; Read a line from the console:
    push    0                           ; lpOverlapped
    push    bytes_read                  ; lpNumberOfBytesRead
    push    MAX_INPUT_SIZE              ; nNumberOfBytesToRead
    push    input_str                   ; lpBuffer
    push    dword [input_handle]        ; hFile
    call    [ReadFile]

    ; Open a file:
    push    0                           ; hTemplateFile
    push    FILE_ATTRIBUTE_NORMAL       ; dwFlagsAndAttributes
    push    CREATE_ALWAYS               ; dwCreationDisposition
    push    0                           ; lpSecurityAttributes
    push    0                           ; dwShareMode
    push    GENERIC_WRITE               ; dwDesiredAccess
    push    filename                    ; lpFileName
    call    [CreateFileA]
    mov     dword [file_handle],eax
    
    ; Write input_str into the file:
    push    0                           ; lpOverlapped
    push    bytes_written               ; lpNumberOfBytesWritten
    push    dword [bytes_read]          ; nNumberOfBytesToWrite
    push    input_str                   ; lpBuffer
    push    dword [file_handle]         ; hFile
    call    [WriteFile]

    ; Close file handle:
    push    [file_handle]               ; hObject
    call    [CloseHandle]

    ; Exit process:
	push	0                           ; uExitCode
	call	[ExitProcess]

; ===============================================
section '.idata' import data readable

library kernel32,'kernel32.dll'

import  kernel32,\
        GetStdHandle,'GetStdHandle',\
        ReadFile,'ReadFile',\
        CreateFileA,'CreateFileA',\
        WriteFile,'WriteFile',\
        CloseHandle,'CloseHandle',\
        ExitProcess,'ExitProcess'
