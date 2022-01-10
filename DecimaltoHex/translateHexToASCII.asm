; convert hex to ascii using offset values
; Jared Dyreson
; CPSC-240-09 TR @ 11:30 - 13:20

; some light -> https://stackoverflow.com/questions/36336045/print-register-value-to-console

; I also included a bash script that I was using to compile the ASM files, thought it might be useful for the class
; cmp function -> https://stackoverflow.com/questions/45898438/understanding-cmp-instruction
; jmp with conditions -> https://stackoverflow.com/questions/1123396/assembly-to-compare-two-numbers
; ^ https://en.wikibooks.org/wiki/X86_Assembly/Control_Flow
global _start

SECTION .text

_start:
  cmp byte[bval], 16 ; if a >= b; then move to the exit function
  jge _exit
  mov rdi, 1
  mov al, byte[bval]
  lea rbx, [xtable]
  xlat
  mov byte[bval], al
  mov rsi, bval
  xor rax, rax
  mov rax, 1
  mov rdx, 2 ; if you pass in length, it prints the content of the a.out bin for some odd, inexplicable reason
  syscall
  jmp _exit
_exit:
  mov rax, 60
  mov rdi, 0
  syscall
SECTION .data

length: equ $bval
xtable: db '0123456789ABCDEF', 10
bval: db 14, 10
