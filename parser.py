from sly import Parser
from lex import VoxLexer


class VoxParser(Parser):
    debugfile = 'parser.debug'
    tokens = VoxLexer.tokens

    @_('varDecl funDecl fStatement')
    def program(self, p):
        return p.varDecl

    @_('VAR ID ";" varDecl')
    def varDecl(self, p):
        return p.ID

    @_('VAR ID ASSIGN init ";" varDecl')
    def varDecl(self, p):
        return p.ID

    @_('empty')
    def varDecl(self, p):
        pass

    @_('FUN function')
    def funDecl(self, p):
        return p.FUN

    @_('empty')
    def funDecl(self, p):
        pass

    @_('simpleStmt ";"')
    def free_statement(self, p):
        pass

    @_('compoundStmt')
    def free_statement(self, p):
        pass

    @_('free_statement')
    def fStatement(self, p):
        pass

    @_('empty')
    def fStatement(self, p):
        pass

    @_('expr')
    def init(self, p):
        pass

    @_('"[" expr subarrinit "]"')
    def init(self, p):
        pass

    @_('"," expr subarrinit')
    def subarrinit(self, p):
        pass

    @_('empty')
    def subarrinit(self, p):
        pass

    @_('asgnStmt')
    def simpleStmt(self, p):
        pass

    @_('printStmt')
    def simpleStmt(self, p):
        pass

    @_('returnStmt')
    def simpleStmt(self, p):
        pass

    @_('ifStmt')
    def compoundStmt(self, p):
        pass

    @_('whileStmt')
    def compoundStmt(self, p):
        pass

    @_('forStmt')
    def compoundStmt(self, p):
        pass

    @_('free_statement')
    def statement(self, p):
        pass

    @_('block')
    def statement(self, p):
        pass

    @_('ID ASSIGN expr')
    def asgnStmt(self, p):
        pass

    @_('ID "[" aexpr "]" ASSIGN expr')
    def asgnStmt(self, p):
        pass

    @_('PRINT expr')
    def printStmt(self, p):
        pass

    @_('RETURN expr')
    def returnStmt(self, p):
        pass

    @_('IF lexpr statement')
    def ifStmt(self, p):
        pass

    @_('IF lexpr statement ELSE statement')
    def ifStmt(self, p):
        pass

    @_('WHILE lexpr statement')
    def whileStmt(self, p):
        pass

    @_('FOR "(" forAsgn ";" forLexpr ";" forAsgn ")" statement')
    def forStmt(self, p):
        pass

    @_('asgnStmt')
    def forAsgn(self, p):
        pass

    @_('empty')
    def forAsgn(self, p):
        pass

    @_('lexpr')
    def forLexpr(self, p):
        pass

    @_('empty')
    def forLexpr(self, p):
        pass

    @_('"{" varDecl blockStmt "}"')
    def block(self, p):
        pass

    @_('statement blockStmt')
    def blockStmt(self, p):
        pass

    @_('empty')
    def blockStmt(self, p):
        pass

    @_('lexpr')
    def expr(self, p):
        pass

    @_('aexpr')
    def expr(self, p):
        pass

    @_('sexpr')
    def expr(self, p):
        pass

    @_('lexpr OR lterm')
    def lexpr(self, p):
        pass

    @_('lterm')
    def lexpr(self, p):
        pass

    @_('lterm AND lfact')
    def lterm(self, p):
        pass

    @_('lfact')
    def lterm(self, p):
        pass

    @_('cexpr')
    def lfact(self, p):
        pass

    @_('BCALL call')
    def lfact(self, p):
        pass

    @_('"(" lexpr ")"')
    def lfact(self, p):
        pass

    @_('BCALL ID')
    def lfact(self, p):
        pass

    @_('BCALL ID "[" aexpr "]"')
    def lfact(self, p):
        pass

    @_('NOT lfact')
    def lfact(self, p):
        pass

    @_('TRUE')
    def lfact(self, p):
        pass

    @_('FALSE')
    def lfact(self, p):
        pass

    @_('aexpr PLUS term')
    def aexpr(self, p):
        pass

    @_('aexpr MINUS term')
    def aexpr(self, p):
        pass

    @_('term')
    def aexpr(self, p):
        pass

    @_('term MULT fact')
    def term(self, p):
        pass

    @_('term DIV fact')
    def term(self, p):
        pass

    @_('fact')
    def term(self, p):
        pass

    @_('MINUS fact')
    def fact(self, p):
        pass

    @_('call')
    def fact(self, p):
        pass

    @_('NUMBER')
    def fact(self, p):
        pass

    @_('"(" aexpr ")"')
    def fact(self, p):
        pass

    @_('ID')
    def fact(self, p):
        pass

    @_('ID "[" aexpr "]"')
    def fact(self, p):
        pass

    @_('aexpr NEQ aexpr')
    def cexpr(self, p):
        pass

    @_('aexpr EQ aexpr')
    def cexpr(self, p):
        pass

    @_('aexpr GT aexpr')
    def cexpr(self, p):
        pass

    @_('aexpr GE aexpr')
    def cexpr(self, p):
        pass

    @_('aexpr LE aexpr')
    def cexpr(self, p):
        pass

    @_('aexpr LT aexpr')
    def cexpr(self, p):
        pass

    @_('STRING')
    def sexpr(self, p):
        pass

    @_('expr subargument')
    def arguments(self, p):
        pass

    @_('"," expr subargument')
    def subargument(self, p):
        pass

    @_('empty')
    def subargument(self, p):
        pass

    @_('empty')
    def arguments(self, p):
        pass

    @_('ID "(" parameters ")" block')
    def function(self, p):
        pass

    @_('ID subparameters')
    def parameters(self, p):
        pass

    @_('"," ID subparameters')
    def subparameters(self, p):
        pass

    @_('empty')
    def subparameters(self, p):
        pass

    @_('empty')
    def parameters(self, p):
        pass

    @_('ID "(" arguments ")"')
    def call(self, p):
        pass

    @_('')
    def empty(self, p):
        pass
