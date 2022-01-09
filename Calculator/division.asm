section .text
global _start
_start:
mov al, byte[number]
mov ah, 0
mov bl, 3
div bl
mov byte[answer], al
mov rax, 60
mov rdi, [answer]
syscall

section .data
number: db 12
answer: db 0
