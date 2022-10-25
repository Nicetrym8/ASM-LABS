    global sinus
    section .text

sinus:
    mov rcx, rdx
    xor rdx, rdx
    loopich:
    lea rax, [rdi+rdx]
    fld dword [rax]
    fsin
    lea rax, [rsi+rdx]
    fstp dword [rax]
    add rdx, 4
    loop loopich
    ret
    
