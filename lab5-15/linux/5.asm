

section	.text
   global main         
	
main:                  
    
   ;open the file for reading
   mov eax, 5
   mov ebx, input
   mov ecx, 0             ;for read only access
   mov edx, 0777          ;read, write and execute by all
   int  0x80
	
   mov  [fd_in], eax
    
   ;read from file
   mov eax, 3
   mov ebx, [fd_in]
   mov ecx, buf
   mov edx, 300
   int 0x80   
    
   ; close the file
   mov eax, 6
   mov ebx, [fd_in]
   int  0x80   

   mov ecx,300
   xor esi,esi
   L:
   mov edi, [buf+ecx]
   mov [buf_invert+esi],edi
   inc esi,
   loop L

   mov	edx,300
   mov	ecx,buf_invert 
   mov	ebx,1       
   mov	eax,4       
   int	0x80 

   mov  eax, 8
   mov  ebx, output
   mov  ecx, 0777        ;read, write and execute by all
   int  0x80             ;call kernel
	
   mov [fd_out], eax
    
   ; write into the file
   mov	edx,300          ;number of bytes
   mov	ecx, buf_invert  ;message to write
   mov	ebx, [fd_out]    ;file descriptor 
   mov	eax,4            ;system call number (sys_write)
   int	0x80             ;call kernel
	
   ; close the file
   mov eax, 6
   mov ebx, [fd_out]
       
   mov	eax,1             
   int	0x80             

section	.data
input db 'input.txt',0
output db 'output.txt',0
buf:   times 300 db ' '

section .bss
fd_out resb 1
fd_in  resb 1
buf_invert resb 300