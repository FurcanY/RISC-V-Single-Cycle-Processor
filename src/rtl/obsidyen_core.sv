/*
    OBSIDYEN RISC-V CORE
    Author : Furkan YILDIRIM

    Note:
        - şu anda riscv single cycle RV32I yapımı ile uğraşıyorum. +
        - Kendime göre bütün modülleri ayırıp yapıyorum. +
        - Daha sonar hazard unit ile beraber pipelined yapacağım. 
        - Daha sonra cache ekleme ile uğraşacağım
        - Doğruluğundan emin olduktan sonra istenilen diğer buyrukları eklemek ile uğaraşacağım.

*/


module obsidyen_core 

import riscv_pkg::*;
(
    input logic             clk_i,
    input logic             rst_ni,
    
    // debug için çıkışlar
    output logic [XLEN-1:0] pc_o,       // program counter çıkışı
    output logic [XLEN-1:0] instr_o,    // instruction çıkışı
    output logic [     4:0] reg_addr_o, // register address çıkışı
    output logic [XLEN-1:0] reg_data_o, // register veri çıkışı

    output logic            update_o

);

/* ---- SİNYALLERİN OLUŞTURULMASI ---- */

// ----Program Counter Sinyalleri----

// logic [XLEN-1:0] pc_plus4_o;         -> pc + 4 çıkış sinyali ( EK MODUL tanımlamasındadır)
// logic [XLEN-1:0] pc_plus_imm_o;      -> pc + immediate çıkış sinyali ( EK MODUL tanımlamasındadır)
// logic [XLEN-1:0] result_o;           -> ALU çıkışının sinyali ( ALU sinyallerinde tanımlandı)
logic [XLEN-1:0] pc_next_i;             // program counter'a girecek olan giriş sinyali
logic [XLEN-1:0] pc_out_o;              // program counter'ın çıkış sinyali

// ----Instruction Memory Sinyalleri----

// logic [XLEN-1:0] instr_mem_addr;     -> bu sinyal zten pc_out_o sinyalidir.
logic [XLEN-1:0] instr_mem_o;           // instruction memory'nin çıkış sinyali

// ----Register File Sinyalleri----

// logic clk_i;                         -> top module'dan gelen clk sinyalidir
// logic rst_ni;                        -> topl module'dan gelen rst_ni sinyalidir.
//logic [     4:0] rs1_addr_i;          -> instr_mem_o[19:15] sinyali zaten buraya bağlanır. 
//logic [     4:0] rs2_addr_i;          -> instr_mem_o[24:20] sinyali zaten buraya bağlanır.
//logic [     4:0] rd_addr_i;           -> instr_mem_o[11:7] sinyali zaten buraya bağlanır.
logic [XLEN-1:0] rd_data_i;             // register destination data girişidir.
logic [XLEN-1:0] rs1_data_o;            // register source 1 data çıkışıdır.
logic [XLEN-1:0] rs2_data_o;            // register source 2 data çıkışıdır.
logic reg_write_en_i;                   // register file write enable giriş siynalidir. ( Control Unit'den )


// ----Immediate Extend Unit Sinyalleri----

immediate_type_e imm_source_i;          // immediate source bilgisi ( Control Unit'den gelir )
// logic [XLEN-1:0]   imm_instruction;  -> instr_mem_o sinyali zaten buraya bağlanır.
logic [XLEN-1:0] imm_extended_o;        // immediate extend edilmiş çıkış sinyalidir


// ----Control Unit Sinyalleri----

