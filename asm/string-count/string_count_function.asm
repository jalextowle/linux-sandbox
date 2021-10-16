global _start

SECTION .data

msg db 'Hello, brave new world!', 0Ah

SECTION .text

_start:
    mov eax, msg
    call strlen

    mov edx, eax      ; Our function leaves the result in eax
    mov ecx, msg      ; This is all the same as before
    mov ebx, 1
    mov eax, 4
    int 80h

    mov ebx, 0
    mov eax, 1
    int 80h

strlen:               ; this is our first function declaration
    push ebx          ; push the value in EBX onto the stack to preserve it while we use EBX in this function
    mov  ebx, eax

nextchar:             ; this is the same as in lesson 3 (string_count_32.asm)
    cmp byte [eax], 0
    jz finished
    inc eax
    jmp nextchar

finished:
    sub eax, ebx
    pop ebx           ; pop the value on the stack into ebx
    ret               ; return from the function
