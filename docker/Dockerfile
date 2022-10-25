FROM --platform=linux/amd64 debian
RUN apt update && \
    apt install -y \
    make \
    binutils \
    nasm \
    gcc \
    gcc-multilib \
    g++ 
#RUN apt install -y \ ptrace don't work in qemu :(
#    gdb
WORKDIR /root/
