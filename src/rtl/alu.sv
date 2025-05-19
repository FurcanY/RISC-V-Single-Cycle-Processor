/*
    --- Aritmetik Mantık Birimi (ALU) ---
    ALU, RISC-V RV32I işlemcisinin temel aritmetik ve mantık işlemlerini gerçekleştirir.
    
    Desteklenen İşlemler:
    1. Aritmetik İşlemler
        - ADD  : İki sayının toplanması (add, addi)
        - SUB  : İki sayının çıkarılması (sub) 
        - SLT  : İşaretli karşılaştırma (slt, slti)     -> rd = (rs1 <0)
        - SLTU : İşaretsiz karşılaştırma (sltu, sltiu)  -> rd = (rs1 ≠0)
        
    2. Mantık İşlemleri
        - AND  : Bit düzeyinde VE işlemi   (and, andi)
        - OR   : Bit düzeyinde VEYA işlemi (or, ori) 
        - XOR  : Bit düzeyinde XOR işlemi  (xor, xori)
        
    3. Kaydırma İşlemleri
        - SLL  : Mantıksal sola kaydırma (sll, slli)
        - SRL  : Mantıksal sağa kaydırma (srl, srli) 
        - SRA  : Aritmetik sağa kaydırma (sra, srai) 
        
    Bayraklar:
    - zero_flag    : Sonuç sıfır ise 1 (beq, bne için)
    - negative_flag: Sonuç negatif ise 1 (blt, bge için)
    - carry_flag   : İşaretsiz taşma durumu (bltu, bgeu için)
    - overflow_flag: İşaretli taşma durumu:
        işaretli taşma -> 
            -iki negatif sayıyı topladın pozitif çıktı
            -iki pozitif sayıyı topladın negatif çıktı
*/

module alu 
    import riscv_pkg::*;
(
    input  logic [XLEN-1:0] source_a,
    input  logic [XLEN-1:0] source_b,
    input  alu_op_e         alu_control,

    output logic [XLEN-1:0] alu_result,
    output logic            zero_flag,
    output logic            negative_flag,
    output logic            carry_flag,
    output logic            overflow_flag
);

    logic [XLEN:0] temp_result;

    always_comb begin
        temp_result     = 0;
        alu_result      = 0;
        zero_flag       = 0;
        negative_flag   = 0;
        carry_flag      = 0;
        overflow_flag   = 0;

        case (alu_control)
            ALU_ADD: begin
                temp_result    = source_a + source_b;
                alu_result     = temp_result[XLEN-1:0];
                carry_flag     = temp_result[XLEN];
                overflow_flag  = (source_a[XLEN-1] == source_b[XLEN-1]) &&
                                 (alu_result[XLEN-1] != source_a[XLEN-1]);
            end

            ALU_SUB: begin
                temp_result    = source_a - source_b;
                alu_result     = temp_result[XLEN-1:0];
                carry_flag     = temp_result[XLEN];
                overflow_flag  = (source_a[XLEN-1] != source_b[XLEN-1]) &&
                                 (alu_result[XLEN-1] != source_a[XLEN-1]);
            end

            ALU_AND:  alu_result = source_a & source_b;
            ALU_OR:   alu_result = source_a | source_b;
            ALU_XOR:  alu_result = source_a ^ source_b;
            ALU_SLL:  alu_result = source_a << source_b[4:0];
            ALU_SRL:  alu_result = source_a >> source_b[4:0];
            ALU_SRA:  alu_result = $signed(source_a) >>> source_b[4:0];
            ALU_SLT:  alu_result = ($signed(source_a) < $signed(source_b)) ? 32'd1 : 32'd0;
            ALU_SLTU: alu_result = (source_a < source_b) ? 32'd1 : 32'd0;

            default: alu_result = 32'd0;
        endcase

        zero_flag     = (alu_result == 0);
        negative_flag = alu_result[XLEN-1];
    end

endmodule
