%include 'functions.asm'

SECTION .text
global _start

_start:
    pop  ecx      ; The first element on the stack is the number of arguments.

loop:
    cmp  ecx, 0h  ; Compare ECX to zero.
    jz   fin      ; Jump to finished if the previous statement set the zero flag.
    pop  eax      ; Pop the next item into EAX (the argument of `sprintln`).
    call sprintln ; Print the argument.
    dec  ecx      ; Decrement the loop counter.
    jmp  loop     ; Restart the loop.

fin:
    call quit     ; Call the quit function.
