section .text
global _start
_start:
xor r9, r9
xor r10, r10
mov r9, 10
mov r10, 19
imul r9, r10
mov rax, 60
mov rdi, r9 ; move the content of r9 into rdi so we can see the muliplication result
syscall
