; Basic Assembly
; ==============
;
; 5.  Rotation overflow.
; 
;     The ror/rol instructions receive two arguments: dest and k. k is the amount
;     of bit locations we rotate. (k=1 means rotate one bit location).
; 
;     What happens if k is larger than the size of the argument? For example, what
;     would the following instructions do:

;     For each of those instructions:
;     - Check if it assembles. a: It assembles.
;     - Write some code that includes that instruction, and find out what it does.
;
;     5.0   ror   eax,54d
;
;     A1: It assembles.
;     A2: It rotates the bits to the right with k=54 in decimal. 
;         Since 2*32-54=10, we could also say it rotates the bits with 
;         k=10 to the left.
;         All the 32 bits get rotated.
; 
;     5.1   rol   bx,19d
;
;     A1: It assembles.
;     A2: It rotates the bits to the left with k=19 in decimal. As 19-16=3,
;         it rotates bx 3 bits to the left.
;         Only the last 16 (bx) bits get rotated, the first sixteen 
;         bits remain intact.
;
;     5.2   ror   dh,10d
;
;     A1: It assembles.
;     A2: It rotates the bits to the right with k=10 in decimal.  Since 10-8=2,
;         it rotates dh 2 bits to the right.
;         The last 8 bits (dl) and the firts 16 bits remain intact, 
;         dh gets rotated.
;
;     5.3   mov   cl,0feh
;           ror   edx,cl
;
;     A1: It assembles.
;     A2: It rotates all the 32 bits in edx with k=2 in decimal 
;         to the left, as 0feh, in 8-bit, is -2 in decimal.
; 
;     5.4   ror   eax,1001d
;
;     A1: It doesn't assemble. The value 1001d (0x3ed) doesn't fit 
;         in a byte.
;         The error: processed: ror eax,1001d
;                    error: value out of range.
;     A2: It does nothing, since it doesn't exist.

format PE console
entry start

include 'win32a.inc' 

; ===============================================
section '.text' code readable executable

start:

    call  read_hex
    mov   ebx,eax
    mov   edx,eax
    mov   ecx,eax
    mov   esi,eax

    ror   eax,54d       ; check 5.0
    call  print_eax

    rol   bx,19d        ; check 5.1
    mov   eax,ebx
    call  print_eax

    ror   dh,10d        ; check 5.2
    mov   eax,edx
    call  print_eax

    mov   edx,esi       ; check 5.3
    mov   cl,0feh
    ror   edx,cl
    mov   eax,edx
    call  print_eax

    mov   eax,esi       ; check 5.4 - Comment it out, if you want to compile
    ror   eax,1001d
    call  print_eax

    ; Exit the process:
    push  0
    call  [ExitProcess]

include 'training.inc'
