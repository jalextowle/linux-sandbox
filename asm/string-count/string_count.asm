global _start

SECTION .data

msg db 'Hello, brave new world!', 0Ah

SECTION .text

_start:
    mov eax, msg
    mov ebx, eax

nextchar:
    cmp byte [eax], 0 ; Compare the byte pointed to by EAX at this address agaisnt zero (Zero is the end of string delimiter)
    jz finished      ; jump (if the zero flagged has been set) to the point in the code labeled 'finished'
    inc eax           ; Increment EAX by one byte
    jmp nextchar      ; jump to the point in the code labeled nextchar

finished:
    sub eax, ebx

    mov edx, eax      ; EAX now equals the number of bytes in our string.
    mov ecx, msg      ; Point ECX to the data
    mov ebx, 1        ; Point EBX to the STDOUT file descriptor
    mov eax, 4        ; The write system call
    int 80h           ; Request an interupt for the syscall

    mov ebx, 0        ; Exit code of 0
    mov eax, 1        ; Exit syscall
    int 80h           ; Request an interupt to exit
