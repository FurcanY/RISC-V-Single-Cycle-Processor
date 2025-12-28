/*
   --- OBSIDYEN RISC-V CORE ---

    Module : Program counter modülü
    Author : Furkan YILDIRIM
    
*/

module program_counter 

import riscv_pkg::*;
(
    input logic clk_i,
    input logic rst_ni,
    input logic [XLEN-1:0] pc_in_i,
    output logic [XLEN-1:0] pc_out_o
);


    always_ff @(posedge clk_i or negedge rst_ni) begin
        if (!rst_ni) begin
            pc_out_o <= 32'h8000_0000;   // default reset address
        end else begin
            pc_out_o <= pc_in_i;
        end
    end

    
endmodule
