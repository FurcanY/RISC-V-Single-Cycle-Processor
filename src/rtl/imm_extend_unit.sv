/*
   --- OBSIDYEN RISC-V CORE ---

    Module : Immediate extend unit modülü
    Author : Furkan YILDIRIM

    
*/


module imm_extend_unit 
    import riscv_pkg::*;
(
    input  immediate_type_e   imm_source      ,      // extend kontrol sinyali
    input  logic [XLEN-1:0]   imm_instruction ,      // Immediate kaynağı
    output logic [XLEN-1:0]   imm_extended           // Extended immediate değeri
);


always_comb begin : imm_extend_logic
    case (imm_source)
        IMM_I: begin
            // I-type immediate (12 bit)
            imm_extended = {{20{imm_instruction[31]}}, imm_instruction[31:20]};
        end
        IMM_S: begin
            // S-type immediate (12 bit)
            imm_extended = {{20{imm_instruction[31]}}, imm_instruction[31:25], imm_instruction[11:7]};
        end
        IMM_B: begin
            // B-type immediate (13 bit)
            imm_extended = {{20{imm_instruction[31]}}, imm_instruction[7], imm_instruction[30:25], imm_instruction[11:8], 1'b0};
        end
        IMM_U: begin
            // U-type immediate (20 bit)
            imm_extended = {imm_instruction[31:12], 12'b0};
        end
        IMM_J: begin
            // J-type immediate (21 bit)
            imm_extended = {{12{imm_instruction[31]}}, imm_instruction[19:12], imm_instruction[20], imm_instruction[30:21], 1'b0};
        end
        default: begin
            imm_extended = 32'hDEADBEEF; // Hata durumu için belirgin bir değer
        end
    endcase
end

endmodule
