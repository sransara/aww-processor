`ifndef CONTROL_UNIT_IF_VH
`define CONTROL_UNIT_IF_VH

// all types
`include "cpu_types_pkg.vh"

interface control_unit_if;
  // import types
  import cpu_types_pkg::*;

  opcode_t opcode;
  funct_t funct;
  aluop_t aluop;
  logic RegDst, RegWr, ImmToReg;
  logic DataRead, DataWrite;
  logic BrEq, BrNeq, Jump, Jal, Jr;
  logic ExtOp, Halt;
  logic ShamToAlu, ImmToAlu;
  logic LinkedLoad, StoreConditional;

  // ports
  modport ci (
    input   opcode,
    input   funct,
    output  aluop,
    output  RegDst, RegWr, ImmToReg,
    output  DataRead, DataWrite,
    output  ShamToAlu, ImmToAlu,
    output  BrEq, BrNeq, Jump, Jal, Jr,
    output  ExtOp, Halt,
    output  LinkedLoad, StoreConditional
  );

endinterface

`endif //CONTROL_UNIT_IF
