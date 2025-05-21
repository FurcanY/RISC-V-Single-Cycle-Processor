// module control_unit 
// 	import riscv_pkg::*;
// (
// 	input  logic [6:0]      opcode,
// 	input  logic [2:0]      funct3,
// 	input  logic [6:0]      funct7,
// 	input  logic            zero_flag,
// 	input  logic            negative_flag,
// 	input  logic            carry_flag,
// 	input  logic            overflow_flag,

// 	output logic            pc_src,
// 	output logic [1:0]      result_src,
// 	output logic            mem_write,
// 	output alu_op_e         alu_control,
// 	output logic            alu_src,
// 	output immediate_type_e imm_src,
// 	output logic            reg_write
// );

// 	always_comb begin : opcode_decoder
// 		pc_src = 0;
// 		result_src = 0;
// 		mem_write = 0;
// 		alu_control = 0;	
// 		alu_src = 0;
// 		imm_src = 0;
// 		reg_write = 0;

// 		case (opcode)
// 			OPCODE_LUI: begin
// 				imm_src = IMM_U;
// 				alu_control = ALU_ADD;
// 				reg_write = 1;
// 			end
			
			
// 		endcase
// 	end
// endmodule
// module control_unit 
// 	import riscv_pkg::*;
// (
// 	input  logic [6:0]      opcode,
// 	input  logic [2:0]      funct3,
// 	input  logic [6:0]      funct7,
// 	input  logic            zero_flag,
// 	input  logic            negative_flag,
// 	input  logic            carry_flag,
// 	input  logic            overflow_flag,

// 	output logic            pc_src,
// 	output logic [1:0]      result_src,
// 	output logic            mem_write,
// 	output alu_op_e         alu_control,
// 	output logic            alu_src,
// 	output immediate_type_e imm_src,
// 	output logic            reg_write
// );

// 	always_comb begin : opcode_decoder
// 		pc_src = 0;
// 		result_src = 0;
// 		mem_write = 0;
// 		alu_control = 0;	
// 		alu_src = 0;
// 		imm_src = 0;
// 		reg_write = 0;

// 		case (opcode)
// 			OPCODE_LUI: begin
// 				imm_src = IMM_U;
// 				alu_control = ALU_ADD;
// 				reg_write = 1;
// 			end
			
			
// 		endcase
// 	end
// endmodule
