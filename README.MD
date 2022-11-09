# Assembly labs/written with NASM
## Lasciate ogne speranza, voi ch’entrate
powered by GodBolt!

## Install gcc-multilib for 32 bit compability
```apt install -y gcc-multilib```

## Compile with nasm asm file
```nasm -f elf "$f.asm" && gcc -m32 -o $f "$f.o"```

---

# GDB cheatsheet

```
set disassembly-flavor intel - set intel flavor
disassemble ${function_name} - disassembl function
```
