; Basic Assembly
; ==============
; 
; Memory - Structures
; -------------------
;
; Structing the union
; @@@@@@@@@@@@@@@@@@@
; 
; 0.    Read the structures' definitions, and take a look at the code.
;
; 1.    Before running the program: Try to predict all the values that will be
;       printed to the console. Write your predictions as comments.
;
;       Remember the ancient proverb:
;
;           "Inside the struct, the offsets are being increased.
;               Inside the union, the offsets do not change."
;
; 2.    Run the program and check your predictions.
;

format PE console
entry start

include 'win32a.inc' 

struct  COOL
    union
        struct
            union
                struct
                    union
                        struct
                            x   dd  ?
                            y   dd  ?
                        ends
                    ends
                ends
            ends
        ends
    ends
ends


struct  COOLER
    union
        struct
            union
                struct
                    union
                        struct
                            union
                                x   dd  ?
                                y   dd  ?
                            ends
                        ends
                    ends
                ends
            ends
        ends
    ends
ends
    
; ===============================================
section '.text' code readable executable

start:
    ; Predict all the following printed values:
    mov     eax,COOL.x
    call    print_eax

    mov     eax,COOL.y
    call    print_eax

    ; Print a delimiter:
    call    print_delimiter

    mov     eax,COOLER.x
    call    print_eax

    mov     eax,COOLER.y
    call    print_eax


    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
