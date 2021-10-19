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

    ; convert back to string
    mov   ecx, 32
    mov   ebx, debug
    call  itoa

    ; print the string
    mov   eax, debug
    call  sprintln

    call  quit
