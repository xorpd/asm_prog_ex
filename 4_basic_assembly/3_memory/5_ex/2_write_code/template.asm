; Basic Assembly
; ==============
; 
; Memory
; ------
;
; Template
; @@@@@@@@
;

format PE console
entry start

include 'win32a.inc' 


; This is the data section:
; ===============================================
section '.data' data readable writeable
    ; some initalized data.


; This is the bss section:
; ===============================================
section '.bss' readable writeable
    ; Some uninitialized data.


; This is the text section:
; ===============================================
section '.text' code readable executable

start:
    ; Program begins here.

    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
