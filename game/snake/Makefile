.POSIX:
.PHONY: *
.ONESHELL:
.NOTPARALLEL:
.EXPORT_ALL_VARIABLES:

f := snake
SHELL := bash

build:
	nasm -f elf '$f.asm' && gcc -m32 -no-pie -o '$f.exe' read.c '$f.o' && rm '$f.o'
