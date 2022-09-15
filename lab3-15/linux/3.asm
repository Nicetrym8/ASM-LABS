bits 32
extern printf
extern puts
extern exit
extern scanf
extern fflush
extern stdin



section .text
global main

main:
    push  msg1
    call  puts 
    add esp,4
    push len
    push format1
    call scanf
    add esp,8
    
    mov ecx, [len]
    cmp ecx,0
    jle WRONG_INPUT
    cmp ecx, 30
    jg WRONG_INPUT
    push ecx
    push  msg2
    call  puts 
    add esp,4
    pop ecx

    lea eax,[arr]
L1:
    push eax
    push ecx
    push eax
    push format1
    call scanf
    add esp,8
    pop ecx
    pop eax
    add eax,8
    loop L1
    
    push msg3
    call puts
    add esp,4
    
    push operation
    push operation+4
    push format4
    call scanf
    add esp,8
    
    push msg4
    call puts
    add esp,4
    
    mov ecx,[len]
    lea eax,[arr]
    
    cmp dword[operation],'|'
    je abs_loop
    cmp dword[operation],'~'
    je inverse_loop
    cmp dword[operation],'^'
    je square_loop
    cmp dword[operation],'/'
    je one_over_loop
    jmp WRONG_INPUT


square_loop:
    push ecx
    push eax
    push eax
    call square
    push dword[eax]
    push format0
    call printf
    add esp,8
    pop eax
    pop ecx
    add eax,8
    loop square_loop
    jmp EXIT

abs_loop:
    push ecx
    push eax
    push eax
    call inv_value
    add dword[eax],1
    push dword[eax]
    push format0
    call printf
    add esp,8
    pop eax
    pop ecx
    add eax,8
    loop abs_loop
    jmp EXIT

inverse_loop:
    push ecx
    push eax
    push eax
    call inv_value
    push dword[eax]
    push format0
    call printf
    add esp,8
    pop eax
    pop ecx
    add eax,8
    loop inverse_loop
    jmp EXIT

one_over_loop:
    push ecx
    push eax
    sub esp,8
    push eax
    call one_over
    fstp qword[esp]
    push format2
    call printf
    add esp,12
    pop eax
    pop ecx
    add eax,8
    loop one_over_loop
    jmp EXIT

EXIT:
    push 0
    call exit

WRONG_INPUT:
   push wrong
   call puts
   add esp,4
   jmp EXIT

inv_value:
   pop edx
   pop eax
   xor dword[eax], 0xffffffff
   push edx
   ret
square:
   pop edx
   pop eax
   mov edi,dword[eax]
   mov esi, edi
   imul esi,edi
   mov [eax], esi
   push edx
   ret
one_over:
   pop edx
   pop eax
   mov ebx,1
   fld qword[one]
   fidiv dword[eax]
   push edx
   ret

 



section .data
  format0 db "%i ",0
  format1 db "%i",0
  format2 db "%f ",0
  format4 db "%c%c",0
  wrong db "Wrong input!",0
  msg1 db "Enter array length: ",0
  msg2 db "Enter array: ",0
  msg3 db "Choose operation( |,~, ^,/): ",0
  msg4 db "Result:",0
  one dq 1.0

section .bss
   operation resd 2
   len resd 1
   arr resq 30
   