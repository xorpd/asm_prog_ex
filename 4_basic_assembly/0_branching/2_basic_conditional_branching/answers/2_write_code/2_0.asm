;  2.  The Fibonacci series is the series of numbers where every number is the sum
;    of the two previous numbers. It begins with the numbers: 1,1,2,3,5,8,...
;    Write a program that takes as input the number n, and prints back the n-th
;    element of the fibonacci series.
;
;    Bonus question: What is the largest n that can be given to your program such
;    that it still returns a correct answer? What happens when it is given larger
;    inputs?
;
;		ANSWER:
;			
;			Use 3 registers, one for the n-1, one for n and one for the sum of 
;			those. Use a counter to compare with user input if we have reached
;			the n-th number.
;			Start with given, 0 and 1, make a loop that adds the last two numbers.
;
;			Bonus: Our largest answer fits in an 32 bits register, which = 8 hex 
;			= 4,294,967,296 dec. Use a table to lookup the largest value.
;
;			0 : 0
;			1 : 1
;			2 : 1
;			3 : 2
;			4 : 3
;			5 : 5
;			6 : 8
;			7 : 13
;			8 : 21
;			9 : 34
;			10 : 55
;			11 : 89
;			12 : 144
;			13 : 233
;			14 : 377
;			15 : 610
;			16 : 987
;			17 : 1597
;			18 : 2584
;			19 : 4181
;			20 : 6765
;			21 : 10946
;			22 : 17711
;			23 : 28657
;			24 : 46368
;			25 : 75025
;			26 : 121393
;			27 : 196418
;			28 : 317811
;			29 : 514229
;			30 : 832040
;			31 : 1346269
;			32 : 2178309
;			33 : 3524578
;			34 : 5702887
;			35 : 9227465
;			36 : 14930352
;			37 : 24157817
;			38 : 39088169
;			39 : 63245986
;			40 : 102334155
;			41 : 165580141
;			42 : 267914296
;			43 : 433494437
;			44 : 701408733
;			45 : 1134903170
;			46 : 1836311903
;			47 : 2971215073
;			48 : 4807526976
;
;			So 47 is the largest n value.
;
;			When we take a larger number, the carry flag is set and the
;			answer cannot be trusted to be valid again.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:
	call 	read_hex

	; previous1 number
	mov		ebx, 0
	; previous2 number
	mov		edx, 1

	; counter for n-th number
	mov		ecx, 0

	; store user input in esi, so we can use it to subtract
	mov		esi, eax

next_fibo:
	; reset the result for next number (= prev1 + prev2)
	mov		edi, 0

	; calculate the next number, store in edi
	add		edi, ebx
	add		edi, edx

	; now shift prev2 to prev1
	mov		ebx, edx
	; now shift next to prev2
	mov		edx, edi

	; increase the n-th counter
	inc		ecx

	; check if counter equals user input, in that case go print ebx
	mov		eax, esi
	sub		eax, ecx
	jnz		next_fibo

	; mov prev2 to print register
	mov		eax, ebx
	
print:
	call	print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]

include 'training.inc'
