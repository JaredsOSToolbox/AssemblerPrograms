section .text
global  _start
_start:
mov r8, 1
mov r9, 3
sub r9, r8
mov rdi, r9
mov rax, 60
syscall
