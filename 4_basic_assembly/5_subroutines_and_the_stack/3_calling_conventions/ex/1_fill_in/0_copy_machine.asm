; Basic Assembly
; ==============
; 
; Subroutines and the stack - Calling conventions
; -----------------------------------------------
; 
; Copy machine
; @@@@@@@@@@@@
;    
; 0.    Skim the code. Take a look at the functions and their descriptions.
;       Understand the dependencies between the functions (Which function calls
;       which function), and what is the special purpose of every function.
;
; 1.    Read the copy_data function, and understand how it works.
;       Find out which calling convention should be used to call this function.
;
; 2.    Fill in a piece of code that calls copy_data using the correct calling
;       convention. Assemble and run the program. Verify the output.
;
;       Just to be sure, check the value of esp before and after
;       your piece of code, to make sure that the stack is balanced.
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    src_data        db  'This is the source data!',0
    SRC_DATA_LEN = $ - src_data
    dest_data       db  SRC_DATA_LEN    dup ('A')

; ===============================================
section '.text' code readable executable

start:

    ; Copy src_data into dest_data:

    ; *** FILL IN YOUR CODE HERE ***
    ;
    ; call  copy_data
    ;
    ; ******************************

    ; Print dest_data to console:
    mov     esi,dest_data
    call    print_str

    ; Exit the process:
	push	0
	call	[ExitProcess]


; ================================================
; copy_data(dest,src,length)
;
; Calling convention: 
;   ?
; Operation:
;   Copy a data buffer.
; Input:
;   dest    -- destination address.
;   src     -- src address.
;   length  -- amount of data to copy (In bytes).
;
copy_data:
    push    esi     ; Keep registers on stack.
    push    edi
    push    ecx

    ; Note that the assembler does the calculation for us Hence this
    ; will turn into 'mov esi,dword [esp + 10h]'.

    ; Think: Why do we have to add 0ch here?
    mov     edi,dword [esp+4+0ch]   ; dest
    mov     esi,dword [esp+8+0ch]   ; src
    mov     ecx,dword [esp+0ch+0ch] ; length

    rep     movsb   ; Copy data.

    pop     ecx     ; Restore registers from stack.
    pop     edi
    pop     esi
    ret

include 'training.inc'
