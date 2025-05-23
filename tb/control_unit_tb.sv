module control_unit_tb;

    import riscv_pkg::*;

    // Giriş sinyalleri
    logic [6:0]  opcode;
    logic [2:0]  funct3;
    logic [6:0]  funct7;
    logic        zero_flag;
    logic        negative_flag;
    logic        carry_flag;
    logic        overflow_flag;

    // Çıkış sinyalleri
    alu_op_e        alu_control;
    alu_src_a_e     alu_src_a_sel;
    alu_src_b_e     alu_src_b_sel;
    logic           reg_write_enable;
    logic           mem_read;
    logic           mem_write;
    mem_size_e      mem_size;
    logic           mem_usign_load;
    immediate_type_e imm_type;
    pc_src_e        pc_src;
    result_src_e    result_src;

    // Cihaz (DUT)
    control_unit dut (
        .opcode(opcode),
        .funct3(funct3),
        .funct7(funct7),
        .zero_flag(zero_flag),
        .negative_flag(negative_flag),
        .carry_flag(carry_flag),
        .overflow_flag(overflow_flag),

        .alu_control(alu_control),
        .alu_src_a_sel(alu_src_a_sel),
        .alu_src_b_sel(alu_src_b_sel),


        .reg_write_enable(reg_write_enable),

        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_size(mem_size),
        .mem_usign_load(mem_usign_load),

        .imm_src(imm_type),
        .pc_src(pc_src),
        .result_src(result_src)
    );

    // Test verileri
    parameter NUM_TESTS = 8;
    int error_count = 0;

    logic [6:0]  opcode_arr     [NUM_TESTS];
    logic [2:0]  funct3_arr     [NUM_TESTS];
    logic [6:0]  funct7_arr     [NUM_TESTS];
    logic        zero_flag_arr  [NUM_TESTS];
    logic        negative_flag_arr [NUM_TESTS];
    logic        carry_flag_arr [NUM_TESTS];
    logic        overflow_flag_arr [NUM_TESTS];

    alu_op_e        exp_alu_control_arr   [NUM_TESTS];
    alu_src_a_e     exp_alu_src_a_sel_arr [NUM_TESTS];
    alu_src_b_e     exp_alu_src_b_sel_arr [NUM_TESTS];
    logic           exp_reg_write_enable_arr [NUM_TESTS];
    logic           exp_mem_read_arr      [NUM_TESTS];
    logic           exp_mem_write_arr     [NUM_TESTS];
    mem_size_e      exp_mem_size_arr      [NUM_TESTS];
    logic           exp_mem_usign_load_arr[NUM_TESTS];
    immediate_type_e exp_imm_type_arr     [NUM_TESTS];
    pc_src_e        exp_pc_src_arr        [NUM_TESTS];
    result_src_e    exp_result_src_arr    [NUM_TESTS];

    task check_outputs(input int i);
        if (alu_control !== exp_alu_control_arr[i]) begin $display("FAILED[%0d]: alu_control", i); error_count++; end
        if (alu_src_a_sel !== exp_alu_src_a_sel_arr[i]) begin $display("FAILED[%0d]: alu_src_a_sel", i); error_count++; end
        if (alu_src_b_sel !== exp_alu_src_b_sel_arr[i]) begin $display("FAILED[%0d]: alu_src_b_sel", i); error_count++; end
        if (reg_write_enable !== exp_reg_write_enable_arr[i]) begin $display("FAILED[%0d]: reg_write_enable", i); error_count++; end
        if (mem_read !== exp_mem_read_arr[i]) begin $display("FAILED[%0d]: mem_read", i); error_count++; end
        if (mem_write !== exp_mem_write_arr[i]) begin $display("FAILED[%0d]: mem_write", i); error_count++; end
        if (mem_size !== exp_mem_size_arr[i]) begin $display("FAILED[%0d]: mem_size", i); error_count++; end
        if (mem_usign_load !== exp_mem_usign_load_arr[i]) begin $display("FAILED[%0d]: mem_usign_load", i); error_count++; end
        if (imm_type !== exp_imm_type_arr[i]) begin $display("FAILED[%0d]: imm_type", i); error_count++; end
        if (pc_src !== exp_pc_src_arr[i]) begin $display("FAILED[%0d]: pc_src", i); error_count++; end
        if (result_src !== exp_result_src_arr[i]) begin $display("FAILED[%0d]: result_src", i); error_count++; end
    endtask

    initial begin
        $dumpfile("control_unit_tb.vcd");
        $dumpvars(0, control_unit_tb);

        // Test 0: LUI
        opcode_arr[0] = OPCODE_LUI;
        funct3_arr[0] = 3'b000;
        funct7_arr[0] = 7'b0000000;
        zero_flag_arr[0] = 0; negative_flag_arr[0] = 0;
        carry_flag_arr[0] = 0; overflow_flag_arr[0] = 0;
        exp_alu_control_arr[0] = ALU_ADD;
        exp_alu_src_a_sel_arr[0] = ALU_SRC_A_ZERO;
        exp_alu_src_b_sel_arr[0] = ALU_SRC_B_IMM;
        exp_reg_write_enable_arr[0] = 1;
        exp_mem_read_arr[0] = 0;
        exp_mem_write_arr[0] = 0;
        exp_mem_size_arr[0] = MEM_WORD;
        exp_mem_usign_load_arr[0] = 0;
        exp_imm_type_arr[0] = IMM_U;
        exp_pc_src_arr[0] = PC_SRC_PC4;
        exp_result_src_arr[0] = RESULT_SRC_ALU;

        // Test 1: AUIPC
        opcode_arr[1] = OPCODE_AUIPC;
        funct3_arr[1] = 3'b000;
        funct7_arr[1] = 7'b0000000;
        zero_flag_arr[1] = 0; negative_flag_arr[1] = 0;
        carry_flag_arr[1] = 0; overflow_flag_arr[1] = 0;
        exp_alu_control_arr[1] = ALU_AUIPC;
        exp_alu_src_a_sel_arr[1] = ALU_SRC_A_PC;
        exp_alu_src_b_sel_arr[1] = ALU_SRC_B_IMM;
        exp_reg_write_enable_arr[1] = 1;
        exp_mem_read_arr[1] = 0;
        exp_mem_write_arr[1] = 0;
        exp_mem_size_arr[1] = MEM_WORD;
        exp_mem_usign_load_arr[1] = 0;
        exp_imm_type_arr[1] = IMM_U;
        exp_pc_src_arr[1] = PC_SRC_PC4;
        exp_result_src_arr[1] = RESULT_SRC_ALU;

        // Test 2: BEQ (taken)
        opcode_arr[2] = OPCODE_BRANCH;
        funct3_arr[2] = FUNCT3_BEQ;
        funct7_arr[2] = 7'b0000000;
        zero_flag_arr[2] = 1; negative_flag_arr[2] = 0;
        carry_flag_arr[2] = 0; overflow_flag_arr[2] = 0;
        exp_alu_control_arr[2] = ALU_ADD;
        exp_alu_src_a_sel_arr[2] = ALU_SRC_A_RS1;
        exp_alu_src_b_sel_arr[2] = ALU_SRC_B_RS2;
        exp_reg_write_enable_arr[2] = 0;
        exp_mem_read_arr[2] = 0;
        exp_mem_write_arr[2] = 0;
        exp_mem_size_arr[2] = MEM_WORD;
        exp_mem_usign_load_arr[2] = 0;
        exp_imm_type_arr[2] = IMM_B;
        exp_pc_src_arr[2] = PC_SRC_BRANCH_JAL;
        exp_result_src_arr[2] = RESULT_SRC_ALU;

        opcode_arr[3] = OPCODE_JAL;
        funct3_arr[3] = 3'b000;
        funct7_arr[3] = 7'b0000000;
        zero_flag_arr[3] = 0; negative_flag_arr[3] = 0;
        carry_flag_arr[3] = 0; overflow_flag_arr[3] = 0;

        exp_alu_control_arr[3]       = ALU_ADD;
        exp_alu_src_a_sel_arr[3]     = ALU_SRC_A_PC;
        exp_alu_src_b_sel_arr[3]     = ALU_SRC_B_IMM;
        exp_reg_write_enable_arr[3]  = 1;
        exp_mem_read_arr[3]          = 0;
        exp_mem_write_arr[3]         = 0;
        exp_mem_size_arr[3]          = MEM_WORD;
        exp_mem_usign_load_arr[3]    = 0;
        exp_imm_type_arr[3]          = IMM_J;
        exp_pc_src_arr[3]            = PC_SRC_BRANCH_JAL;
        exp_result_src_arr[3]        = RESULT_SRC_PC4;

        opcode_arr[4] = OPCODE_JALR;
        funct3_arr[4] = 3'b000;
        funct7_arr[4] = 7'b0000000;
        zero_flag_arr[4] = 0; negative_flag_arr[4] = 0;
        carry_flag_arr[4] = 0; overflow_flag_arr[4] = 0;

        exp_alu_control_arr[4]       = ALU_ADD;
        exp_alu_src_a_sel_arr[4]     = ALU_SRC_A_RS1;
        exp_alu_src_b_sel_arr[4]     = ALU_SRC_B_IMM;
        exp_reg_write_enable_arr[4]  = 1;
        exp_mem_read_arr[4]          = 0;
        exp_mem_write_arr[4]         = 0;
        exp_mem_size_arr[4]          = MEM_WORD;
        exp_mem_usign_load_arr[4]    = 0;
        exp_imm_type_arr[4]          = IMM_I;
        exp_pc_src_arr[4]            = PC_SRC_JALR;
        exp_result_src_arr[4]        = RESULT_SRC_PC4;

        opcode_arr[5] = OPCODE_LOAD;
        funct3_arr[5] = FUNCT3_LW;
        funct7_arr[5] = 7'b0000000;
        zero_flag_arr[5] = 0; negative_flag_arr[5] = 0;
        carry_flag_arr[5] = 0; overflow_flag_arr[5] = 0;

        exp_alu_control_arr[5]       = ALU_ADD;
        exp_alu_src_a_sel_arr[5]     = ALU_SRC_A_RS1;
        exp_alu_src_b_sel_arr[5]     = ALU_SRC_B_IMM;
        exp_reg_write_enable_arr[5]  = 1;
        exp_mem_read_arr[5]          = 1;
        exp_mem_write_arr[5]         = 0;
        exp_mem_size_arr[5]          = MEM_WORD;
        exp_mem_usign_load_arr[5]    = 0;
        exp_imm_type_arr[5]          = IMM_I;
        exp_pc_src_arr[5]            = PC_SRC_PC4;
        exp_result_src_arr[5]        = RESULT_SRC_MEM;

        opcode_arr[6] = OPCODE_STORE;
        funct3_arr[6] = FUNCT3_SW;
        funct7_arr[6] = 7'b0000000;
        zero_flag_arr[6] = 0; negative_flag_arr[6] = 0;
        carry_flag_arr[6] = 0; overflow_flag_arr[6] = 0;

        exp_alu_control_arr[6]       = ALU_ADD;
        exp_alu_src_a_sel_arr[6]     = ALU_SRC_A_RS1;
        exp_alu_src_b_sel_arr[6]     = ALU_SRC_B_IMM;
        exp_reg_write_enable_arr[6]  = 0;
        exp_mem_read_arr[6]          = 0;
        exp_mem_write_arr[6]         = 1;
        exp_mem_size_arr[6]          = MEM_WORD;
        exp_mem_usign_load_arr[6]    = 0;
        exp_imm_type_arr[6]          = IMM_S;
        exp_pc_src_arr[6]            = PC_SRC_PC4;
        exp_result_src_arr[6]        = RESULT_SRC_ALU;

        opcode_arr[7] = OPCODE_I_TYPE;
        funct3_arr[7] = FUNCT3_ADDI;
        funct7_arr[7] = 7'b0000000;
        zero_flag_arr[7] = 0; negative_flag_arr[7] = 0;
        carry_flag_arr[7] = 0; overflow_flag_arr[7] = 0;

        exp_alu_control_arr[7]       = ALU_ADD;
        exp_alu_src_a_sel_arr[7]     = ALU_SRC_A_RS1;
        exp_alu_src_b_sel_arr[7]     = ALU_SRC_B_IMM;
        exp_reg_write_enable_arr[7]  = 1;
        exp_mem_read_arr[7]          = 0;
        exp_mem_write_arr[7]         = 0;
        exp_mem_size_arr[7]          = MEM_WORD;
        exp_mem_usign_load_arr[7]    = 0;
        exp_imm_type_arr[7]          = IMM_I;
        exp_pc_src_arr[7]            = PC_SRC_PC4;
        exp_result_src_arr[7]        = RESULT_SRC_ALU;





        // Testleri çalıştır
        for (int i = 0; i < NUM_TESTS; i++) begin
            opcode        = opcode_arr[i];
            funct3        = funct3_arr[i];
            funct7        = funct7_arr[i];
            zero_flag     = zero_flag_arr[i];
            negative_flag = negative_flag_arr[i];
            carry_flag    = carry_flag_arr[i];
            overflow_flag = overflow_flag_arr[i];
            #1;
            check_outputs(i);
        end

        if (error_count == 0)
            $display("✅ Tüm testler BAŞARILI.");
        else
            $display("❌ %0d test HATALI.", error_count);

        $finish;
    end

endmodule
