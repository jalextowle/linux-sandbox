%include '../functions.asm'

SECTION .bss
xin:  RESB 32
yin:  RESB 32
qout: RESB 32
rout: RESB 32

SECTION .data
prompt_x db 'Provide a value for x: ', 0h
prompt_y db 'Provide a value for y: ', 0h

answer   db 'The quotient of x and y is: ', 0h

SECTION .text
global  _start

_start:
    ; print the prompt for x
    mov   eax, prompt_x
    call  sprint

    ; read the string input for x
    mov   ebx, 32
    mov   eax, xin
    call  sin

    ; print the prompt for y
    mov   eax, prompt_y
    call  sprint

    ; read the string input for y
    mov   ebx, 32
    mov   eax, yin
    call  sin

    ; convert xin to an integer and put it in ESI
    mov   eax, xin
    call  str_remove_trailing_line_fee
    call  atoi
    mov   esi, eax

    ; convert yin to an integer and put it in ECX
    mov   eax, yin
    call  str_remove_trailing_line_fee
    call  atoi
    mov   ebx, eax

    ; print the difference of x and y
    mov   edx, 0
    mov   eax, esi
    div   ebx
    mov   ecx, 32
    mov   ebx, qout
    call  itoa
    mov   eax, answer
    call  sprint
    mov   eax, qout
    call  sprintln

    ; exit
    call  quit
