.intel_syntax noprefix
.global adding
.type adding, @function
.section .text
adding:
  add edi, esi
  mov eax, esi
  ret
