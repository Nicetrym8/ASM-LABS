extern printf
section .text
global main

main:
    push msg
    push c
    call printf
    add esp, 8
    mov eax, 1
    mov ebx, 0
    int 0x80

section .data
    msg db "Hello from mars",0xA,0
    c db "%s",0