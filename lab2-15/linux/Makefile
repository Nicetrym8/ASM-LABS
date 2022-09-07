.POSIX:
.PHONY: *
.ONESHELL:
.NOTPARALLEL:
.EXPORT_ALL_VARIABLES:

f := 2
SHELL := bash

build:
	nasm  -f elf '$f.asm' && ld -m elf_i386 -s -o '$f.out' '$f.o'