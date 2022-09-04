         global    _main

_main:   mov rax, 0x02000004         
         mov rdi, 1                 
         mov rsi, message            
         mov rdx, 16                 
         syscall                     
         mov rax, 0x02000001         
         xor rdi, rdi                
         syscall                     

message: db "Hello, World", 10     
	 db "Hey", 4
