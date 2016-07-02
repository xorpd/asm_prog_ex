; Basic Assembly Answers
; ======================
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
;	ANSWER:
;
;		None.
;
; 2.    Read the program's code below, and try to understand what does it do.
;       Try to describe it as simply as you can. What are the numbers seen at
;       the outputs? What do they mean?
;
;	ANSWER:
;
;		The numbers at the output are 8, 7 and 3. When we walk through the code,
;		we can say that this equation must be solved for x:
;
;		f(x) = x^3 - 18 * x^2 + 101 * x - 168 = 0
;
; 3.    Add comments to the code, to make it more readable.
;
;	ANSWER:
;
;		Added an example for ecx = 8 and added comments.
;
; 4.    Identify the different structured branching constructs inside this
;       code: Identify IF,FOR,WHILE and BREAK.
;
;	ANSWER:
;
;		Added more comments.
;
; 5.    What happens if you change the first "mov ecx,10000000h" instruction?
;       For example, to the number 0ffffffffh? Why?
;
;	ANSWER:
;
;		The program will be slower, because it will have more iterations. Also
;		it will have more output values:
;
;		c0000007
;		c0000003
;		80000007
;		80000003
;		40000007
;		40000003
;		8
;		7
;		3

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:

    mov     ecx,0ffffffffh ; ecx = 8 ; FOR LOOP: COUNTER

looper:                 ; FOR LOOP: START
    mov     eax,ecx     ; eax = 8
    mul     ecx         ; eax = 64
    mov     esi,eax     ; esi = 64    ESI = x^2
    mul     ecx         ; eax = 8 * 64 = 512
    mov     edi,eax     ; edi = 512	  EDI = x^3

    mov     eax,esi     ; eax = 64
    mov     esi,18d     ; esi = 18
    mul     esi         ; eax = 64 * 18 = 1152
    sub     edi,eax     ; edi = 512 - 1152 = -640  	EDI = x^3 - 18 * x^2

    mov     eax,ecx     ; eax = 8
    mov     ebx,101d    ; ebx = 101
    mul     ebx         ; eax = 8 * 101 = 808
    add     edi,eax     ; edi = -640 + 808 = 168	EDI = x^3 - 18 * x^2 + 101 * x

    sub     edi,168d    ; edi = 168 - 168 = 0		EDI = x^3 - 18 * x^2 + 101 * x - 168

    cmp     edi,0       ; when edi = 0, print the input value ecx, IF STRUCTURE: START
    jnz     skip_print  ; when not, go loop again, IF STRUCTURE: CONDITION ELSE

    mov     eax,ecx     ; IF STRUCTURE: THEN
    call    print_eax

skip_print:             ; IF STRUCTURE: ELSE
    loop    looper      ; FOR LOOP: END, DECREASE ECX AND START LOOP AGAIN IF ECX > 0


    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
