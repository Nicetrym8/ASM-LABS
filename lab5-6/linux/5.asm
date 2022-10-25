extern puts
extern exit
extern scanf
extern printf

section .text
    global main

    check:
        pusha
        mov ecx, [number_symbols]
        xor eax, eax
        L2:
            mov ebp, [flag+eax]
            cmp ebp, 1
            jne pass_check
            add eax, 4
            loop L2

        add DWORD [counter], 1
        pass_check:
            mov ecx, [number_symbols]
            xor eax, eax
        
        passpassich:
            mov DWORD [flag+eax], 0
            add eax, 4
            loop passpassich

        popa
        xor esi, esi
        jmp rets

    main:
        push number_of_symbols
        call puts
        add esp, 4

        push number_symbols
		push integer
		call scanf
		add esp, 8

        cmp eax, 1
        jne error

        push symbols
        call puts
        add esp, 4

        mov ecx, [number_symbols]
        xor esi, esi

        read:
            push ecx
            lea edi, [symb+esi]
            inc esi
            push edi
            push char_input
            call scanf
            add esp, 8
            pop ecx
            loop read

        mov eax, 5
        mov ebx, filename
        mov ecx, 0
        mov edx, 0666
        int 0x80

        mov [fd], eax
        xor esi, esi
        mov DWORD [counter],0

        loopich:
            lea edi, [buff+esi]
            mov eax, 3
            mov ebx, [fd]
            mov ecx, edi
            mov edx, 1
            int 0x80


            mov ecx, [number_symbols]
            xor edi, edi
            push eax
            xor eax, eax
            F1:
                mov bl, [symb+edi]
                
                mov eax, edi
                push ecx
                mov ecx, 4
                mul ecx
                pop ecx

                cmp [buff+esi], bl
                jne pass
                mov DWORD [flag+eax], 1
                pass:
                    inc edi
                loop F1
            pop eax
            cmp byte [buff+esi], 0x0A
            je check
            cmp eax, 0
            je check
            retd:
                inc esi
            rets:
                cmp eax, 0
            jne loopich

        push n_of_symb
        call puts
        add esp, 4

        mov eax, [counter]
        push eax
        push integer
        call printf
        add esp, 8

        push newline
        call puts
        add esp, 4

        mov eax, 6
        mov ebx, [fd]
        int 0x80

        push 0
        call exit

    error:
		push err
		call puts
		add esp, 4
		push 0
		call exit

section .data
    number_of_symbols db "Enter number of symbols: ",0
    symbols db "Enter symbols: ",0
    n_of_symb db "Number of lines with this symbols: ",0
    filename db "file.txt",0
    mes db "lel",0
    integer db "%d",0
    char_input db " %c",0
    char db "%c",0
    err db "Error",0
    newline db 0x0D,0x0A,0

section .bss
    buff resb 300
    fd resb 1
    off resd 1
    number_symbols resd 1
    symb resb 10
    flag resd 10
    counter resd 1
