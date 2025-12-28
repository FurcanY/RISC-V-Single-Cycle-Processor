module data_memory_tb;
    import riscv_pkg::*;

    // sinyaller
    logic clk_i;
    logic rst_ni;
    logic mem_write_en_i;
    logic [XLEN-1:0] addr_i;
    logic [XLEN-1:0] write_data_i;
    logic [1:0] mem_size_i;
    logic mem_sign_ext_i;
    logic [XLEN-1:0] read_data_o;

    // testbench genel değişkenleri (Verilator iç-deklarasyon uyumluluğu için module scope)
    int i;
    logic [XLEN-1:0] random_value [0:99];
    logic [15:0] half_word_value;
    logic [7:0]  byte_value;
    logic [31:0] tmp32;
    logic [31:0] tmp32_b;
    logic       rand_bit;
    logic [1:0] rand_idx;

    localparam CLOCK_PERIOD = 10ns;

    // DUT instantiate
    data_memory dut (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .mem_write_en_i(mem_write_en_i),
        .addr_i(addr_i),
        .write_data_i(write_data_i),
        .mem_size_i(mem_size_i),
        .mem_sign_ext_i(mem_sign_ext_i),
        .read_data_o(read_data_o)
    );

    // clock
    initial begin
        clk_i = 0;
        forever #(CLOCK_PERIOD / 2) clk_i = ~clk_i;
    end

    // vcd
    initial begin
        $dumpfile("./file_vcd/data_memory.vcd");
        $dumpvars(0, data_memory_tb);
    end

    // test senaryosu
    initial begin
        rst_ni = 0;
        #(CLOCK_PERIOD * 2);
        $display("Reset durumundan cikildi.");

        // WORD yazma (0..99)
        $display("ilk 100 adres rastgele word yazma islemi testi basliyor.");
        rst_ni = 1;
        mem_write_en_i = 1;
        mem_sign_ext_i = 0;
        mem_size_i = 2'b10;

        for (i = 0; i < 100; i++) begin
            @(posedge clk_i);
            addr_i = i * 4;
            random_value[i] = $urandom_range(0, 32'hFFFF_FFFF);
            write_data_i = random_value[i];
        end

        @(posedge clk_i); // 100.iterasyon için clock vuruşu

        // WORD okuma
        $display("Word yazma islemi tamamlandi. Okuma islemi basliyor.");
        mem_write_en_i = 0;
        mem_size_i = 2'b10;

        for (i = 0; i < 100; i++) begin
            @(posedge clk_i);
            addr_i = i * 4;
            #1ns;
            if (read_data_o == random_value[i]) begin
                $display("addr_i = %h için okuma dogru: read_data_o = %h", addr_i, read_data_o);
            end else begin
                $error("Hata: addr_i = %h için beklenen = %h, alınan = %h", addr_i, random_value[i], read_data_o);
            end
        end
        @(posedge clk_i); // 100.iterasyon için clock vuruşu
        $display("Word okuma testi tamamlandi.");

        // HALF yazma
        $display("Half yazma ve okuma testi basliyor.");
        mem_write_en_i = 1;
        mem_size_i = 2'b01;

        for (i = 0; i < 100; i++) begin
            @(posedge clk_i);
            tmp32 = $urandom_range(0, 32'h0000_FFFF);
            half_word_value = tmp32[15:0];
            addr_i = i * 4;
            tmp32 = $urandom_range(0, 32'd1); // reuse tmp32 for random bit
            rand_bit = tmp32[0];
            if (rand_bit) begin
                addr_i[1] = 1'b1;
                random_value[i] = {16'h0000, half_word_value};
            end else begin
                addr_i[1] = 1'b0;
                random_value[i] = {16'hFFFF, half_word_value};
            end
            write_data_i = random_value[i];
            
        end

        @(posedge clk_i); // 100.iterasyon için clock vuruşu

        $display("Half yazma testi tamamlandi.");
        $display("Half okuma testi basliyor.");
        mem_write_en_i = 0;
        mem_size_i = 2'b01;

        for (i = 0; i < 100; i++) begin
            @(posedge clk_i);
            addr_i = i * 4;
            #1ns;
            if (random_value[i][31:16] == 16'h0000) begin
                if (read_data_o[31:16] == random_value[i][31:16]) $display("addr_i = %h half ok", addr_i);
                else $error("Hata half: addr=%h bek=%h al=%h", addr_i, random_value[i][31:16], read_data_o[31:16]);
            end else begin
                if (read_data_o[15:0] == random_value[i][15:0]) $display("addr_i = %h half ok", addr_i);
                else $error("Hata half: addr=%h bek=%h al=%h", addr_i, random_value[i][15:0], read_data_o[15:0]);
            end
        end

        @(posedge clk_i); // 100.iterasyon için clock vuruşu
        $display("Half okuma yazma testi tamamlandi");

        // BYTE yazma
        $display("Byte yazma ve okuma testi basliyor.");
        mem_write_en_i = 1;
        mem_size_i = 2'b00;

        for (i = 0; i < 100; i++) begin
            @(posedge clk_i);
            tmp32_b = $urandom_range(0, 32'h0000_00FF);
            byte_value = tmp32_b[7:0];
            addr_i = i * 4;
            tmp32_b = $urandom_range(0, 32'd3);
            rand_idx = tmp32_b[1:0];
            case (rand_idx)
                2'd0: begin addr_i[1:0] = 2'b00; random_value[i] = {24'hAAAAAA, byte_value}; end
                2'd1: begin addr_i[1:0] = 2'b01; random_value[i] = {24'hBBBBBB, byte_value}; end
                2'd2: begin addr_i[1:0] = 2'b10; random_value[i] = {24'hCCCCCC, byte_value}; end
                2'd3: begin addr_i[1:0] = 2'b11; random_value[i] = {24'hDDDDDD, byte_value}; end
                default: begin addr_i[1:0] = 2'b00; random_value[i] = {24'hAAAAAA, byte_value}; end
            endcase
            write_data_i = random_value[i];
            
        end

        @(posedge clk_i); // 100.iterasyon için clock vuruşu

        $display("Byte yazma testi tamamlandi.");
        $display("Byte okuma testi basliyor.");
        mem_write_en_i = 0;
        mem_size_i = 2'b00;
        mem_sign_ext_i = 0;

        for (i = 0; i < 100; i++) begin
            @(posedge clk_i);

            // hangi byte yazma yaptıysak o byte'ı okumak için adresi ayarla 0x10001 0x1003 gibi offsetler eklendi  
            addr_i = i * 4;
            case (random_value[i][31:8])
                24'hAAAAAA: addr_i[1:0] = 2'b00;
                24'hBBBBBB: addr_i[1:0] = 2'b01;
                24'hCCCCCC: addr_i[1:0] = 2'b10;
                24'hDDDDDD: addr_i[1:0] = 2'b11;
                default: addr_i[1:0] = 2'b00;
            endcase
            
            #1ns;

            if (random_value[i][31:8] == 24'hAAAAAA) begin
                if (read_data_o[7:0] == random_value[i][7:0]) $display("addr=%h byte0 ok", addr_i);
                else $error("Hata byte0 addr=%h", addr_i);
            end else if (random_value[i][31:8] == 24'hBBBBBB) begin
                if (read_data_o[7:0] == random_value[i][7:0]) $display("addr=%h byte1 ok", addr_i);
                else $error("Hata byte1 addr=%h", addr_i);
            end else if (random_value[i][31:8] == 24'hCCCCCC) begin
                if (read_data_o[7:0] == random_value[i][7:0]) $display("addr=%h byte2 ok", addr_i);
                else $error("Hata byte2 addr=%h", addr_i);
            end else if (random_value[i][31:8] == 24'hDDDDDD) begin
                if (read_data_o[7:0] == random_value[i][7:0]) $display("addr=%h byte3 ok", addr_i);
                else $error("Hata byte3 addr=%h", addr_i);
            end
            addr_i = i * 4;
        end

        @(posedge clk_i); // 100.iterasyon için clock vuruşu

        $display("Byte okuma yazma testi tamamlandi");
        $display("Tüm testler başarıyla tamamlandı.");
        $finish;
    end

endmodule
