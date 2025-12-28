/*
   --- OBSIDYEN RISC-V CORE ---

    Module : Branch Unit
    Author : Furkan YILDIRIM

    Note:
        - B-type branch talimatları için karşılaştırma işlemlerini yapar.
    
*/


module branch_unit 
    import riscv_pkg::*;
(
    input  logic [2:0]  funct3,             // Instruction'dan gelen karşılaştırma türü (BEQ, BNE...)
    input  logic        alu_zero_i,         // ALU'dan gelen Zero bayrağı
    input  logic        alu_result_lsb,     // ALU sonucunun en küçük biti (SLT/SLTU sonucu)
    input  logic        is_branch_op,        // Control Unit'ten: "Bu bir B-Type instruction mı?"

    output logic        branch_taken_o     // Branch'in gerçekleşip gerçekleşmediği
);

    logic branch_signal;

    always_comb begin
        branch_signal = 1'b0;
        
        case (funct3)
            F3_BEQ:  branch_signal = alu_zero_i;          // BEQ: Eşitse (Zero=1)
            F3_BNE:  branch_signal = !alu_zero_i;         // BNE: Eşit Değilse (Zero=0)
            F3_BLT:  branch_signal = alu_result_lsb;      // BLT: SLT sonucu 1 ise
            F3_BGE:  branch_signal = !alu_result_lsb;     // BGE: SLT sonucu 0 ise
            F3_BLTU: branch_signal = alu_result_lsb;      // BLTU
            F3_BGEU: branch_signal = !alu_result_lsb;     // BGEU
            default: branch_signal = 1'b0;
        endcase
    end

assign branch_taken_o = is_branch_op ? branch_signal : 1'b0;

endmodule
