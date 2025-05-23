module core_model_tb;
    import riscv_pkg::*;


logic            clk;
logic            rst_n;

integer          file,read,line =0;
logic [XLEN-1:0]  prev_instruction = 32'b0;
logic [XLEN-1:0]  prev_rs1_data= 32'b0;
logic [XLEN-1:0]  prev_rs2_data= 32'b0;

core_model dut (
    .clk   (clk  ),
    .rst_n (rst_n)
);


initial forever begin
    #5;
    clk = ~clk;
end

initial begin
    $dumpfile("dumb.vcd");
    $dumpvars();
end

initial begin

    //dosya işlemleri 
    file = $fopen("./test/instruction_tests/golden_model_log.txt", "w");

    //başlangıç sinyalleri
    clk   = 0;
    rst_n = 0;
    #3;
    rst_n = 1;
    #2;

    #2000;
    for ( int i = 0; i< 32; i++) begin
        $display ("x[%2d]. register degeri = %8h",i,dut.RF.registers[i[4:0]]);
    end

    for ( int i = 0; i< 32'h400; i++) begin
        $display ("%0d. address'deki data degeri = %8h",i,dut.DM.data_mem[i[9:0]]);
    end
    $finish;

end
// tamamladığı pc, tamamladığı komutu, tammaladığı reg ve değeri, mem addresi mem değeri

always @(posedge clk ) begin
    logic [31:0] current_instruction = dut.IM.instruction_mem[dut.IM.pc_in[$clog2(MEM_SIZE*4)-1:2]];
    logic [31:0] current_rs1_data = dut.RF.rs1_data;
    logic [31:0] current_rs2_data = dut.RF.rs2_data;
    $fwrite(file, "pc[%8h] ", dut.PC.pc_current);
    if (current_instruction !== prev_instruction) begin

        prev_instruction = current_instruction;


        if (current_rs1_data !== prev_rs1_data) begin
            prev_rs1_data = current_rs1_data;
            $fwrite(file, "reg1[%8h]= ", dut.RF.rs1_addr);
            $fwrite(file, "%8h ", current_rs1_data);
        end
        else
            $fwrite(file, "                         ");

        if (current_rs2_data !== prev_rs2_data) begin
            prev_rs2_data = current_rs2_data;
            $fwrite(file, "reg2[%8h]= ", dut.RF.rs2_addr);
            $fwrite(file, "%8h ", current_rs2_data);
        end

        else
            $fwrite(file, "                         ");
    end
    $fwrite(file,"\n"); 

end

/*
    bne 'de hata aldım test_05.dump satır 26
    0x00000068  0x30900b93  addi x23,x0,0x00000309       47   addi x23, x0, 777
*/


endmodule
