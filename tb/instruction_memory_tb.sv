module instruction_memory_tb;
    import riscv_pkg::*;

    logic [XLEN-1:0]   pc_in;       
    logic [XLEN-1:0]   instruction;

    instruction_memory dut(
        .pc_in       (pc_in),            
        .instruction (instruction)           
    );

    integer file, read, line = 0, error_count = 0;
    logic [XLEN-1:0] expected_instruction;

    initial begin 
        pc_in = 0;

        file = $fopen("./test/test_1.hex","r");
        if (file == 0) begin
            $fatal("Dosya açılamadı!");
        end
        #5;

        while (1) begin
            read = $fscanf(file, "%h", expected_instruction);
            if (read != 1) break; // dosya bitti ya da hatalı satır
            #5;
            isTrue(expected_instruction, instruction, line);
            line++;
            pc_in += 4; //word okuma yapıldığı için 4 eklenir.
            #1;
        end

        if (error_count == 0) begin
            $display(" Hata yok, tüm okumalar doğru!");
        end else begin
            $display(" Hata sayısı = %0d", error_count);
        end
        $finish;
    end

    task isTrue(input logic [XLEN-1:0] exp_instr, instr, input int line_no);
        if (exp_instr !== instr) begin
            $display(" Hatalı okuma! Satır = %0d", line_no);
            $display("  Beklenen = %0h, Oluşan = %0h", exp_instr, instr);
            error_count++;
        end
    endtask

endmodule
