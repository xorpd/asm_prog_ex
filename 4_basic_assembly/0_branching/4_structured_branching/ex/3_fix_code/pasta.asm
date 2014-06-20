; Basic Assembly
; ==============
; 
; Structured branching
; --------------------
;
; Pasta
; @@@@@
; 
; You are given a piece of spaghetti code, and you are going to understand it
; and then fix it, to be a normal readable piece of code.
; 
; Enjoy your food :)
; 
;
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;
; 2.    Try to give different inputs to this program, and check the results.
;
; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can.
;       
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
; 
; 5.    Try to think about a better design for this code:
;       What kinds of loops are you going to use?
;       What kind of branches are you going to use?
;
;       Make the changes to the code. Make sure your new code has no
;       intersecting branches. Also make sure that it is readable, and well
;       commented. Finally, make sure that it has exactly the same output as the
;       original code.
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov     ecx,eax

    mov     ebx,0

iters:
    add     ebx,ecx
    mov     esi,5d
    mov     eax,ecx
    mov     edx,0
    div     esi
    cmp     edx,0
    jnz     skip1
    jmp     discard_last
skip1:
come_back:
    dec     ecx
    jz      end_loop
    jmp     iters
end_loop:
    
    mov     eax,ebx
    call    print_eax

    jmp     end_prog
discard_last:
    sub     ebx,ecx
    jmp     come_back

end_prog:

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
