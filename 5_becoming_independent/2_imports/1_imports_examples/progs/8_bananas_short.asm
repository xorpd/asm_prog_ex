; Becoming independent
; ====================
; 
; Imports - Imports Examples
; --------------------------
; 
; Bananas (Short)
; @@@@@@@@@@@@@@@
;
; Demonstates usage of the invoke fasm macro.
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

format PE GUI 4.0
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
    invoke  MessageBoxA,0,welcome_body,welcome_title,\
                                MB_OK or MB_ICONINFORMATION

    ; Show a question (Yes/No) messagebox:
    invoke  MessageBoxA,0,question_body,question_title,\
                        MB_YESNO or MB_ICONQUESTION

    cmp     eax,IDYES
    jz      .like_bananas
    ; Be here if doesn't like bananas:
    ; Show a disappointed messagebox:
    invoke  MessageBoxA,0,answer_no_body,answer_no_title,\
                                        MB_OK or MB_ICONHAND

    jmp     .end_prog
.like_bananas:
    ; Be here if like bananas:
    ; Show a happy messagebox:
    invoke  MessageBoxA,0,answer_yes_body,answer_yes_title,\
                                            MB_OK or MB_ICONEXCLAMATION

.end_prog:
    ; Exit program:
    invoke  ExitProcess,0

; ===============================================
section '.idata' import data readable

library kernel32,'kernel32.dll',\
        user32,'user32.dll'
 
import  kernel32,\
        ExitProcess,'ExitProcess'

import  user32,\
        MessageBoxA,'MessageBoxA'
