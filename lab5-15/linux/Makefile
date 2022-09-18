.POSIX:
.PHONY: *
.ONESHELL:
.NOTPARALLEL:
.EXPORT_ALL_VARIABLES:

f := 5
SHELL := bash

build:
	nasm -f elf '$f.asm' && gcc -m32 -o '$f.out' '$f.o'