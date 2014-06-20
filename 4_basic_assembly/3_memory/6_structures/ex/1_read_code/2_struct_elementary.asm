; Basic Assembly
; ==============
; 
; Memory - Structures
; -------------------
;
; Struct Elementary
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

struct UNI_COLORED_LINE
    union
        struct
            red     db      ?
            green   db      ?
            blue    db      ?
                    db      ?
        ends
        color   dd      ?
    ends
    cline   LINE    ?
ends


struct INDEXED_LINE
    index   dd  ?
    union
        struct
            red     db      ?
            green   db      ?
            blue    db      ?
                    db      ?
        ends
        color   dd      ?
    ends
    cline   LINE    ?
ends

; ===============================================
section '.bss' readable writable
    
    my_u_line           UNI_COLORED_LINE    ?
    my_i_line           INDEXED_LINE        ?
    
; ===============================================
section '.text' code readable executable

start:
    
    
    ; UNI_COLORED_LINE structure:
    ; ---------------------------

    ; Compare the following two values:
    mov     eax,UNI_COLORED_LINE.red
    call    print_eax

    mov     eax,UNI_COLORED_LINE.color
    call    print_eax

    ; And also compare the following two values:
    mov     eax,my_u_line.red
    call    print_eax

    mov     eax,my_u_line.color
    call    print_eax


    mov     dword [my_u_line.color],11223344h
    ; Predict the following values:
    movzx   eax,byte [my_u_line.red]
    call    print_eax
    movzx   eax,byte [my_u_line.green]
    call    print_eax
    movzx   eax,byte [my_u_line.blue]
    call    print_eax

    ; Print a delimiter.
    call    print_delimiter


    ; INDEXED_LINE structure:
    ; -----------------------

    ; Predict the following values:
    mov     eax,INDEXED_LINE.red
    call    print_eax

    mov     eax,sizeof.INDEXED_LINE
    call    print_eax

    mov     eax,INDEXED_LINE.cline.p_start.y
    call    print_eax


    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
