module extend_immediate
    import riscv_pkg::*;
(
    input  immediate_type_e   imm_source      ,      // extend kontrol sinyali
    input  logic [XLEN-1:0]   imm_instruction ,      // Immediate kaynağı
    output logic [XLEN-1:0]   imm_extended           // Extended immediate değeri
);

    always_comb begin
        //nasıl extend edileceği control unit'den gelen sinyale göre yapılır.
        case (imm_source) 
            IMM_I: imm_extended = {{20{imm_instruction[31]}}, imm_instruction[31:20]};
            IMM_S: imm_extended = {{20{imm_instruction[31]}}, imm_instruction[31:25], imm_instruction[11:7]};
            IMM_B: imm_extended = {{19{imm_instruction[31]}}, imm_instruction[31], imm_instruction[7], imm_instruction[30:25], imm_instruction[11:8], 1'b0};
            IMM_U: imm_extended = {imm_instruction[31:12], 12'b0};   
            IMM_J: imm_extended = {{12{imm_instruction[31]}}, imm_instruction[19:12], imm_instruction[20], imm_instruction[30:21], 1'b0};
            default: imm_extended = '0;     
        endcase
    end

endmodule
