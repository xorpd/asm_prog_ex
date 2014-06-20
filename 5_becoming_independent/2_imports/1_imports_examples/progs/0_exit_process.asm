; Becoming independent
; ====================
; 
; Imports - Imports Examples
; --------------------------
; 
; ExitProcess
; @@@@@@@@@@@
;
; This program uses the ExitProcess API function from kernel32.dll to exit the
; process.
; 

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

	push	0               ; uExitCode
	call    [ExitProcess]

; ===============================================
section '.idata' import data readable

library kernel32,'kernel32.dll'
 
import  kernel32,\
        ExitProcess,'ExitProcess'
