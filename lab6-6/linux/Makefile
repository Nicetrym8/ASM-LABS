.POSIX:
.PHONY: *
.ONESHELL:
.NOTPARALLEL:
.EXPORT_ALL_VARIABLES:

f := 6
SHELL := bash

build:
	nasm -f elf64 '$f.asm' && g++ -no-pie -o main main.cpp '$f.o' && rm '$f.o'
