module core_model_tb;
    import riscv_pkg::*;


logic     clk;
logic     rst_n;

integer file,read,line =0;

core_model dut (
    .clk   (clk  ),
    .rst_n (rst_n)
);


initial forever begin
    #5;
    clk = ~clk;
end

initial begin
    //başlangıç sinyalleri
    clk   = 0;
    rst_n = 0;
    #3;
    rst_n = 1;
    #2;

    //deneme test_01.hex
    #1000;
    for ( int i = 0; i< 32; i++) begin
        $display ("x[%0d]. register degeri = %8h",i,dut.RF.registers[i[4:0]]);
    end

    for ( int i = 0; i< 10; i++) begin
        $display ("%0d. address'deki data degeri = %8h",i,dut.DM.data_mem[i[9:0]]);
    end

    $finish;

end



endmodule
