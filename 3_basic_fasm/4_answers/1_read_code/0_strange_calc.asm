; Basic fasm Answers
; ==================
; 
; Read Code
; ---------
;
; Strange Calc
; @@@@@@@@@@@@
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
;   The program reads a hex number and stores is temporarily in edx. Then the program
;   reads another number and adds the first number to it. Then it is multiplied by
;   2 and then 1 is added. After that the answer is printed to screen in hex.
;       
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;
;   Answer:
;
;   1,2 -> 7
;   F,1 -> 21
;   F,F -> 3D
;

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
    ; The program begins here:

    call    read_hex    
    mov     edx,eax
    call    read_hex    
    add     eax,edx
    add     eax,eax
    inc     eax         

    call    print_eax   

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
