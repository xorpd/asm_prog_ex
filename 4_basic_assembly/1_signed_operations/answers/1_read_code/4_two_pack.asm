; Basic Assembly Answers
; ======================
;
; Signed Operations
; -----------------
;
; Two Pack
; @@@@@@@@
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
;       Specifically, try the following inputs:
;       12345, 0101, 0202, 0203, 01ff.
;
;	ANSWER:
;
;		12345 -> 12345
;		0101 -> 1
;		0202 -> 4
;		0203 -> 6
;		01FF -> FFFFFFFF
;
; 3.    Read the program's code below, and try to understand what does it do. Try
;       to describe it as simply as you can.
;
;	ANSWER:
;
;		It takes 1 input of max ffffh. If it is below or equal to ffffh, the first
;		nibble is sign extended (so numbers below 0 are kept intact) and the
;		second nibble is zero extended (treated as a unsigned number). Those numbers
;		are multiplied and the result is printed. If the number is above ffffh, the
;		number is directly printed back.
;
; 4.    Pick some random inputs and verify your predictions about what this
;       program does.
;
;	ANSWER:
;
;		021f -> 3E
;		028f -> 1FFFFFF1E
;
; 5.    Describe what happens for input ff01 against what happens for input
;       01ff.
;
;	ANSWER:
;
;		ff01 will multiply 01 ff times. ff is zero extended and 01 is sign extended.
;		01 extended gives us 00000001, and ff zero extended gives us 000000ff.
;		Multiplying 00000001 * 000000ff is the same as 01 * ff (= ff)
;
;		01ff will multiply ff 01 time. 01 is zero extended and ff is sign extended.
;		ff extended gives us ffffffff and 01 extended gives us 00000001.
;		Multiplying 00000001 * ffffffff is different than 01 * ff (= ffffffff).
;



format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:

    call    read_hex
    cmp     eax,0ffffh
    ja      exit_program

    movsx   esi,al
    movzx   eax,ah

    imul    esi
    call    print_eax

exit_program:
    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
