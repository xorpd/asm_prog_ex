; Basic Assembly
; ==============
; 
; Structured branching
; --------------------
;
; Roots
; @@@@
;
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect? (Maybe non at all?)
;
; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. What are the numbers seen at
;       the outputs? What do they mean?
;
; 3.    Add comments to the code, to make it more readable.
; 
; 4.    Identify the different structured branching constructs inside this
;       code: Identify IF,FOR,WHILE and BREAK.
;
; 5.    What happens if you change the first "mov ecx,10000000h" instruction?
;       For example, to the number 0ffffffffh? Why?

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    
    mov     ecx,10000000h

looper:
    mov     eax,ecx
    mul     ecx     
    mov     esi,eax
    mul     ecx
    mov     edi,eax

    mov     eax,esi
    mov     esi,18d
    mul     esi
    sub     edi,eax

    mov     eax,ecx
    mov     ebx,101d
    mul     ebx
    add     edi,eax

    sub     edi,168d

    cmp     edi,0
    jnz     skip_print

    mov     eax,ecx
    call    print_eax

skip_print:
    loop    looper


    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
