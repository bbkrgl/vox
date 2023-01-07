import argparse
import misc
import sys
import codegen
import subprocess

if __name__ == '__main__':
    argparser = argparse.ArgumentParser(prog='Vox Compiler',
                                        description='Compiler for Vox, project language for METU CENG444',
                                        epilog='')
    argparser.add_argument('filename',
                           help='Source file to be compiled')
    argparser.add_argument('-o',
                           default='a.out',
                           help='Output binary')
    argparser.add_argument('-c',
                           default='',
                           help='Output binary')

    args = argparser.parse_args()
    code = ""
    with open(args.filename) as f:
        l = f.readlines()
        for line in l:
            code += line

    intermediate = misc.process(code)
    if misc.undeclared_vars(intermediate) != [] or misc.multiple_var_declarations(intermediate) != []:
        print("Error msg")
        sys.exit()

    ast = misc.generate_ast(intermediate)
    generator = codegen.CodeGenerator(ast)
    out = generator.code
    if args.c:
        with open(args.c, "w") as f:
            f.write(out)

    cmd = f"riscv64-linux-gnu-gcc -march=rv64gcv -static -o {args.o} -xassembler -"
    p = subprocess.Popen(cmd.split(), stdin=subprocess.PIPE)
    p.communicate(input=out.encode())
