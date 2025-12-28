/*
    python klasörü içerisinde imm_extend_generator.py dosyası ile
    çeşitli immediate tipleri için genişletilmiş immediate değerleri
    üreten bir script bulunmaktadır.

    bu scirpt ile 50 farklı immediate değeri için genişletilmiş immediate
    değerleri üretilip decoded_imm.txt dosyasına  kaydedilmiştir.

*/

module imm_extend_unit_tb 
    import riscv_pkg::*;
();
    
immediate_type_e   imm_source;
logic [XLEN-1:0]   imm_instruction;
logic [XLEN-1:0]   imm_extended;

logic [XLEN-1:0] instructions      [0:49];

logic [XLEN-1:0] expected_extended [0:49];

// DUT baslatma
imm_extend_unit dut (
    .imm_source      (imm_source),
    .imm_instruction (imm_instruction),
    .imm_extended    (imm_extended)
);

initial begin: load_instructions

    instructions = '{
        32'b00010000000000000000000010010111,
        32'b10101011110011011110000100110111,
        32'b01111111111100001000000110010011,
        32'b11111111111100010000001000010011,
        32'b00000000010000100001001010010011,
        32'b00000000001000101101001100010011,
        32'b00000111111100110111001110010011,
        32'b11111111111100111100010000010011,
        32'b00010000000000000000010100010111,
        32'b11111110011101010000010100010011,
        32'b00010000000000000000011000010111,
        32'b11111101100001100000011000010011,
        32'b00000000000001100010010110000011,
        32'b00010000000000000000011000010111,
        32'b11111101000001100000011000010011,
        32'b00000000000001100001011010000011,
        32'b00000000000001100101011100000011,
        32'b00010000000000000000011000010111,
        32'b11111100001001100000011000010011,
        32'b00000000000001100000011110000011,
        32'b00010010001000110011100000010111,
        32'b00000010110010000000100000010011,
        32'b00000001000001010010000000100011,
        32'b00000001000001010001001000100011,
        32'b00000001000001010000001100100011,
        32'b11111110101101010010111000100011,
        32'b00000001000001011000100010110011,
        32'b00000001000001011100100100110011,
        32'b00000001001010001111100110110011,
        32'b00000001000110001000100001100011,
        32'b11101010110110111110101000010111,
        32'b00001110111110100000101000010011,
        32'b00000001110000000000000001101111,
        32'b00000000000100000000101000010011,
        32'b00000001001010001001011001100011,
        32'b00000000001000000000101010010011,
        32'b00000000110000000000000001101111,
        32'b11101010110110111110101010010111,
        32'b00001110111110101000101010010011,
        32'b00000001000000000000110011101111,
        32'b11101010110110111110101100010111,
        32'b00001110111110110000101100010011,
        32'b00000001110000000000000001101111,
        32'b00000000000100000000101100010011,
        32'b00000000010011001000110101100111,
        32'b11101010110110111110101110010111,
        32'b00001110111110111000101110010011,
        32'b00000000100000000000000001101111,
        32'b00000000000100000000101110010011,
        32'b00000000000000000000000001101111
    };
end


    initial begin: load_expected_extended
        expected_extended = '{
            32'h10000000,
            32'hABCDE000,
            32'h000007FF,
            32'hFFFFFFFF,
            32'h00000004,
            32'h00000002,
            32'h0000007F,
            32'hFFFFFFFF,
            32'h10000000,
            32'hFFFFFFE7,
            32'h10000000,
            32'hFFFFFFD8,
            32'h00000000,
            32'h10000000,
            32'hFFFFFFD0,
            32'h00000000,
            32'h00000000,
            32'h10000000,
            32'hFFFFFFC2,
            32'h00000000,
            32'h12233000,
            32'h0000002C,
            32'h00000000,
            32'h00000004,
            32'h00000006,
            32'hFFFFFFFC,
            32'hDEADBEEF,
            32'hDEADBEEF,
            32'hDEADBEEF,
            32'h00000010,
            32'hEADBE000,
            32'h000000EF,
            32'h0000001C,
            32'h00000001,
            32'h0000000C,
            32'h00000002,
            32'h0000000C,
            32'hEADBE000,
            32'h000000EF,
            32'h00000010,
            32'hEADBE000,
            32'h000000EF,
            32'h0000001C,
            32'h00000001,
            32'h00000004,
            32'hEADBE000,
            32'h000000EF,
            32'h00000008,
            32'h00000001,
            32'h00000000
        };
    end



// test senaryosu
initial begin: test

    for (int i = 0; i < 50; i++) begin
        // instruction yükle
        imm_instruction = instructions[i];

        // immediate tipini belirle
        imm_source = get_imm_type_func(imm_instruction[6:0]);


        // küçük bir bekleme süresi
        #1ns;

        // sonucu kontrol et
        assert (imm_extended === expected_extended[i])
        else 
            $error("Test %0d başarısız: instruction = %h, beklenen = %h, alınan = %h",
                        i, imm_instruction, expected_extended[i], imm_extended);
    end

    $display("Tüm testler tamamlandı.");
    $finish;

end


function automatic immediate_type_e get_imm_type_func(input logic [6:0] opcode);
    case (opcode)
        // U-type instructions
        7'b0110111,
        7'b0010111: get_imm_type_func = IMM_U;
        
        // J-type instructions
        7'b1101111: get_imm_type_func = IMM_J;
        
        // I-type instructions
        7'b1100111,
        7'b0000011,
        7'b0010011,
        7'b1110011: get_imm_type_func = IMM_I;
        
        // S-type instructions
        7'b0100011: get_imm_type_func = IMM_S;
        
        // B-type instructions
        7'b1100011: get_imm_type_func = IMM_B;
        
        // R-type (NOT: R-type için immediate yok, IMM_NONE kullanılmalı)
        7'b0110011: get_imm_type_func = IMM_NONE;
        
        // Default (varsayılan I-type değil, IMM_NONE)
        default: get_imm_type_func = IMM_NONE;
    endcase
endfunction


endmodule
