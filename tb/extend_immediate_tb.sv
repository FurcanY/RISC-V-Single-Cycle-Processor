module extend_immediate_tb;
    import riscv_pkg::*;

    immediate_type_e   imm_source      ; 
    logic [XLEN-1:0]   imm_instruction ; 
    logic [XLEN-1:0]   imm_extended    ; 

    extend_immediate dut(
        .imm_source      (imm_source      ), 
        .imm_instruction (imm_instruction ),      
        .imm_extended    (imm_extended    )       
    );

    /*
        dosya okuma sirasi
        imm_instruction imm_extended imm_source
    
    */
    //----------- gerekli değişkenler --------------
    immediate_type_e   exp_imm_source      ; 
    logic [XLEN-1:0]   exp_imm_instruction ; 
    logic [XLEN-1:0]   exp_imm_extended    ; 

    integer file, read, line = 1, error_count = 0;
    int signal_value; //enum değerini cast etmek için

    //---------- waveform olusturma ----------------
    initial begin
    $dumpfile("dumb.vcd");
        $dumpvars(); 
    end


    //-------- dosya okuma ve test etme -------------
    initial begin

        file = $fopen("./test/immediate_extend.txt","r");

        if (file == 0) 
            $fatal("dosya acilamadi!");



        while(!$feof(file))begin
            read = $fscanf (file,"%h %h %d\n",imm_instruction,exp_imm_extended,signal_value);
            imm_source = immediate_type_e'(signal_value); //enum cast islemi
            #10;
            isTrue(imm_extended,exp_imm_extended);
            line++;
        end

        //son sonucların yazilmasi
        if (error_count == 0) begin
            $display("Hic HATA YOK :) ");
        end
    end

    task  isTrue(input [XLEN-1:0] imm_extended, input [XLEN-1:0] exp_imm_extended);
        
        if (imm_extended !== exp_imm_extended ) begin
            $display ("X HATALI,\n beklenen= %0h, alinan= %0h \t satir = %0d \n",exp_imm_extended,imm_extended, line);
            error_count++;
        end

    endtask


endmodule
