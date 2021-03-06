`include "control_unit_if.vh"
`include "cpu_types_pkg.vh"

module control_unit
import cpu_types_pkg::*;
(
  control_unit_if.ci cuif
);

opcode_t opcode;
funct_t funct;
assign opcode = cuif.opcode;
assign funct = cuif.funct;

assign cuif.RegDst = (opcode === RTYPE) && (funct !== JR);
assign cuif.RegWr = ~((opcode === RTYPE) && (funct  === JR)) && (opcode !== BEQ)
            && (opcode !== BNE) && (opcode !== SW) && (opcode !== J)
            && (opcode !== HALT);

assign  cuif.ImmToReg = (opcode === LUI);
assign  cuif.ExtOp = (opcode === ADDIU) || (opcode === LW) || (opcode === SW)
            || (opcode === SLTIU) || (opcode == SLTI) || (opcode === LL) || (opcode === SC);

assign  cuif.ShamToAlu = (opcode === RTYPE) && ((funct === SLL) || (funct === SRL));

assign  cuif.ImmToAlu= (opcode !== RTYPE) && (opcode !== BEQ) && (opcode !== BNE)
            && (opcode !== JAL) && (opcode !== J) && (opcode !== HALT);

assign cuif.DataRead = (opcode === LW) || (opcode === LL);
assign cuif.DataWrite = (opcode === SW) || (opcode === SC);
assign cuif.LinkedLoad = opcode === LL;
assign cuif.StoreConditional = opcode === SC;

assign cuif.BrEq = (opcode === BEQ);
assign cuif.BrNeq = (opcode === BNE);
assign cuif.Jump = (opcode === J) || (opcode === JAL);
assign cuif.Jr = (opcode === RTYPE) && (funct === JR);
assign cuif.Jal = (opcode === JAL);

assign cuif.Halt = (opcode === HALT);

// alu control
  aluop_t alu_ftop;
  // alu control logic
  always_comb
  begin
    casez (opcode)
      RTYPE:  cuif.aluop = alu_ftop;
      ADDIU:  cuif.aluop = ALU_ADD;
      ANDI:   cuif.aluop = ALU_AND;
      ORI:    cuif.aluop = ALU_OR;
      SLTI:   cuif.aluop = ALU_SLT;
      SLTIU:  cuif.aluop = ALU_SLTU;
      XORI:   cuif.aluop = ALU_XOR;
      default: cuif.aluop = ALU_ADD;
    endcase
  end

  always_comb
  begin
    casez (funct)
      SLL:  alu_ftop = ALU_SLL;
      SRL:  alu_ftop = ALU_SRL;
      ADD, ADDU:  alu_ftop = ALU_ADD;
      SUB, SUBU:  alu_ftop = ALU_SUB;
      AND:  alu_ftop = ALU_AND;
      OR:   alu_ftop = ALU_OR;
      XOR:  alu_ftop = ALU_XOR;
      NOR:  alu_ftop = ALU_NOR;
      SLT:  alu_ftop = ALU_SLT;
      SLTU: alu_ftop = ALU_SLTU;
      default: alu_ftop = ALU_ADD;
    endcase
  end

endmodule
