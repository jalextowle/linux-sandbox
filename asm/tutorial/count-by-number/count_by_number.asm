%include 'functions.asm'

SECTION .bss
max: RESB 32
debug: RESB 32

SECTION .data
prompt db 'Please enter a number to count to: ', 0h

SECTION .text
global _start

_start:
    ; print the prompt
    mov   eax, prompt
    call  sprint

    ; read in user input
    mov   ebx, 32
    mov   eax, max
    call  sin

    ; convert the string (interpreted as decimal number) to integer
    call  atoi
    mov   edx, eax
    mov   esi, 0

print_loop:
    cmp   esi, edx
    jz    print_success
    mov   ecx, 32
    mov   ebx, debug
    mov   eax, esi
    call  itoa
    mov   eax, ebx
    call  sprintln
    inc   esi
    jmp   print_loop

print_success:
    call  quit
