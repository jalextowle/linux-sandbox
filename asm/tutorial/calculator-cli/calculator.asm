%include '../functions.asm'

SECTION .bss
sum:  RESB 32

SECTION .data
answer   db 'The sum of the input is: ', 0h

SECTION .text
global  _start

_start:
    ; get the number of command line arguments
    pop   ecx
    cmp   ecx, 1
    jle   fail

    ; pop the binary path off the stack
    pop   edx
    dec   ecx

    mov   esi, 0

loop:
    ; for each command line argument, add to the total
    cmp   ecx, 0
    je    success
    pop   eax
    call  atoi
    add   esi, eax
    dec   ecx
    jmp   loop

success:
    ; convert the total to a string
    mov   ecx, 32
    mov   ebx, sum
    mov   eax, esi
    call  itoa

    ; print the prelude
    mov   eax, answer
    call  sprint

    ; print the sum
    mov   eax, sum
    call  sprintln

    call quit

fail:
    mov  eax, 1
    call exit
