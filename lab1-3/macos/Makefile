.POSIX:
.PHONY: *
.ONESHELL:
.NOTPARALLEL:
.EXPORT_ALL_VARIABLES:


SHELL := bash

build:
		nasm -fmacho64 "$f.asm" && ld -L/Library/Developer/CommandLineTools/SDKs/MacOSX.sdk/usr/lib -macosx_version_min 12.15 -lSystem -no_pie "$f.o" -o $f && rm "$f.o" 	
