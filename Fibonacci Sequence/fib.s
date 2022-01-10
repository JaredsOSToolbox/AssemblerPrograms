.intel_syntax noprefix
.global fib
.type fib, @function
.section .text
fib:
  cmp rax, 1
  jbe exit
  dec rax
  push rax
  call fib
  xchg rax, 0[rsp]
  dec rax
  call fib
  pop rcx
  add rax, rcx
  
  exit:
    ret

  
