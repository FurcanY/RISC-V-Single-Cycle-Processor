module control_unit
	import riscv_pkg::*;
(
	input  logic [6:0] opcode           ,
	input  logic [2:0] funct3           ,
	input  logic [6:0] funct7           ,
    input  logic        zero_flag       , 
    input  logic        negative_flag   , 
    input  logic        carry_flag      , 
    input  logic        overflow_flag   , 

	// ALU kontrol sinyalleri
	output alu_op_e    alu_control      ,
	output alu_src_a_e alu_src_a_sel    , // 00=register / 01=program counter / 10=sıfır 
	output alu_src_b_e alu_src_b_sel    , // 0=register seçimi / 1=immediate seçimi

	

	// Register dosyası kontrol sinyalleri
	output logic        reg_write_enable,

	// Bellek kontrol sinyalleri
	output logic        mem_read        ,
	output logic 		mem_write       ,
	output mem_size_e	mem_size        ,    // 00: byte, 01: yarım kelime, 10: kelime
	output logic        mem_usign_load  ,    // 1: işaretsiz yükleme, 0: işaretli yükleme

	// Immediate kontrol sinyali
	output immediate_type_e imm_src    ,

	// Program sayacı kontrol sinyali
	output pc_src_e 	pc_src          ,

	// Sonuç kaynağı kontrol sinyali
	output result_src_e result_src      
);

	// Branch kontrol sinyalleri
	logic        branch_taken    ; // Branch'in alınıp alınmadığını gösteren sinyal



	// Opcode decoder
	always_comb begin

		//varsayılan değerler
		alu_control      = ALU_ADD;
		alu_src_a_sel    = ALU_SRC_A_RS1;
		alu_src_b_sel    = ALU_SRC_B_RS2;
		branch_taken     = 1'b0;
		reg_write_enable = 1'b0;
		mem_read         = 1'b0;
		mem_write        = 1'b0;
		mem_size         = MEM_WORD;
		mem_usign_load   = 1'b0;
		imm_src          = IMM_I;
		pc_src           = PC_SRC_PC4;
		result_src       = RESULT_SRC_ALU;

		case (opcode)
			OPCODE_LUI: begin
				reg_write_enable = 1;
				alu_src_a_sel 	 = ALU_SRC_A_ZERO;
				alu_src_b_sel    = ALU_SRC_B_IMM;
				imm_src         = IMM_U;
				result_src       = RESULT_SRC_ALU;
			end

			OPCODE_AUIPC: begin
				alu_control      = ALU_AUIPC;
				alu_src_a_sel    = ALU_SRC_A_PC;
				alu_src_b_sel    = ALU_SRC_B_IMM;
				reg_write_enable = 1'b1;
				imm_src         = IMM_U;
				result_src       = RESULT_SRC_ALU;
			end

			OPCODE_JAL: begin
				alu_src_a_sel    = ALU_SRC_A_PC;
				alu_src_b_sel    = ALU_SRC_B_IMM;
				reg_write_enable = 1'b1;
				imm_src         = IMM_J;
				pc_src           = PC_SRC_BRANCH_JAL;
				result_src       = RESULT_SRC_PC4;
			end

			OPCODE_JALR: begin
				alu_src_a_sel    = ALU_SRC_A_RS1;
				alu_src_b_sel    = ALU_SRC_B_IMM;
				reg_write_enable = 1'b1;
				imm_src         = IMM_I;
				pc_src           = PC_SRC_JALR;
				result_src       = RESULT_SRC_PC4;
			end

			OPCODE_BRANCH: begin
				alu_control      = ALU_SUB; 
				alu_src_a_sel    = ALU_SRC_A_RS1;
				alu_src_b_sel    = ALU_SRC_B_RS2;
				imm_src          = IMM_B;
				
				case (funct3)
					FUNCT3_BEQ:  branch_taken = zero_flag;                    // rs1 == rs2
					FUNCT3_BNE:  branch_taken = ~zero_flag;                   // rs1 != rs2
					FUNCT3_BLT:  branch_taken = negative_flag ^ overflow_flag; // rs1 < rs2 (signed)
					FUNCT3_BGE:  branch_taken = ~(negative_flag ^ overflow_flag); // rs1 >= rs2 (signed)
					FUNCT3_BLTU: branch_taken = carry_flag;                   // rs1 < rs2 (unsigned)
					FUNCT3_BGEU: branch_taken = ~carry_flag;                  // rs1 >= rs2 (unsigned)
					default:     branch_taken = 1'b0;
				endcase
				pc_src           = (branch_taken == 1) ? PC_SRC_BRANCH_JAL: PC_SRC_PC4;
			end

			OPCODE_LOAD: begin
				alu_src_a_sel    = ALU_SRC_A_RS1;
				alu_src_b_sel    = ALU_SRC_B_IMM;
				reg_write_enable = 1'b1;
				mem_read         = 1'b1;
				imm_src         = IMM_I;
				result_src       = RESULT_SRC_MEM;
				case (funct3)
					FUNCT3_LB:  begin mem_size = MEM_BYTE;  mem_usign_load = 0; end
					FUNCT3_LH:  begin mem_size = MEM_HALFW; mem_usign_load = 0; end
					FUNCT3_LW:  begin mem_size = MEM_WORD;  mem_usign_load = 0; end
					FUNCT3_LBU: begin mem_size = MEM_BYTE;  mem_usign_load = 1; end
					FUNCT3_LHU: begin mem_size = MEM_HALFW; mem_usign_load = 1; end
					default:    begin mem_size = MEM_WORD;  mem_usign_load = 0; end
				endcase
			end

			OPCODE_STORE: begin
				alu_src_a_sel    = ALU_SRC_A_RS1;
				alu_src_b_sel    = ALU_SRC_B_IMM;
				mem_write        = 1'b1;
				imm_src         = IMM_S;
				case (funct3)
					FUNCT3_SB: begin mem_size = MEM_BYTE;  end
					FUNCT3_SH: begin mem_size = MEM_HALFW; end
					FUNCT3_SW: begin mem_size = MEM_WORD;  end
					default:   begin mem_size = MEM_WORD;  end
				endcase
			end

			OPCODE_I_TYPE: begin
				alu_src_a_sel    = ALU_SRC_A_RS1;
				alu_src_b_sel    = ALU_SRC_B_IMM;
				reg_write_enable = 1'b1;
				imm_src         = IMM_I;
				result_src       = RESULT_SRC_ALU;
				case (funct3)
					FUNCT3_ADDI:  alu_control = ALU_ADD;
					FUNCT3_SLTI:  alu_control = ALU_SLT;
					FUNCT3_SLTIU: alu_control = ALU_SLTU;
					FUNCT3_XORI:  alu_control = ALU_XOR;
					FUNCT3_ORI:   alu_control = ALU_OR;
					FUNCT3_ANDI:  alu_control = ALU_AND;
					FUNCT3_SLLI:  alu_control = ALU_SLL;
					FUNCT3_SRLI:  alu_control = (funct7[5]) ? ALU_SRA : ALU_SRL;
					default:      alu_control = ALU_ADD;
				endcase
			end

			OPCODE_R_TYPE: begin
				alu_src_a_sel    = ALU_SRC_A_RS1;
				alu_src_b_sel    = ALU_SRC_B_RS2;
				reg_write_enable = 1'b1;
				result_src       = RESULT_SRC_ALU;
				case (funct3)
					FUNCT3_ADD:  alu_control = (funct7[5]) ? ALU_SUB : ALU_ADD;
					FUNCT3_SLL:  alu_control = ALU_SLL;
					FUNCT3_SLT:  alu_control = ALU_SLT;
					FUNCT3_SLTU: alu_control = ALU_SLTU;
					FUNCT3_XOR:  alu_control = ALU_XOR;
					FUNCT3_SRL:  alu_control = (funct7[5]) ? ALU_SRA : ALU_SRL;
					FUNCT3_OR:   alu_control = ALU_OR;
					FUNCT3_AND:  alu_control = ALU_AND;
					default:     alu_control = ALU_ADD;
				endcase
			end

			default: begin
				// Varsayılan değerler kullanılır
			end
		endcase
	end

endmodule
