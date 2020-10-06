                                     ; 0.
;   0.1 Write a program that does the same, except that it multiplies the four
;       bytes. (All the bytes are considered to be unsigned).
;
;   ANSWER:
;
;       Because max input is FC05FC01 (= FF * FF * FF * FF), max. result will fit in
;       a 32 bit register. Every multiplication is saved in edx:eax (but only eax,
;       since max. result is 32 bit), so we can take every outcome and multiply it
;       with the next param.

format PE console
entry start

include 'win32a.inc'

; ===============================================
section '.text' code readable executable
start:
      call  read_hex
      mov   edi, eax

      ; cleared registers for isolating the params
      mov   ebx, 0  
      ; same as above but takes less bytes
      xor   edx, edx
      ;result
      mov   ecx, 0

      ; Treat the lower word
      mov   bl, al              
      movzx eax , ah  ; clear eax since it still has part of the input
      mul   ebx                 
      mov   ecx, eax

      mov   edx, 0
      ;restore the original value of eax
      mov   eax, edi
      ;right word shift
      mov   esi, 65536
      
      div   esi                   

      ;now treat the higher word which was just shifted to the lower
      mov   bl, al
      movzx eax, ah        
      mul   ebx         

      ;(param1 * param2) * (param3 * param4)
      mul   ecx
      
      ;print eax
      call  print_eax

      ; Exit the process:
      push  0
      call  [ExitProcess]
        
include 'training.inc'
