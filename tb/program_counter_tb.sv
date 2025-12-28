

module program_counter_tb
    import riscv_pkg::*;
 ();
    
logic clk_i;
logic rst_ni;
logic [XLEN-1:0] pc_in_i;
logic [XLEN-1:0] pc_out_o;


localparam CLOCK_PERIOD = 10ns;

program_counter dut (
    .clk_i(clk_i),
    .rst_ni(rst_ni),
    .pc_in_i(pc_in_i),
    .pc_out_o(pc_out_o)
);

// Clock olusturma
initial begin
    clk_i = 0;
    forever #(CLOCK_PERIOD / 2)  clk_i = ~clk_i; // 10 time unit clock period 
end


// reset testbench'i

initial begin
    
    //waveform için vcd dosyası olusturma
    $dumpfile("./file_vcd/program_counter.vcd");
    $dumpvars(0, program_counter_tb);

    $display("-------------------------------------------------------");
    $display("RISC-V Program Counter Testbench Baslatiliyor");
    $display("-------------------------------------------------------");

    rst_ni = 0;
    pc_in_i = '0;

    # (CLOCK_PERIOD * 2);
    rst_ni = 1;
    $display("Resetten cikildi, pc_out_o degeri: %h (beklenen: 80000000)", pc_out_o);



end


initial begin
    @(posedge rst_ni); // resetten cikis bekle
    #1ns;

    $display("PC'ye yeni deger yaziliyor: 80000004");
    pc_in_i = 32'h8000_0004;


    @(posedge clk_i);

    assert (pc_out_o == 32'h8000_0004) else begin
        $error("Test Basarisiz: pc_out_o beklenen deger 80000004, alinan deger: %h", pc_out_o);
    end
    $display("Test Basarili: pc_out_o degeri dogru: %h", pc_out_o);


    #1ns;

    $display("PC'ye yeni deger yaziliyor: 80000008");
    pc_in_i = 32'h8000_0008;

    @(posedge clk_i);
    assert (pc_out_o == 32'h8000_0008) else begin
        $error("Test Basarisiz: pc_out_o beklenen deger 80000008, alinan deger: %h", pc_out_o);
    end
    $display("Test Basarili: pc_out_o degeri dogru: %h", pc_out_o);

    #1ns;

    rst_ni = 0;
    $display("Reset uygulaniyor.");
    

    @(posedge clk_i);
    assert (pc_out_o == 32'h8000_0000) else begin
        $error("Test Basarisiz: pc_out_o beklenen deger 80000000, alinan deger: %h", pc_out_o);
    end
    $display("Test Basarili: Resetten sonra pc_out_o degeri dogru: %h", pc_out_o);



    $display("Tum testler tamamlandi.");
    $finish;

end


endmodule
