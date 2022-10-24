bits 32

section	.text
   global main         
	
main:                  
    
   mov eax, 5
   mov ebx, input
   mov ecx, 0             
   mov edx, 0777          
   int  0x80
	
   mov  [fd_in], eax
    
   mov eax, 3
   mov ebx, [fd_in]
   mov ecx, buf
   mov edx, 300
   int 0x80   
    
   ; close the file
   mov eax, 6
   mov ebx, [fd_in]
   int  0x80 



   lea esi, [name]
   mov [argv], esi
   mov esi,4
   xor edi,edi
   xor ecx,ecx

   L1:
   cmp byte[buf+ecx],10
   je  swap
   next:
   inc ecx
   cmp ecx, 300
   jl L1
   mov eax, 11   
   mov ebx, name 
   mov ecx, argv 
   mov edx, envp 
   int 0x80


   mov	eax,1             
   int	0x80  

   swap:
   mov byte[buf+ecx], 0
   lea edx, [buf+edi]
   mov [argv+esi],  edx
   mov edi,ecx
   inc edi
   add esi, 4
   jmp next
section	.data
buf times 300 db 0
envp dd 0
input db 'input.txt',0
name db './main.o',0
section .bss
argv resd 12
fd_in  resb 1

