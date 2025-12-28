/*
    OBSIDYEN RISC-V CORE
    Author : Furkan YILDIRIM

    CORE MODEL TESTBENCH

    Note:
        - update_o sinyali single cycle processor için 1'b1 verilir.

*/

module obsidyen_core_tb 
    import riscv_pkg::*;
();

logic            clk_i      ;
logic            rst_ni     ;   
logic [XLEN-1:0] pc_o       ;       
logic [XLEN-1:0] instr_o    ;    
logic [     4:0] reg_addr_o ; 
logic [XLEN-1:0] reg_data_o ; 
logic            update_o   ;

integer file_pointer;
localparam CLOCK_PERIOD = 10ns;

/* --- DUT --- */
obsidyen_core dut(
    .clk_i      (clk_i      ),
    .rst_ni     (rst_ni     ),
    .pc_o       (pc_o       ),
    .instr_o    (instr_o    ),
    .reg_addr_o (reg_addr_o ),
    .reg_data_o (reg_data_o ),
    .update_o   (update_o   )   
);

/* --- VCD FILE --- */
initial begin
    $dumpfile("./file_vcd/obsidyen_core.vcd");
    $dumpvars(0, obsidyen_core_tb);
end

/* --- Instruction Memory Initialize --- */
/*
// bunu yapınca işlemiyor. yine instruction_memory.sv içindeki readmemh işlevini gerçekleştiriyor
initial begin
    $readmemh ("./memory/golden_mem.hex",dut.i_mem.instr_mem);
end
*/
/* --- DUMP FILE --- */
initial begin

    file_pointer = $fopen ("./logs/obsidyen_core_dump.log","w");
    // ilk instruction fetch için 2 clock cycle beklenir
    #(CLOCK_PERIOD * 2);

    forever begin
        // clk_i tetiklendiği zaman verileri okuabiliriz.
        @(posedge clk_i);
        
        // register işlemleri olmayınca reg_addr_o = 0 olur
        if (reg_addr_o == 0 )
            $fdisplay(file_pointer, "0x%8h (0x%8h)", pc_o, instr_o);
        else begin

            if (reg_addr_o > 9) begin
                $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d 0x%8h", pc_o, instr_o, reg_addr_o, reg_data_o);
            end

            else begin
                $fdisplay(file_pointer, "0x%8h (0x%8h) x%0d  0x%8h", pc_o, instr_o, reg_addr_o, reg_data_o);
            end
        end
    end


end


/* --- CLOCK GENERATOR --- */
initial begin
        clk_i = 1'b0;
        forever #(CLOCK_PERIOD / 2) clk_i = ~clk_i;
end

/* --- TB RESULT --- */
initial begin

rst_ni = 0;
#(CLOCK_PERIOD *2);
rst_ni = 1;

#(CLOCK_PERIOD * 2000);

dut.d_mem.dump_memory_contents("./logs/data_memory_dump.log");

$finish;

end

endmodule
