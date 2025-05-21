module data_memory_tb;
    import riscv_pkg::*;

    // ---------- waveform olusturma  ---------
    initial begin
        $dumpfile("dumb.vcd");
        $dumpvars();
    end

    // ----------- gerekli degiskenler -----------
    logic                         clk;
    logic [31:0]                  data_addr;
    logic [31:0]                  data_write_data;
    logic                         mem_read;
    logic                         mem_write;
    logic [1:0]                   mem_size;
    logic                         unsigned_load;
    logic [31:0]                  data_read_data;

    logic [31:0]                  exp_data_read_data;

    integer file, read, error_count = 0, line = 1;
    integer log_file;

    // ------ design under test ------------
    data_memory dut(
        .clk(clk),
        .mem_read(mem_read),
        .mem_write(mem_write),
        .mem_size(mem_size),
        .unsigned_load(unsigned_load),
        .data_addr(data_addr),
        .data_write_data(data_write_data),
        .data_read_data(data_read_data)
    );

    initial clk = 0;
    initial forever #5 clk = ~clk;

    // ----------- testbench -------------
    initial begin
        #7;
        file = $fopen("./test/data_memory_tb_full.txt", "r");
        log_file = $fopen("./test/log/data_memory_log.txt", "w");
        if (file == 0) $fatal("Veri dosyası açılamadı");
        if (log_file == 0) $fatal("Log dosyası açılamadı");

        mem_write = 1;
        mem_read  = 0;

        for (int i = 0; i < 1024; i++) begin
            read = $fscanf(file, "%h %h %b %b\n", data_addr, data_write_data, mem_size, unsigned_load);
            #10;
            line++;
        end

        mem_write = 0;
        mem_read  = 1;
        #20;

        for (int i = 0; i < 1024; i++) begin
            read = $fscanf(file, "%h %b %b %h\n", data_addr, mem_size, unsigned_load, exp_data_read_data);
            #10;
            isTrue(exp_data_read_data, data_read_data);
            line++;
        end

        if (error_count == 0)
            $fdisplay(log_file, "✅ HATA YOK.");
        else
            $fdisplay(log_file, "❌ %0d HATA TESPIT EDILDI.", error_count);

        $fclose(file);
        $fclose(log_file);
        $finish;
    end

    task isTrue(input logic [31:0] exp_data, input logic [31:0] data);
        if (exp_data !== data) begin
            $fdisplay(log_file, "x HATA, beklenen = %0h, alinan = %0h, satir = %0d", exp_data, data, line);
            error_count++;
        end
    endtask

endmodule
