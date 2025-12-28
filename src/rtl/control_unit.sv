/*
   --- OBSIDYEN RISC-V CORE ---

    Module : Control Unit
    Author : Furkan YILDIRIM

    Note:
        -instruction bilgisini alır ve gerekli kontrol sinyallerini üretir.

        mem_sign_ext_o : load işlemlerinde işaret genişletme için kullanılır.
        mem_size_o     : memory erişim boyutunu belirtir (byte, half-word, word).
        mem_write_en_o : data memory'ye yazma işlemi için enable sinyali.

        imm_source_o   : immediate extend unit için kontrol sinyali.

        reg_write_en_o : register file'a yazma işlemi için enable sinyali.
        wb_sel_o       : write-back veri kaynağını seçer (ALU sonucu, memory verisi, PC+4).

        alu_op_o       : ALU işlemi için kontrol sinyali.

        is_branch_o    : branch işlemi için sinyal.
        next_pc_sel_o  : sonraki PC adresi seçimi (normal, jump, branch).

        op_a_source_o  : ALU'nin birinci operand kaynağını belirler (register veya pc).
        op_b_source_o  : ALU'nin ikinci operand kaynağını belirler (register veya immediate).
        
    ŞU AN İÇİN SADECE RV32I İÇİN KONTROL SİNYALLERİ ÜRETİLİYOR. 14.12.25
*/

module control_unit 
    import riscv_pkg::*;
(
    input logic [XLEN-1:0] instruction_i, 

    output logic                mem_sign_ext_o,          
    output logic [1:0]          mem_size_o,
    output logic                mem_write_en_o,
    output logic                mem_read_en_o,   // Load işlemleri için okuma sinyali

    output immediate_type_e     imm_source_o, 

    output logic                reg_write_en_o,
    output writeback_select_e   wb_sel_o,        // Geri yazma verisi seçimi

    output alu_operation_e      alu_op_o,    

    output logic                is_branch_o,             
    output next_pc_select_e     next_pc_sel_o,   // PC kaynak seçimi (JAL/JALR/Branch yönetimi)

    output op_a_source_e        op_a_source_o,
    output op_b_source_e        op_b_source_o
);

// instruction alanlarından gerekli bilgileri çıkar
instruction_t decoded_instr;

// cast edilmiş instruction
assign decoded_instr = instruction_t'(instruction_i);

