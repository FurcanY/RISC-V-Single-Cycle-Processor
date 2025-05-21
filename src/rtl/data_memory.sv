module data_memory
    import riscv_pkg ::*;
(
    input  logic                        clk,                   // Clock sinyali
    input  logic [$clog2(DMEM_SIZE)-1:0] data_addr,             // Data memory'e girilen adres
    input  logic [XLEN-1:0]             data_write_data,       // Data memory'e yazılacak veri
    input  logic                        data_write_enable,     // Data memory'e yazma enable sinyali
    output logic [XLEN-1:0]             data_read_data         // Data memory'den okunan veri
);

    logic [XLEN-1:0] data_mem [MEM_SIZE-1:0];      // Data memory

    always_ff @(posedge clk) begin
        if (data_write_enable) begin
            data_mem[data_addr] <= data_write_data;  // Data memory'e yazılacak veri
        end
    end

    assign data_read_data = data_mem[data_addr];     // Data memory'den okunan veri 

endmodule
