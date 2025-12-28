/*
OBSIDYEN RISC-V CORE

instruction memory testbench modülü


*/


module instruction_memory_tb 
    import riscv_pkg::*;
();

logic [XLEN-1:0] addr_i;
logic [XLEN-1:0] instr_o;

instruction_memory dut (
    .addr_i(addr_i),
    .instr_o(instr_o)
);


// okuma testi

initial begin

    int i = 0;
    for (i = 0; i < 110; i++) begin
        addr_i = i * 4;
        #5ns;
        $display("addr_i: %d, instr_o: %h", addr_i/4, instr_o);
    end

    addr_i = 32'h0000_0000;
    #5ns;
    assert (instr_o == 32'h00a00093 ) 
    else 
        $error("Hata: addr_i = %h için beklenen instr_o = %h, alınan instr_o = %h", addr_i, 32'h00a00093, instr_o);
    $display("1. satirdaki okuma dogru");


    addr_i = 32'h0000_0004;
    #5ns;
    assert (instr_o == 32'h00500113 ) 
    else 
        $error("Hata: addr_i = %h için beklenen instr_o = %h, alınan instr_o = %h", addr_i, 32'h00500113, instr_o);
    $display("2. satirdaki okuma dogru");


    addr_i = 32'h0000_01b4;
    #5ns;
    assert (instr_o == 32'h0000_0069)
    else 
        $error("Hata: addr_i = %h için beklenen instr_o = %h, alınan instr_o = %h", addr_i, 32'h0000_0069, instr_o);
    $display("110. satirdaki  okuma dogru");


    addr_i = 32'h0000_009c;
    #5ns;
    assert (instr_o == 32'h6789ae17)
    else
        $error("Hata: addr_i = %h için beklenen instr_o = %h, alınan instr_o = %h", addr_i, 32'h0000_009c, instr_o);
    $display("40. satırdaki okuma dogru");

    $display("test tamamlandi");
    $finish;
end


endmodule
