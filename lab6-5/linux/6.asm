        global  pow
        section .text
pow:
        mov rcx,rdi
        sub rcx,1
        vmovups zmm0,zword[rsi]
        vmovups zmm1,zmm0
        L1:
        vmulps zmm0,zmm1
        loop L1
        vmovups zword[rsi],zmm0
        ret  