/*
   --- OBSIDYEN RISC-V CORE ---

    Module : Instruction memory modülü
    Author : Furkan YILDIRIM

    Note: 
        - şu anlık sadece register ile beraber instruction fetch işlemi yapıyor
    
*/



// kombinasyonel olarak address girdisinden sonra pdelay zaman sonra data çıktısı alınır
module instruction_memory
    import riscv_pkg::*;
(
    input logic [XLEN-1:0] addr_i,
    output logic [XLEN-1:0] instr_o
);

localparam INSTR_ADDR = 2048;

logic  [XLEN-1:0] instr_mem [INSTR_ADDR-1:0] ; // instruction memory - word adreslenebilir


// test icin basit bir program yukleme
initial begin
    $readmemh("./memory/data_mem_non_algm_test.hex", instr_mem);
end



// kombinasyonel islemler
always_comb begin
    instr_o = instr_mem[addr_i[$clog2(INSTR_ADDR*4)-1:2]]; // word aligned adresleme
end


endmodule
