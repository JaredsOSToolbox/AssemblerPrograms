; This program will test my NASM knowledge

global _start
section .text
; Takes in al as input
isEven:
  ; C-Code Equivalent
  ; return (number%2==0) ? 1 : 0;
  push r8
  ; divide the number by 2
  ; check if the remainder is 0?
  ; preparing for integer division
  mov al, r8b
  xor ah, ah ; clear the remainder
  mov bl, 3
  div bl
  cmp ah, 0
  jz return_zero
  return_one:
    ; since we do not need to have al stay in contact, we can discard it by having it hold the TRUE or FALSE variable
    mov r8, 1
    jmp exit
  return_zero:
    xor r8, r8
  exit:
    ret
_start:
  mov al, 2
  call isEven
  cmp r8, 1
  inc r9
  mov rax, 60
  mov rdi, 0
  syscall
section .data
array: dq ""
