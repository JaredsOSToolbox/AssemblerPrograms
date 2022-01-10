; handles reading in the file, to the buffer, then closing the file

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
