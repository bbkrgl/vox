## Vox Programming Language
A toy programming language inspired by [Lox](https://craftinginterpreters.com/the-lox-language.html), as the project of introductory compiler course [CENG444](https://github.com/bozsahin/ceng444).

Programs can be compiled to RISC-V binary with
```
python voxc.py <src-filename> -o <binary-filename> -c <asm-out-filename>
```
Binary and ASM filename are optional.

Notes:
- Vectors' addresses are passed as arguments.
- For the vector arithmetic to work, the destination must be allocated before the operation, therefore it can only be used in an assign statement.
- Currently the vector arithmetic operations only allow two operands.
- Number of arguments are restricted to 7.
