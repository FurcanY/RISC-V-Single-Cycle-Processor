module register_file_tb;
    import riscv_pkg::*;

    // Testbench Sinyalleri
    logic clk_i;
    logic rst_ni;
    logic reg_write_en_i;
    logic [4:0] rs1_addr_i;
    logic [4:0] rs2_addr_i;
    logic [4:0] rd_addr_i;
    logic [XLEN-1:0] rd_data_i;
    logic [XLEN-1:0] rs1_data_o;
    logic [XLEN-1:0] rs2_data_o;

    // Parametre Tanımı
    localparam CLOCK_PERIOD = 10ns;

    // DUT (Device Under Test) Örneklendirmesi
    register_file dut (
        .clk_i(clk_i),
        .rst_ni(rst_ni),
        .reg_write_en_i(reg_write_en_i),
        .rs1_addr_i(rs1_addr_i),
        .rs2_addr_i(rs2_addr_i),
        .rd_addr_i(rd_addr_i),
        .rd_data_i(rd_data_i),
        .rs1_data_o(rs1_data_o),
        .rs2_data_o(rs2_data_o)
    );

    // -------------------------------------------------------------------------
    // 1. Saat ve Reset Üretimi
    // -------------------------------------------------------------------------

    // Saat Üretimi (Clock Generator)
    initial begin
        clk_i = 1'b0;
        forever #(CLOCK_PERIOD / 2) clk_i = ~clk_i;
    end

    // Reset Dizisi (Reset Sequence)
    initial begin
        // VCD (Value Change Dump) Dosyası Oluşturma Komutları
        // register_file.vcd adında bir dosya oluşturulur
        $dumpfile("./file_vcd/register_file.vcd");
        // Tüm sinyalleri (0: derinlik seviyesi) testbench modülü altından kaydetmeye başla
        $dumpvars(0, register_file_tb);


        $display("-------------------------------------------------------");
        $display("RISC-V Register File Testbench Baslatiliyor");
        $display("-------------------------------------------------------");
        rst_ni = 1'b0; // Reset aktif
        reg_write_en_i = 1'b0;
        rd_addr_i = '0;
        rd_data_i = '0;
        rs1_addr_i = '0;
        rs2_addr_i = '0;
        
        # (CLOCK_PERIOD * 2); 
        rst_ni = 1'b1; // Reset de-aktif
        $display("[%0t] Reset sonlandi. Islem basliyor...", $time);
    end

    // -------------------------------------------------------------------------
    // 2. Eş Zamanlı Doğrulama (SystemVerilog Assertions - SVA)
    // -------------------------------------------------------------------------

    // Kural 1: x0 Register'ı Her Zaman Sıfırdır (Hardwired Zero)
    // x0 adresi okunmaya çalışıldığında çıktının her zaman sıfır olması gerekir. kombinasyonel çıkarım ( | -> )
    assert_x0_rs1_kontrol: assert property (@(posedge clk_i) 
        (rs1_addr_i == 5'd0) |-> (rs1_data_o == 0))
    else $error("[%0t] HATA: rs1 (x0) okundugunda sifir olmaliydi!", $time);

    assert_x0_rs2_kontrol: assert property (@(posedge clk_i) 
        (rs2_addr_i == 5'd0) |-> (rs2_data_o == 0))
    else $error("[%0t] HATA: rs2 (x0) okundugunda sifir olmaliydi!", $time);


    // Kural 2: Senkron Yazma İşleminin Doğrulanması
    // Yazma etkin ve hedef x0 değilse, bir sonraki saat vuruşunda (clk) register içeriği doğru veriye eşit olmalıdır.
    assert_senkron_yazma_kontrol: assert property (@(posedge clk_i) disable iff (!rst_ni)
        (reg_write_en_i && (rd_addr_i != 5'd0)) |=> 
        (dut.reg_file[rd_addr_i] == rd_data_i))
    else $error("[%0t] HATA: Senkron yazma islemi basarisiz oldu! (rd_addr=%d)", $time, rd_addr_i);
    

    // Kural 3: Birleşimsel (Kombinasyonel) Okuma İşleminin Doğrulanması
    // Okuma çıktıları, iç register dosyasının içeriğine anlık olarak eşit olmalıdır.
    assert_kombinasyonel_okuma_kontrol: assert property (@(negedge clk_i) disable iff (!rst_ni)
        (1'b1) |-> (rs1_data_o == dut.reg_file[rs1_addr_i] && rs2_data_o == dut.reg_file[rs2_addr_i]))
    else $error("[%0t] HATA: Birlesimsel okuma cikisi, register icerigiyle eslesmiyor!", $time);


    // Kural 4: x0'a Yazma Girişimi
    // Yazma etkin olsa bile rd_addr=0 ise, register içeriği değişmemelidir.
    // Başlangıçta 0 olduğu için, sadece 0 olarak kalması yeterlidir.
    assert_x0_yazma_kontrol: assert property (@(posedge clk_i) disable iff (!rst_ni)
        (reg_write_en_i && (rd_addr_i == 5'd0)) |=> (dut.reg_file[5'd0] == 0))
    else $error("[%0t] HATA: X0 register'ina yazma islemi basariyla ENGELLENEMEDI!", $time);


    // -------------------------------------------------------------------------
    // 3. Test Senaryoları
    // -------------------------------------------------------------------------

    initial begin
        // Reset'in sonlanmasını bekle
        @(posedge rst_ni);
        #1ns;

        $display("\n--- TEST SENARYOSU 1: Basit Yazma ve Okuma (x1) ---");
        
        // x1'e 0xDEADBEEF yaz
        reg_write_en_i = 1'b1;
        rd_addr_i = 5'd1;
        rd_data_i = 32'hDEADBEEF;
        rs1_addr_i = 5'd1;
        rs2_addr_i = 5'd0; // x0 oku
        
        #1ns;
        // Kombinasyonel Okuma Kontrolü (bir sonraki kenarı beklemeden)
        assert (rs1_data_o == 32'h0) else $error("[%0t] HATA: Kombinasyonel okuma yanlis (Yazma oncesi: x1=0 olmaliydi)", $time);
        assert (rs2_data_o == 32'h0) else $error("[%0t] HATA: Kombinasyonel okuma yanlis (x0=0 olmaliydi)", $time);


        @(posedge clk_i);
        #1ns; // Yazma işlemi gerçekleşti (SVA Kural 2 kontrol etti)
        
        // Yazma sonrası okuma
        reg_write_en_i = 1'b1;
        rd_addr_i = 5'd2;
        rd_data_i = 32'hAABBCCDD;
        rs1_addr_i = 5'd1; 
        rs2_addr_i = 5'd2; 
        
        assert (rs1_data_o == 32'hDEADBEEF) else $error("[%0t] HATA: Yazma sonrasi okuma yanlis (x1)", $time);
        assert (rs2_data_o == 32'h00000000) else $error("[%0t] HATA: Yazma sonrasi okuma yanlis (x1)", $time);
        $display("[%0t] Senaryo 1 Basarili: x1 dogru okundu.", $time);


        $display("\n--- TEST SENARYOSU 2: x0'a Yazma Engelleme Testi ---");

        // x0'a yazma denemesi yap
        reg_write_en_i = 1'b1;
        rd_addr_i = 5'd0; // HEDEF X0
        rd_data_i = 32'hFFFFFFFF; // Farklı bir değer
        rs1_addr_i = 5'd0;
        
        @(posedge clk_i);
        #1ns; // Yazma işlemi gerçekleşmedi (SVA Kural 4 kontrol etti)

        // Okuma Kontrolü: x0 hala 0 olmalı
        reg_write_en_i = 1'b0;
        assert (rs1_data_o == 32'h0) else $error("[%0t] HATA: x0'a yazma engellenemedi! Cikis sifir degil.", $time);
        assert (dut.reg_file[5'd0] == 0) else $error("[%0t] HATA: X0 register icerigi yazma denemesinden sonra degisti!", $time);
        $display("[%0t] Senaryo 2 Basarili: x0'a yazma engellendi.", $time);


        $display("\n--- TEST SENARYOSU 3: Coklu Yazma ve Okuma ---");

        // x2'ye 0x11111111 yaz
        reg_write_en_i = 1'b1;
        rd_addr_i = 5'd2;
        rd_data_i = 32'h11111111;
        
        @(posedge clk_i);
        
        // x3'e 0x22222222 yaz
        rd_addr_i = 5'd3;
        rd_data_i = 32'h22222222;
        
        @(posedge clk_i);
        
        // Yazmayı durdur
        reg_write_en_i = 1'b0;
        #1ns;

        // Kontrol: x1, x2, x3'ü oku
        rs1_addr_i = 5'd1; // x1 -> DEADBEEF
        rs2_addr_i = 5'd2; // x2 -> 11111111

        assert (rs1_data_o == 32'hDEADBEEF) else $error("[%0t] HATA: x1 yanlis okundu.", $time);
        assert (rs2_data_o == 32'h11111111) else $error("[%0t] HATA: x2 yanlis okundu.", $time);
        
        rs1_addr_i = 5'd3; // x3 -> 22222222
        rs2_addr_i = 5'd1; // x1 -> DEADBEEF
        
        assert (rs1_data_o == 32'h22222222) else $error("[%0t] HATA: x3 yanlis okundu.", $time);
        assert (rs2_data_o == 32'hDEADBEEF) else $error("[%0t] HATA: x1 yanlis okundu.", $time);
        
        $display("[%0t] Senaryo 3 Basarili: Coklu yazma/okuma dogrulandi.", $time);


        $display("\n-------------------------------------------------------");
        $display("[%0t] TUM TESTLER TAMAMLANDI. SVA Sonuclarini Kontrol Edin.", $time);
        $display("-------------------------------------------------------");
        
        # (CLOCK_PERIOD * 5); // SVA'nın son işlemleri yakalaması için biraz bekle
        $stop;
    end

endmodule
