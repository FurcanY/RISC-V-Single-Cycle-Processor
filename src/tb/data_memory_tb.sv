module data_memory_tb;
    import riscv_pkg::*;

    // Clock generation
    logic clk;
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end

    // Testbench signals
    logic [$clog2(DMEM_SIZE)-1:0] data_addr;
    logic [XLEN-1:0] data_write_data;
    logic data_write_enable;
    logic [2:0] mem_width;
    logic mem_unsigned;
    logic [XLEN-1:0] data_read_data;

    // File handle for reading test vectors
    integer file;
    integer scan_file;
    integer num_tests = 0;
    integer num_passed = 0;

    // Instantiate the data memory module
    data_memory dut (
        .clk(clk),
        .data_addr(data_addr),
        .data_write_data(data_write_data),
        .data_write_enable(data_write_enable),
        .mem_width(mem_width),
        .mem_unsigned(mem_unsigned),
        .data_read_data(data_read_data)
    );

    // Test vector structure
    typedef struct packed {
        logic [31:0] addr;
        logic [31:0] write_data;
        logic write_enable;
        logic [2:0] mem_width;
        logic mem_unsigned;
        logic [31:0] expected_read;
    } test_vector_t;

    // Task to apply test vector
    task apply_test_vector(input test_vector_t vec);
        @(posedge clk);
        data_addr = vec.addr[$clog2(DMEM_SIZE)-1:0];  // Truncate address to fit
        data_write_data = vec.write_data;
        data_write_enable = vec.write_enable;
        mem_width = vec.mem_width;
        mem_unsigned = vec.mem_unsigned;
        
        // Wait for read data to be valid
        @(posedge clk);
        
        // Check read data
        if (data_read_data === vec.expected_read) begin
            $display("✅ Test passed: addr=0x%h, write_data=0x%h, width=%b, unsigned=%b, read=0x%h",
                    vec.addr, vec.write_data, vec.mem_width, vec.mem_unsigned, data_read_data);
            num_passed++;
        end else begin
            $display("❌ Test failed: addr=0x%h, write_data=0x%h, width=%b, unsigned=%b",
                    vec.addr, vec.write_data, vec.mem_width, vec.mem_unsigned);
            $display("  Expected: 0x%h", vec.expected_read);
            $display("  Got:      0x%h", data_read_data);
        end
        num_tests++;
    endtask

    // Main test process
    initial begin
        // Initialize signals
        data_addr = 0;
        data_write_data = 0;
        data_write_enable = 0;
        mem_width = 0;
        mem_unsigned = 0;

        // Open test vector file
        file = $fopen("data_memory_tb.log", "r");
        if (file == 0) begin
            $display("Error: Could not open data_memory_tb.log");
            $finish;
        end

        // Read and apply test vectors
        while (!$feof(file)) begin
            test_vector_t vec;
            scan_file = $fscanf(file, "%h %h %b %b %b %h",
                              vec.addr, vec.write_data, vec.write_enable,
                              vec.mem_width, vec.mem_unsigned, vec.expected_read);
            if (scan_file == 6) begin
                apply_test_vector(vec);
            end
        end

        // Close file and display results
        $fclose(file);
        $display("\nTest Summary:");
        $display("Total tests: %0d", num_tests);
        $display("Passed:      %0d", num_passed);
        $display("Failed:      %0d", num_tests - num_passed);
        
        // End simulation
        #100;
        $finish;
    end

endmodule 