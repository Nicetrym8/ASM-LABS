; End my suffering pls
section .text
        org 100h
        jmp main


error:
        mov ah, 9
        mov dx, newline
        int 21h
        mov dx, errormsg
        int 21h
        mov ax, 0x4c00
        int 0x21


read_str:
        mov ah, 1
        int 21h
        cmp al, 0x0D
        je return
        stosb
        inc cx
        cmp cx, 100
        jge error
        jmp read_str

max_word:
        mov ah, 1
        xor cx, cx
        mov dh, al
        mov di, si
        sub di, 1
        push di
        jmp word_loop_max
word_loop_max_cont:
        inc cx
        lodsb
word_loop_max cmp al,0x20
        jne word_loop_max_cont
        push cx
        jmp word_loop1


sort:
        lodsb
        jmp white_spc_loop1
white_spc_loop1_cont lodsb
white_spc_loop1:
        cmp al, 255
        je sort_loop
        cmp al,0x20 
        je white_spc_loop1_cont
        cmp al,dh
        jl max_word
        jmp word_loop1
word_loop1_cont lodsb
word_loop1 cmp al,0x20
        jne word_loop1_cont
        cmp al, 255
        jne sort


sort_loop:
        cmp ah,0
        je back
        xor ah, ah
        cld
        pop cx
        pop si
        push si 
        push cx
        lea di, [buff+bx]
        repnz movsb
        pop cx
        pop si
        cld
        push cx
        mov di, si
        mov al, " "
        repnz stosb
        pop cx
        add bx, cx
        inc bx
        mov si, buff+100
        mov dh, 127
        cld
        jmp sort


main:   
        mov ah,9
        mov dx,startmsg
        int 21h
        call clean
        mov di, buff+100
        xor cx, cx
        xor bx, bx
        cld
        call read_str
        mov di, buff+199
        mov al, 255
        stosb
        mov di, buff+200
        mov al, "$"
        stosb
        mov ah,9
        mov dx,buff+100
        int 21h
        mov si, buff+100
        mov dh, 127
        cld
        xor ah, ah
        jmp sort
back:
        mov di, buff+100
        mov al, "$"
        stosb
        mov ah,9
        mov dx,newline
        int 21h
        mov ah,9
        mov dx,buff
        int 21h
        mov ax, 0x4c00
        int 0x21

clean:
        mov di,buff
        mov cx, 200
        mov al, " "
L1:
        stosb
        loop L1
        ret

return:
        ret
        


section .data
        errormsg db "Error","$"
        startmsg db "Enter string: ","$"
        newline db 0Ah,0Dh, "$"

section .bss
        buff resb 200

