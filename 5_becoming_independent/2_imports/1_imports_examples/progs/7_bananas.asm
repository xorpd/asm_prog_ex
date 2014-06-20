; Becoming independent
; ====================
; 
; Imports - Imports Examples
; --------------------------
; 
; Bananas
; @@@@@@@
;
; This program does the following:
;
; 0. Welcome the user using a Message Box.
; 1. Ask the user if he likes bananas.
; 2. If the user answers yes, respond with a happy Message Box
; 3. If the user answers no, respond with a disappointed Message Box.
;
; This program demonstrates usage of the MessageBox API function from 
; user32.dll

format PE GUI 4.0   ; GUI program.
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    welcome_body        db  'Welcome to this program!',0
    welcome_title       db  'Important message',0

    question_body       db  'Do you like bananas?',0
    question_title      db  'Question',0

    answer_yes_body     db  'Bring on the bananas!',0
    answer_yes_title    db  'Yesss!',0

    answer_no_body      db  'So disappointing...',0
    answer_no_title     db  'Ohh'

; ===============================================
section '.text' code readable executable

start:
    ; Show a welcome message box:
    push    MB_OK or MB_ICONINFORMATION     ; uType
    push    welcome_title                   ; lpCaption
    push    welcome_body                    ; lpText
    push    0                               ; hWnd
    call    [MessageBoxA]

    ; Show a question (Yes/No) messagebox:
    push    MB_YESNO or MB_ICONQUESTION     ; uType
    push    question_title                  ; lpCaption
    push    question_body                   ; lpText
    push    0                               ; hWnd
    call    [MessageBoxA]

    cmp     eax,IDYES
    jz      .like_bananas
    ; Be here if doesn't like bananas: (NO)
    ; Show a disappointed messagebox:
    push    MB_OK or MB_ICONHAND            ; uType
    push    answer_no_title                 ; lpCaption
    push    answer_no_body                  ; lpText
    push    0                               ; hWnd
    call    [MessageBoxA]

    jmp     .end_prog
.like_bananas:
    ; Be here if like bananas: (YES)
    ; Show a happy messagebox:
    push    MB_OK or MB_ICONEXCLAMATION     ; uType
    push    answer_yes_title                ; lpCaption
    push    answer_yes_body                 ; lpText
    push    0                               ; hWnd
    call    [MessageBoxA]

.end_prog:
    ; Exit program:
	push	0                               ; uExitCode
	call	[ExitProcess]

; ===============================================
section '.idata' import data readable

library kernel32,'kernel32.dll',\
        user32,'user32.dll'
 
import  kernel32,\
        ExitProcess,'ExitProcess'

import  user32,\
        MessageBoxA,'MessageBoxA'
