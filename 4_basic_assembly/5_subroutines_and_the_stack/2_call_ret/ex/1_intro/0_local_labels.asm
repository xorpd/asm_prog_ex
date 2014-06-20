; Basic Assembly
; ==============
; 
; Subroutines and the stack - CALL and RET
; ----------------------------------------
;
; Local labels
; @@@@@@@@@@@@
;
; We introduce a new fasm syntax called local labels.
; local labels allow us to reuse the same name for a label in many different
; contexts. Using local labels will make sure that you never "run out of names"
; for your labels.
;
; There are two types of labels: Global and Local. Labels that begin with a dot
; are local, the rest are global.
;
; A local label is attached to the closest global label above it in the source
; code. Hence if we have this construct:
;
; global_lbl:
;   ...
; .local_lbl:
;   ...
;
; then the second label is attached to the first one, to form the full name of
; 'global_lbl.local_lbl'.
;
; In this case you may refer to .local_lbl with its short name anywhere
; between global_lbl and the next global label in the source file. However, you
; can't use the short name .local_lbl outside that scope.
;
; ----------------------------------------------------------------------------
;    
; 0.    Assemble and run this program.
;
; 1.    Try to give the program different inputs, and observe the output.
;
; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
; 3.    Explain the program's output.
;
; 4.    Note that we have 2 local labels with the name .eax_is_3, and two local
;       labels with the name .end_test.
;       
;       The first two local labels .eax_is_3 and .end_test labels are attached
;       to the global label first_test.
;
;       The second two local labels .eax_is_3 and .end_test labels are attached
;       to the global label second_test.
;
;       Hence although we use the same names for the local labels, there is no
;       conflict.
;

format PE console
entry start

include 'win32a.inc' 


; ===============================================
section '.data' data readable writeable
    enter_eax       db  'Enter value for eax: ',0
    eax_3           db  'eax is 3 :)',13,10,0
    eax_not_3       db  'eax is not 3 :(',13,10,0

; ===============================================
section '.text' code readable executable

start:

first_test:     ; This is a global label.
    mov     esi,enter_eax
    call    print_str
    call    read_hex
    cmp     eax,3
    jz      .eax_is_3
    mov     esi,eax_not_3
    call    print_str
    jmp     .end_test
.eax_is_3:      ; This is a local label.
                ; Its full name is 'first_test.eax_is_3'.
    mov     esi,eax_3
    call    print_str
.end_test:      ; This is a local label.
                ; Its full name is 'first_test.end_test'.

second_test:    ; This is a global label.
    mov     esi,enter_eax
    call    print_str
    call    read_hex
    cmp     eax,3
    jz      .eax_is_3
    mov     esi,eax_not_3
    call    print_str
    jmp     .end_test
.eax_is_3:      ; This is a local label. 
                ; Its full name is 'second_test.eax_is_3'.
    mov     esi,eax_3
    call    print_str
.end_test:      ; This is a local label.
                ; Its full name is 'second_test.end_test'.

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
