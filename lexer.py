from sly import Lexer
from ast_tools import Identifier


class Lexer(Lexer):
    tokens = {
        NUMBER, ID, WHILE, IF, ELSE, PRINT,
        PLUS, MINUS, TIMES, DIVIDE, ASSIGN,
        EQ, LT, LE, GT, GE, NE, AND,
        FALSE, TRUE, FUN, FOR, OR,
        RETURN, VAR, STRING, NOT
    }

    literals = {'(', ')', '{', '}', '[', ']', ';', ',', '#'}

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
    TIMES = r'\*'
    DIVIDE = r'/'

    EQ = r'=='
    NE = r'!='
    NOT = r'!'

    GT = r'>'
    GE = r'>='
    LT = r'<'
    LE = r'<='

    ASSIGN = r'='
    PRINT = r'print'
    RETURN = r'return'

    ID = r'[a-zA-Z_][a-zA-Z0-9_]*'
    NUMBER = r'([0-9]*[.])?[0-9]+'
    STRING = r'"[\s\S]*"'

    @_(r'\n+')
    def ignore_newline(self, t):
        self.lineno += len(t.value)

    def NUMBER(self, t):
        t.value = float(t.value)
        return t

    def STRING(self, t):
        t.value = t.value[1:-1]
        return t

    def ID(self, t):
        t.value = Identifier(t.value, self.lineno, self.index - 1)
        return t

    def error(self, t):
        print('Line %d: Bad character %r' % (self.lineno, t.value[0]))
        self.index += 1
        return t
