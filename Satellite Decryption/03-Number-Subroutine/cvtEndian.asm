%include "satStruct.inc"
        global _start
        section  .text
_start:

        mov     rax, 2          ; System call for Open
        mov     rdi, fileName   ; File name null terminated
        mov     rsi, 0          ; Address of string to output
        syscall                 ; invoke operating system to do the write
        mov     qword [fileDesc], rax

        mov     rax, 0          ; System call for read
        mov     rdi, qword [fileDesc]    ; File handle from Open
        mov     rsi, readBuffer          ; Address of read buffer
        mov     rdx, readBufferLen       ; Size of message in # of bytes
        syscall                 ; invoke operating system to do the write

; Decrypt the buffer...
        mov     r8, 0           ; r8 will be index into readBuffer
        mov     r9, 0           ; r9 will be index into the key
decryptLoop:
        cmp     r8, 180
        je      loopEnd
        mov     al, [key+r9]    ; Pick up next byte in key.
        xor     Byte [readBuffer+r8], al   ; unmask one byte in the buffer.
        inc     r8              ; Index to next byte in bufferRead
        inc     r9              ; Index to next byte in key
        cmp     r9, keyLen      ; Are we beyond end of key?
        jne     noKeyReset      ; Not yet =>
        mov     r9, 0           ; Reset index into the key.
noKeyReset:
        jmp     decryptLoop
loopEnd:

        mov     eax, dword [readBuffer + track_object_nbr]
        call    cvtEndian
        mov     dword [readBuffer + track_object_nbr], eax

        mov     rsi, track_object_nbr_name
        mov     rdx, track_object_nbr_name_len
        call    print

        mov     eax, dword [readBuffer + track_object_nbr]
        call    printDWord
	mov	rsi, rax
	mov	rdx, rbx
    	call	print
	mov	rsi, lf
	mov	rdx, 1
	call 	print

; Exit back to the operating system...
exit:
        mov     rax, 60         ; System call for exit
        xor     rdi, rdi        ; exit code 0
        syscall                 ; Invoke operating system to do the exit

; Print to console
; input is rsi -> what to write  rdx -> length to write...
print:
        push    rax
        push    rdi
        mov     rax, 1          ; System call for write
        mov     rdi, 1          ; File handle is 1 for stdout
        syscall                 ; invoke operating system to do the write
        pop     rdi
        pop     rax
        ret



; Alternative way of converting endianess...
; Convert dword endian...
; eax has value to convert
; Will return converted value in eax

cvtEndian:
	push	rbx
;                                       ; eax = 4 3 2 1
        rol     eax, 8			; eax = 3 2 1 4
        mov     ebx, eax
        and     eax, 0x00ff00ff		; eax = - 2 - 4
        and     ebx, 0xff00ff00		; ebx = 3 - 1 -
        ror     ebx, 16			; ebx = 1 - 3 -
        or      eax, ebx		; eax = 1 2 3 4
	pop	rbx
	ret

; Print a dword on the console
; Pass dword to print in eax...
; returns ptr to printable in rax, length in rbx...
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
        mov     byte [outWork + r8], dl
        inc     rbx
        cmp     eax, 0
        jz      printexit
        dec     r8
        jmp     printloop
printexit:
        lea     rax, [outWork + r8]
        pop     r8
        ret


        section .data
fileName  db    "sat41x10.dat",0
key       db    0x36,0x13,0x92,0xa5,0x5a,0x27,0xf3,0x00,0x32
keyLen    equ   $-key
track_object_nbr_name db "Track Object Number: "
track_object_nbr_name_len  equ  $-track_object_nbr_name
ten       dd    10
lf	  db	10

        section .bss
fileDesc       resq  1
readBuffer     resb  180
readBufferLen  equ   $-readBuffer
outWork        resb  8
