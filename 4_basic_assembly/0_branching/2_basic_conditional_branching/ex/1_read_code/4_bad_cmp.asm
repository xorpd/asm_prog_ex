; Basic Assembly
; ==============
; 
; Basic Conditional Branching
; ---------------------------
;
; Read Code
; ---------
;
; bad cmp
; @@@@@@@
;
; 0.    Note that this program is the same as "simp cmp", except for one
;       instruction. Find it.
; 
; 1.    Has the behaviour of this program changed as a result? Check some inputs
;       for example. If you think that the behaviour has changed, prove it by
;       finding input that gives different results in this program and in simp_cmp
;       program.
;
;       HINT: How does it work with signed numbers?
; 
; 2.    *Bonus*: Could you make this program understand comparison of signed
;       numbers using only the Sign Flag and the Overflow Flag? Make the
;       necessary modifications to the code.
; 

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; The program begins here:

    call    read_hex
    mov     ecx,eax
    call    read_hex
    sub     eax,ecx
    js      b1

s1:
    mov     eax,0
    call    print_eax
    jmp     c1
    
b1:
    mov     eax,1
    call    print_eax

c1:
    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
