; adder

SECTION .data
  var1:  dq 1
  var2: dq 2
  var3: dq 0
SECTION .text
global _start
_start:
  mov rax,rax
  mov rax,[var1]
  add rax,[var2]
  mov rax, [var3]
  mov ecx, [var3]
  mov     rdi, 1          ; File handle 1 is stdout
  mov     rsi, [var3]   ; Addres of string to output
  mov     rdx, 12          ; Size of message in # of bytes
  syscall
  mov rax, 60
  syscall


