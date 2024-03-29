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

        self._symbol_table = [[[], 0]]
        self._actual_params = []
        self._curr_scope_level = 0
        self._funs = []
        self._infun = False
        self._return_load_regs = ([], 0)
        self._stack = []
        self._stack_record = []
        self._spill_offset = 0
        self._saved_regs = []
        self._fun_vars = []
        self.str_literals = {}

        self._flt_tmps = [f"ft{i}" for i in range(7, -1, -1)]
        self._int_tmps = [f"t{i}" for i in range(7, -1, -1)]
        self._flt_tmp_record = []
        self._int_tmp_record = []
        self._label_counter = 0

        self._vector_arithmetic_dest = ""

        self.code = self.visit(source)

    def get_from_scope(self, var):
        offset = 0
        for scope, o in self._symbol_table[::-1]:
            for sym in scope:
                if sym.name == var:
                    return sym, offset
            offset += o

        return None

    def get_tmp(self, t):
        if t == "float" and self._flt_tmps != []:
            return self._flt_tmps.pop()
        elif (t == "int" or t == "bool") and self._int_tmps != []:
            return self._int_tmps.pop()
        return None

    def free_tmp(self, tmp):
        if tmp[0] == "f":
            self._flt_tmps.append(tmp)
            if self.is_recorded(tmp):
                self._flt_tmp_record.remove(tmp)
        else:
            self._int_tmps.append(tmp)
            if self.is_recorded(tmp):
                self._int_tmp_record.remove(tmp)

    def is_recorded(self, tmp):
        if tmp[0] == "f":
            return tmp in self._flt_tmp_record
        return tmp in self._int_tmp_record

    def visit_SLiteral(self, sliteral: SLiteral):
        label = ".S" + str(len(self.str_literals))
        self.str_literals[label] = sliteral.value
        return label, sliteral.value

    def visit_Program(self, program: Program):
        text = "#include <stdio.h>\n.align 2\n.section .text\n.global main\n\n\n"
        main = "main:\n"
        data = "\n\n.section .data\n"
        for elem in program.var_decls:
            sym, init = self.visit(elem)
            data += f"{sym.location}: .dword 0{str('0'.join([','] * (sym.vector_len)))[:-1]}\n"
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
        data += '.intformat: .string "%d\\n"\n'
        data += '.floatformat: .string "%f\\n"\n'

        return text + main + data

    def visit_VarDecl(self, vardecl: VarDecl):
        addressing = ""
        location = ""
        if self._curr_scope_level == 0:
            addressing = "global"
            location = f".glob_{vardecl.identifier.name}"
        else:
            addressing = "sp"
            location = f"{8 * len(self._stack)}"
            self._stack.append(vardecl.identifier.name)

        init = ""
        t = "float"
        vec_len = 0
        if isinstance(vardecl.initializer, List):
            t = "vec"
            vec_len = len(vardecl.initializer)
            if addressing == "global":
                init += f"la a0, {location}\n"
            else:
                self._stack.pop()

            for i, elem in enumerate(vardecl.initializer):
                reg, code = self.visit(elem)
                self.free_tmp(reg)

                init += code
                if isinstance(elem, LExpr):
                    init += f"fcvt.d.w fa0, {reg}\n"
                    reg = "fa0"

                if addressing == "global":
                    init += f"fsd {reg}, {8 * i}(a0)\n"
                else:
                    self._stack.append(f"{vardecl.identifier.name}[{i}]")
                    init += f"fsd {reg}, {int(location) + 8 * i}(sp)\n"

        elif vardecl.initializer is not None:
            reg, code = self.visit(vardecl.initializer)
            self.free_tmp(reg)

            init += code
            if isinstance(vardecl.initializer, LExpr):
                init += f"fcvt.d.w fa0, {reg}\n"
                reg = "fa0"

            if addressing == "global":
                init += f"la a0, {location}\n"
                init += f"fsd {reg}, (a0)\n"
            else:
                init += f"fsd {reg}, {int(location)}(sp)\n"

        sym = Symbol(vardecl.identifier.name, addressing, location, t, vec_len)
        self._symbol_table[self._curr_scope_level][0].append(sym)

        return sym, init

    def visit_FunDecl(self, fundecl: FunDecl):
        self._funs.append(fundecl.identifier.name)
        self._fun_vars = [elem for elem in fundecl.params]

        self._infun = True
        self._saved_regs.append("ra")
        text = f"{fundecl.identifier.name}:\n"
        text += self.visit(fundecl.body)
        text += "li a0, 0\n"
        text += "ret\n"

        return text

    def visit_Assign(self, assign: Assign):
        sym, offset = self.get_from_scope(assign.identifier.name)
        if sym.type == "vec":
            self._vector_arithmetic_dest = sym
            reg, (code, vlen) = self.visit(assign.expr)
            self._vector_arithmetic_dest = ""
            return code

        reg, code = self.visit(assign.expr)
        self.free_tmp(reg)

        instr = "fsd"
        if isinstance(assign.expr, LExpr) or reg[0] != "f":
            instr = "sd"

        if sym.addressing == "global":
            code += f"la s0, {sym.location}\n"
            code += f"{instr} {reg}, (s0) # {assign.identifier.name}\n"
        else:
            if sym.type == "param":
                location = int(sym.location.split("/")[1])
            else:
                location = int(sym.location)
            code += f"{instr} {reg}, {location + offset + 8 * self._spill_offset}(sp) # {assign.identifier.name}\n"

        return code

    def visit_SetVector(self, setvector: SetVector):
        sym, offset = self.get_from_scope(setvector.identifier.name)
        expr_reg, expr = self.visit(setvector.expr)
        index_reg, index_expr = self.visit(setvector.vector_index)
        self.free_tmp(index_reg)
        self.free_tmp(expr_reg)

        code = expr
        if isinstance(setvector.expr, LExpr):
            code += f"fcvt.d.w ft0, {expr_reg}\n"
            expr_reg = "ft0"

        code += index_expr
        if sym.addressing == "global":
            code += f"la s0, {sym.location}\n"
            code += f"fcvt.w.d s1, {index_reg}\n"
            code += f"slli s1, s1, 3\n"
            code += f"add s0, s0, s1\n"
        else:
            if sym.type == "param":
                location = int(sym.location.split("/")[1])
                code += f"ld s0, {location}(sp)\n"
                ptr_reg = "s0"
            else:
                ptr_reg = "sp"

            code += f"fcvt.w.d s1, {index_reg}\n"
            code += f"slli s1, s1, 3\n"
            code += f"add s0, {ptr_reg}, s1\n"
            if offset != 0:
                code += f"addi s0, {offset + 8 * self._spill_offset}\n"

        code += f"fsd {expr_reg}, (s0)\n"

        return code

    def visit_ForLoop(self, forloop: ForLoop):
        init = ""
        reg, cond = "", ""
        incr = ""
        if forloop.initializer is not None:
            init = self.visit(forloop.initializer)
        if forloop.condition is not None:
            reg, cond = self.visit(forloop.condition)
        if forloop.increment is not None:
            incr = self.visit(forloop.increment)

        body = self.visit(forloop.body)

        l1 = f".L{self._label_counter}"
        self._label_counter += 1
        test_label = f".L{self._label_counter}"
        self._label_counter += 1

        code = init
        code += f"j {test_label}\n"
        code += f"{l1}:\n"
        code += body
        code += incr
        code += f"{test_label}:\n"
        code += cond
        code += f"bnez {reg}, {l1}\n"

        return code

    def visit_Return(self, returnn: Return):
        offset = 0
        for _, o in self._symbol_table[:1:-1]:
            offset += o

        reg, code = self.visit(returnn.expr)
        self.free_tmp(reg)
        if isinstance(returnn.expr, LExpr) or isinstance(returnn.expr, SLiteral):
            code += f"mv a0, {reg}\n"
        else:
            code += f"fmv.x.d a0, {reg}\n"

        saved_regs, stack_size = self._return_load_regs
        for i, reg in enumerate(saved_regs):
            if reg[0] == "f":
                if reg[1] == "a":
                    continue
                code += f"fld {reg}, {8 * i + offset}(sp)\n"
            else:
                if reg[0] == "a":
                    continue
                code += f"ld {reg}, {8 * i + offset}(sp)\n"
        code += f"addi sp, sp, {stack_size}\n"
        code += "ret\n"

        return code

    def visit_WhileLoop(self, whileloop: WhileLoop):
        reg, cond = self.visit(whileloop.condition)
        self.free_tmp(reg)
        body = self.visit(whileloop.body)

        l1 = f".L{self._label_counter}"
        self._label_counter += 1
        test_label = f".L{self._label_counter}"
        self._label_counter += 1

        code = f"j {test_label}\n"
        code += f"{l1}:\n"
        code += body
        code += f"{test_label}:\n"
        code += cond
        code += f"bnez {reg}, {l1}\n"

        return code

    def visit_Block(self, block: Block):
        self._symbol_table.append([[], 0])
        self._stack_record.append(
            (
                self._stack,
                self._flt_tmp_record,
                self._int_tmp_record,
                self._return_load_regs,
            )
        )
        self._stack = []
        saved_regs = []
        fun_vars = []
        if self._infun:
            saved_regs = self._saved_regs[:]
            saved_regs += self._flt_tmp_record + self._int_tmp_record
            fun_vars = self._fun_vars
            self._flt_tmp_record = []
            self._int_tmp_record = []
            self._infun = False
        self._curr_scope_level += 1

        stack_size = len(saved_regs) + len(fun_vars)
        for elem in block.var_decls:
            if elem.initializer is not None:
                if isinstance(elem.initializer, List):
                    stack_size += len(elem.initializer)
                else:
                    stack_size += 1

        stack_size *= 8
        self._symbol_table[self._curr_scope_level][1] = stack_size

        reg_save = ""
        for reg in saved_regs:
            if reg[0] == "f":
                reg_save += f"fsd {reg}, {8 * len(self._stack)}(sp)\n"
            else:
                reg_save += f"sd {reg}, {8 * len(self._stack)}(sp)\n"
            self._stack.append(f"saved_{reg}")

        self._return_load_regs = (
            self._return_load_regs[0] + saved_regs,
            self._return_load_regs[1] + stack_size,
        )

        saved_args = []
        for i, identifier in enumerate(fun_vars):
            if i < 7:
                sym = Symbol(
                    identifier.name, "sp", f"a{i}/{8 * len(self._stack)}", "param", 0
                )  # TODO: Change direct addressing from reg
            else:
                # TODO: Place of arg > 7 should be set from the caller
                sym = Symbol(
                    identifier.name, "sp", f"{8 * len(self._stack)}", "param", 0
                )
            self._stack.append(sym)
            saved_args.append(sym)
            self._symbol_table[self._curr_scope_level][0].append(sym)
            self._actual_params.append(sym)

        for sym in saved_args:
            if sym.addressing == "sp":  # TODO
                reg_save += f"sd {sym.location.split('/')[0]}, {sym.location.split('/')[1]}(sp)\n"

        code = ""
        for elem in block.var_decls:
            sym, init = self.visit(elem)
            code += init

        stack_init = ""
        if stack_size != 0:
            stack_init += f"addi sp, sp, -{stack_size}\n"

        for elem in block.statements:
            code += self.visit(elem)

        reg_load = ""
        for i, reg in enumerate(saved_regs):
            if reg[0] == "f":
                if reg[1] == "a":
                    continue
                reg_load += f"fld {reg}, {8 * i}(sp)\n"
            else:
                if reg[0] == "a":
                    continue
                reg_load += f"ld {reg}, {8 * i}(sp)\n"

        if stack_size != 0:
            reg_load += f"addi sp, sp, {stack_size}\n"

        code = stack_init + reg_save + code + reg_load

        (
            self._stack,
            self._flt_tmp_record,
            self._int_tmp_record,
            self._return_load_regs,
        ) = self._stack_record.pop()
        self._fun_vars = []
        self._saved_regs = []
        self._actual_params = []
        self._symbol_table = self._symbol_table[:-1]
        self._curr_scope_level -= 1

        return code

    def visit_Print(self, printt: Print):
        reg, code = self.visit(printt.expr)
        for i in range(len(self._actual_params)):
            self._actual_params[i].addressing = "sp"
        if isinstance(printt.expr, AExpr):
            code += f"la a0, .floatformat\n"
            code += f"fmv.x.d a1, {reg}\n"
            self.free_tmp(reg)
        elif isinstance(printt.expr, LExpr):
            code += f"la a0, .intformat\n"
            code += f"mv a1, {reg}\n"
            self.free_tmp(reg)
        elif isinstance(printt.expr, SLiteral):
            code = f"la a0, .strformat\n"
            code += f"la a1, {reg}\n"

        code += "call printf\n"
        return code

    def visit_IfElse(self, ifelse: IfElse):
        reg, cond = self.visit(ifelse.condition)
        self.free_tmp(reg)
        if_code = self.visit(ifelse.if_branch)

        else_code = ""
        if ifelse.else_branch is not None:
            else_code = self.visit(ifelse.else_branch)

        l1 = f".L{self._label_counter}"
        self._label_counter += 1

        code = cond
        code += f"beqz {reg}, {l1}\n"
        code += if_code
        if else_code:
            l2 = f".L{self._label_counter}"
            self._label_counter += 1

            code += f"j {l2}\n"
            code += f"{l1}:\n"
            code += else_code
            code += f"{l2}:\n"
        else:
            code += f"{l1}:\n"

        return code

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
            if lreg in self._int_tmps:
                self._int_tmps.remove(lreg)

            code += f"ld {lreg}, (sp)\n"
            code += f"addi sp, sp, 8\n"
            self._spill_offset -= 1
            self._stack.pop()
            if lreg in self._int_tmp_record:
                self._int_tmp_record.remove(lreg)
            self._int_tmp_record.append(lreg)

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
            self._spill_offset -= 1
            self._stack.pop()
            if lreg in self._flt_tmp_record:
                self._flt_tmp_record.remove(lreg)
            self._flt_tmp_record.append(lreg)

        tmp = self.get_tmp("bool")
        if tmp is None:
            tmp = self._int_tmp_record.pop(0)
            self._stack.append(tmp)
            code += f"addi sp, sp, -8\n"
            code += f"sd {tmp}, (sp)\n"
            self._spill_offset += 1
        if tmp in self._int_tmp_record:
            self._int_tmp_record.remove(tmp)
        self._int_tmp_record.append(tmp)

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
            tmp = self._int_tmp_record.pop(0)
            self._stack.append(tmp)
            code += f"addi sp, sp, -8\n"
            code += f"sd {tmp}, (sp)\n"
            self._spill_offset += 1
        if tmp in self._int_tmp_record:
            self._int_tmp_record.remove(tmp)
        self._int_tmp_record.append(tmp)

        return tmp, code + f"li {tmp}, {int(lliteral.value)}\n"

    def visit_LPrimary(self, lprimary: LPrimary):
        reg, code = self.visit(lprimary.primary)
        self.free_tmp(reg)

        tmp = self.get_tmp("bool")
        if tmp is None:
            tmp = self._int_tmp_record.pop(0)
            self._stack.append(tmp)
            code += f"addi sp, sp, -8\n"
            code += f"sd {tmp}, (sp)\n"
            self._spill_offset += 1
        if tmp in self._int_tmp_record:
            self._int_tmp_record.remove(tmp)
        self._int_tmp_record.append(tmp)

        code += f"fcvt.w.d {tmp}, {reg}\n"
        code += f"snez {tmp}, {tmp}\n"

        return tmp, code

    def visit_GetVector(self, getvector: GetVector):
        sym, offset = self.get_from_scope(getvector.identifier.name)
        reg, expr = self.visit(getvector.vector_index)

        code = expr
        if sym.addressing == "global":
            code += f"la s0, {sym.location}\n"
            code += f"fcvt.w.d a1, {reg}\n"
            code += f"slli s1, a1, 3\n"
        else:
            code += f"fcvt.w.d s1, {reg}\n"
            code += f"slli s1, s1, 3\n"
            if sym.type == "param":
                location = int(sym.location.split("/")[1])
                code += f"ld s0, {location}(sp)\n"
            else:
                location = int(sym.location)
                code += (
                    f"addi s0, sp, {int(location) + offset + 8 * self._spill_offset}\n"
                )

        code += f"add s0, s0, s1\n"
        code += f"fld {reg}, (s0)\n"
        return reg, code

    def visit_Variable(self, variable: Variable):
        sym, offset = self.get_from_scope(variable.identifier.name)
        if sym.type == "vec":
            tmp = self.get_tmp("int")
            code = ""
            if tmp is None:
                tmp = self._int_tmp_record.pop(0)
                self._stack.append(tmp)
                code += f"addi sp, sp, -8\n"
                code += f"sd {tmp}, (sp)\n"
                self._spill_offset += 1
            if tmp in self._int_tmp_record:
                self._int_tmp_record.remove(tmp)
            self._int_tmp_record.append(tmp)

            if sym.addressing == "global":
                code += f"la {tmp}, {sym.location}\n"
            elif sym.addressing == "sp":
                if sym.type == "param":
                    location = int(sym.location.split("/")[1])
                else:
                    location = int(sym.location)
                code += (
                    f"addi {tmp}, sp, {location + offset + 8 * self._spill_offset}\n"
                )
            else:
                code += f"mv {tmp}, {sym.location.split('/')[0]}\n"

            return tmp, (code, sym.vector_len)

        code = ""
        tmp = self.get_tmp("float")
        if tmp is None:
            tmp = self._flt_tmp_record.pop(0)
            self._stack.append(tmp)
            code += f"addi sp, sp, -8\n"
            code += f"fsd {tmp}, (sp)\n"
            self._spill_offset += 1
        if tmp in self._flt_tmp_record:
            self._flt_tmp_record.remove(tmp)
        self._flt_tmp_record.append(tmp)

        if sym.addressing == "global":
            code += f"la s0, {sym.location}\n"
            code += f"fld {tmp}, (s0)\n"
        elif sym.addressing == "sp":
            if sym.type == "param":
                location = int(sym.location.split("/")[1])
            else:
                location = int(sym.location)
            code += f"fld {tmp}, {location + offset + 8 * self._spill_offset}(sp)\n"
        else:
            code += f"fmv.d.x {tmp}, {sym.location.split('/')[0]}\n"

        return tmp, code

    def visit_LNot(self, lnot: LNot):
        tmp, code = self.visit(lnot.right)
        code += f"xori {tmp}, {tmp}, 1\n"

        return tmp, code

    def visit_ABinary(self, abinary: ABinary):
        lreg, lexpr = self.visit(abinary.left)
        rreg, rexpr = self.visit(abinary.right)
        self.free_tmp(rreg)

        if isinstance(lexpr, tuple) and isinstance(rexpr, tuple):
            lexpr, lvlen = lexpr
            rexpr, rvlen = rexpr

            code = lexpr + rexpr

            sym = self._vector_arithmetic_dest
            if sym.addressing == "global":
                code += f"la s0, {sym.location}\n"
            else:
                if sym.type == "param":
                    location = int(sym.location.split('/')[1])
                else:
                    location = int(sym.location)
                code += f"addi s0, sp, {location}\n"

            code += f"li s2, {lvlen}\n"
            label = f".L{self._label_counter}"
            self._label_counter += 1
            code += f"{label}:\n"
            code += f"vsetvli s1, s2, e64\n"
            code += f"vle64.v v0, ({lreg})\n"
            code += f"vle64.v v1, ({rreg})\n"
            if abinary.op == "+":
                code += f"vfadd.vv v0, v0, v1\n"
            elif abinary.op == "-":
                code += f"vfsub.vv v0, v0, v1\n"
            elif abinary.op == "*":
                code += f"vfmul.vv v0, v0, v1\n"
            elif abinary.op == "/":
                code += f"vfdiv.vv v0, v0, v1\n"

            code += f"vse64.v v0, (s0)\n"
            code += f"sub s2, s2, s1\n"
            code += f"slli s3, s1, 3\n"
            code += f"add {lreg}, {lreg}, s3\n"
            code += f"add {rreg}, {rreg}, s3\n"
            code += f"add s0, s0, s3\n"
            code += f"bgtz s2, {label}\n"

            return "s0", (code, lvlen)

        code = lexpr + rexpr
        if self._stack != [] and self._stack[-1] == lreg:
            if lreg in self._flt_tmps:
                self._flt_tmps.remove(lreg)

            code += f"fld {lreg}, (sp)\n"
            code += f"addi sp, sp, 8\n"
            self._spill_offset -= 1
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
        code = ""
        tmp = self.get_tmp("float")
        if tmp is None:
            tmp = self._flt_tmp_record.pop(0)
            self._stack.append(tmp)
            code += f"addi sp, sp, -8\n"
            code += f"fsd {tmp}, (sp)\n"
            self._spill_offset += 1
        if tmp in self._flt_tmp_record:
            self._flt_tmp_record.remove(tmp)
        self._flt_tmp_record.append(tmp)

        val = int.from_bytes(struct.pack("d", aliteral.value), "little")
        code += f"li t2, {val} # {aliteral.value}\n"
        code += f"fmv.d.x {tmp}, t2\n"
        return tmp, code

    def visit_Call(self, call: Call):
        code = ""
        tmp = self.get_tmp("float")
        if tmp is None:
            tmp = self._flt_tmp_record.pop(0)
            self._stack.append(tmp)
            code += f"addi sp, sp, -8\n"
            code += f"fsd {tmp}, (sp)\n"
            self._spill_offset += 1
        if tmp in self._flt_tmp_record:
            self._flt_tmp_record.remove(tmp)
        self._flt_tmp_record.append(tmp)

        for i, elem in enumerate(call.arguments):
            if i < len(self._actual_params):
                self._actual_params[i].addressing = "sp"
            reg, expr = self.visit(elem)
            self.free_tmp(reg)
            if isinstance(expr, tuple):
                expr, vlen = expr
            code += expr
            if reg[0] == "f":
                code += f"fmv.x.d a{i}, {reg}\n"
            else:
                code += f"mv a{i}, {reg}\n"

        saved_regs = self._flt_tmp_record + self._int_tmp_record
        code += f"addi sp, sp, -{8 * len(saved_regs)}\n"
        for i, reg in enumerate(saved_regs):
            if reg[0] == "f":
                if reg[1] == "a":
                    continue
                code += f"fsd {reg}, {8 * i}(sp)\n"
            else:
                if reg[0] == "a" or reg[0] == "r":
                    continue
                code += f"sd {reg}, {8 * i}(sp)\n"

        code += f"call {call.callee.name}\n"

        for i, reg in enumerate(saved_regs):
            if reg[0] == "f":
                if reg[1] == "a":
                    continue
                code += f"fld {reg}, {8 * i}(sp)\n"
            else:
                if reg[0] == "a" or reg[0] == "r":
                    continue
                code += f"ld {reg}, {8 * i}(sp)\n"
        code += f"addi sp, sp, {8 * len(saved_regs)}\n"
        code += f"fmv.d.x {tmp}, a0\n"

        return tmp, code

    def visit_ErrorStmt(self, errorstmt: ErrorStmt):
        pass
