module core_model 
    import riscv_pkg::*;
(
    input logic     clk,
    input logic     rst_n
);


    /*=== Control Unit Sinyalleri ===*/
	alu_op_e         alu_control      ;     
	alu_src_a_e      alu_src_a_sel    ;
	alu_src_b_e      alu_src_b_sel    ; 
	logic            branch_taken     ;
	logic            reg_write_enable ;
	logic            mem_read         ;
	logic 		     mem_write        ;
	mem_size_e	     mem_size         ;   
	logic            mem_usign_load   ;  
	immediate_type_e imm_source       ;
	pc_src_e 	     pc_src           ;
	result_src_e     result_src       ;

    /*=== Program Counter Sinyalleri ===*/
    logic [XLEN-1:0]   pc_next     ;
    logic [XLEN-1:0]   pc_current  ;

    /*=== Instruction Memory Sinyalleri ===*/
    logic [XLEN-1:0]   pc_in       ;
    logic [XLEN-1:0]   instruction ;

    /*=== Register File Sinyalleri ===*/                     
    logic [REG_ADDR_WIDTH-1:0] rs1_addr         ;               
    logic [REG_ADDR_WIDTH-1:0] rs2_addr         ;               
    logic [REG_ADDR_WIDTH-1:0] rd_addr          ;                
    logic [XLEN-1:0]           write_data       ;            
    logic [XLEN-1:0]           rs1_data         ;               
    logic [XLEN-1:0]           rs2_data         ;

    /*=== ALU Sinyalleri ===*/
    logic    [XLEN-1:0] source_a      ;
    logic    [XLEN-1:0] source_b      ;
    logic    [XLEN-1:0] alu_result    ;
    logic               zero_flag     ;
    logic               negative_flag ;
    logic               carry_flag    ;
    logic               overflow_flag ;

    /*=== Extend Immediate Sinyalleri ===*/          
    logic             [XLEN-1:0]   imm_extended    ;   
     
    /*=== Data Memory Sinyalleri ===*/
    logic [31:0]  data_write_data ;
    logic [31:0]  data_read_data  ;

    /*=== Diğer Sinyaller ===*/
    logic [31:0] result ;
    logic [31:0] pc_target;


    /*=== Module'lerin Oluşturulması ===*/
    control_unit CU (
        .opcode          (instruction [6:0]   ),
        .funct3          (instruction [14:12] ),
        .funct7          (instruction [31:25] ),
        .zero_flag       (zero_flag           ),
        .negative_flag   (negative_flag       ),
        .carry_flag      (carry_flag          ),
        .overflow_flag   (overflow_flag       ),
        .alu_control     (alu_control         ),
        .alu_src_a_sel   (alu_src_a_sel       ),
        .alu_src_b_sel   (alu_src_b_sel       ),
        .branch_taken    (branch_taken        ),
        .reg_write_enable(reg_write_enable    ),
        .mem_read        (mem_read            ),
        .mem_write       (mem_write           ),
        .mem_size        (mem_size            ),
        .mem_usign_load  (mem_usign_load      ),
        .imm_src         (imm_source          ),
        .pc_src          (pc_src              ),
        .result_src      (result_src          )
    );

    program_counter PC (
        .pc_next    (pc_next    ),
        .pc_current (pc_current ),
        .clk        (clk        ),
        .rst_n      (rst_n      )
    );

    instruction_memory IM (
        .pc_in       (pc_current  ), //pc_next -> pc_in
        .instruction (instruction )
    );

    register_file RF (
        .clk              (clk                ),
        .rst_n            (rst_n              ),
        .reg_write_enable (reg_write_enable   ),
        .rs1_addr         (instruction[19:15] ),
        .rs2_addr         (instruction[24:20] ),
        .rd_addr          (instruction[11:7]  ),
        .write_data       (result             ),
        .rs1_data         (rs1_data           ),
        .rs2_data         (rs2_data           )
    );

    alu ALU (
        .source_a      (source_a      ),
        .source_b      (source_b      ),
        .alu_control   (alu_control   ),
        .alu_result    (alu_result    ),
        .zero_flag     (zero_flag     ),
        .negative_flag (negative_flag ),
        .carry_flag    (carry_flag    ),
        .overflow_flag (overflow_flag )
    );

    extend_immediate EI (
        .imm_source      (imm_source      ),
        .imm_instruction (instruction     ),
        .imm_extended    (imm_extended    )
    );
    
    data_memory DM (
        .clk             (clk             ),
        .mem_read        (mem_read        ),
        .mem_write       (mem_write       ),
        .mem_size        (mem_size        ),
        .unsigned_load   (mem_usign_load  ),
        .data_addr       (alu_result      ),
        .data_write_data (rs2_data        ),
        .data_read_data  (data_read_data  )
    );

    //birleştirme işlemleri

    /*=== PC Next MUX ===*/ 
    always_comb begin
        case (pc_src)
            PC_SRC_PC4        : pc_next = pc_current + 4; 
            PC_SRC_BRANCH_JAL : pc_next = pc_target;
            PC_SRC_JALR       : pc_next = rs1_data + imm_extended;
            default           : pc_next = pc_current + 4;
        endcase
    end

    /*=== PC Target ===*/ 
    assign pc_target = pc_current + imm_extended;

    /*=== Result MUX ===*/ 
    always_comb begin
        case (result_src)
            RESULT_SRC_ALU : result = alu_result;
            RESULT_SRC_MEM : result = data_read_data;
            RESULT_SRC_PC4 : result = pc_current + 4;
            default        : result = alu_result;
        endcase
    end

    /*=== Source A MUX ===*/ 
    always_comb begin
        case (alu_src_a_sel)
            ALU_SRC_A_RS1  : source_a = rs1_data;
            ALU_SRC_A_PC   : source_a = pc_current;
            ALU_SRC_A_ZERO : source_a = 32'b0; 
            default        : source_a = rs1_data;
        endcase
    end

    /*=== Source B MUX ===*/ 
    always_comb begin
        case (alu_src_b_sel)
            ALU_SRC_B_RS2 : source_b = rs2_data;
            ALU_SRC_B_IMM : source_b = imm_extended; 
            default       : source_b = rs2_data;
        endcase
    end


    
endmodule
