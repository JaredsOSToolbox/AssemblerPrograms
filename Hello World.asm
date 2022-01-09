; Link found here -> https://stackoverflow.com/questions/20619853/syscalls-for-x86-64-linux-nasmyasm-detailed-description
; File to look at here -> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/fs/open.c
SECTION .data
    message: db 'Hello, world!',0x0a
    length:    equ    $-message
    fname    db "result"
    fd       dq 0

SECTION .text
global _start
_start:
        mov rax, 2            ; 'open' syscall
        mov rdi, fname        ; file name
        mov rsi, 0102o        ; read and write mode, create if not
        mov rdx, 0666o        ; permissions set
        syscall

        mov [fd], rax

        mov    rax, 1          ; 'write' syscall
        mov    rdi, [fd]       ; file descriptor
        mov    rsi, message    ; message address
        mov    rdx, length     ; message string length
        syscall

        mov rax, 3             ; 'close' syscall
        mov rdi, [fd]          ; file descriptor
        syscall

        mov    rax, 60         ; we wanna quit fo real
        mov    rdi, 0
        syscall
