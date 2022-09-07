;I hate it :)

section .text
    global _start
    jmp _start


strlen:
    push  ebx
    push  edi
    push  ecx   
    mov   ebx, edi            
    xor   al, al              
    mov   ecx, 201
    repne scasb               
    sub   edi, ebx       
    mov   eax, edi   
    dec   eax    
    pop   ecx
    pop   edi
    pop   ebx       
    ret 

paste_by_index:
    pop edx
    mov edi, buf
    call strlen
    pop ebx
    sub eax, ebx
    mov ecx, eax
    lea esi, [buf+ebx]
    lea edi, [buf+200]
    cld
    repnz movsb
    mov ecx,msg_len
    mov esi,msg
    lea edi,[buf+ebx]
    cld
    repnz movsb
    mov ecx,eax
    lea esi, [buf+200]
    lea edi, [buf+msg_len+ebx]
    cld
    repnz movsb
    push edx
    ret





    

check_string_is_number:
    mov edi, buf
    call strlen
    mov ebx, eax
    xor esi,esi
    xor eax,eax
    xor edx,edx
    mov byte[buf+ebx-1],' '
    
L1:
    mov ecx, dig_len
    mov edi, dig
    mov al,  [buf+esi]
    inc esi
    cld
    repne scasb 
    je L2
    cmp esi,ebx
    jl L1
    ret
L2:  
    inc edx
    mov edi,dig
    mov ecx,dig_len
    mov al, [buf+esi]
    cld
    repe scasb 
    je L2
    mov edi, esi
    sub edi, edx
    cmp al,' '
    jne L4
    ;mov dl,[buf+edi-1]
    ;cmp dl,' '
    ;jne L3
    pusha
    push edi
    call paste_by_index
    popa
    add ebx,msg_len
    add esi,msg_len
L3:
    xor edx,edx
    jmp L1
L4: 
    inc esi
    jmp L2
    
_start:

    mov	edx,welcom_len    
    mov	ecx,welcome_msg     
    mov	ebx,1       
    mov	eax,4       
    int	0x80
    
    mov edx,200 
    mov ecx,buf
    mov	ebx,0       
    mov	eax,3       
    int	0x80 

    call check_string_is_number
    
    mov	edx,200
    mov	ecx,buf     
    mov	ebx,1       
    mov	eax,4       
    int	0x80
    

    mov	eax,1       
    int	0x80


section .data
    welcome_msg db "Enter your string: "
    welcom_len equ $ - welcome_msg
    msg db "number "
    msg_len equ $ - msg
    dig db "0123456789"
    dig_len equ $ - dig

section .bss
    buf resb 300
