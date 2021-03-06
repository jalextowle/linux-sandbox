;----------------------------------------------
; int slen(String message)
; String length calculation function
slen:
    push   ebx           ; push EBX onto the stack (this is the only variable we use)
    mov    ebx, eax      ; now EAX and EBX point to the provided input (EAX)

nextchar:
    cmp    byte [eax], 0 ; compare the byte that EAX points to zero. this will set the zero flag (ZF) if appropriate
    jz     finished      ; if the null terminator was found, jump to finished
    inc    eax           ; increment EAX
    jmp    nextchar      ; loop back to next char

finished:
    sub    eax, ebx      ; compute EAX - EBX and put the result in EAX
    pop    ebx           ; pop the previous EBX register off the stack
    ret                  ; return

;----------------------------------------------
; void sprint(String message)
; String printing function
sprint:
    push   edx           ; Push the previous value of EDX onto the stack
    push   ecx           ; Push the previous value of ECX onto the stack
    push   ebx           ; Push the previous value of EBX onto the stack
    push   eax           ; Push the previous value of EAX onto the stack (we use this to return the value from slen)
    call   slen          ; Call slen. The value of EAX is the provided function parameter.

    mov    edx, eax      ; Move EAX into EDX since EDX is the string length in the write syscall
    pop    eax           ; Pop the string parameter off the stack

    mov    ecx, eax      ; Move the string parameter into ECX for the write syscall
    mov    ebx, 1        ; Set the file descriptor to STDOUT (this gets us the behavior of println
    mov    eax, 4        ; Set the syscall to write
    int    80h           ; Schedule an interupt for the syscall

    mov    eax, ecx      ; Move the string pointer back into EAX
    pop    ebx           ; Pop the previous value of EBX off the stack
    pop    ecx           ; Pop the previous value of ECX off the stack
    pop    edx           ; Pop the previous value of EAX off the stack
    ret

;----------------------------------------------
; void sprintln(String message)
; String printing function that prints a new line at the end
sprintln:
    push   eax           ; Push the argument onto the stack proactively.
    call   sprint        ; Print the string.
    mov    eax, 0Ah      ; Move the line feed character into EAX
    push   eax           ; Push EAX onto the stack.
    mov    eax, esp      ; Push ESP (the extended stack pointer) into EAX to print out the line feed character.
    call   sprint        ; Print the line feed
    pop    eax           ; Pop the new line feed off the stack
    pop    eax           ; Pop the original EAX value off the stack
    ret

;----------------------------------------------
; void sprint(String message)
; String printing function
quit:
    mov    ebx, 0        ; Exit code of 1
    mov    eax, 1        ; Exit syscall
    int    80h           ; Schedule interupt for exit
    ret
