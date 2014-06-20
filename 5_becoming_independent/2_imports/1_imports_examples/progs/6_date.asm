; Becoming independent
; ====================
; 
; Imports - Imports Examples
; --------------------------
; 
; Date
; @@@@
;
; This program displays the current date to the user, in the format:
; Day/Month/Year.
;
; It demonstrates usage of the GetSystemTime API function from kernel32.dll.
; The structure SYSTEMTIME is defined inside win32a.inc.
; 

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    s_date  db  'The date is %d/%d/%d,',13,10
            db  'Have a great day!',13,10,0

; ==============================================
section '.bss' readable writeable
    ; A structure to hold the system time.
    systime     SYSTEMTIME  ?

; ===============================================
section '.text' code readable executable

start:

    ; Get the system time into the systime structure:
    push    systime             ; lpSystemTime
    call    [GetSystemTime] 

    ; Print the date to the user in the format Day/Month/Year:
    movzx   eax,word [systime.wYear]
    push    eax
    movzx   eax,word [systime.wMonth]
    push    eax
    movzx   eax,word [systime.wDay]
    push    eax
    push    s_date
    call    [printf]
    add     esp,4*4

    ; Exit process:
	push	0                   ; uExitCode
	call	[ExitProcess]

; ===============================================
section '.idata' import data readable

library kernel32,'kernel32.dll',\
        msvcrt,'msvcrt.dll'

import  kernel32,\
        ExitProcess,'ExitProcess',\
        GetSystemTime,'GetSystemTime'

import  msvcrt,\
        printf,'printf'
