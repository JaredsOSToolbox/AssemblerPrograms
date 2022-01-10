; taken from here cause I was banging my head against a wall for hours -> https://gist.github.com/BertrandBordage/10921263
; checking if file exists -> https://gist.github.com/Archenoth/5380671
; This program will decrypt a packet from an incoming satallite
; It decrypts the packet in memory so there is no need to write subroutines to reverse the order of the bytes
; Written by Jared Dyreson
; CPSC-240 TR @ 11:30 to 13:20

; Our Macros
%define SYS_EXIT 60
%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define STDOUT 1
%define SYS_CREATE 85
%define BUFFER_SIZE 180

; headers to clean this code up
%include "print.asm"
%include "decryption_algorithm.asm"
%include "packet_struct.inc"

section .text
global  _start
_start:
  ; So we can read in our argument from argv[]
  add rsp, byte 0x10
  pop rdi
_check_file_continutity:
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
  je close_file

  jp _read_write


_exit_failiure:
  ; exit with code 1
  mov rax, 60
  mov rdi, 1
  syscall

close_file:
  ; Close the file stream
  mov rax, SYS_CLOSE
  mov rdi, fd
  syscall

  xor r8, r8
  xor rax, rax

  call decrypt
exit:
  ; implementing code
  ; mov     eax, dword [file_buffer+msg_length]
  ; call    cvtEndian
  ; mov     dword [file_buffer+msg_length], eax

  mov rsi, status_message
  mov rdx, status_message_length
  call print

  mov rsi, file_buffer+status_msg
  mov rdx, 128
  call print

  mov rsi, endl
  mov rdx, 2
  call print

  mov rsi,  status_message_size
  mov rdx,  status_message_size_length
  call print

  ; mov eax, dword[file_buffer+msg_length]
  ; call cvtEndian
  ; mov dword[file_buffer+msg_length], eax
  mov eax, dword[file_buffer+NodeNumber]
  call cvtEndian
  mov dword[file_buffer+NodeNumber], eax
  call printDWord
  ; mov rsi, file_buffer+msg_length
  ; mov rdx, 1
  ; call print

  ; mov rsi, file_buffer+msg_length
  ; mov rdx, 1
  ; call print
  ; mov	rsi, rax
  ; mov rdx, rbx
  ; call print
  ; mov rsi, file_buffer
  ; mov rdx, BUFFER_SIZE
  ; call print
  mov rsi, endl
  mov rdx, 2
  call print
  mov rax, 60
  mov rdi, BUFFER_SIZE
  syscall
section .data
key: dq 0x36,0x13,0x92,0xa5,0x5a,0x27,0xf3,0x00,0x32
endl: db 0xA, 0xD
status_message db "Status Message: "
status_message_length  equ $-status_message
status_message_size db "Status Message Length: "
status_message_size_length equ $-status_message_size
fd dw 0

section .bss
file_buffer resb BUFFER_SIZE
