;----------------------------------------------
; int digits(int i)
; Calculate the number of digits in an integer
digits:
    ; save the registers to stack
    push   edx
    push   ecx
    push   ebx

    ; set up registers
    mov    ecx, 10
    mov    ebx, 0

digits_loop:
    ; loop through until total is divided to zero
    cmp    eax, 0
    jz     digits_success
    mov    edx, 0
    div    ecx
    inc    ebx
    jmp    digits_loop

digits_success:
    ; restore the registers to stack, add return to EAX, and return
    mov    eax, ebx
    pop    ebx
    pop    ecx
    pop    edx
    ret

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

; FIXME: This function should do error handling if the input isn't an integer.
;----------------------------------------------
; int atoi(String str)
; Converts an ascii string to an integer
atoi:
    ; save previous registers
    push   edx
    push   ecx
    push   ebx

    ; set up registers
    mov    ebx, eax ; use ebx to reference the string
    mov    eax, 0   ; use eax to refer to the total

atoi_loop:
    cmp    byte [ebx], 0h  ; check to see if EBX points to the null terminator
    jz     atoi_success    ; succeed if the string was terminated
    cmp    byte [ebx], 0Ah ; check to see if EBX points to the new line
    jz     atoi_success    ; succeed if the string was terminated
    mov    ecx, 10         ; set ECX to 10
    mul    ecx             ; multiply EAX by 10 (the value stored in ECX)
    mov    dl, [ebx]       ; move the byte pointed to by EBX to DL (the 0 byte of EDX or RDX)
    sub    edx, 48         ; convert ascii digit to int
    add    eax, edx        ; add the digits integer value to the total
    inc    ebx             ; increment the EBX pointer
    jmp    atoi_loop

atoi_success:
    ; restore previous registers and return
    pop    ebx
    pop    ecx
    pop    edx
    ret

; FIXME: Respect len
;----------------------------------------------
; void itoa(int i, void* buf, int len)
; Converts an integer to an ascii string
itoa:
    ; save registers on stack
    push   edx
    push   ecx
    push   ebx
    push   eax

    ; base case (i is zero)
    cmp    eax, 0
    jz     itoa_base_case

    ; set up initial registers
    mov    ecx, 10

    ; get the number of digits in the stack and add this to the pointer
    push   eax            ; save the EAX register
    call   digits         ; compute the number of digits in the integer
    sub    eax, 1         ; subtract 1 from the number of digits
    add    ebx, eax       ; add the updated EAX value to the EBX pointer
    pop    eax            ; restore the EAX register

itoa_loop:
    ; add each digit to the string one at a time
    cmp    eax, 0         ; check if EAX is zero
    jz     itoa_success   ; succeed if EAX is zero
    mov    edx, 0         ; set up EDX for division
    div    ecx            ; divide EAX by 10. put the result in EAX and the remainder in EDX
    add    edx, 48        ; add 48 to the remainder to convert it to an ascii integer
    mov    byte [ebx], dl ; store the ascii character in the buffer
    dec    ebx            ; decrement the EBX pointer
    jmp    itoa_loop

itoa_success:
    ; restore registers from stack and return
    pop    eax
    pop    ebx
    pop    ecx
    pop    edx
    ret

itoa_base_case:
    ; write a zero to the string
    mov    byte [ebx], 48 ; write a zero into the string
    jmp    itoa_success

; TODO: This function is unsafe in that it will only remove a single trailing newline
;----------------------------------------------
; void str_remove_line_feed(String str)
; Strips the line feed from the string
str_remove_trailing_line_fee:
    push  eax

str_remove_line_feed_loop:
    ; find the trailing line feed character
    cmp   byte [eax], 0Ah
    jz    str_remove_line_feed_success
    inc   eax
    jmp   str_remove_line_feed_loop

str_remove_line_feed_success:
    ; delete the newline
    mov   byte [eax], 0h

    pop   eax
    ret

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
; void sin(void* buff, int count)
; User input reading function
sin:
    ; save the used registers to the stack
    push  edx
    push  ecx
    push  ebx
    push  eax

    ; read the user input
    mov   edx, ebx ; use the specified max buffer size
    mov   ecx, eax ; use the specified buffer
    mov   ebx, 0   ; read from stdin
    mov   eax, 3   ; read syscall code
    int   80h      ; schedule the interrupt

    ; restore the previous registers and return
    pop   eax
    pop   ebx
    pop   ecx
    pop   edx
    ret

;----------------------------------------------
; void quit()
; Quits the program successfully
quit:
    mov    ebx, 0        ; Exit code of 1
    mov    eax, 1        ; Exit syscall
    int    80h           ; Schedule interupt for exit
    ret

;----------------------------------------------
; void exit(int code)
; Exits the program with an exit code
exit:
    mov    ebx, eax
    mov    eax, 1
    int    80h
    ret
