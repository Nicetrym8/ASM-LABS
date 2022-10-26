bits 32

section	.text
   global main         
	
main:                  

   mov eax, 11   
   mov ebx, name
   mov ecx, argv
   mov edx, envp 
   int 0x80


   mov	eax,1             
   int	0x80  

section	.data
envp dd 0
name db '/usr/bin/script',0
arg1 db 'output.txt',0
argv dd name, arg1
