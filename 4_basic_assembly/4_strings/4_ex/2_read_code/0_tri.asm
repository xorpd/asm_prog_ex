; Basic Assembly
; ==============
; 
; Strings
; -------
;
; Tri
; @@@
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
; 4.    Make a modification to the program, to reverse the picture that is being
;       drawn. (Reverse it vertically).
;

format PE console
entry start

include 'win32a.inc' 


; ===============================================
section '.data' data readable writeable
    enter_size  db  'Enter wanted size: ',0
    star        db  '*',0
    newline     db  13,10,0

; ===============================================
section '.text' code readable executable

start:
    ; Show a message to the user:
    mov     esi,enter_size
    call    print_str

    ; Read size from user:
    call    read_hex

draw_line:
    mov     ecx,eax
one_star:
    ; Print one star:
    mov     esi,star
    call    print_str
    loop    one_star
    
    ; Print a new line:
    mov     esi,newline
    call    print_str

    dec     eax
    jnz     draw_line
    

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
