module data_memory
    import riscv_pkg::*;
(
    input  logic                  clk,
    input  logic                  mem_read,
    input  logic                  mem_write,
    input  mem_size_e             mem_size,       // 00: byte, 01: halfword, 10: word
    input  logic                  unsigned_load,  // 1: zero-extend, 0: sign-extend
    input  logic [31:0]           data_addr,
    input  logic [31:0]           data_write_data,
    output logic [31:0]           data_read_data
);

    logic [XLEN-1:0] data_mem [0:DMEM_SIZE-1];

    logic [$clog2(DMEM_SIZE)-1:0] word_index;
    logic [1:0] byte_offset;
    logic [7:0] byte_val;
    logic [15:0] half_val;

    assign word_index = data_addr[11:2];    // 4-byte aligned index
    assign byte_offset = data_addr[1:0];    // 0 to 3

    // Write
    always_ff @(posedge clk) begin
        if (mem_write) begin
            case (mem_size)
                2'b00: begin // SB
                    case (byte_offset)
                        2'd0: data_mem[word_index][7:0]   <= data_write_data[7:0];
                        2'd1: data_mem[word_index][15:8]  <= data_write_data[7:0];
                        2'd2: data_mem[word_index][23:16] <= data_write_data[7:0];
                        2'd3: data_mem[word_index][31:24] <= data_write_data[7:0];
                    endcase
                end
                2'b01: begin // SH
                    case (byte_offset)
                        2'd0: data_mem[word_index][15:0]  <= data_write_data[15:0];
                        2'd2: data_mem[word_index][31:16] <= data_write_data[15:0];
                        default: ; // hizasız erişim yok sayılır
                    endcase
                end
                2'b10: begin // SW
                    data_mem[word_index] <= data_write_data;
                end
            endcase
        end
    end

    // Read
    always_comb begin
        byte_val = 8'b0;
        half_val = 16'b0;
        data_read_data = 32'b0;

        if (mem_read) begin
            case (mem_size)
                2'b00: begin // LB / LBU
                    case (byte_offset)
                        2'd0: byte_val = data_mem[word_index][7:0];
                        2'd1: byte_val = data_mem[word_index][15:8];
                        2'd2: byte_val = data_mem[word_index][23:16];
                        2'd3: byte_val = data_mem[word_index][31:24];
                    endcase
                    data_read_data = unsigned_load ? {24'b0, byte_val} : {{24{byte_val[7]}}, byte_val};
                end
                2'b01: begin // LH / LHU
                    case (byte_offset)
                        2'd0: half_val = data_mem[word_index][15:0];
                        2'd2: half_val = data_mem[word_index][31:16];
                        default: half_val = 16'h0000; // hizasız erişim -> sıfırla
                    endcase
                    data_read_data = unsigned_load ? {16'b0, half_val} : {{16{half_val[15]}}, half_val};
                end
                2'b10: begin // LW
                    data_read_data = data_mem[word_index];
                end
                default: data_read_data = 32'hDEADBEEF;
            endcase
        end
    end

endmodule
