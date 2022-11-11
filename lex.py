from sly import Lexer


class VoxLexer(Lexer):
    tokens = {
        VAR, ID, FUN,
        IF, ELSE, WHILE, FOR,
        OR, AND, TRUE, FALSE,
        PLUS, MINUS, MULT, DIV,
        EQ, NEQ, NOT, GT, GE, LT, LE, BCALL,
        ASSIGN, PRINT, RETURN,
        NUMBER, STRING,
    }

    literals = {';', ',', '(', ')', '[', ']', '{', '}'}

    ignore = ' \t'
    ignore_comment = '//'
    ignore_newline = '\n+'

    VAR = r'var'
    FUN = r'fun'

    IF = r'if'
    ELSE = r'else'
    WHILE = r'while'
    FOR = r'for'

    OR = r'or'
    AND = r'and'
    TRUE = r'true'
    FALSE = r'false'

    PLUS = r'\+'
    MINUS = r'-'
    MULT = r'\*'
    DIV = r'/'

    EQ = r'=='
    NEQ = r'!='
    NOT = r'!'

    GT = r'>'
    GE = r'>='
    LT = r'<'
    LE = r'<='
    BCALL = r'\#'

    ASSIGN = r'='
    PRINT = r'print'
    RETURN = r'return'

    ID = r'[a-zA-Z_][a-zA-Z0-9_]*'
    NUMBER = r'^[+-]?\d+(\.\d+)?$'
    STRING = r'"[\s\S]*"'

    @_(r'\n+')
    def ignore_newline(self, t):
        self.lineno += len(t.value)

    def error(self, t):
        print('Line %d: Bad character %r' % (self.lineno, t.value[0]))
        self.index += 1
