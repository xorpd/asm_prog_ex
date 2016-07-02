; Basic Assembly Answers
; ======================
;
; Structured branching
; --------------------
;
; Perfect
; @@@@@@@
;
; 0.    Assemble and run this program.
;
; 1.    How many inputs does this program expect?
;
;	ANSWER:
;
;		One.
;
; 2.    Try to give different inputs to this program, and check the results.
;
;	ANSWER:
;
;		It looks like the program is running and doesn't end for the 3 first inputs.
;
;		2 -> 6, 1c, 1f0, 1fc0
;		FFFFF -> 6, 1c, 1f0, 1fc0
;		1 -> 6, 1c, 1f0, 1fc0
;		3 ->
;		4 ->
;		fff -> 6, 1c, 1f0
;
; 3.    Read the program's code below, and try to understand what does it do.
;       Try to describe it as simply as you can.
;
;       (Hint: Search about Perfect numbers on the web.)
;
;	ANSWER:
;
;		The code will accept 1 user input as the max. upper bound to search for
;		a perfect number. The first loop has ecx as it's counter and this loop
;		will continue until the max upper bound is reached. The second loop has edi
;		as it's counter. It will try to divide ecx by edi and checks if we have a
;		remainder. If there is one, we should not add it to our sum in ebx. This
;		continues until the second counter edi equals the first counter ecx. If
;		the sum of those divisions in ebx equals the last value in ecx, we print it
;		and we found a perfect number.
;
; 4.    Add comments to the code, to make it more readable.
;
; 5.    Pick some random inputs and verify your predictions about what this
;       program does.
;
;	ANSWER:
;
;		When it has a value of <= 2, it will reach an infinite loop. When we have a
;		value of FFFFF or higher, the program takes very long to execute (+1 min).
;		So probably these are the outcomes for the given inputs:
;
;		2 -> 6, 1c, 1f0, 1fc0 (infinite)
;		eeeeee -> 6, 1c, 1f0, 1fc0 (takes too long)
;		5 -> (no output)
;		6 -> (no output)
;		7 -> 6
;		ffff -> 6, 1c, 1f0, 1fc0
;
; 6.    Identify the different structured branching constructs inside this
;       code: Identify IF,FOR,WHILE and BREAK.
;
; 7.    Try to give the program input of 0x100000. Why does it take the program
;       so long to finish the calculation?
;
;	ANSWER:
;
;		See answer of 5.

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    mov     esi,eax     ; esi = user input limit
    mov     ecx,2       ; counter for the whole code (increased at the end)

iters:                  ; FOR LOOP 1 START
    mov     edi,1       ; edi: divisor start value
    mov     ebx,0       ; ebx: sum of all divisions without remainders

sum_divisors:           ; FOR LOOP 2 START
    mov     eax,ecx
    mov     edx,0       ; edx = 0
    div     edi
    cmp     edx,0
    jnz     non_divisible ; IF STATEMENT, check if we have remainder of ecx / edi
    add     ebx,edi     ; only add edi to ebx when we have no remainder
non_divisible:
    inc     edi         ; edi: increase divisor
    cmp     edi,ecx     ; check if we reached FOR LOOP 1 counter value
    jnz     sum_divisors; FOR LOOP 2 END when edi !== ecx, start FOR LOOP 2 again

    cmp     ebx,ecx
    jnz     not_perfect ; IF STATEMENT check if ebx !== ecx, and then skip the print
    mov     eax,ecx
    call    print_eax   ; only print when ebx === ecx

not_perfect:
    inc     ecx
    cmp     ecx,esi
    jnz     iters       ; FOR LOOP 1 END, ecx = counter start at 2, with a max of esi = user input

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
