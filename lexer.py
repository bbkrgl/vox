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
    ignore_comment = '//.*'
    ignore_newline = '\n+'
    
    ID = r'[a-zA-Z_][a-zA-Z0-9_]*'
    NUMBER = r'([0-9]*[.])?[0-9]+'
    STRING = r'"(?:[^"\\]|\\.)*"'

    ID['var'] = VAR
    ID['fun'] = FUN

    ID['if'] = IF
    ID['else'] = ELSE
    ID['while'] = WHILE
    ID['for'] = FOR

    ID['or'] = OR
    ID['and'] = AND
    ID['true'] = TRUE
    ID['false'] = FALSE

    PLUS = r'\+'
    MINUS = r'-'
    TIMES = r'\*'
    DIVIDE = r'/'

    EQ = r'=='
    NE = r'!='
    GE = r'>='
    LE = r'<='
    GT = r'>'
    LT = r'<'
    NOT = r'!'

    ASSIGN = r'='
    ID['print'] = PRINT
    ID['return'] = RETURN

    @_(r'\n+')
    def ignore_newline(self, t):
        self.lineno += len(t.value)

    def NUMBER(self, t):
        t.value = float(t.value)
        return t

    def STRING(self, t):
        t.value = t.value[1:-1]
        return t

    def error(self, t):
        print('Line %d: Bad character %r' % (self.lineno, t.value[0]))
        self.index += 1
        return t
