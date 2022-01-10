; taken from here cause I was banging my head against a wall for hours -> https://gist.github.com/BertrandBordage/10921263
; checking if file exists -> https://gist.github.com/Archenoth/5380671
%define SYS_EXIT 60
%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define STDOUT 1
%define SYS_CREATE 85

%define BUFFER_SIZE 180

section .text
global  _start
_start:
  ; So we can read in our argument from argv[]
  add rsp, byte 0x10
  pop rdi
  jmp _check
  ; I added this to see
_check:
; basic if/else control flow -> https://stackoverflow.com/questions/14292903/complex-if-statement-in-assembly
  mov rdx,0
  cmp rdx,rax
  jle _cont
  jnle _exit_failiure
  _cont:

  ; open the file
  mov rax, SYS_OPEN
  mov rsi, 0
  syscall
  mov [fd], rax
  jmp _read_write

_read_write:
  ; Read the file into the buffer
  mov rax, SYS_READ
  mov rdi, [fd]
  mov rsi, file_buffer
  mov rdx, BUFFER_SIZE
  syscall

  cmp rax, 0
  je _exit_success

  jp _read_write


_exit_failiure:
  ; exit with code 1
  mov rax, 60
  mov rdi, 1
  syscall

_exit_success:
  ; Close the file stream
  mov rax, SYS_CLOSE
  mov rdi, fd
  syscall
  jmp exit
exit:
  mov rax, SYS_WRITE
  mov rdi, 1
  mov rsi, file_buffer
  mov rdx, BUFFER_SIZE
  syscall
  mov rax, SYS_WRITE
  mov rsi, 10
  mov rdx, 1
  syscall
  mov rax, 60
  mov rdi, BUFFER_SIZE
  syscall


section .data
fd dw 0
key db 0x32,0x36,0x13,0x92,0xa5,0x5a,0x27,0xf3
path: db "decrypted"
decrypted dw 0
led: equ $-path
index db 1


section .bss
file_buffer resb BUFFER_SIZE
length: equ $-file_buffer

; key: db '0123456789ABCDEF', 10
