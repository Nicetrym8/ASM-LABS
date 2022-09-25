
.POSIX:
.PHONY: *
.ONESHELL:
.NOTPARALLEL:
.EXPORT_ALL_VARIABLES:

f:= 6
SHELL := bash

build:
	nasm -felf64 $f.asm && clang++ $f.o main.cpp 

clean:
	rm main.o
