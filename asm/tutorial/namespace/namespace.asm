%include '../functions.asm'

SECTION .bss
xin: RESB 32

SECTION .data
msg1 db     'Jumping to finished label.', 0h
msg2 db     'Inside subroutine number: ', 0h
msg3 db     'Inside subroutine finished.', 0h

SECTION .text
global  _start

_start:

subroutine_one:
    mov    eax, msg1
    call   sprintln
    jmp    .finished

; This local variable is "owned" by the global label "subroutine_one".
.finished:
    mov    eax, msg2
    call   sprint
    mov    ecx, 32
    mov    ebx, xin
    mov    eax, 1
    call   itoa
    mov    eax, xin
    call   sprintln

subroutine_two:
    mov    eax, msg1
    call   sprintln
    jmp    .finished

; This local variable is "owned" by the global label "subroutine_two".
; In general, local labels inherit the context of the global variable
; directly before it.
.finished:
    mov    eax, msg2
    call   sprint
    mov    ecx, 32
    mov    ebx, xin
    mov    eax, 2
    call   itoa
    mov    eax, xin
    call   sprintln
    jmp    finished

finished:
    mov    eax, msg3
    call   sprintln
    call   quit


