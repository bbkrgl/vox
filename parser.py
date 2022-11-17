from sly import Parser
from lexer import Lexer
from ast_tools import *


class Parser(Parser):
    debugfile = "parser.debug"
    tokens = Lexer.tokens

    """
    Program syntax
    """

    @_("varDecl funDecl fStatement")
    def program(self, p):
        return Program(p.varDecl, p.funDecl, p.fStatement)

    """
    Global Variable Declarations
    """

    @_('VAR ID ";" varDecl')
    def varDecl(self, p):
        id = Identifier(p.ID, p.lineno, p.index)
        return [VarDecl(id, None)] + p.varDecl

    @_('VAR ID ASSIGN init ";" varDecl')
    def varDecl(self, p):
        id = Identifier(p.ID, p.lineno, p.index)
        return [VarDecl(id, p.init)] + p.varDecl

    @_("empty")
    def varDecl(self, p):
        return []

    """
    Global Function Declarations
    """

    @_("FUN function funDecl")
    def funDecl(self, p):
        return [p.function] + p.funDecl

    @_("empty")
    def funDecl(self, p):
        return []

    """
    Free Statements
    """

    @_('simpleStmt ";"')
    def free_statement(self, p):
        return p.simpleStmt

    @_("compoundStmt")
    def free_statement(self, p):
        return p.compoundStmt

    @_("free_statement fStatement")
    def fStatement(self, p):
        return [p.free_statement] + p.fStatement

    @_("empty")
    def fStatement(self, p):
        return []

    """
    Initialization
    """

    @_("expr")
    def init(self, p):
        return p.expr

    @_('"[" expr subarrinit "]"')
    def init(self, p):
        return [p.expr] + p.subarrinit

    @_('"," expr subarrinit')
    def subarrinit(self, p):
        return [p.expr] + p.subarrinit

    @_("empty")
    def subarrinit(self, p):
        return []

    """
    Simple-Compound Statements
    """

    @_("asgnStmt")
    def simpleStmt(self, p):
        return p.asgnStmt

    @_("printStmt")
    def simpleStmt(self, p):
        return p.printStmt

    @_("returnStmt")
    def simpleStmt(self, p):
        return p.returnStmt

    @_("ifStmt")
    def compoundStmt(self, p):
        return p.ifStmt

    @_("whileStmt")
    def compoundStmt(self, p):
        return p.whileStmt

    @_("forStmt")
    def compoundStmt(self, p):
        return p.forStmt

    """
    Statements
    """

    @_("free_statement")
    def statement(self, p):
        return p.free_statement

    @_("block")
    def statement(self, p):
        return p.block

    """
    Assignment Statements
    """

    @_("ID ASSIGN expr")
    def asgnStmt(self, p):
        id = Identifier(p.ID, p.lineno, p.index)
        return Assign(id, p.expr)

    @_('ID "[" aexpr "]" ASSIGN expr')
    def asgnStmt(self, p):
        id = Identifier(p.ID, p.lineno, p.index)
        return SetVector(id, p.aexpr, p.expr)

    """
    Print Statement
    """

    @_("PRINT expr")
    def printStmt(self, p):
        return Print(p.expr)

    """
    Return Statement
    """

    @_("RETURN expr")
    def returnStmt(self, p):
        return Return(p.expr)

    """
    If Statement
    """

    @_("IF lexpr statement")
    def ifStmt(self, p):
        return IfElse(p.lexpr, p.statement, None)

    @_("IF lexpr statement ELSE statement")
    def ifStmt(self, p):
        return IfElse(p.lexpr, p.statement0, p.statement1)

    """
    While Statement
    """

    @_("WHILE lexpr statement")
    def whileStmt(self, p):
        return WhileLoop(p.lexpr, p.statement)

    """
    For Statement
    """

    @_('FOR "(" forAsgn ";" forLexpr ";" forAsgn ")" statement')
    def forStmt(self, p):
        return ForLoop(p.forAsgn0, p.forLexpr, p.forAsgn1, p.statement)

    @_("asgnStmt")
    def forAsgn(self, p):
        return p.asgnStmt

    @_("empty")
    def forAsgn(self, p):
        return None

    @_("lexpr")
    def forLexpr(self, p):
        return p.lexpr

    @_("empty")
    def forLexpr(self, p):
        return None

    """
    Block
    """

    @_('"{" varDecl blockStmt "}"')
    def block(self, p):
        return Block(p.varDecl, p.blockStmt)

    @_("statement blockStmt")
    def blockStmt(self, p):
        return [p.statement] + p.blockStmt

    @_("empty")
    def blockStmt(self, p):
        return []

    """
    Expressions
    """

    @_("lexpr")
    def expr(self, p):
        return p.lexpr

    @_("aexpr")
    def expr(self, p):
        return p.aexpr

    @_("sexpr")
    def expr(self, p):
        return p.sexpr

    @_("lexpr OR lterm")
    def lexpr(self, p):
        return LBinary("or", p.lexpr, p.lterm)

    @_("lterm")
    def lexpr(self, p):
        return p.lterm

    @_("lterm AND lfact")
    def lterm(self, p):
        return LBinary("and", p.lterm, p.lfact)

    @_("lfact")
    def lterm(self, p):
        return p.lfact

    @_("cexpr")
    def lfact(self, p):
        return p.cexpr

    @_('"#" call')
    def lfact(self, p):
        return LPrimary(p.call)

    @_('"(" lexpr ")"')
    def lfact(self, p):
        return p.lexpr

    @_('"#" ID')
    def lfact(self, p):
        id = Identifier(p.ID, p.lineno, p.index)
        return LPrimary(Variable(id))

    @_('"#" ID "[" aexpr "]"')
    def lfact(self, p):
        id = Identifier(p.ID, p.lineno, p.index)
        return LPrimary(GetVector(id, p.aexpr))

    @_("NOT lfact")
    def lfact(self, p):
        return LNot(p.lfact)

    @_("TRUE")
    def lfact(self, p):
        return LLiteral(p.TRUE)

    @_("FALSE")
    def lfact(self, p):
        return LLiteral(p.FALSE)

    @_("aexpr PLUS term")
    def aexpr(self, p):
        return ABinary("+", p.aexpr, p.term)

    @_("aexpr MINUS term")
    def aexpr(self, p):
        return ABinary("-", p.aexpr, p.term)

    @_("term")
    def aexpr(self, p):
        return p.term

    @_("term TIMES fact")
    def term(self, p):
        return ABinary("*", p.term, p.fact)

    @_("term DIVIDE fact")
    def term(self, p):
        return ABinary("/", p.term, p.fact)

    @_("fact")
    def term(self, p):
        return p.fact

    @_("MINUS fact")
    def fact(self, p):
        return AUMinus(p.fact)

    @_("call")
    def fact(self, p):
        return p.call

    @_("NUMBER")
    def fact(self, p):
        return ALiteral(p.NUMBER)

    @_('"(" aexpr ")"')
    def fact(self, p):
        return p.aexpr

    @_("ID")
    def fact(self, p):
        id = Identifier(p.ID, p.lineno, p.index)
        return Variable(id)

    @_('ID "[" aexpr "]"')
    def fact(self, p):
        id = Identifier(p.ID, p.lineno, p.index)
        return GetVector(id, p.aexpr)

    @_("aexpr NE aexpr")
    def cexpr(self, p):
        return Comparison("!=", p.aexpr0, p.aexpr1)

    @_("aexpr EQ aexpr")
    def cexpr(self, p):
        return Comparison("==", p.aexpr0, p.aexpr1)

    @_("aexpr GT aexpr")
    def cexpr(self, p):
        return Comparison(">", p.aexpr0, p.aexpr1)

    @_("aexpr GE aexpr")
    def cexpr(self, p):
        return Comparison(">=", p.aexpr0, p.aexpr1)

    @_("aexpr LE aexpr")
    def cexpr(self, p):
        return Comparison("<=", p.aexpr0, p.aexpr1)

    @_("aexpr LT aexpr")
    def cexpr(self, p):
        return Comparison("<", p.aexpr0, p.aexpr1)

    @_("STRING")
    def sexpr(self, p):
        return SLiteral(p.STRING)

    """
    Function Definition
    """

    @_('ID "(" parameters ")" block')
    def function(self, p):
        id = Identifier(p.ID, p.lineno, p.index)
        return FunDecl(id, p.parameters, p.block)

    @_("ID subparameters")
    def parameters(self, p):
        id = Identifier(p.ID, p.lineno, p.index)
        return [id] + p.subparameters

    @_('"," ID subparameters')
    def subparameters(self, p):
        id = Identifier(p.ID, p.lineno, p.index)
        return [id] + p.subparameters

    @_("empty")
    def subparameters(self, p):
        return []

    @_("empty")
    def parameters(self, p):
        return []

    """
    Function Call - Definition
    """

    @_("expr subargument")
    def arguments(self, p):
        return [p.expr] + p.subargument

    @_('"," expr subargument')
    def subargument(self, p):
        return [p.expr] + p.subargument

    @_("empty")
    def subargument(self, p):
        return []

    @_("empty")
    def arguments(self, p):
        return []

    @_('ID "(" arguments ")"')
    def call(self, p):
        id = Identifier(p.ID, p.lineno, p.index)
        return Call(id, p.arguments)

    """
    Empty
    """

    @_("")
    def empty(self, p):
        pass

    """
    Error Handling
    """

    @_('error ";"', 'error "}"')
    def free_statement(self, p):
        print("Syntax error at line", p.lineno)
        return ErrorStmt()
