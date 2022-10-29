extern sleep
section .txt
global main

main:

    mov eax, 5
    mov ebx, filename
    mov ecx, 0
    mov edx, 0666
    int 0x80

    mov [fd], eax

    mov eax, 3
    mov ebx, [fd]
    mov ecx, buff
    mov edx, 200
    int 0x80   

    mov eax, 6
    mov ebx, [fd]
    int 0x80

    xor esi, esi
    xor edx, edx
    push edx
    loopich:
    mov al, [buff+esi]
    inc esi
    cmp byte al, 0x0A
    je L1
    cmp esi, 100
    jg end
    jmp loopich
    L1:
    pop edx
    lea eax, [buff+edx]
    mov edx, esi
    push edx
    mov dword [run], eax
    mov byte [buff+esi-1], 0

    mov eax, 2
	int 0x80

    cmp eax, 0
    jne pass
    mov eax, 0x0B
    mov ebx, [run]
    xor ecx, ecx
    xor edx, edx
    int 0x80
    pass:
    jmp loopich
    end:

    push sec
    call sleep
    add esp, 4

    mov eax, 1
    mov ebx, 0
    int 0x80

section .data
    path db "./binary/run.exe",0
    nice db "Nice",0x0A,0
    sec db 1
    filename db "input.txt",0

section .bss
    fd resb 1
    buff resb 200
    run resd 16