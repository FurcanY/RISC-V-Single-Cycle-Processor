package riscv_pkg;

// Genel parametreler
parameter int XLEN = 32;
parameter int REG_ADDR_WIDTH = 5;
parameter int MEM_SIZE = 1024;



/*
    --- Instruction OPCODE'lar
    --  grup olarak opcode'lar aynı olup ayırt etmey funct3 ve funct7'de yapılır.
*/
localparam logic [6:0]
OPCODE_LUI     = 7'b0110111,
OPCODE_AUIPC   = 7'b0010111,
OPCODE_JAL     = 7'b1101111,
OPCODE_JALR    = 7'b1100111,
OPCODE_BRANCH  = 7'b1100011,
OPCODE_LOAD    = 7'b0000011,
OPCODE_STORE   = 7'b0100011,
OPCODE_I_TYPE  = 7'b0010011,
OPCODE_R_TYPE  = 7'b0110011;


/*
    --- Instruction funct3

*/
localparam logic [2:0]
FUNCT3_JALR    = 3'b000,
FUNCT3_BEQ     = 3'b000,
FUNCT3_BNE     = 3'b001,
FUNCT3_BLT     = 3'b100,
FUNCT3_BGE     = 3'b101,
FUNCT3_BLTU    = 3'b110,
FUNCT3_BGEU    = 3'b111,
FUNCT3_LB      = 3'b000,
FUNCT3_LH      = 3'b001,
FUNCT3_LW      = 3'b010,
FUNCT3_LBU     = 3'b100,
FUNCT3_LHU     = 3'b101,
FUNCT3_SB      = 3'b000,
FUNCT3_SH      = 3'b001,
FUNCT3_SW      = 3'b010,
FUNCT3_ADDI    = 3'b000,
FUNCT3_SLTI    = 3'b010,
FUNCT3_SLTIU   = 3'b011,
FUNCT3_XORI    = 3'b100,
FUNCT3_ORI     = 3'b110,
FUNCT3_ANDI    = 3'b111,
FUNCT3_SLLI    = 3'b001,
FUNCT3_SRLI    = 3'b101,
FUNCT3_SRAI    = 3'b101,
FUNCT3_ADD     = 3'b000,
FUNCT3_SUB     = 3'b000,
FUNCT3_SLL     = 3'b001,
FUNCT3_SLT     = 3'b010,
FUNCT3_SLTU    = 3'b011,
FUNCT3_XOR     = 3'b100,
FUNCT3_SRL     = 3'b101,
FUNCT3_SRA     = 3'b101,
FUNCT3_OR      = 3'b110,
FUNCT3_AND     = 3'b111;


/*
    --- Instruction funct7

*/
localparam logic [6:0]
FUNCT7_SLLI    = 7'b0000000,
FUNCT7_SRLI    = 7'b0000000,
FUNCT7_SRAI    = 7'b0100000,
FUNCT7_ADD     = 7'b0000000,
FUNCT7_SUB     = 7'b0100000,
FUNCT7_SLT     = 7'b0000000,
FUNCT7_SLL     = 7'b0000000,
FUNCT7_SLTU    = 7'b0000000,
FUNCT7_XOR     = 7'b0000000,
FUNCT7_SRL     = 7'b0000000,
FUNCT7_SRA     = 7'b0100000,
FUNCT7_OR      = 7'b0000000,
FUNCT7_AND     = 7'b0000000;
/*

/*
    --- Instruction Immediate türleri
    - Immediate extend unit içerisinde bu enum ile extend biçimi ayarlanır.
*/
typedef enum logic [2:0] { 
    IMM_I = 3'b000,
    IMM_S = 3'b001,
    IMM_B = 3'b010,
    IMM_U = 3'b011,
    IMM_J = 3'b100  
} immediate_type_e;

/*
    --- ALU kontrol sinyalleri
    - op'code göre alunun hangi işlemi yaapacağını söyler.
*/
typedef enum logic [3:0] {  
    ALU_ADD  = 4'b0000,
    ALU_SUB  = 4'b0001,
    ALU_AND  = 4'b0010,
    ALU_OR   = 4'b0011,
    ALU_XOR  = 4'b0100,
    ALU_SLL  = 4'b0101,
    ALU_SRL  = 4'b0110,
    ALU_SRA  = 4'b0111,
    ALU_SLT  = 4'b1000,
    ALU_SLTU = 4'b1001
}alu_op_e;   
endpackage : riscv_pkg
