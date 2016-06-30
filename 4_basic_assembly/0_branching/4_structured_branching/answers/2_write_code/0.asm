; 0. Write a program that takes the number n as input. Then it prints all the
;    numbers x below n that have exactly 2 different integral divisors (Besides 1
;    and x).
;
;    For example: 15 is such a number. It is divisible by 1,3,5,15. (Here 3 and 5
;    are the two different divisiors, besides 1 and 15).
;
;    However, 4 is not such a number. It is divisible by 1,2,4
;

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable

start:
  call  read_hex

	mov   esi, eax    ; user input
	mov   ebx, 2      ; counter for x, x must be at least 3 or higher (inc in first iteration)

next_integral:
	inc   ebx

	mov   ecx, 2      ; counter for divisor, at least 2
	mov   edi, 0      ; counter for integral divisors

try_division:
	mov   eax, ebx
	mov   edx, 0
	div   ecx

	cmp   edx, 0      ; check if there is a remainder
	jnz   we_have_remainder
	inc   edi         ; no remainder, so increase the counter for integral diviors

we_have_remainder:
	inc   ecx

	cmp   ebx, ecx
	jnz   try_division

	cmp   edi, 2      ; check if we have exactely 2 divisors
	jnz   no_print_integral

	mov   eax, ebx
	call  print_eax

no_print_integral:
	cmp   esi, ebx    ; check if our counter ebx has reached the user limit esi

	jnz   next_integral

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
