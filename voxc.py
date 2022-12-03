import argparse
import misc

if __name__ == '__main__':
    argparser = argparse.ArgumentParser(prog='Vox Compiler',
                                        description='Compiler for Vox, project language for METU CENG444',
                                        epilog='')
    argparser.add_argument('filename',
                           help='Source file to be compiled')
    argparser.add_argument('-Pdebug',
                           default='parser.debug',
                           help='Parser debug output')

    args = argparser.parse_args()
    code = ""
    with open(args.filename) as f:
        l = f.readlines()
        for line in l:
            code += line

    # TODO: Preprocessing, macros etc.

    ast = misc.generate_ast(misc.process(code))
