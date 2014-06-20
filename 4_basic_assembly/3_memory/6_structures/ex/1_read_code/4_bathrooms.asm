; Basic Assembly
; ==============
; 
; Memory - Structures
; -------------------
;
; Bathrooms
; @@@@@@@@@
; 
; 0.    Assemble and run this program.
;
; 1.    How many inputs does this program require? 
;       Try to give the program some inputs, and check out the results. 
;
; 2.    Read the program's code below, and try to understand what does it do. 
;       Try to describe it as simply as you can. Add comments if needed.
;
; 3.    Try to draw the city's map.
;

format PE console
entry start

include 'win32a.inc' 

; Coordinate structure:
struct COORD
    x   db  ?
    y   db  ?
ends

; Dimensions of the city:
CITY_WIDTH      = 12
CITY_HEIGHT     = 11

; ===============================================
section '.data' data readable writeable
    ; List of bathroom's coordinates in the city:
    bathrooms   COORD    4,3
                COORD    7,3
                COORD    3,6
                COORD    8,6
                COORD    4,7
                COORD    7,7
                COORD    5,8
                COORD    6,8
    NUM_BATHROOMS = ($ - bathrooms) / sizeof.COORD
    ; NOTE: $ means the address of the current location.
    ; This is a trick used to calculate the size of some chunk of data.
    ; $ can be used anywhere in the assembly source file. (In the code section
    ; too.)

; ===============================================
section '.bss' readable writable

    user_location               COORD   ?
    closest_bathroom_index      dd      ?
    closest_bathroom_dist       dd      7fffffffh ; "Infinity"
    
; ===============================================
section '.text' code readable executable

start:
    
    ; Read current location from user:
    call    read_hex
    mov     edx,eax
    call    read_hex

    ; First make sure that the location is inside the city.
    ; If not, exit the program.

    cmp     edx,CITY_WIDTH
    jb      dont_exit1
    ; NOTE: We can exit the program whenever we want using the two following
    ; instructions:

    ; Exit the program:
    push    0
    call    [ExitProcess]
dont_exit1:
    
    cmp     eax,CITY_HEIGHT
    jb      dont_exit2
    ; Exit the program
    push    0
    call    [ExitProcess]
dont_exit2:

    ; Keep the user's location in memory.
    mov     byte [user_location.x],dl
    mov     byte [user_location.y],al

    mov     esi,bathrooms
    mov     ecx,NUM_BATHROOMS

calc_one_dist:
    ; edi will store the square of the distance:
    xor     edi,edi

    ; (user_location.x - bathroom.x)^2
    movzx   eax,byte [user_location.x]
    movzx   ebx,byte [esi + COORD.x]
    sub     eax,ebx
    imul    eax
    add     edi,eax

    ; (user_location.y - bathroom.y)^2
    movzx   eax,byte [user_location.y]
    movzx   ebx,byte [esi + COORD.y]
    sub     eax,ebx
    imul    eax
    add     edi,eax

    ; Now edi == distance(user_location,current_bathroom)^2
    cmp     edi,dword [closest_bathroom_dist]
    jge     not_closer

    ; Update the closest distance to be edi:
    mov     dword [closest_bathroom_dist],edi

    ; Update the index of closest bathroom to be (NUM_BATHROOMS - ecx):
    mov     edx,ecx
    sub     edx,NUM_BATHROOMS
    neg     edx
    mov     dword [closest_bathroom_index],edx
not_closer:
    add     esi,sizeof.COORD
    loop    calc_one_dist

    ; Print results:
    ; --------------

    ; Print a delimiter:
    call    print_delimiter

    ; Print closest distance (Squared):
    mov     eax, dword [closest_bathroom_dist]
    call    print_eax

    ; Print another delimiter:
    call    print_delimiter

    mov     edi,bathrooms
    mov     esi,dword [closest_bathroom_index]
    lea     esi,[edi + sizeof.COORD * esi]

    ; Print x and y coordinates:
    movzx   eax,byte [esi + COORD.x]
    call    print_eax

    movzx   eax,byte [esi + COORD.y]
    call    print_eax

    ; Exit the program:
	push	0
	call	[ExitProcess]


include 'training.inc'
