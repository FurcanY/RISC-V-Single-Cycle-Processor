
/*
   --- OBSIDYEN RISC-V CORE ---

    Module : Register file modülü
    Author : Furkan YILDIRIM

    Note: 
        -clk sinyaline göre registerhedef register'a yazma işlemi gerçekleştirir.
        -asenkron olarak register okuma işlemi yapar.
    
*/


module register_file
    import riscv_pkg::*;
(
    input logic clk_i,
    input logic rst_ni,

    input logic reg_write_en_i,          // write enable sinyali (clock rising edge ile senkron çalışır)
    input logic [4:0] rs1_addr_i,        // kaynak register 1 adresi
    input logic [4:0] rs2_addr_i,        // kaynak register 2 adresi
    input logic [4:0] rd_addr_i,         // hedef register adresi
    input logic [XLEN-1:0] rd_data_i,    // hedef register'a yazılacak veri    

    output logic [XLEN-1:0] rs1_data_o,  // kaynak register 1 verisi
    output logic [XLEN-1:0] rs2_data_o   // kaynak register 2 verisi
);

localparam REG_FILE_SIZE = 32;
    
logic [XLEN-1:0] reg_file [0:REG_FILE_SIZE-1]; // Register dosyası


//  ardışık işlemler
always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
        // Reset durumunda register dosyasını sıfırla
        for (int i = 0; i < REG_FILE_SIZE; i++) begin
            reg_file[i] <= '0;
        end
    end else if (reg_write_en_i && (rd_addr_i != 5'd0)) begin
        // Yazma işlemi (x0 register'ı yazılamaz)
        reg_file[rd_addr_i] <= rd_data_i;
    end
end

// kombinasyonel işlemler

always_comb begin : okuma_bolumu
    rs1_data_o = reg_file[rs1_addr_i];
    rs2_data_o = reg_file[rs2_addr_i];
end


endmodule
