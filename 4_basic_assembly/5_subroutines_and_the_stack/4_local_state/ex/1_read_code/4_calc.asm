; Basic Assembly
; ==============
; 
; Subroutines and the stack - Local state
; ---------------------------------------
; 
; Calc
; @@@@
;
; 0.    Assemble and run this program.
;
; 1.    Observe the output.
;
; 2.    Skim the code. Take a look at the functions and their descriptions.
;       Understand the dependencies between the functions (Which function calls
;       which function), and what is the special purpose of every function.
;
; 3.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
;       For every function: Fill in the Input, Output and Operation. Be brief
;       and to the point.
;
; 4.    Edge cases:
;
;       - What happens when the operator is not identified? How is it being
;         checked?
;       - What happens if a digit is not identified? How is it being checked?
;
; 5.    Add support for the XOR (^) and the OR (|) operators.
;
; 6.    Currently the program only supports decimal digits. Add support for
;       hexadecimal digits too.
;

format PE console
entry start

include 'win32a.inc' 

MAX_EXPR = 4
; ===============================================
section '.data' data readable writeable
    enter_exp       db  'Enter an expression of the form [digit][operator]'
                    db  '[digit]',13,10
                    db  'Examples: 1+2,3-5,4*3:',13,10
                    db  '>',0

    result          db  'The result is: ',0
    expr            db  MAX_EXPR dup (0)

    oper_tbl:  
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, star_op, plus_op, def_op, minus_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op
    dd      def_op, def_op, def_op, def_op, def_op, def_op, def_op, def_op

; ===============================================
section '.text' code readable executable

start:
    ; Ask the user for expression:
    mov     esi,enter_exp
    call    print_str

    ; Read expression:
    mov     ecx,MAX_EXPR
    mov     edi,expr
    call    read_line

    ; Evaluate expression:
    push    expr
    call    eval
    add     esp,4

    ; Print result to console:
    mov     esi,result
    call    print_str
    call    print_eax

    ; Exit the process:
	push	0
	call	[ExitProcess]


; ===========================================================
; digit_to_num(digit_addr)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;   ?
;
digit_to_num:
    .digit_addr = 8
    push    ebp
    mov     ebp,esp
    push    esi

    mov     esi,dword [ebp + .digit_addr]
    lodsb

    sub     al,'0'
    cmp     al,9
    jbe     .good_digit
    ; If invalid digit, we return zero:
    xor     eax,eax
.good_digit:
    movzx   eax,al
    pop     esi
    leave
    ret

; ===========================================================
; func_by_operator(oper_addr)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;   ?
;
func_by_operator:
    .oper_addr = 8
    push    ebp
    mov     ebp,esp
    push    esi

    mov     esi,dword [ebp + .oper_addr] 
    lodsb
    movzx   eax,al
    mov     esi,oper_tbl
    mov     eax,dword [esi + 4*eax]

    pop     esi
    leave
    ret


; ===========================================================
; eval(str_addr)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;   ?
;
eval:
    .str_addr = 8
    push    ebp
    mov     ebp,esp

    mov     esi,dword [ebp + .str_addr]
    push    esi
    call    digit_to_num
    add     esp,4
    mov     edx,eax

    inc     esi
    push    esi
    call    func_by_operator
    add     esp,4
    mov     edi,eax

    inc     esi
    push    esi
    call    digit_to_num
    add     esp,4

    push    eax
    push    edx
    call    edi
    add     esp,2*4

    leave
    ret

; ===========================================================
; op(a,b)
;
; Input:
;   ?
; Output:
;   ?
; Operation:
;   ?
;

def_op:
    .a = 8
    .b = 0ch
    push    ebp
    mov     ebp,esp
    xor     eax,eax
    leave
    ret

star_op:
    .a = 8
    .b = 0ch
    push    ebp
    mov     ebp,esp
    push    edx

    mov     eax,dword [ebp + .a]
    mul     dword [ebp + .b]
    
    pop     edx
    leave
    ret

plus_op:
    .a = 8
    .b = 0ch
    push    ebp
    mov     ebp,esp

    mov     eax,dword [ebp + .a]
    add     eax,dword [ebp + .b]
    
    leave
    ret

minus_op:
    .a = 8
    .b = 0ch
    push    ebp
    mov     ebp,esp

    mov     eax,dword [ebp + .a]
    sub     eax,dword [ebp + .b]
    
    leave
    ret

include 'training.inc'
