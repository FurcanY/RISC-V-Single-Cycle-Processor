/*
   --- OBSIDYEN RISC-V CORE ---

    Module : Data Memory Modülü (Revize: Unaligned Access Support)
    Author : Furkan YILDIRIM

    Note:
        - Register ile beraber data yazma okuma işlemi yapıyor
        - Hizasız erişim (Unaligned Access) desteği için Byte-Addressable yapıya geçildi.
    
*/

module data_memory 
    import riscv_pkg::*;
(
    input logic             clk_i,
    input logic             rst_ni,
    
    input logic             mem_write_en_i,     // write enable sinyali (clock rising edge ile senkron çalışır)
    input logic [XLEN-1:0]  addr_i,              // memory adresi
    input logic [XLEN-1:0]  write_data_i,        // memory'ye yazılacak veri

    input logic [1:0]       mem_size_i,         // memory erişim boyutu (00: byte, 01: half-word, 10: word)
    input logic             mem_sign_ext_i,      // işaret genişletme sinyali (load işlemleri için, 0 ise unsigned, 1 ise signed)
    

    output logic [XLEN-1:0] read_data_o         // memory'den okunan veri
);

// Eski DATA_ADDR word sayısıydı (2048 Word). 
// Şimdi Byte sayısı yapıyoruz: 2048 * 4 = 8192 Byte
localparam MEM_DEPTH = 8192; 

// data memory - ARTIK BYTE ADRESLENEBİLİR (logic [7:0])
logic [7:0] data_mem [0:MEM_DEPTH-1]; 

//ardisik islemler

always_ff @(posedge clk_i or negedge rst_ni) begin
    if (!rst_ni) begin
        // Reset durumunda data memory'yi sıfırla
        for (int i = 0; i < MEM_DEPTH; i++) begin
            data_mem[i] <= 8'b0;
        end
    end 

    /*
        
        Yazma işlemi
    
    */
    else if (mem_write_en_i) begin
        
        // mem_size'a göre farklı boyutlarda yazma işlemi yap
        // Not: Artık word hizalaması ([...:2]) yapmadan doğrudan adrese yazıyoruz.
        case (mem_size_i)
            2'b10: begin // word (4 Byte Yaz)
                data_mem[addr_i]     <= write_data_i[7:0];
                data_mem[addr_i + 1] <= write_data_i[15:8];
                data_mem[addr_i + 2] <= write_data_i[23:16];
                data_mem[addr_i + 3] <= write_data_i[31:24];
            end
            2'b01: begin // half-word (2 Byte Yaz)
                data_mem[addr_i]     <= write_data_i[7:0];
                data_mem[addr_i + 1] <= write_data_i[15:8];
            end
            2'b00: begin // byte (1 Byte Yaz)
                data_mem[addr_i]     <= write_data_i[7:0];
            end
            default: ; // no operation
        endcase
    end
end

// kombinasyonel islemler
// Okuma işlemini kolaylaştırmak için geçici byte değişkenleri
logic [7:0] b0, b1, b2, b3;

always_comb begin
    // İstenilen adresten başlayarak 4 byte'ı çekiyoruz
    b0 = data_mem[addr_i];
    b1 = data_mem[addr_i + 1];
    b2 = data_mem[addr_i + 2];
    b3 = data_mem[addr_i + 3];

    // mem_size'a göre farklı boyutlarda okuma işlemi yap
    case (mem_size_i)
        2'b10: begin // word
            read_data_o = {b3, b2, b1, b0}; // Little Endian
        end
        2'b01: begin // half-word
            if (mem_sign_ext_i) begin
                // işaret genişletme
                read_data_o = {{16{b1[7]}}, b1, b0};
            end else begin
                // sıfır genişletme
                read_data_o = {16'b0, b1, b0};
            end
        end

        2'b00: begin // byte
            if (mem_sign_ext_i) begin
                // işaret genişletme
                read_data_o = {{24{b0[7]}}, b0};
            end else begin
                // sıfır genişletme 
                read_data_o = {24'b0, b0};
            end
        end
        default: read_data_o = '0; // no operation
    endcase

end

// Testbench için Memory DUMP almamızı sağlayan task
task dump_memory_contents(input string filename);
    int fd;
    logic [31:0] temp_word; // Byte'ları birleştirip göstermek için
    fd = $fopen(filename, "w");
    
    if (fd != 0) begin
        $display("--------------------------------------------------");
        $display("--- DATA MEMORY DUMP BAŞLIYOR (%s) ---", filename);
        $display("--------------------------------------------------");
        
        $fdisplay(fd, "Address(Hex)      Word Data(Hex)");
        $fdisplay(fd, "------------      --------------");

        // Döngü artık byte byte değil, 4'er 4'er artarak word word gösterecek
        for (int i = 0; i < 400; i = i + 4) begin
            
            // 4 byte'ı birleştirip 32-bit Word haline getiriyoruz
            temp_word = {data_mem[i+3], data_mem[i+2], data_mem[i+1], data_mem[i]};
            
            // Word adresi byte adresine çevirerek yazıyoruz
            $fdisplay(fd, "0x%08h        0x%08h", i, temp_word);

        end
        $fclose(fd);
        $display("--- DATA MEMORY DUMP TAMAMLANDI ---");
    end else begin
        $display("Hata: Dosya açılamadı: %s", filename);
    end
endtask

endmodule