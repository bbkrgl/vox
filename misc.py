from ast_tools import *
from typing import List
from parser import Parser
from lexer import Lexer


class Intermediate(ASTNodeVisitor):
    def __init__(self, source):
        super().__init__()

        lexer = Lexer()
        parser = Parser()

        self.tokens = lexer.tokenize(source)
        self.ast = parser.parse(self.tokens)

        self._symbol_table = [[]]
        self._curr_scope_level = 0
        self._funs = []
        self._fun_vars = []

        self.undeclared_vars = []
        self.multiple_declarations = []

        self.visit(self.ast)

    def in_scope(self, var, scan_curr_scope=False):
        if not scan_curr_scope:
            for scope in self._symbol_table:
                if var in scope:
                    return True
        else:
            if var in self._symbol_table[self._curr_scope_level]:
                return True

        return False

    def visit_SLiteral(self, sliteral: SLiteral):
        pass

    def visit_Program(self, program: Program):
        for elem in program.var_decls:
            self.visit(elem)
        for elem in program.fun_decls:
            self.visit(elem)
        for elem in program.statements:
            self.visit(elem)

    def visit_ErrorStmt(self, errorstmt: ErrorStmt):
        pass

    def visit_VarDecl(self, vardecl: VarDecl):
        if not self.in_scope(vardecl.identifier.name, True):
            self._symbol_table[self._curr_scope_level].append(
                vardecl.identifier.name)
        else:
            self.multiple_declarations.append(vardecl.identifier)

        if type(vardecl.initializer) == list:
            for elem in vardecl.initializer:
                self.visit(elem)
        elif vardecl.initializer is not None:
            self.visit(vardecl.initializer)

    def visit_FunDecl(self, fundecl: FunDecl):
        if fundecl.identifier.name not in self._funs and not self.in_scope(
            fundecl.identifier.name, True
        ):
            self._funs.append(fundecl.identifier.name)
        else:
            self.multiple_declarations.append(fundecl.identifier)
        self._fun_vars = [elem for elem in fundecl.params]

        self.visit(fundecl.body)

    def visit_Assign(self, assign: Assign):
        if not self.in_scope(assign.identifier.name):
            self.undeclared_vars.append(assign.identifier)

        self.visit(assign.expr)

    def visit_SetVector(self, setvector: SetVector):
        if not self.in_scope(setvector.identifier.name):
            self.undeclared_vars.append(setvector.identifier)

        self.visit(setvector.vector_index)
        self.visit(setvector.expr)

    def visit_ForLoop(self, forloop: ForLoop):
        if forloop.initializer is not None:
            self.visit(forloop.initializer)
        if forloop.condition is not None:
            self.visit(forloop.condition)
        if forloop.increment is not None:
            self.visit(forloop.increment)

        self.visit(forloop.body)

    def visit_Return(self, returnn: Return):
        self.visit(returnn.expr)

    def visit_WhileLoop(self, whileloop: WhileLoop):
        self.visit(whileloop.condition)
        self.visit(whileloop.body)

    def visit_Block(self, block: Block):
        self._symbol_table.append([])
        self._curr_scope_level += 1

        for identifier in self._fun_vars:
            if not self.in_scope(identifier.name, True):
                self._symbol_table[self._curr_scope_level].append(
                    identifier.name)
            else:
                self.multiple_declarations.append(identifier)

        self._fun_vars = []

        for elem in block.var_decls:
            self.visit(elem)
        for elem in block.statements:
            self.visit(elem)

        self._symbol_table = self._symbol_table[:-1]
        self._curr_scope_level -= 1

    def visit_Print(self, printt: Print):
        self.visit(printt.expr)

    def visit_IfElse(self, ifelse: IfElse):
        self.visit(ifelse.condition)
        self.visit(ifelse.if_branch)

        if ifelse.else_branch is not None:
            self.visit(ifelse.else_branch)

    def visit_LBinary(self, lbinary: LBinary):
        self.visit(lbinary.left)
        self.visit(lbinary.right)

    def visit_Comparison(self, comparison: Comparison):
        self.visit(comparison.left)
        self.visit(comparison.right)

    def visit_LLiteral(self, lliteral: LLiteral):
        pass

    def visit_LPrimary(self, lprimary: LPrimary):
        self.visit(lprimary.primary)

    def visit_GetVector(self, getvector: GetVector):
        if not self.in_scope(getvector.identifier.name):
            self.undeclared_vars.append(getvector.identifier)

        self.visit(getvector.vector_index)

    def visit_Variable(self, variable: Variable):
        if not self.in_scope(variable.identifier.name):
            self.undeclared_vars.append(variable.identifier)

    def visit_LNot(self, lnot: LNot):
        self.visit(lnot.right)

    def visit_ABinary(self, abinary: ABinary):
        self.visit(abinary.left)
        self.visit(abinary.right)

    def visit_AUMinus(self, auminus: AUMinus):
        self.visit(auminus.right)

    def visit_ALiteral(self, aliteral: ALiteral):
        pass

    def visit_Call(self, call: Call):
        if call.callee.name not in self._funs:
            self.undeclared_vars.append(call.callee)

        for elem in call.arguments:
            self.visit(elem)


def process(source):
    """parse the source text here. you may return the AST specified in ast_tools.py or something else."""
    return Intermediate(source)


def generate_ast(intermediate) -> Program:
    """return the AST using the output of process() here."""
    return intermediate.ast


def undeclared_vars(intermediate) -> List[Identifier]:
    """return all of the undeclared uses of the variables in the order they appear in the source code here, using the return value of process()"""
    return intermediate.undeclared_vars


def multiple_var_declarations(intermediate) -> List[Identifier]:
    """return all of the subsequent declarations of a previously declared variable if the re-declaration cannot be explained by shadowing,
    in the order they appear in the source code, using the return value of process()"""
    return intermediate.multiple_declarations
