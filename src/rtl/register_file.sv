module register_file
    import riscv_pkg::*;
(
    input  logic                      clk,                    // Clock sinyali
    input  logic                      rst_n,                  // Reset sinyali
    input  logic                      reg_write_enable,       // Register'a yazma enable sinyali
    input  logic [REG_ADDR_WIDTH-1:0] rs1_addr,               // Source register 1 adresi 
    input  logic [REG_ADDR_WIDTH-1:0] rs2_addr,               // Source register 2 adresi
    input  logic [REG_ADDR_WIDTH-1:0] rd_addr,                // Destination register adresi
    input  logic [XLEN-1:0]           write_data,             // Register'a yazılacak veri
    output logic [XLEN-1:0]           rs1_data,               // Source register 1'den okunan veri
    output logic [XLEN-1:0]           rs2_data                // Source register 2'den okunan veri


);

    logic [XLEN-1:0] registers [32]; // 32 adet 4 byte register

    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            for (int i = 0; i < 32; i++) begin
                registers[i] <= '0;
            end
        end
        else if (reg_write_enable && rd_addr != '0) begin
        registers[rd_addr] <= write_data;                   // rd_addr adresine yazılacak veri
        end
    end

    //x0 register 0 değerini verir.
    assign rs1_data = (rs1_addr == '0) ? '0 : registers[rs1_addr]; 
    assign rs2_data = (rs2_addr == '0) ? '0 : registers[rs2_addr];
    
endmodule 
