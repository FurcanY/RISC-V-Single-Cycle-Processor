module instruction_memory
    import riscv_pkg::*;
(
    input  logic [XLEN-1:0]   pc_in,            // instruction memory'e girilen pc değeri
    output logic [XLEN-1:0]   instruction       // dışarı verilen instruction
);

    logic [XLEN-1:0] instruction_mem [MEM_SIZE-1:0];       // Word-addressable memory

    initial begin
        $readmemh("./test/instruction_tests/golden_model.hex", instruction_mem);  // Test programını yükle
    end

    assign instruction = instruction_mem[pc_in[$clog2(MEM_SIZE*4)-1:2]];  // 1024 = 2^10 -> 10 bitlik bu adresin 2 sağ shift edilmiş hali alınmalıdır.

endmodule


/*

==============================================================
TESTBENCH çağırılırken, gerekli olan instruction eklenmeli
$readmemh("./test/test_1.hex", instruction_mem);  
==============================================================

*/
