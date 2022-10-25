extern printf
extern puts
extern exit
extern scanf

section .text
    global main



    main:
		push fmsg
		call puts
		add esp, 4

		push len
		push integer
		call scanf
		add esp, 8

		cmp eax,1
		jne error
		mov eax, [len]
		cmp eax, 0
		jle error
		cmp eax, 30
		jg error

		push smsg
		call puts
		add esp, 4

		xor ebx, ebx
		mov ecx, [len]
		lea edi, [arr]

		L1:
			push ecx
			push edi
			push long_integer
			call scanf
			cmp eax, 1
			jne error
			add esp, 8
			add edi, 8
			pop ecx
			loop L1

		lea edi, [arr]
		mov ecx, [len]
		xor eax, eax

		average_value:
			add eax, [edi]
			add edi, 8
			loop average_value

		push eax
		push amsg
		call puts
		add esp, 4
		pop eax

		xor edx, edx
		mov ebx, [len]
		div ebx
		push eax

		push long_integer
		call printf
		add esp, 8

		push newline
		call puts
		add esp, 4

		push 0
		call exit



	error:
		push err
		call puts
		add esp, 4
		push 0
		call exit


section .data
	fmsg db "Enter array size: ", 0
    smsg db "Enter array elements: ",0
	amsg db "Average array size: ",0
	integer db "%d",0
	long_integer db "%ld",0
	newline db 0x0D,0x0A,0
	err db "Error",0

section .bss
	len resd 1
	arr resq 30
