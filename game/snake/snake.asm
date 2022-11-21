extern puts
extern putchar
extern printf
extern read
extern readInp
extern sleep
extern system
extern open
extern gen_num
section .text
global main

gameover:
    push endgame
    call puts
    add esp, 4

    mov eax, 1
    xor ebx, ebx
    int 0x80

gen_new_num:
    
    call gen_num
    mov DWORD [random_num], eax
    xor ecx, ecx
    G1:
    cmp DWORD eax, [snake+ecx]
    je gen_new_num
    add ecx, 4
    cmp DWORD [snake+ecx],0
    jne G1
    cmp BYTE [top+eax], '#'
    je gen_new_num

    ret


printc:
    pusha
    mov eax, 4
    mov ebx, 1
    mov ecx, toprint
    mov edx, 1
    int 0x80
    popa
    ret

print_field:
    push new
    call puts
    add esp, 4
    xor ecx, ecx
    L1:
    call check_snake
    inc ecx
    cmp DWORD ecx, [len_to_print]
    jl L1
    ret

init:
    push ebp
    mov ebp, esp
    push start_msg
    call puts
    add esp, 4
    mov DWORD [snake_len], 4
    add DWORD [width], 1
    lea eax,[snake]
    mov DWORD [eax],80
    lea eax,[snake+4]
    mov DWORD [eax],79
    lea eax,[snake+8]
    mov DWORD [eax],78
    lea eax,[snake+12]
    mov DWORD [eax],77
    lea eax,[snake+16]
    mov DWORD [eax],76
    mov edx, [eax]
    mov DWORD [tail_loc], edx
    mov BYTE [prevchar],"D"
    mov DWORD eax, [width]
    mov ecx, 22
    mul ecx
    mov DWORD [len_to_print], eax
    call gen_new_num
    leave
    ret

check_snake:
    push ecx
    mov edx, ecx
    xor ecx, ecx
    C1:
    cmp [snake+ecx],edx
    je C2
    add ecx, 4
    cmp DWORD [snake+ecx],0
    jne C1
    pop ecx
    cmp DWORD ecx, [random_num]
    je C5
    lea eax, [top+ecx]
    mov bl, [eax]
    mov byte [toprint], bl
    call printc
    jmp C4
    C5:
    mov byte [toprint], "+"
    call printc
    jmp C4
    C2:
    test ecx, ecx
    jne C3
    mov al, "@"
    mov byte [toprint], al
    call printc
    pop ecx
    jmp C4
    C3:
    mov al, "%"
    mov byte [toprint], al
    call printc
    pop ecx
    C4:
    ret

check_tail:
    ; cmp DWORD [snake+4], ebx - to prevent back snake
    mov ecx, 4
    CT:
    mov eax, [snake+ecx]
    cmp  eax, ebx
    je gameover
    add ecx, 4
    cmp DWORD [snake+ecx],0
    jne CT
    ret

add_points:
    mov eax, [random_num]
    cmp DWORD [snake], eax
    jne A1
    inc DWORD [snake_len]
    mov DWORD eax, [snake_len]
    mov edx, 4
    mul edx
    mov DWORD edx, [tail_loc]
    mov DWORD [snake+eax], edx
    call gen_new_num
    A1:
    ret


move:
    mov ebx, [snake]
    cmp byte [prevchar],'A'
    je moveA
    cmp byte [prevchar],'W'
    je moveW
    cmp byte [prevchar],'S'
    je moveS
    cmp byte [prevchar],'D'
    je moveD

    moveA:
    dec ebx
    jmp M1
    moveW:
    sub ebx, [width]
    jmp M1
    moveS:
    add ebx, [width]
    jmp M1
    moveD:
    inc ebx
    jmp M1

    M1:

    cmp byte [top+ebx], '#'
    je gameover
    call check_tail
    call add_points


    xor edx, edx
    mov eax, [snake]
    mov [snake], ebx
    add edx, 4
    M2:
    mov DWORD ebx, [snake+edx]
    mov DWORD [snake+edx], eax
    add edx, 4
    mov eax, ebx
    cmp DWORD [snake+edx], 0
    jne M2
    mov eax, [snake+edx-4]
    mov DWORD [tail_loc], eax 

    ret

read_input:
    call readInp
    cmp eax, 0
    je R1
    
    cmp eax, 0x41
    je A_move
    cmp eax, 0x61
    je A_move

    cmp eax, 0x57
    je W_move
    cmp eax, 0x77
    je W_move

    cmp eax, 0x53
    je S_move
    cmp eax, 0x73
    je S_move

    cmp eax, 0x44
    je D_move
    cmp eax, 0x64
    je D_move

    A_move:
    mov byte [prevchar], 'A'
    jmp R1
    W_move:
    mov byte [prevchar], 'W'
    jmp R1
    S_move:
    mov byte [prevchar], 'S'
    jmp R1
    D_move:
    mov byte [prevchar], 'D'
    jmp R1
    R1:
    ret

main:
    call init
    call print_field
    noice:
    call read_input
    call move
    call print_field
    ; push clear
    ; call system
    ; add esp, 4
    jmp noice

    mov eax, 1
    xor ebx, ebx
    int 0x80



section .data
    start_msg db "Snake game",0
    endgame db "Gameover :(",0
    start_wall db "#",0
    top db "############################################################",0xA,
    walls times 20 db "#                                                          #",0xA,
    bot db "############################################################",0xA,0
    prevchar db 1
    clear db "clear",0
    new db "",0
    integer db "%d",0
    random_file db "/dev/urandom"
    width dd 60
    height dd 20


section .bss
    snake resd 200
    toprint resb 1
    len_to_print resd 1
    key resb 1
    random_num resd 1
    snake_len resd 1
    tail_loc resd 1