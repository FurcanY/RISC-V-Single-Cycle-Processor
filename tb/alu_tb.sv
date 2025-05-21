/*
    test dosyasından okunacak verilerin sıralaması:
    source_a  
    source_b  
    alu_op  
    result  
    zero  
    negative  
    carry  
    overflow
*/
module alu_tb; 
    import riscv_pkg::*;

logic [XLEN-1:0] source_a      ; 
logic [XLEN-1:0] source_b      ; 
alu_op_e         alu_control   ; 
logic [XLEN-1:0] alu_result    ; 
logic            zero_flag     ;  
logic            negative_flag ;  
logic            carry_flag    ;  
logic            overflow_flag ; 

// waveform dosyaları
initial begin
    $dumpfile("dumb.vcd");
    $dumpvars();
end

//design under unit
alu dut(
    .source_a      (source_a)      ,
    .source_b      (source_b)      ,
    .alu_control   (alu_control)   ,
    .alu_result    (alu_result)    ,
    .zero_flag     (zero_flag)     ,
    .negative_flag (negative_flag) ,
    .carry_flag    (carry_flag)    ,
    .overflow_flag (overflow_flag)
);

// Beklenen değerler
logic [31:0] expected_result;
logic expected_zero, expected_negative, expected_carry, expected_overflow;
int op_val;

// Dosya okuma
integer file, r, line = 0, error_count = 0;
initial begin
    source_a     = 0;
    source_b     = 0;
    alu_control  = ALU_ADD;  // Default operation
end
initial begin
    #20;
    file = $fopen("./test/alu_test.txt", "r");
    if (file == 0) begin
        $fatal("Dosya acilamadi");
    end

    while (!$feof(file)) begin
        r = $fscanf(file, "%h %h %d %h %d %d %d %d\n",
                    source_a, source_b, op_val, 
                    expected_result,
                    expected_zero, expected_negative, expected_carry, expected_overflow);
        alu_control = alu_op_e'(op_val);  // enum cast işlemi
        #10;  // ALU hesaplasın

        // Karşılaştırma
        if (alu_result !== expected_result ||
            zero_flag !== expected_zero ||
            negative_flag !== expected_negative ||
            carry_flag !== expected_carry ||
            overflow_flag !== expected_overflow) begin            
            $display("\nHATA: Satir %0d", line);
            $display("Operasyon: %0s", alu_control.name());
            $display("A (source_a) = %h", source_a);
            $display("B (source_b) = %h", source_b);
            $display("Beklenen: R=%h Z=%b N=%b C=%b O=%b",
                        expected_result, expected_zero, expected_negative, expected_carry, expected_overflow);
            $display("Gerçek  : R=%h Z=%b N=%b C=%b O=%b\n",
                        alu_result, zero_flag, negative_flag, carry_flag, overflow_flag);
            error_count++;
        end

        line++;
    end

    $fclose(file);

    if (error_count == 0)
        $display("\n✅ Tüm testler başarılı! (%0d satir)", line);
    else
        $display("\n❌ %0d satirda hata bulundu.", error_count);

    $finish;
end
    
endmodule
