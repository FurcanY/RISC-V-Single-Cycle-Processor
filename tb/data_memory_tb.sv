module data_memory_tb;
    import riscv_pkg::*;


// ---------- waveform olusturma  ---------
initial begin
    $dumpfile("dumb.vcd");
    $dumpvars();
end


// ----------- gerekli degiskenler -----------
logic                         clk               ;
logic [$clog2(DMEM_SIZE)-1:0] data_addr         ;
logic [XLEN-1:0]              data_write_data   ;
logic                         data_write_enable ;
logic [XLEN-1:0]              data_read_data    ;

integer file,read,error_count = 0,line = 1;

logic [XLEN-1:0]              exp_data_read_data;


// ------ design under test ------------
data_memory dut(
  .clk              (clk              ),              
  .data_addr        (data_addr        ),        
  .data_write_data  (data_write_data  ),  
  .data_write_enable(data_write_enable),
  .data_read_data   (data_read_data   )
);

initial clk = 0;
initial data_write_enable = 1;

initial forever begin
   #5;
   clk = ~clk; 
end

// -----------testbench -------------

initial begin
    #7;
    file = $fopen("./test/data_memory_tb.txt","r");
    if(file == 0) $fatal("dosya acilamadi");

    repeat (1024) begin
        read = $fscanf(file,"%h %h\n",data_addr,data_write_data);
        #10;
        line++;
    end
    data_write_enable = 0;
    #50; //waveformda anlamak için
    for (int i = 0; i<1024; i++) begin
        read = $fscanf(file,"%h\n",exp_data_read_data);
        data_addr = i[$clog2(DMEM_SIZE)-1:0];
        #10;
        isTrue (exp_data_read_data,data_read_data);
        line++;
    end

    if(error_count == 0)begin
        $display("HATA YOK");
    end
    $finish;
end

task  isTrue(input logic [XLEN-1:0]exp_data, input logic [XLEN-1:0] data);

    if ( exp_data !== data) begin
        $display("x HATA, beklenen = %0h, alinan = %0h, satir = %0d",exp_data,data,line);
        error_count++;
    end
endtask


endmodule