//logic [XLEN-1:0] instruction_i;       -> instr_mem_o sinyali zaten buraya bağlanır.
logic                mem_sign_ext_o;    // data memory'ye bağlanır.
logic [1:0]          mem_size_o;
logic                mem_write_en_o;
logic                mem_read_en_o;
//immediate_type_e     imm_source_o     -> imm_source_i bu sinyaldir.
//logic                reg_write_en_o;  -> reg_write_en_i sinyali zaten buraya bağlanır.
writeback_select_e   wb_sel_o;          // write back aşamasına gidecek olan siynalin kontrol sinyali (mux çıkışı)
alu_operation_e      alu_op_o;          // ALU op kontrol sinyali
logic                is_branch_o;       // branch unit kontrol sinyali
next_pc_select_e     next_pc_sel_o;     // pc next mux'un kontrol sinyali
op_a_source_e        op_a_source_o;     // alu A girişinin mux kontrol sinyali
op_b_source_e        op_b_source_o;     // alu B girişinin mux kontrol sinyali
logic                force_alu_a_zero;  // alu op_a_i LUI komutu için 0 girişi verilir.

// ----ALU Sinyalleri----

// alu_operation_e      alu_op_i;       -> alu_op_o sinyali zaten buraya bağlanır (Control Unit Sinyali)
logic [XLEN-1:0]     op_a_i;            // ALU A giriş sinyali
logic [XLEN-1:0]     op_b_i;            // ALU B giriş sinyali
logic [XLEN-1:0]     result_o;          // ALU sonuç sinyali
logic                zero_o;            // zero flag sinyali


// ----Branch Unit Sinyalleri----

//logic [2:0]  funct3;                  -> instr_mem_o[14:12] sinyali zaten buraya bağlanır
//logic        alu_zero_i;              -> ALU'dan gelen zero_o zaten buraya bağlanır.
//logic        alu_result_lsb;          -> ALU result_o[0] sinyali zaten buraya bağlanır.
//logic        is_branch_op;            -> is_branch_o Control Unit Sinyallerinden zaten geliyor.
logic        branch_taken_o;            // branch var mı sinyalidir ( pc_next için kullanılır. )

// ----Data Memory Sinyalleri----

// logic clk_i;                         ->top module'dan gelen clk sinyalidir
// logic rst_ni;                        ->topl module'dan gelen rst_ni sinyalidir.
// logic mem_write_en_i;                -> mem_write_en_o sinyali zaten buraya bağlanır (Control Unit)
// logic [XLEN-1:0] addr_i              -> result_o sinyali zaten buraya bağlanır (ALU)
// logic [XLEN-1:0] write_data_i        -> rs2_data_o sinyali zaten buraya bağlanır (Register File)
// logic [1:0] mem_size_i               -> mem_size_o sinyali zaten buraya bağlanır (Control Unit)
// logic       mem_sign_ext_i           -> mem_sign_ext_o sinyali zaten buraya bağlanır (Control Unit)
logic [XLEN-1:0] read_data_o;           // Data Memory Veri çıkış sinyalidir.


/* ----Ek Module Sinyalleri---- */

// ----Mux Sinyalleri----
logic [XLEN-1:0] pc_plus4_o;            // pc + 4 modulünün çıkış sinyalidir.
logic [XLEN-1:0] pc_plus_imm_o;         // pc + imm modulünün çıkış sinyalidir.


/* --- EK MODULE'LARIN OLUŞTURULMASI --- */

// PC+4 
always_comb begin: pc_plus_4_module
    pc_plus4_o = pc_out_o + 32'h000_0004;
end

// PC + Imm
always_comb begin: pc_plus_imm_module
    pc_plus_imm_o = pc_out_o + imm_extended_o;
end

// PC NEXT MUX
always_comb begin: pc_next_mux_module

    if (next_pc_sel_o == NEXT_PC_ALU)
        pc_next_i = result_o;

    else if (next_pc_sel_o == NEXT_PC_IMM)
        pc_next_i = pc_plus_imm_o;

    else if (branch_taken_o)
        pc_next_i = pc_plus_imm_o;

    // default olarak pc+4 yapılır
    else
        pc_next_i = pc_plus4_o;
end

// WRITE BACK MUX
always_comb begin: write_back_mux_module
    rd_data_i = result_o;
    case(wb_sel_o)
        WB_ALU:
            rd_data_i = result_o;
        WB_MEM:
            rd_data_i = read_data_o;
        WB_PC_PLUS_4:
            rd_data_i =pc_plus4_o;
        default:
            rd_data_i = result_o;
    endcase

