.POSIX:
.PHONY: *
.ONESHELL:
.NOTPARALLEL:
.EXPORT_ALL_VARIABLES:

f := 7
SHELL := bash

build:
	nasm -f elf '$f.asm' && gcc -m32 -o '$f.out' '$f.o'
build_cpp:
	g++ -std=c++20 -o main.o main.cpp