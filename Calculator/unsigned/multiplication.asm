; Jared Dyreson
section .text
global _start
; result = number * other
_start:
mov al, byte[number]
mul byte[other]
; the result of the multiplication operation is in ax which is the 8 bit register of rax
; register widening to make way for the result of ax to be stored in the answer variable
mov word[answer], ax
; since the contents of the answer variable will fit inside the rdi register, we do not need to type punn it
mov rdi, [answer]
mov rax, 60
syscall

section .data
number: db 10
other: db 10
answer: db 0
