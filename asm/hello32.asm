global _start

SECTION .text

_start:
    mov eax, 4       ; Invoke the write syscall
    mov ebx, 1       ; Write to the stdout file descriptor
    mov ecx, msg
    mov edx, msg_len
    int 80h
    
    mov eax, 1       ; Exit the program
    mov ebx, 0       ; No errors
    int 80h

SECTION .data
msg     db  "Hello, brave new world!", 0Ah
msg_len equ $-msg
