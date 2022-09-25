        global  pow
        section .text
pow:
        mov rcx,rdi
        dec rcx
        vmovups zmm0,zword[rsi]
        L1:
        vmulps zmm0,zmm0
        loop L1
        vmovups zword[rsi],zmm0
        ret  