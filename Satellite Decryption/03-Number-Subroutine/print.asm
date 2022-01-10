; Our Macros
%define SYS_EXIT 60
%define SYS_READ 0
%define SYS_WRITE 1
%define SYS_OPEN 2
%define SYS_CLOSE 3
%define STDOUT 1
%define SYS_CREATE 85
%define BUFFER_SIZE 180

section .text
; input is rsi, len is rdx
; print(content=rsi, strlen=rdx)
print:
  push rax
  push rdi
  mov rax, SYS_WRITE
  mov rdi, 1
  syscall
  pop rdi
  pop rax
  ret

; printDoubleWord(eax)
printDWord:
        push    r8
        mov     r8, 7   ; i
        mov     rbx, 0
printloop:
        cmp     r8, 0
        jz      printexit
	xor	edx, edx
        div     dword [ten]        ; rem in edx
        add     edx, '0'
        mov     byte [small_buffer + r8], dl
        inc     rbx
        cmp     eax, 0
        jz      printexit
        dec     r8
        jmp     printloop
printexit:
        lea     rax, [small_buffer + r8]
        pop     r8
        ret
; Convert dword endian...
; eax has value to convert
; Will return converted value in eax
; cvtEndian(eax)

cvtEndian:
  push    rbx
  push    rcx

  mov     ebx, eax
  shr     ebx, 24
  mov     ecx, ebx

  mov     ebx, eax
  shr     ebx, 8
  and     ebx, 0xff00
  or      ecx, ebx

  mov     ebx, eax
  shl     ebx, 0x8
  and     ebx, 0xff0000
  or      ecx, ebx

  mov     ebx, eax
  shl     ebx, 0x18
  or      ecx, ebx
  mov     eax, ecx

  pop     rcx
  pop     rbx
  ret
section .data
xlat_table: db "0123456789", 10
ten       dd    10

section .bss
small_buffer  resb  8
