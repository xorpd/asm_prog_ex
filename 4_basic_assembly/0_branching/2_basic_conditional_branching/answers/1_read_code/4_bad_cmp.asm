; Basic Assembly Answers
; ======================
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
;	ANSWER:
;
;		jz is changed into js.
; 
; 1.    Has the behaviour of this program changed as a result? Check some inputs
;       for example. If you think that the behaviour has changed, prove it by
;       finding input that gives different results in this program and in simp_cmp
;       program.
;
;       HINT: How does it work with signed numbers?
;
;	ANSWER:
;
;		Yes, it now checks if the MSB is 1. This means that answers ranging from
;		8000 0000 and higher are considered signed and everything below is not
;		signed.
;
;		simp_cmp results:
;
;		FF,FF 		-> 0
;		4,1			-> 1
;		FFFFFFFF,1	-> 1
;
;		bad_cmp resutls:
;
;		FF,FF 		-> 0
;		4,1			-> 1
;		FFFFFFFF,1	-> 0
;
; 2.    *Bonus*: Could you make this program understand comparison of signed
;       numbers using only the Sign Flag and the Overflow Flag? Make the
;       necessary modifications to the code.
;
;	ANSWER:
;	
;		What are expected values of the overflow flag when we subtract positive
;		and negative numbers? 
;
;		+ - + = overflow flag undefined
;		+ - - = overflow flag set when result is - 
;		- - - = overflow flag undefined
;		- - + = overflow flag set when result is +
;
;		Say the first value = a, second value = b.  So when overflow flag is 
;		set, and sign flag is set, the second rule must be applied, so a > b.
;		We can say the reverse for the fourth rule, when the overflow flag
;		is set and the sign flag is not set, b >= a.
;		
;		Now for the first and third rule, create an example to see if the 
;		sign flag can be used to determine the largest value.
;
;		-3 - -4 = 1		sign flag not set a > b
;		-4 - -3 = -1	sign flag is set b >= a
; 		6 - 7 = -1		sign flag is set b >= a
;		7 - 6 = 1		sign flag not set a > b
;
;		We can conclude that when the sign flag is set, a is in both the first
;		and third rule larger then b. When the sign flag is not set, b is larger
;		or equal to a.
;
;		The program is written below. We used some extra labels and jumps for
;		readability.
	
	

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
    jo      overflow
    js		no_overflow_signed
    jns		no_overflow_not_signed

overflow:
	js		overflow_signed
	jns		overflow_not_signed

overflow_not_signed:
no_overflow_signed:
	; print 0 when first argument is largest 
    mov     eax,0
    call    print_eax
    jmp     c1
    

overflow_signed:
no_overflow_not_signed:
	; print 1 when first argument is smaller or equal
    mov     eax,1
    call    print_eax

c1:
    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
