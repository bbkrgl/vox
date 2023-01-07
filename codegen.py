from ast_tools import *
import struct


@dataclass()
class Symbol:
    name: str
    addressing: str
    location: str
    type: str
    vector_len: int


class CodeGenerator(ASTNodeVisitor):
    def __init__(self, source):
        super().__init__()

        self._symbol_table = [[]]
        self._curr_scope_level = 0
        self._funs = []
        self._stack = []
        self._saved_regs = []
        self._fun_vars = []
        self.str_literals = {}

        self._flt_tmps = [f"ft{i}" for i in range(7, -1, -1)]
        self._bool_tmps = [f"t{i}" for i in range(7, -1, -1)]
        self._flt_tmp_record = []
        self._bool_tmp_record = []
        self._label_counter = 0

        self.code = self.visit(source)

    def get_from_scope(self, var):
        for scope in self._symbol_table:
            for sym in scope:
                if sym.name == var:
                    return sym

        return None

    def get_tmp(self, t):
        if t == "float" and self._flt_tmps != []:
            return self._flt_tmps.pop()
        elif t == "bool" and self._bool_tmps != []:
            return self._bool_tmps.pop()
        return None

    def free_tmp(self, tmp):
        if tmp[0] == "f":
            self._flt_tmps.append(tmp)
            if self.is_recorded(tmp):
                i = list(map(lambda l: l[0], self._flt_tmp_record)).index(tmp)
                del self._flt_tmp_record[i]
        else:
            self._bool_tmps.append(tmp)
            if self.is_recorded(tmp):
                i = list(map(lambda l: l[0], self._bool_tmp_record)).index(tmp)
                del self._bool_tmp_record[i]

    def is_recorded(self, tmp):
        if tmp[0] == "f":
            return tmp in map(lambda l: l[0], self._flt_tmp_record)
        return tmp in map(lambda l: l[0], self._bool_tmp_record)

    def pop_record(self, tmp=None):
        if tmp == "float":
            return self._flt_tmp_record.pop()
        if tmp == "bool":
            return self._bool_tmp_record.pop()

        if tmp[0] == "f":
            if self._flt_tmp_record[-1] != tmp:
                return self._flt_tmp_record.pop()
            r = None
            for record in self._flt_tmp_record[::-1]:
                if record != tmp:
                    r = record
            self._flt_tmp_record.remove(r)
            return r

        if self._bool_tmp_record[-1] != tmp:
            return self._bool_tmp_record.pop()
        r = None
        for record in self._bool_tmp_record[::-1]:
            if record != tmp:
                r = record
        self._bool_tmp_record.remove(r)
        return r

    def visit_SLiteral(self, sliteral: SLiteral):
        label = ".S" + str(len(self.str_literals))
        self.str_literals[label] = sliteral.value
        return label, sliteral.value

    def visit_Program(self, program: Program):
        text = "#include <stdio.h>\n.align 2\n.section .text\n.global main\n\n\n"
        main = "main:\n"
        data = "\n\n.section .data\n"
        for elem in program.var_decls:
            loc, init = self.visit(elem)
            data += f"{loc}: .float 0.0\n"  # TODO: Init vector
            main += init

        for elem in program.fun_decls:
            text += self.visit(elem)

        for elem in program.statements:
            main += self.visit(elem)

        main += "\nli a0, 0\n"
        main += "li a7, 93\n"
        main += "ecall\n"

        for key, strl in self.str_literals.items():
            data += f'{key}: .string "{strl}"\n'

        data += '.strformat: .string "%s\\n"\n'
        data += '.boolformat: .string "%d\\n"\n'
        data += '.floatformat: .string "%f\\n"\n'

        return text + main + data

    def visit_VarDecl(self, vardecl: VarDecl):
        # TODO
        # -- Space Allocation --
        # DONE: Determine if the var is global or not
        # DONE: If global, give it a label and store in the data section
        # DONE: Else record the position in the stack
        # -- Initialization value --
        # TODO: Exprs will return the accumulated register
        # DONE: Move the result from register to the identifier place
        # TODO: Optimization: Determine if the var is used immediately, use the reg directly if so

        addressing = ""
        location = ""
        if self._curr_scope_level == 0:
            addressing = "global"
            location = f"glob_{vardecl.identifier.name}"
        else:
            addressing = "sp"
            location = f"{self._stack * 8}"
            self._stack += 1

        init = ""
        vec_len = 0
        t = "float"
        instr = "fsd"
        if isinstance(vardecl.initializer, List):
            # TODO: Read vector initialization
            # TODO: Allocate vector
            # TODO: Iterate over initializers and put them into their indexes at the vector
            t = "vec"
            vec_len = len(vardecl.initializer)
            for elem in vardecl.initializer:
                reg, code = self.visit(elem)
        elif vardecl.initializer is not None:
            reg, code = self.visit(vardecl.initializer)
            init += code
            if isinstance(vardecl.initializer, LExpr):
                t = "bool"
                instr = "sd"

            if addressing == "global":
                init += f"la t0, {location}\n{instr} {reg}, (t0)\n"
            else:
                init += f"{instr} {reg}, {-int(location)}(sp)"

        sym = Symbol(vardecl.identifier.name, addressing, t, location, vec_len)
        self._symbol_table[self._curr_scope_level].append(sym)

        return location, init

    def visit_FunDecl(self, fundecl: FunDecl):
        # TODO
        self._funs.append(fundecl.identifier.name)
        self._fun_vars = [elem for elem in fundecl.params]
        self._stack = 0

        # DONE: Add function label
        # DONE: Return the code taken from the block

        text = f"{fundecl.identifier.name}:\n"
        text += self.visit(fundecl.body)

        return text

    def visit_Assign(self, assign: Assign):
        # TODO
        sym = self.get_from_scope(assign.identifier.name)
        reg, code = self.visit(assign.expr)

        code = ""
        t = "float"
        instr = "fsd"
        if isinstance(assign.expr, LExpr):
            t = "bool"
            instr = "sd"

        if sym.addressing == "global":
            code += f"la t0, {sym.location}\n{instr} {reg}, (t0)\n"
        else:
            code += f"{instr} {reg}, {-int(sym.location)}(sp)"

        # TODO: Change type of sym
        return code

    def visit_SetVector(self, setvector: SetVector):
        # TODO
        if not self.in_scope(setvector.identifier.name):
            self.undeclared_vars.append(setvector.identifier)

        self.visit(setvector.vector_index)
        self.visit(setvector.expr)

    def visit_ForLoop(self, forloop: ForLoop):
        # TODO
        if forloop.initializer is not None:
            self.visit(forloop.initializer)
        if forloop.condition is not None:
            self.visit(forloop.condition)
        if forloop.increment is not None:
            self.visit(forloop.increment)

        self.visit(forloop.body)

    def visit_Return(self, returnn: Return):
        # TODO
        reg, code = self.visit(returnn.expr)
        if isinstance(returnn.expr, LExpr) or isinstance(returnn.expr, SLiteral):
            code += f"mv a0, {reg}\nret\n"
        else:  # TODO: Check
            code += f"mv fa0, {reg}\nret\n"

        return code

    def visit_WhileLoop(self, whileloop: WhileLoop):
        # TODO
        self.visit(whileloop.condition)
        self.visit(whileloop.body)

    def visit_Block(self, block: Block):
        # TODO
        # DONE: Allocate space for old used registers
        # DONE: Allocate space for parameters (if num_param>7)
        # DONE: Allocate space for locals
        # DONE: Add body code
        # DONE: Restore old registers
        # DONE: Deallocate stack
        # DONE: Return to ra

        self._symbol_table.append([])
        self._curr_scope_level += 1

        stack_size = (
            len(block.var_decls) + len(self._saved_regs) +
            len(self._fun_vars[8:])
        )

        text = ""
        if stack_size != 0:
            text += f"\tsubi sp, sp, {stack_size * 8}\n"

        # TODO: Fix num_params > 7
        for identifier in self._fun_vars[8:]:
            # TODO: Change type
            sym = Symbol(identifier.name, "sp",
                         f"{self._stack * 8}", "float", 0)
            self._stack += 1
            self._symbol_table[self._curr_scope_level].append(sym)

        reg_pos = []
        for reg in self._saved_regs:
            text += f"\tsd {reg}, ({self._stack})sp\n"
            reg_pos.append((reg, self._stack))
            self._stack += 1

        for elem in block.var_decls:
            location, init = self.visit(elem)
            text += init

        for elem in block.statements:
            text += self.visit(elem)

        for reg, pos in reg_pos:
            text += f"\tld {reg}, ({pos * 8})(sp)\n"

        text += f"\taddi sp, sp, {stack_size * 8}\n"

        self._fun_vars = []
        self._symbol_table = self._symbol_table[:-1]
        self._curr_scope_level -= 1

        return text

    def visit_Print(self, printt: Print):
        reg, code = self.visit(printt.expr)
        if isinstance(printt.expr, AExpr):
            code += f"la a0, .floatformat\n"
            code += f"fmv.x.d a1, {reg}\n"
            self.free_tmp(reg)
        elif isinstance(printt.expr, LExpr):
            code += f"la a0, .boolformat\n"
            code += f"mv a1, {reg}\n"
            self.free_tmp(reg)
        elif isinstance(printt.expr, SLiteral):
            code = f"la a0, .strformat\n"
            code += f"la a1, {reg}\n"

        code += "call printf\n"
        return code

    def visit_IfElse(self, ifelse: IfElse):
        # TODO
        self.visit(ifelse.condition)
        self.visit(ifelse.if_branch)

        if ifelse.else_branch is not None:
            self.visit(ifelse.else_branch)

    def visit_LBinary(self, lbinary: LBinary):
        lreg, lexpr = self.visit(lbinary.left)
        rreg, rexpr = self.visit(lbinary.right)
        self.free_tmp(rreg)

        code = lexpr
        if lbinary.op == "or":
            code += f"bnez {lreg}, .L{self._label_counter}\n"
        elif lbinary.op == "and":
            code += f"beqz {lreg}, .L{self._label_counter}\n"

        code += rexpr
        if self._stack != [] and self._stack[-1] == lreg:
            if lreg in self._bool_tmps:
                self._bool_tmps.remove(lreg)

            code += f"fld {lreg}, (sp)\n"
            code += f"addi sp, sp, 8\n"
            self._stack.pop()
            if lreg in self._bool_tmp_record:
                self._bool_tmp_record.remove(lreg)
            self._bool_tmp_record.append(lreg)

        if lbinary.op == "or":
            code += f"or {lreg}, {lreg}, {rreg}\n"
        elif lbinary.op == "and":
            code += f"and {lreg}, {lreg}, {rreg}\n"

        code += f".L{self._label_counter}:\n"
        self._label_counter += 1

        return lreg, code

    def visit_Comparison(self, comparison: Comparison):
        lreg, lexpr = self.visit(comparison.left)
        rreg, rexpr = self.visit(comparison.right)
        self.free_tmp(lreg)
        self.free_tmp(rreg)
        code = lexpr + rexpr

        if self._stack != [] and self._stack[-1] == lreg:
            if lreg in self._flt_tmps:
                self._flt_tmps.remove(lreg)

            code += f"fld {lreg}, (sp)\n"
            code += f"addi sp, sp, 8\n"
            self._stack.pop()
            if lreg in self._flt_tmp_record:
                self._flt_tmp_record.remove(lreg)
            self._flt_tmp_record.append(lreg)

        tmp = self.get_tmp("bool")
        if tmp is None:
            tmp = self._bool_tmp_record.pop(0)
            self._stack.append(tmp)
            code += f"addi sp, sp, -8\n"
            code += f"sd {tmp}, (sp)\n"
        if tmp in self._bool_tmp_record:
            self._bool_tmp_record.remove(tmp)
        self._bool_tmp_record.append(tmp)

        if comparison.op == "<":
            code += f"flt.d {tmp}, {lreg}, {rreg}\n"
        elif comparison.op == "<=":
            code += f"fle.d {tmp}, {lreg}, {rreg}\n"
        elif comparison.op == "==":
            code += f"feq.d {tmp}, {lreg}, {rreg}\n"
        elif comparison.op == "!=":
            code += f"feq.d {tmp}, {lreg}, {rreg}\n"
            code += f"xori {tmp}, {tmp}, 1\n"
        elif comparison.op == ">":
            code += f"flt.d {tmp}, {rreg}, {lreg}\n"
        elif comparison.op == ">=":
            code += f"fle.d {tmp}, {rreg}, {lreg}\n"

        return tmp, code

    def visit_LLiteral(self, lliteral: LLiteral):
        tmp = self.get_tmp("bool")
        code = ""
        if tmp is None:
            tmp = self._bool_tmp_record.pop(0)
            self._stack.append(tmp)
            code += f"addi sp, sp, -8\n"
            code += f"sd {tmp}, (sp)\n"
        if tmp in self._bool_tmp_record:
            self._bool_tmp_record.remove(tmp)
        self._bool_tmp_record.append(tmp)

        return tmp, code + f"li {tmp}, {int(lliteral.value)}\n"

    def visit_LPrimary(self, lprimary: LPrimary):
        preg, code = self.visit(lprimary.primary)
        self.free_tmp(preg)

        tmp = self.get_tmp("bool")
        code += f"fcvt.w.d {tmp}, {preg}\n"

        return tmp, code

    def visit_GetVector(self, getvector: GetVector):
        # TODO
        if not self.in_scope(getvector.identifier.name):
            self.undeclared_vars.append(getvector.identifier)

        self.visit(getvector.vector_index)

    def visit_Variable(self, variable: Variable):
        # TODO
        if not self.in_scope(variable.identifier.name):
            self.undeclared_vars.append(variable.identifier)

    def visit_LNot(self, lnot: LNot):
        tmp, code = self.visit(lnot.right)
        code += f"xori {tmp}, {tmp}, 1\n"

        return tmp, code

    def visit_ABinary(self, abinary: ABinary):
        lreg, lexpr = self.visit(abinary.left)
        rreg, rexpr = self.visit(abinary.right)
        self.free_tmp(rreg)

        code = lexpr + rexpr
        if self._stack != [] and self._stack[-1] == lreg:
            if lreg in self._flt_tmps:
                self._flt_tmps.remove(lreg)

            code += f"fld {lreg}, (sp)\n"
            code += f"addi sp, sp, 8\n"
            self._stack.pop()
            if lreg in self._flt_tmp_record:
                self._flt_tmp_record.remove(lreg)
            self._flt_tmp_record.append(lreg)

        if abinary.op == "+":
            code += f"fadd.d {lreg}, {lreg}, {rreg}\n"
        elif abinary.op == "-":
            code += f"fsub.d {lreg}, {lreg}, {rreg}\n"
        elif abinary.op == "*":
            code += f"fmul.d {lreg}, {lreg}, {rreg}\n"
        elif abinary.op == "/":
            code += f"fdiv.d {lreg}, {lreg}, {rreg}\n"

        return lreg, code

    def visit_AUMinus(self, auminus: AUMinus):
        tmp, code = self.visit(auminus.right)
        code += f"fsgnjn.d {tmp}, {tmp}, {tmp}\n"
        return tmp, code

    def visit_ALiteral(self, aliteral: ALiteral):
        tmp = self.get_tmp("float")
        code = ""
        if tmp is None:
            tmp = self._flt_tmp_record.pop(0)
            self._stack.append(tmp)
            code += f"addi sp, sp, -8\n"
            code += f"fsd {tmp}, (sp)\n"
        if tmp in self._flt_tmp_record:
            self._flt_tmp_record.remove(tmp)
        self._flt_tmp_record.append(tmp)

        val = int.from_bytes(struct.pack("d", aliteral.value), "little")
        code += f"li t2, {val} # {aliteral.value}\n"
        code += f"fmv.d.x {tmp}, t2\n"
        return tmp, code

    def visit_Call(self, call: Call):
        # TODO
        if call.callee.name not in self._funs:
            self.undeclared_vars.append(call.callee)

    def visit_ErrorStmt(self, errorstmt: ErrorStmt):
        pass
