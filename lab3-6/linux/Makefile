.POSIX:
.PHONY: *
.ONESHELL:
.NOTPARALLEL:
.EXPORT_ALL_VARIABLES:

f := 3
SHELL := bash

build:
	nasm -f elf '$f.asm' && gcc -m32 -no-pie -o '$f.exe' '$f.o' && rm '$f.o'
