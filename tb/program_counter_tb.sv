module program_counter_tb;
    import riscv_pkg::*;


logic              clk        ;
logic              rst_n      ; 
logic [XLEN-1:0]   pc_next    ; 
logic [XLEN-1:0]   pc_current ;  
    
program_counter dut (
    .clk        (clk       ),        
    .rst_n      (rst_n     ),        
    .pc_next    (pc_next   ),        
    .pc_current (pc_current)         
);

// ------- waveform olusturma --------
initial begin
    $dumpfile("dumb.vcd");
    $dumpvars();
end


// ----------- clock olusturma --------
initial forever begin
    #5;
    clk = ~clk;
end

// --------- reset islemleri-----------
initial begin 
    clk = 0;
    rst_n = 0;
    #5;
    rst_n = 1;
end


int error_count = 0;

// -------- testbench ------------------
initial begin
    #8;
    repeat (100) begin
        pc_next = $random();
        #10;
        if(pc_current !== pc_next)begin
            $display("hata beklenen = %0d, alinan = %0d",pc_next,pc_current);
            error_count++;
        end
    end

    if(error_count == 0) begin
        $display("HIC HATA YOK ");
    end
    $finish;
end


endmodule
