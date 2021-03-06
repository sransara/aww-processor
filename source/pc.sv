`include "pc_if.vh"
`include "cpu_types_pkg.vh"

module pc
import cpu_types_pkg::*;
(
  input logic CLK, nRST,
  pc_if.pci pcif
);

parameter PC_INIT = 0;
assign pcif.pc_plus = pcif.cpc + WBYTES;

always_ff @(posedge CLK, negedge nRST)
begin
  if(!nRST)
  begin
    pcif.cpc <= PC_INIT;
  end
  else if(pcif.WEN) begin
    pcif.cpc <= pcif.npc;
  end
end

endmodule
