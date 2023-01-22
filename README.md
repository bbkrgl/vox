## Vox Programming Language, for CENG444
Programs can be compiled to RISC-V binary with
```
python voxc.py <src-filename> -o <binary-filename> -c <asm-out-filename>
```
Binary and ASM filename are optional.

Notes:
- Currently the vector arithmetic operations only allow two operands.
- Number of arguments are restricted to 7.