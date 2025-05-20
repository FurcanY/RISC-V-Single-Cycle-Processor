module program_counter
    import riscv_pkg::*;
(
    input  logic              clk,              // Clock sinyali
    input  logic              rst_n,            // Reset sinyali
    input  logic [XLEN-1:0]   pc_next,          // pc'ye gelen değer
    output logic [XLEN-1:0]   pc_current        // pc'nin şuanki değeri
);

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc_current <= '0;  // Word adresi 0'dan başla
        end 
        else begin
            pc_current <= pc_next;
        end
    end
endmodule
