; Basic Assembly
; ==============
; 
; Subroutines and the stack - CALL and RET
; ----------------------------------------
;
; Anonymous labels
; @@@@@@@@@@@@@@@@
;
; We introduce the syntax of anonymous labels in fasm.
; Anonymous labels have the form:
;
; @@:
;
; You can have as many anonymous labels as you want in your source file.
; You can refer to the next anonymous label as @f (f stands for Forward), and
; to the previous anonymous label as @b (b stands for backwards). @r is a
; synonym for @b.
;
; Example:
;
; @@:
;   jmp   @b  ; Jump to the first anonymous label.
;   jmp   @f  ; Jump to the second anonymous label.
; @@:
;
;
; Note that this syntax should only be used if the code is very simple and
; clear. Excessive use of anonymous labels can make your code unreadable.
; Prefer Local labels with meaningful names over Anonymous labels.
; 
; This material is introduced mainly because you might see those labels in other
; people's code.
;
; ---------------------------------------------------------------------------
;
; 0.    Assemble and run this program.
;
; 1.    Try to give the program different inputs, and observe the output.
;
; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
; 3.    Note the use of anonymous labels in the code.
;
; 4.    Explain the program's output.
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.data' data readable writeable
    enter_n         db  'Enter value for n: ',0
    sum_is_a        db  'The sum is a!',13,10,0
    sum_not_a       db  'The sum is not a...',13,10,0

; ===============================================
section '.text' code readable executable

start:

    mov     esi,enter_n
    call    print_str
    call    read_hex
    mov     ecx,eax

    xor     eax,eax
    jecxz   .after_loop ; We don't need to iterate if ecx == 0.
@@:                     ; This is an anonymous label.
    add     eax,ecx
    loop    @b          ; @b refers to the first anonymous label backwards.
                        ; You may also use @r, which is the same as @b.
.after_loop:

    cmp     eax,0ah
    jnz     @f          ; @f refers to the first anonymous label forward.
    
    mov     esi,sum_is_a
    call    print_str
    jmp     .end_check
@@:                     ; This is an anonymous label.
    mov     esi,sum_not_a
    call    print_str
.end_check:
    

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
