; This is home to the world famous decryption algorithm
; goal
; xor each byte in the file buffer, given a certain offset to that position in the string in the file_buffer and the key
; reset the key once we reach 9th element

; r8 -> indexing the file_buffer
; rax -> indexing our key
; r11 -> contains our needed variable from the file_buffer
; r12 -> contains our needed variable from the key
section .text
_reset_key:
  xor rax, rax
  jmp decrypt

decrypt:
  ; if(r8 >= 180), we need to leave
  cmp r8, 180
  jge exit

  ; if(r9 > 8), we need to reset it
  cmp rax, 8
  jg _reset_key

  ; load the character from the file_buffer we need into the variable [check]
  lea rbx, [file_buffer]
  mov r11, [rbx+(r8*1)] ; variable = buff[i]
  ; move current offset into the correct register
  lea rbx, [key]
  mov r12, [rbx+(rax*8)]; xor_key_variable = key[index]
  xor r11, r12 ; buf[i] ^ key[index]
  mov [file_buffer+r8], r11b ; r11 = buf[i] ^ key[index]
  inc r8 ; r8++
  inc rax ; rax++
  jmp decrypt ;loop back
