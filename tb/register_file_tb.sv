module register_file_tb;

    initial begin
        $dumpfile("dumb.vcd");
        $dumpvars();
    end
    import riscv_pkg::*;

    logic                      clk;
    logic                      rst_n;
    logic                      reg_write_enable;       
    logic [REG_ADDR_WIDTH-1:0] rs1_addr;               
    logic [REG_ADDR_WIDTH-1:0] rs2_addr;               
    logic [REG_ADDR_WIDTH-1:0] rd_addr;                
    logic [XLEN-1:0]           write_data;             
    logic [XLEN-1:0]           rs1_data;               
    logic [XLEN-1:0]           rs2_data;

    //design under test
    register_file dut(
        .clk              (clk),
        .rst_n            (rst_n),
        .reg_write_enable (reg_write_enable),
        .rs1_addr         (rs1_addr),
        .rs2_addr         (rs2_addr),
        .rd_addr          (rd_addr),
        .write_data       (write_data),
        //outputs
        .rs1_data         (rs1_data),
        .rs2_data         (rs2_data)
    );
    logic [XLEN-1:0]           exp_rs1_data;               
    logic [XLEN-1:0]           exp_rs2_data;
    int test_number = 200;


    //clock üretimi
    initial clk =0;
    initial forever begin
        #5;
        clk = ~clk;
    end
    //resetleme
    initial begin
        rst_n = 0;
        #5;
        rst_n = 1; 
    end

    integer file, read, line = 1, error_count = 0;
    initial begin
        file = $fopen("./test/register_file.txt","r");
        if (file == 0) begin
            $fatal("Dosya açılamadı!");
        end

        // register'lara degerler yazilir.
        #8;
        reg_write_enable = 1;
        for (int i = 0; i<32; i++) begin
            read = $fscanf (file, "%h",write_data); 
            rd_addr = i[4:0];             // yalnızca alt 5 biti al
            #10;  
            line++;
        end
        reg_write_enable = 0; 
        // register'lardan veri okumasi yapilir
        // okuma sirasi:
        // rs1_addr rs2_addr rs1_data rs2_data
        repeat(32) begin
            read = $fscanf (file, "%h %h %h %h",rs1_addr, rs2_addr,exp_rs1_data,exp_rs2_data);
            #10;
            isTrue(exp_rs1_data,exp_rs2_data,rs1_data,rs2_data);
            line++;


        end

        if(error_count == 0) begin
            $display ("HIC hata yok!");
        end
        else begin
            $display ("HATA sayisi = %d",error_count);
        end
        
        $finish;
        
    end

    task isTrue (input logic [XLEN-1:0] exp_rs1_data,exp_rs2_data,rs1_data,rs2_data);

        if (exp_rs1_data !== rs1_data ) begin
            $display ("X hatali okunan deger, satir= %0d",line);
            $display ("beklenen= %8h, okunan= %8h \n",exp_rs1_data,rs1_data);
            error_count++;
        end

        if (exp_rs2_data !== rs2_data) begin
            $display ("X hatali okunan deger satir= %0d",line);
            $display ("beklenen= %8h, okunan= %8h \n",exp_rs2_data,rs2_data);
            error_count++;
        end
    endtask 


endmodule
