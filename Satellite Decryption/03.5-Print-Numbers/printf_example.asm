extern printf

global main

section .text
main:
    mov rdi,printf_format
    mov rsi,0x404000
    xor rax,rax
    call printf


    mov rax,60	; exit
    syscall


section .data
printf_format: db '%x',10,0
