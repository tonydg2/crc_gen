module crc8_ccitt_parallel #(
    parameter DATA_WIDTH = 64  // Width of the input data block
) (
    input  logic                     clk,
    input  logic                     reset_n,
    input  logic [DATA_WIDTH-1:0]    data_in,
    input  logic                     data_valid,
    output logic [7:0]               crc_out
);

    // Internal signals
    logic [7:0] crc_comb;

    // Generate the CRC in a combinational logic block
    always_comb begin
        integer i;
        logic [7:0] crc;

        crc = 8'h00;  // Initial CRC value

        // Process each bit of the input data block
        for (i = DATA_WIDTH-1; i >= 0; i = i - 1) begin
            crc = crc_next(crc, data_in[i]);
        end

        crc_comb = crc;
    end

    // Sequential logic to register the CRC output
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            crc_out <= 8'h00;
        end else if (data_valid) begin
            crc_out <= crc_comb;// ^ 8'h55; final xor
        end
    end

    // Function to calculate the next CRC value for a single bit
    function automatic logic [7:0] crc_next(
        input logic [7:0] crc_in,
        input logic       data_bit
    );
        logic [7:0] crc;
        logic       crc_msb;

        begin
            crc_msb = crc_in[7] ^ data_bit;
            crc     = {crc_in[6:0], 1'b0};

            if (crc_msb) begin
                crc = crc ^ 8'h07;  // XOR with polynomial 0x07
            end

            return crc;
        end
    endfunction

endmodule