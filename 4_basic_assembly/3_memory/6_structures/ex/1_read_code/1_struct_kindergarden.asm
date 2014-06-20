; Basic Assembly
; ==============
; 
; Memory - Structures
; -------------------
;
; Struct playground
; @@@@@@@@@@@@@@@@@
; 
; 0.    Read the structures' definitions, and take a look at the code.
;
; 1.    Before running the program: Try to predict all the values that will be
;       printed to the console. Write your predictions as comments.
;
; 2.    Run the program and check your predictions.
;

format PE console
entry start

include 'win32a.inc' 

struct PNT
    x   db  ?
    y   db  ?
ends

struct LINE
    p_start     PNT     ?
    p_end       PNT     ?
ends

struct COLORED_LINE
    struct
        red     db      ?
        green   db      ?
        blue    db      ?
                db      ?
    ends
    cline   LINE    ?
ends

; ===============================================
section '.bss' readable writable
    
    my_point            PNT                 ?
    my_line             LINE                ?
    my_c_line           COLORED_LINE        ?
    
; ===============================================
section '.text' code readable executable

start:

    ; PNT structure:
    ; ------------------
    mov     eax,my_point
    call    print_eax

    mov     eax,my_point.x
    call    print_eax

    mov     eax,my_point.y
    call    print_eax

    mov     eax,sizeof.PNT
    call    print_eax

    mov     eax,PNT.x
    call    print_eax

    mov     eax,PNT.y
    call    print_eax

    ; Prove the following: my_point + PNT.y == my_point.y

    call    print_delimiter

    ; LINE structure:
    ; --------------------

    mov     eax,sizeof.LINE
    call    print_eax

    mov     eax,my_line
    call    print_eax

    mov     eax,my_line.p_end.x
    call    print_eax

    mov     eax,LINE.p_end.x
    call    print_eax

    ; Prove the following: my_line + LINE.p_end.x == my_line.p_end.x

    call    print_delimiter

    ; COLORED_LINE structure:
    ; -----------------------

    ; Try to predict the following offsets:
    mov     eax, COLORED_LINE.cline
    call    print_eax

    mov     eax, COLORED_LINE.cline.p_end
    call    print_eax

    mov     eax, COLORED_LINE.cline.p_end.y
    call    print_eax


    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
