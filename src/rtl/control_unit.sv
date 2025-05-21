module control_unit
	import riscv_pkg::*;
(
	input  logic [6:0] opcode,
	input  logic [2:0] funct3,
	input  logic [6:0] funct7,

	// ALU control
	output alu_op_e    alu_control,
	output alu_src_a_e alu_src_a_sel,
	output alU_src_b_e alu_src_b_sel,

	// Branch control
	output branch_type_e branch_type,
	output pc_src_e     pc_src,

	// Register file control
	output logic        reg_write,
	output logic        reg_src_sel,  // 0: ALU result, 1: Memory data
	output logic        reg_pc4_sel,  // 0: Normal result, 1: PC+4

	// Memory control
	output logic        mem_read,
	output logic        mem_write,
	output logic [2:0]  mem_width,    // 000: byte, 001: half, 010: word

	// Immediate control
	output immediate_type_e imm_type
);

	always_comb begin
		// Default values
		alu_control    = ALU_ADD;
		alu_src_a_sel  = ALU_SRC_A_RS1;
		alu_src_b_sel  = ALU_SRC_B_RS2;
		branch_type    = BRANCH_NONE;
		pc_src         = PC_SRC_PC4;
		reg_write      = 1'b0;
		reg_src_sel    = 1'b0;
		reg_pc4_sel    = 1'b0;
		mem_read       = 1'b0;
		mem_write      = 1'b0;
		mem_width      = 3'b010;  // Default to word
		imm_type       = IMM_I;

		case (opcode)
			OPCODE_R_TYPE: begin
				reg_write = 1'b1;
				case (funct3)
					3'b000: alu_control = (funct7[5]) ? ALU_SUB : ALU_ADD;
					3'b001: alu_control = ALU_SLL;
					3'b010: alu_control = ALU_SLT;
					3'b011: alu_control = ALU_SLTU;
					3'b100: alu_control = ALU_XOR;
					3'b101: alu_control = (funct7[5]) ? ALU_SRA : ALU_SRL;
					3'b110: alu_control = ALU_OR;
					3'b111: alu_control = ALU_AND;
				endcase
			end

			OPCODE_I_TYPE: begin
				reg_write = 1'b1;
				alu_src_b_sel = ALU_SRC_B_IMM;
				imm_type = IMM_I;
				case (funct3)
					3'b000: alu_control = ALU_ADD;  // ADDI
					3'b001: alu_control = ALU_SLL;  // SLLI
					3'b010: alu_control = ALU_SLT;  // SLTI
					3'b011: alu_control = ALU_SLTU; // SLTIU
					3'b100: alu_control = ALU_XOR;  // XORI
					3'b101: alu_control = (funct7[5]) ? ALU_SRA : ALU_SRL; // SRAI/SRLI
					3'b110: alu_control = ALU_OR;   // ORI
					3'b111: alu_control = ALU_AND;  // ANDI
				endcase
			end

			OPCODE_LOAD: begin
				reg_write = 1'b1;
				reg_src_sel = 1'b1;  // Memory to register
				mem_read = 1'b1;
				alu_src_b_sel = ALU_SRC_B_IMM;
				imm_type = IMM_I;
				case (funct3)
					3'b000: mem_width = 3'b000;  // LB
					3'b001: mem_width = 3'b001;  // LH
					3'b010: mem_width = 3'b010;  // LW
					3'b100: mem_width = 3'b000;  // LBU
					3'b101: mem_width = 3'b001;  // LHU
				endcase
			end

			OPCODE_STORE: begin
				mem_write = 1'b1;
				alu_src_b_sel = ALU_SRC_B_IMM;
				imm_type = IMM_S;
				case (funct3)
					3'b000: mem_width = 3'b000;  // SB
					3'b001: mem_width = 3'b001;  // SH
					3'b010: mem_width = 3'b010;  // SW
				endcase
			end

			OPCODE_BRANCH: begin
				imm_type = IMM_B;
				case (funct3)
					3'b000: branch_type = BRANCH_EQ;   // BEQ
					3'b001: branch_type = BRANCH_NE;   // BNE
					3'b100: branch_type = BRANCH_LT;   // BLT
					3'b101: branch_type = BRANCH_GE;   // BGE
					3'b110: branch_type = BRANCH_LTU;  // BLTU
					3'b111: branch_type = BRANCH_GEU;  // BGEU
				endcase
				pc_src = PC_SRC_BRANCH;
			end

			OPCODE_JAL: begin
				reg_write = 1'b1;
				reg_pc4_sel = 1'b1;  // Use PC+4 for register write
				imm_type = IMM_J;
				pc_src = PC_SRC_JAL;
			end

			OPCODE_JALR: begin
				reg_write = 1'b1;
				reg_pc4_sel = 1'b1;  // Use PC+4 for register write
				imm_type = IMM_I;
				pc_src = PC_SRC_JALR;
			end

			OPCODE_LUI: begin
				reg_write = 1'b1;
				alu_control = ALU_LUI;
				alu_src_a_sel = ALU_SRC_A_ZERO;
				alu_src_b_sel = ALU_SRC_B_IMM;
				imm_type = IMM_U;
			end

			OPCODE_AUIPC: begin
				reg_write = 1'b1;
				alu_control = ALU_AUIPC;
				alu_src_a_sel = ALU_SRC_A_PC;
				alu_src_b_sel = ALU_SRC_B_IMM;
				imm_type = IMM_U;
			end
		endcase
	end

endmodule
