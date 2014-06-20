; Basic Assembly
; ==============
; 
; Memory
; ------
;
; Peak
; @@@@
; 
; 0.    Assemble and run this program.
;
; 1.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
; 2.    Explain the program's output.
;
; 3.    Note the trick which allows to find out the size of the array at
;       assembly time. Try to add the element 21h to the array, and make sure
;       that you get the expected behaviour from the new program.
;

format PE console
entry start

include 'win32a.inc' 

; This is the data section:
; ===============================================
section '.data' data readable writeable
    ; We use here a common trick to find out the length of the array.
    ; We mark the end of the array with a label, and then we can subtract
    ; the two labels to get the total size in bytes.
    ; (See code below)

    ; Here we define some consecutive dwords:
    my_nums   dd  1,6,3,2,11h,3,9,17h,5h,14h
    my_nums_end:

    ; In this manner we could add new numbers to the array, and our code will
    ; keep working.
    
; This is the code section:
; ===============================================
section '.text' code readable executable

start:

    ; Find out the number of elements in the array:
    ; we use (my_nums_end - my_nums) / 4.
    ; We divide by 4, because every element is of size 4 bytes.

    ; my_nums is the address of the my_nums array.
    ; my_nums_end is the address of the end of the my_nums array.
    mov     ebx,(my_nums_end - my_nums) / 4
    ; Note that the expression (my_nums_end - my_nums)/4 is being calculated by
    ; fasm, at the assembly time.

    xor     esi,esi     ; dword index.
    mov     edi,my_nums ; Base (my_nums)
    xor     ecx,ecx     ; Lowest unsigned number is zero.

check_num:
    ; Get dword number esi from my_nums:
    mov     eax,dword [edi + 4*esi]
    cmp     ecx,eax
    jae     no_new_max
    ; Set new maximum:
    mov     ecx,eax
no_new_max:
    inc     esi
    cmp     esi,ebx
    jnz     check_num

    ; Print the result:
    mov     eax,ecx
    call    print_eax 

    ; Exit the process:
	push	0
	call	[ExitProcess]


include 'training.inc'
