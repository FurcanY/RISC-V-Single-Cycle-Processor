module branch_unit_tb
    import riscv_pkg::*;
();

    logic [2:0]  funct3;
    logic        alu_zero_i;
    logic        alu_result_lsb;
    logic        is_branch_op;
    logic        branch_taken_o;

    // DUT instantiation
    branch_unit dut (
        .funct3(funct3),
        .alu_zero_i(alu_zero_i),
        .alu_result_lsb(alu_result_lsb),
        .is_branch_op(is_branch_op),
        .branch_taken_o(branch_taken_o)
    );

    int error_count;
    int total_count;
    logic expected_branch_taken;

    // Test Baslangici
    initial begin : branch_test

        error_count = 0;
        total_count = 0;

        $display("Manuel Test Basliyor:");

        // --- TEST 1: BEQ (Eşitlik Var) ---
        funct3 = F3_BEQ;
        alu_zero_i = 1;
        alu_result_lsb = 0;
        is_branch_op = 1;
        #10;
        total_count++;

        isBranch(funct3, alu_zero_i, alu_result_lsb, is_branch_op, expected_branch_taken);
        if (branch_taken_o !== expected_branch_taken) begin
            $error("Test 1 Basarisiz (BEQ): Beklenen: %0b, Karsilasilan: %0b", expected_branch_taken, branch_taken_o);
            error_count++;
        end

        // --- TEST 2: BNE (Eşitlik Yok) ---

        funct3 = F3_BNE;
        alu_zero_i = 0; // Eşit değil, zıplamalı
        alu_result_lsb = 0;
        is_branch_op = 1;
        #10;
        total_count++;

        isBranch(funct3, alu_zero_i, alu_result_lsb, is_branch_op, expected_branch_taken);
        if (branch_taken_o !== expected_branch_taken) begin
            $error("Test 2 Basarisiz (BNE): Beklenen: %0b, Karsilasilan: %0b", expected_branch_taken, branch_taken_o);
            error_count++;
        end

        // --- TEST 3: BLT (Küçüktür) ---
        funct3 = F3_BLT;
        alu_zero_i = 0;
        alu_result_lsb = 1; // Küçük (Sonuç 1)
        is_branch_op = 1;
        #10;
        total_count++;

        isBranch(funct3, alu_zero_i, alu_result_lsb, is_branch_op, expected_branch_taken); 
        if (branch_taken_o !== expected_branch_taken) begin
            $error("Test 3 Basarisiz (BLT): Beklenen: %0b, Karsilasilan: %0b", expected_branch_taken, branch_taken_o);
            error_count++;
        end

        $display ("Manuel Test Tamamlandi");
        $display("Karisik Test Basliyor:");

        // --- KARISIK TEST ---
        for (int i = 0; i < 150; i++) begin
            // cast işlemi ile bit sorununu kaldırırız
            funct3 = 3'($urandom_range(0, 7)); 
            alu_zero_i = 1'($urandom_range(0, 1));
            alu_result_lsb = 1'($urandom_range(0, 1));
            is_branch_op = 1'($urandom_range(0, 1));
            #5;
            total_count++;

            isBranch(funct3, alu_zero_i, alu_result_lsb, is_branch_op, expected_branch_taken);
            if (branch_taken_o !== expected_branch_taken) begin
                $error("Rand Test Basarisiz: funct3=%0d, Zero=%0b, ResLSB=%0b, is_br=%0b. Beklenen: %0b, Gercek: %0b",
                    funct3, alu_zero_i, alu_result_lsb, is_branch_op, expected_branch_taken, branch_taken_o);
                error_count++;
            end
        end

        $display ("Karisik Test Tamamlandi");

        $display ("---------------------------------------------------");
        if (error_count == 0)
            $display ("TUM TESTLER BASARILI! (Toplam: %0d)", total_count);
        else
            $display ("TESTLER BASARISIZ! (Hata: %0d / %0d)", error_count, total_count);
        $display ("---------------------------------------------------");

        $finish;
    
    end



    task isBranch(
        input [2:0]  funct3,
        input        alu_zero_i,
        input        alu_result_lsb,
        input        is_branch_op,
        output logic expected_branch_taken
    );
        expected_branch_taken = 1'b0;
        
        if (is_branch_op == 0) begin
            expected_branch_taken = 1'b0;
            return;
        end

        case (funct3)
            F3_BEQ:  
                if (alu_zero_i == 1) expected_branch_taken = 1'b1;
            
            F3_BNE:  
                // DÜZELTME: BNE, Zero==0 ise (Eşit Değilse) zıplar!
                if (alu_zero_i == 0) expected_branch_taken = 1'b1; 
            
            F3_BLT:  
                if (alu_result_lsb == 1) expected_branch_taken = 1'b1;
            
            F3_BGE:  
                if (alu_result_lsb == 0) expected_branch_taken = 1'b1;
            
            F3_BLTU: 
                if (alu_result_lsb == 1) expected_branch_taken = 1'b1;
            
            F3_BGEU: 
                if (alu_result_lsb == 0) expected_branch_taken = 1'b1;
            
            default:
                 // Beklenmeyen funct3 durumunda branch yapmasın (0 kalsın)
                 expected_branch_taken = 1'b0; 
        endcase
        
    endtask

endmodule
