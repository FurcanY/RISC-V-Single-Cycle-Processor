module branch_control
    import riscv_pkg::*;
(
    input  branch_type_e branch_type,
    input  logic         zero_flag,
    input  logic         negative_flag,
    input  logic         carry_flag,
    input  logic         overflow_flag,

    output logic         branch_taken
);

    always_comb begin
        case (branch_type)
            BRANCH_NONE: branch_taken = 1'b0;
            BRANCH_EQ:   branch_taken = zero_flag;
            BRANCH_NE:   branch_taken = ~zero_flag;
            BRANCH_LT:   branch_taken = negative_flag ^ overflow_flag;
            BRANCH_GE:   branch_taken = ~(negative_flag ^ overflow_flag);
            BRANCH_LTU:  branch_taken = carry_flag;
            BRANCH_GEU:  branch_taken = ~carry_flag;
            default:     branch_taken = 1'b0;
        endcase
    end

endmodule 