%include      'functions.asm'

SECTION .data
msg1 db 'Hello, brave new world!', 0h        ; Note the lack of a line feed
msg2 db 'This is how we recycle in NASM', 0h ; Note the lack of a line feed

SECTION .text
global  _start

_start:

    mov  eax, msg1
    call sprintln

    mov  eax, msg2
    call sprintln

    call quit
