%include 'functions.asm'

SECTION .data
prompt db 'Please enter your name: ', 0h
msg db 'Hello, ', 0h

SECTION .bss
sinput:  resb 255

SECTION .text
global _start

_start:
    ; print the prompt
    mov    eax, prompt
    call   sprint

    ; read user input using the read syscall (read(int fd, void *buff, size_t count))
    mov    edx, 255      ; max number of bytes to read
    mov    ecx, sinput   ; uninitialized buffer to write to
    mov    ebx, 0        ; read from the stdin file
    mov    eax, 3        ; read syscall
    int    80h           ; schedule an interrupt. the result will be put into EAX

    ; print the message
    mov    eax, msg
    call   sprint

    ; print the user input
    mov    eax, sinput
    call   sprint

    ; quit
    call   quit
