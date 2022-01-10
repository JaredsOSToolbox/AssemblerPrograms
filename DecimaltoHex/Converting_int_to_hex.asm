; Links : https://www.aldeid.com/wiki/X86-assembly/Instructions/div
; Algorithm : https://learn.sparkfun.com/tutorials/hexadecimal/all

%define STACK_SIZE 12

section .data
variable: db 15, 10
large_number: dd 300
answer: db 0
hextable: db "0123456789ABCDEF"

section .text
global _start
global conversion

_start:
		push rbp
		mov rbp, rsp
		sub rsp, STACK_SIZE
		mov eax, [large_number]
		xor r11, r11 ; to move through the stack
		mov ecx, 16 ; our divisor
		div ecx
		mov dword[large_number], eax
		mov dword[answer], edx
		push answer
		jmp conversion

conversion:
		; divide until the quotient is zero
		; push the remainder onto the stack

		cmp eax,0
		je exit_loop
		xor edx, edx

exit_loop:
		; retrieve the values from the stack
		cmp r11, STACK_SIZE
		jge finally
		; mov al, byte[rbp+4]
		pop r12
		mov al, byte[r12]
		lea rbx, [hextable]
		xlat
		mov byte[answer], al
		mov rsi, answer
		mov rax, 1
		mov rdx, 2
		add r11, 4
		syscall
		; pop rbp
		jmp exit_loop
		finally:
		mov rax, 60
		mov rdi, 1
		syscall
