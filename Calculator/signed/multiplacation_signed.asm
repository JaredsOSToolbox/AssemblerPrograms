section .text
global _start
_start:
; answer = number * constant
mov ax, [number]
imul ax, -10
mov [number], ax
mov rdi, number
mov rax, 60
syscall
section .data
number: db 10
