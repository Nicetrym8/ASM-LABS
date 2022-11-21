extern puts
extern scanf
extern gets
section .text
global main

main:
    push buff
    call gets
    add esp, 4

    mov eax, 2
    int 0x80

    cmp eax, 0
    jne pass
    
    mov eax, 11
    mov ebx, date
    mov ecx, argv
    xor edx, edx
    int 0x80

    pass:
    jmp main

    mov eax, 1
    int 0x80


section .data
    date db "/bin/date",0
    argv dd date, buff,0

section .bss
    buff resb 50