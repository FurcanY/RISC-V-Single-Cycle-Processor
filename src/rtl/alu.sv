/*
   --- OBSIDYEN RISC-V CORE ---

    Module : Arithmetic Logic Unit (modülü
    Author : Furkan YILDIRIM

    Note:
        - ALU işlemleri: ADD,SUB,SLL,SLT,SLTU,XOR,SRL,SRA,OR,AND
        - I işlemleri ALU dışında handledilir
        - Zero flag çıkışı branch birimi için kullanılır.
    
*/



module alu 
    import riscv_pkg::*;
(
    input  alu_operation_e      alu_op_i,   // Kontrol sinyali
    input  logic [XLEN-1:0]     op_a_i,
    input  logic [XLEN-1:0]     op_b_i,
    output logic [XLEN-1:0]     result_o,
    output logic                zero_o       // Branch için
);

    logic [31:0]                adder_result;
    logic                       adder_cout;         // carry out
    logic [31:0]                operand_b_mux;      // Sub işlemine göre B'nin complementi
    logic                       adder_cin;         // carry in
    logic                       is_sub;           // çıkarma işlemi mi?




    
    // Çıkarma veya Karşılaştırma yapıyorsak B'nin tersini alacağız (2's complement)
    assign is_sub = (alu_op_i == ALU_SUB || alu_op_i == ALU_SLT || alu_op_i == ALU_SLTU);

    assign operand_b_mux = is_sub ? ~op_b_i : op_b_i;
    assign adder_cin     = is_sub ? 1'b1    : 1'b0;

    // Tek bir Adder bloğu
    assign {adder_cout, adder_result} = {1'b0, op_a_i} + {1'b0, operand_b_mux} + {{32{1'b0}}, adder_cin};


    // 2. Karşılaştırma Mantığı (SLT, SLTU)
    logic slt_result;
    logic sltu_result;

    // İşaretsiz karşılaştırma (Carry out)
    assign sltu_result = !adder_cout; 
    
    // İşaretli karşılaştırma (XOR mantığı: Overflow varsa işaret ters döner)
    // A < B (signed) mantığı: (A[31] != B[31]) ? A[31] : (A-B)[31]
    assign slt_result = (op_a_i[31] ^ op_b_i[31]) ? op_a_i[31] : adder_result[31];


    always_comb begin
        result_o = '0; // Default
        
        case (alu_op_i)
            // Aritmetik
            ALU_ADD, ALU_SUB: result_o = adder_result;
            
            // Karşılaştırma
            ALU_SLT:          result_o = {31'b0, slt_result};
            ALU_SLTU:         result_o = {31'b0, sltu_result};

            // Mantıksal
            ALU_AND:          result_o = op_a_i & op_b_i;
            ALU_OR:           result_o = op_a_i | op_b_i;
            ALU_XOR:          result_o = op_a_i ^ op_b_i;

            // Kaydırma ( Shift )
            // Not: SystemVerilog >>> operatörü signed ise aritmetik kaydırır.
            ALU_SLL:          result_o = op_a_i << op_b_i[4:0];
            ALU_SRL:          result_o = op_a_i >> op_b_i[4:0];
            ALU_SRA:          result_o = $signed(op_a_i) >>> op_b_i[4:0];

            // RV32B Geldiğinde buraya yeni case'ler eklenir
            // ALU_ROL: ...
            
            default:          result_o = '0;
        endcase
    end

    // Zero Flag (Branch Unit için)
    assign zero_o = (result_o == 32'b0);

endmodule
