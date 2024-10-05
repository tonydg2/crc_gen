module crc8_ccitt (
    input  logic         clk,
    input  logic         reset_n,
    input  logic [7:0]   data_in,
    input  logic         data_valid,
    output logic [7:0]   crc_out
);

    logic [7:0] crc_reg;

    // Function to calculate the next CRC value
    function automatic logic [7:0] crc_next(input logic [7:0] crc_in, input logic [7:0] data_in);
        logic [7:0] crc;
        logic       crc_msb;
        integer     i;

        begin
            crc = crc_in;

            for (i = 7; i >= 0; i = i - 1) begin
                crc_msb = crc[7] ^ data_in[i];
                crc     = {crc[6:0], 1'b0};

                if (crc_msb) begin
                    crc = crc ^ 8'h07; // XOR with polynomial 0x07
                end
            end

            return crc;
        end
    endfunction

    // Sequential logic to update the CRC register
    always_ff @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            crc_reg <= 8'h00; // Initial CRC value
        end else if (data_valid) begin
            crc_reg <= crc_next(crc_reg, data_in);
        end
    end

    assign crc_out = crc_reg; // Output the current CRC value

endmodule