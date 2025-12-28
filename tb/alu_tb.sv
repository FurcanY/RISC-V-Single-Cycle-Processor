

module alu_tb
    import riscv_pkg::*; 
();

alu_operation_e      alu_op_i;
logic [31:0]         op_a_i;
logic [31:0]         op_b_i;
logic [31:0]         result_o;
logic                zero_o;

// Hata Sayacı
int error_count = 0;
int test_count = 0;


// DUT baslatma
alu dut (
    .alu_op_i   (alu_op_i),
    .op_a_i     (op_a_i),
    .op_b_i     (op_b_i),
    .result_o   (result_o),
    .zero_o     (zero_o)
);




    // -------------------------------------------------------------------------
    // 4. Test Senaryoları
    // -------------------------------------------------------------------------
    initial begin
        $display("--------------------------------------------------");
        $display("--- RV32I ALU TESTBENCH STARTED ---");
        $display("--------------------------------------------------");

        // --- A. DIRECTED TESTS (Temel Durumlar) ---
        $display("Testing Basic Arithmetic...");
        check_alu(ALU_ADD, 32'd10, 32'd20, "Simple ADD");
        check_alu(ALU_SUB, 32'd20, 32'd5,  "Simple SUB");
        check_alu(ALU_SUB, 32'd10, 32'd20, "Negative Result SUB"); // 10 - 20 = -10 (FFFFFFF6)

        // --- B. CORNER CASES (Köşe Durumlar) ---
        $display("Testing Corner Cases...");
        // 1. Sıfır Testi
        check_alu(ALU_ADD, 32'd0, 32'd0, "Zero + Zero");
        // 2. Max Değer (Overflow)
        check_alu(ALU_ADD, 32'hFFFFFFFF, 32'd1, "Overflow Check");
        // 3. Shift Sınırları
        check_alu(ALU_SLL, 32'hFFFFFFFF, 32'd0,  "Shift Left 0");
        check_alu(ALU_SLL, 32'hFFFFFFFF, 32'd31, "Shift Left 31");
        // 4. Aritmetik vs Mantıksal Kaydırma Farkı
        // Negatif sayıyı sağa kaydırınca SRA 1 doldurmalı, SRL 0 doldurmalı.
        check_alu(ALU_SRL, 32'hFFFF0000, 32'd4,  "SRL Negative Num"); 
        check_alu(ALU_SRA, 32'hFFFF0000, 32'd4,  "SRA Negative Num"); 

        // --- C. COMPARISON TESTS (Karşılaştırma) ---
        $display("Testing Comparisons...");
        // -5 < 2 ? (Signed: Evet, Unsigned: Hayır çünkü -5 büyük bir pozitif gibi görünür)
        check_alu(ALU_SLT,  -32'd5, 32'd2, "SLT Signed (-5 < 2)");  // Exp: 1
        check_alu(ALU_SLTU, -32'd5, 32'd2, "SLTU Unsigned (-5 < 2)"); // Exp: 0

        // --- D. RANDOMIZED TESTING (Rastgele Testler) ---
        $display("Starting Randomized Tests (1000 iterations)...");
        for (int i = 0; i < 1000; i++) begin
            alu_operation_e rand_op;
            logic [31:0] rand_a;
            logic [31:0] rand_b;

            // Rastgele değerler üret
            // Enum'u cast etmemiz lazım çünkü randomize direkt enum döndürmez
            rand_op = alu_operation_e'($urandom_range(0, {28'b0,ALU_AND}));
            rand_b = $urandom();

            check_alu(rand_op, rand_a, rand_b, "Random Test");
        end

        // -------------------------------------------------------------------------
        // 5. Raporlama
        // -------------------------------------------------------------------------
        $display("--------------------------------------------------");
        if (error_count == 0) begin
            $display("Test Completed Successfully!");
            $display("Total Tests: %0d", test_count);
            $display("Status: PASSED ");
        end else begin
            $display("Test Failed!");
            $display("Total Errors: %0d", error_count);
            $display("Status: FAILED ");
        end
        $display("--------------------------------------------------");
        $finish;
    end


// Test sayacı ve hata sayacı
task check_alu(input alu_operation_e op, input [31:0] a, input [31:0] b, string test_name);

        logic [31:0] expected_result;
        logic        expected_zero;
        
        // Girişleri Sür
        alu_op_i = op;
        op_a_i   = a;
        op_b_i   = b;

        // küçük bekleme
        #5; 

        // Referans
        case (op)
            ALU_ADD:  expected_result = a + b;
            ALU_SUB:  expected_result = a - b;
            ALU_AND:  expected_result = a & b;
            ALU_OR:   expected_result = a | b;
            ALU_XOR:  expected_result = a ^ b;
            ALU_SLL:  expected_result = a << b[4:0];
            ALU_SRL:  expected_result = a >> b[4:0];
            ALU_SRA:  expected_result = $signed(a) >>> b[4:0];
            ALU_SLT:  expected_result = ($signed(a) < $signed(b)) ? 32'd1 : 32'd0;
            ALU_SLTU: expected_result = (a < b) ? 32'd1 : 32'd0;
            default:  expected_result = 32'd0;
        endcase

        expected_zero = (expected_result == 32'd0);

        // Kontrol Mekanizması
        test_count++;
        if (result_o !== expected_result || zero_o !== expected_zero) begin
            $display("[FAIL] %s | Op: %s | A: %h | B: %h", test_name, op.name(), a, b);
            $display("       Expected: %h (Z:%b)", expected_result, expected_zero);
            $display("       Actual:   %h (Z:%b)", result_o, zero_o);
            error_count++;
        end
endtask

endmodule