end

// ALU A,B MUX
always_comb begin: alu_operand_mux
    // A Operandı MUX
    if (force_alu_a_zero) begin
        op_a_i = 32'h0000_0000;  // LUI için 0
    end
    else if (op_a_source_o == ALU_SRC_PC) begin
        op_a_i = pc_out_o;       // AUIPC, JAL için PC
    end
    else begin
        op_a_i = rs1_data_o;     // Normal: Register File'dan rs1
    end
    op_b_i = (op_b_source_o == ALU_SRC_IMM) ? imm_extended_o : rs2_data_o;
end



/* --- ANA MODULE'LARIN OLUŞTURULMASI --- */

// Program Counter
program_counter pc(
    .clk_i      (clk_i),
    .rst_ni     (rst_ni),
    .pc_in_i    (pc_next_i),
    .pc_out_o   (pc_out_o)
);

// Instruction Memory
instruction_memory i_mem(
    .addr_i(pc_out_o),
    .instr_o(instr_mem_o)
);

// Register File
register_file rf (
    .clk_i           (clk_i),
    .rst_ni          (rst_ni),
    .reg_write_en_i  (reg_write_en_i),          
    .rs1_addr_i      (instr_mem_o[19:15]),        
    .rs2_addr_i      (instr_mem_o[24:20]),        
    .rd_addr_i       (instr_mem_o[11:7]),         
    .rd_data_i       (rd_data_i),    
    .rs1_data_o      (rs1_data_o),
    .rs2_data_o      (rs2_data_o) 
);

// Immediate Extend Unit
imm_extend_unit imm_ext (
    .imm_source     (imm_source_i),
    .imm_instruction(instr_mem_o),
    .imm_extended   (imm_extended_o)
);

// Control Unit
control_unit c_unit (
    .instruction_i  (instr_mem_o),
    .mem_sign_ext_o (mem_sign_ext_o),
    .mem_size_o     (mem_size_o),
    .mem_write_en_o (mem_write_en_o),
    .mem_read_en_o  (mem_read_en_o),
    .imm_source_o   (imm_source_i),
    .reg_write_en_o (reg_write_en_i),
    .wb_sel_o       (wb_sel_o),
    .alu_op_o       (alu_op_o),
    .is_branch_o    (is_branch_o),
    .next_pc_sel_o  (next_pc_sel_o),
    .op_a_source_o  (op_a_source_o),
    .op_b_source_o  (op_b_source_o),
    .force_alu_a_zero_o(force_alu_a_zero)
);

// ALU
alu alu(
    .alu_op_i   (alu_op_o),
    .op_a_i     (op_a_i),
    .op_b_i     (op_b_i),
    .result_o   (result_o),
    .zero_o     (zero_o)
);

// Branch Unit
branch_unit b_unit(
    .funct3         (instr_mem_o[14:12]),
    .alu_zero_i     (zero_o),
    .alu_result_lsb (result_o[0]),
    .is_branch_op   (is_branch_o),
    .branch_taken_o (branch_taken_o)
);

// Data Memory
data_memory d_mem(
    .clk_i          (clk_i),
    .rst_ni         (rst_ni),
    .mem_write_en_i (mem_write_en_o),
    .addr_i         (result_o),
    .write_data_i   (rs2_data_o),
    .mem_size_i     (mem_size_o),
    .mem_sign_ext_i (mem_sign_ext_o),
    .read_data_o    (read_data_o)
);


/* --- DEBUG CONTROL ISLEMLERI --- */

always_comb begin: debug_signal_module

    update_o    = 1'b1                  ; // clk senkron şekilde çıkış alacağımızdan bu sinyal hep 1 olsun.
    pc_o        = pc_out_o              ; // program counter değeri
    instr_o     = instr_mem_o           ; // instruction memory değeri
    reg_addr_o  = reg_write_en_i ? instr_mem_o[11:7] : 5'b0; // wb register address değeri
    reg_data_o  = rd_data_i             ; // wb register data değeri
end

endmodule
