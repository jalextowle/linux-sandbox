; A hello world assembly program.

global _start

section .text
_start:
    ; Write message to stdin
    mov rax, 1           ; system call for write
    mov rdi, 1           ; file descriptor for stdin
    mov rsi, message     ; address of string to output
    mov rdx, message_len ; length of the message
    syscall              ; invoke operating system to do the write

    ; Exit
    mov rax, 60          ; system call for exit
    xor rdi, rdi         ; exit code 0
    syscall              ; invoke operating system to exit

section .data
    message db "Hello, world!", 0xa 
    message_len equ $-message
