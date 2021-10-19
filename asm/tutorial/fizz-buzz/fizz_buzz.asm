%include '../functions.asm'

SECTION .bss
ascii:  RESB 32

SECTION .data
fizz    db 'fizz', 0h
buzz    db 'buzz', 0h
newline db 0h

SECTION .text
global  _start

_start:

.loop:
    cmp    ecx, 101
    je     .success
    mov    esi, 0

    ; check if the counter is divisble by 3
    mov    ebx, 3
    mov    edx, 0
    mov    eax, ecx
    div    ebx
    cmp    edx, 0
    jz     .fizz

.fizz_back:
    ; check if the counter is divisble by 5
    mov    ebx, 5
    mov    edx, 0
    mov    eax, ecx
    div    ebx
    cmp    edx, 0
    jz     .buzz

.buzz_back:
    ; check if fizz or buzz was printed
    cmp    esi, 1
    je     .newline
    push   ecx
    mov    eax, ecx
    mov    ecx, 32
    mov    ebx, ascii
    call   itoa
    pop    ecx
    mov    eax, ascii
    call   sprintln
    inc    ecx
    jmp    .loop

.newline:
    mov    eax, newline
    call   sprintln
    inc    ecx
    jmp    .loop

.fizz:
    cmp    ecx, 0
    je     .fizz_back
    mov    eax, fizz
    call   sprint
    mov    esi, 1
    jmp    .fizz_back

.buzz:
    cmp    ecx, 0
    je     .buzz_back
    mov    eax, buzz
    call   sprint
    mov    esi, 1
    jmp    .buzz_back

.success:
    call   quit
