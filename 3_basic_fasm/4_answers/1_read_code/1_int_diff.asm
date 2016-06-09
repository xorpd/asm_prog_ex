; Basic fasm Answers
; ==================
; 
; Notes:
; For hexadecimal calculations we use a calculator
;
; Read Code
; ---------
;
; Int Diff
; @@@@@@@@
; 
; 0.    Assemble and run this program.
; 
; 1.    How many inputs does this program expect?
;
;   Answer:
; 
;   This program expects 2 inputs, because read_hex is called 2 times.
;
; 2.    Try to give different inputs to this program, and check the results.
;
; 3.    Read the program's code below, and try to understand what does it do. Try
;       to describe it as simply as you can.
;       
;       Note that the relevant part of the code is from the "start" label until
;       the [ExitProcess] call invocation. You do not need to read the input and
;       output subroutines.
;
;   Answer:
;
;   The program reads a number from console and takes the power of 2 of that number.
;   That result is moved to esi temporarily and another number from console is read.
;   From the second number the power of 2 is taken and the second number in eax is
;   subtracted from the first number in esi. The result is stored in esi, moved to
;   eax so it can be printed and then it is printed to console.
;       
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;
;   Answer:
;   
;   2,1 -> 3
;   F,2 -> DD
;   1,2 -> FFFF FFFD
;   1,F -> FFFF FF20
;   9,F -> FFFF FF70
;
; 5.    Use the following input values: 0xffffffff and 0x1. Explain the output
;       that you get back from the program.
;
;   Answer:
;   
;   FFFF FFFF
;   FFFF FFFF * FFFF FFFF = 1
;   1 * 1 = 1
;   1 - 1 = 0

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; The program begins here:

    call    read_hex    
    mul     eax
    mov     esi,eax

    call    read_hex
    mul     eax
    sub     esi,eax
    mov     eax,esi

    call    print_eax   

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