always_comb begin : control_unit_logic
    // Varsayılan değerler
    mem_sign_ext_o    = 1'b0;
    mem_size_o        = 2'b00;
    mem_write_en_o    = 1'b0;
    mem_read_en_o     = 1'b0;

    imm_source_o      = IMM_NONE;

    reg_write_en_o    = 1'b0;
    wb_sel_o          = WB_ALU;      // Varsayılan ALU sonucu

    alu_op_o          = ALU_ADD;

    is_branch_o       = 1'b0;
    next_pc_sel_o     = NEXT_PC_4;   // Varsayılan PC+4

    op_a_source_o     = ALU_SRC_RD1;
    op_b_source_o     = ALU_SRC_RD2;


    case (decoded_instr.itype.opcode)

        OpcodeOp: begin : rv32i_r_type_instructions
            // R-type işlemler
            reg_write_en_o = 1'b1; // R-type işlemler register'a yazar
            // wb_sel_o zaten WB_ALU


            // funct3 bakılır, daha sonra funct7 ile ayrım yapılır
            case (decoded_instr.rtype.funct3)

                F3_ADD_SUB  : begin
                    if (decoded_instr.rtype.funct7 == F7_SUB) begin
                        alu_op_o = ALU_SUB;
                    end else begin
                        alu_op_o = ALU_ADD;
                    end
                end

                F3_SLL      :begin 
                    alu_op_o = ALU_SLL ;
                end

                F3_SLT      :begin 
                    alu_op_o = ALU_SLT ;
                end

                F3_SLTU     :begin 
                    alu_op_o = ALU_SLTU;
                end

                F3_XOR      :begin 
                    alu_op_o = ALU_XOR ;
                end
                F3_SRL_SRA  : begin
                    if (decoded_instr.rtype.funct7 == F7_SRA) begin
                        alu_op_o = ALU_SRA;
                    end else begin
                        alu_op_o = ALU_SRL;
                    end
                end
                F3_OR       :begin
                     alu_op_o = ALU_OR; 
                end
                F3_AND      :begin
                     alu_op_o = ALU_AND; 
                end
                
                default: alu_op_o = ALU_ADD; // Geçersiz funct3

            endcase 
        end

        // I-type load instructions
        OpcodeLoad: begin : rv32i_i_type_instruction_load
            
            // immediate kontrol sinyali
            imm_source_o = IMM_I;

            reg_write_en_o = 1'b1; // load işlemlerinde register'a yazma etkinleştirilir
            mem_read_en_o  = 1'b1; // Memory okuma aktif
            op_b_source_o  = ALU_SRC_IMM; // Adres hesabı için (rs1 + imm)
            
            wb_sel_o       = WB_MEM;      // Memory'den okunan veri yazılacak

            //funct 3e göre ayrılırlar
            case (decoded_instr.itype.funct3)
                F3_LB : begin
                    mem_size_o     = 2'b00; // byte
                    mem_sign_ext_o = 1'b1;  // işaret genişletme
                end
                F3_LH : begin
                    mem_size_o     = 2'b01; // half-word
                    mem_sign_ext_o = 1'b1;  // işaret genişletme
                end
                F3_LW : begin
                    mem_size_o     = 2'b10; // word
                    mem_sign_ext_o = 1'b0;  // işaret genişletme yok
                end
                F3_LBU: begin
                    mem_size_o     = 2'b00; // byte
                    mem_sign_ext_o = 1'b0;  // sıfır genişletme
                end
                F3_LHU: begin
                    mem_size_o     = 2'b01; // half-word
                    mem_sign_ext_o = 1'b0;  // sıfır genişletme
                end
                default: ; // no operation
            endcase
        end

        // I-type immediate instructions
        OpcodeOpImm: begin : rv32i_i_type_instruction_imm
            
            // immediate kontrol sinyali
            imm_source_o = IMM_I;

            reg_write_en_o = 1'b1; // immediate işlemler register'a yazar
            op_b_source_o  = ALU_SRC_IMM; // ikinci operand immediate
            // wb_sel_o zaten WB_ALU

            // funct3 bakılır, daha sonra funct7 ile ayrım yapılır
            case (decoded_instr.itype.funct3)
                F3_ADDI      : begin
                    alu_op_o = ALU_ADD;
                end

                F3_SLTI      : begin
                    alu_op_o = ALU_SLT;
                end

                F3_SLTIU     : begin
                    alu_op_o = ALU_SLTU;
                end

                F3_XORI      : begin
                    alu_op_o = ALU_XOR;
                end

                F3_ORI       : begin
                    alu_op_o = ALU_OR;
                end

                F3_ANDI      : begin
                    alu_op_o = ALU_AND;
                end

                F3_SLLI      : begin
                    alu_op_o = ALU_SLL;
                end

                F3_SRLI_SRAI : begin
                    if (decoded_instr.rtype.funct7 == F7_SRAI) begin
                        alu_op_o = ALU_SRA;
                    end
                    else begin
                        alu_op_o = ALU_SRL;
                    end
                end // Düzeltme: Fazladan parantez silindi

                default: ; // no operation
            endcase 
        end

        // I-type jalr instruction
        OpcodeJalr: begin : rv32i_i_type_instruction_jalr
            
            // immediate kontrol sinyali
            imm_source_o = IMM_I;

            case (decoded_instr.itype.funct3)
                F3_JALR: begin
                    // is_jalr_o yerine next_pc_sel_o kullanıyoruz
                    next_pc_sel_o  = NEXT_PC_ALU; 
                    
                    reg_write_en_o = 1'b1; // jalr da registera yazar
                    alu_op_o       = ALU_ADD; // ALU toplama yapar
                    op_b_source_o  = ALU_SRC_IMM; // ikinci operand immediate
                    
                    wb_sel_o       = WB_PC_PLUS_4; // Dönüş adresi PC+4
                end
                default: ; // no operation  
            endcase
        end

        // I-type system daha sonra eklenecek
        /*
            OpcodeSystem: begin : rv32i_i_type_instruction_system
                // eklenecek
                ...
                ...
            end
        */


        // S-type store instructions
        OpcodeStore: begin : rv32i_s_type_instructions

            // immediate kontrol sinyali
            imm_source_o = IMM_S;
            
            op_b_source_o = ALU_SRC_IMM; // Düzeltme: Store için adres hesabında IMM gerekir

            mem_write_en_o = 1'b1; // store işlemlerinde memory'ye yazma etkinleştirilir

            // funct3 bakılır
            case (decoded_instr.stype.funct3)
                F3_SB: begin
                    mem_size_o = 2'b00; // byte
                end
                F3_SH: begin
                    mem_size_o = 2'b01; // half-word
                end
                F3_SW: begin
                    mem_size_o = 2'b10; // word
                end
                default: ; // no operation
            endcase
        end

        // B-type branch instructions
        OpcodeBranch: begin : rv32i_b_type_instructions

            // immediate kontrol sinyali
            imm_source_o = IMM_B;

            is_branch_o = 1'b1; // branch işlemlerinde branch sinyali

            // next_pc_sel_o varsayılan NEXT_PC_4 kalır, 
            // Core modülünde branch_taken sinyaline göre karar verilir.

            // funct3 bakılır
            case (decoded_instr.stype.funct3)
                F3_BEQ : begin
                    alu_op_o = ALU_SUB;
                end
                F3_BNE : begin
                    alu_op_o = ALU_SUB;
                end
                F3_BLT : begin
                    alu_op_o = ALU_SLT;
                end
                F3_BGE : begin
                    alu_op_o = ALU_SLT;
                end
                F3_BLTU: begin
                    alu_op_o = ALU_SLTU;
                end
                F3_BGEU: begin
                    alu_op_o = ALU_SLTU;
                end
                default: alu_op_o= ALU_ADD ; // no operation
            endcase
        end 

        // U-type instuructions
        OpcodeLui: begin : rv32i_u_type_instruction_lui
            // immediate kontrol sinyali
            imm_source_o = IMM_U;

            reg_write_en_o = 1'b1;        // register'a yazar
            alu_op_o       = ALU_ADD;     // LUI için ALU işlemine gerek yok, default ADD
            op_b_source_o  = ALU_SRC_IMM; // ikinci operand immediate
            // wb_sel_o -> WB_ALU
        end

        OpcodeAuipc: begin : rv32i_u_type_instruction_auipc
            // immediate kontrol sinyali
            imm_source_o = IMM_U;

            reg_write_en_o = 1'b1;        // register'a yazar
            alu_op_o       = ALU_ADD;     // toplama işlemi AUIPC için kullanılır.
            op_a_source_o  = ALU_SRC_PC;  // AUIPC için A operandı PC olmalı
            op_b_source_o  = ALU_SRC_IMM; // ikinci operand immediate
            // wb_sel_o -> WB_ALU
        end

        // J-type jal instruction
        OpcodeJal: begin : rv32i_j_type_instruction_jal
            // immediate kontrol sinyali
            imm_source_o = IMM_J;
            
            // JAL için pc+imm 
            next_pc_sel_o  = NEXT_PC_IMM;

            reg_write_en_o = 1'b1; // jal da registera yazar
            alu_op_o       = ALU_ADD; // ALU toplama yapar
            op_b_source_o  = ALU_SRC_IMM; // ikinci operand immediate
            
            wb_sel_o       = WB_PC_PLUS_4; // Dönüş adresi PC+4
        end

        default: ; // no operation


    endcase // opcode endcase

end // always_comb

endmodule
