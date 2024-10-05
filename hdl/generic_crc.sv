//
//
module generic_crc #(
  parameter                       REFLECT_IO  = 0           ,
  parameter                       FINAL_XOR   = 0           ,
  parameter                       POLYWIDTH   = 8           ,  // defines checksum width
  parameter                       DATAWIDTH   = 8           ,
  parameter logic [POLYWIDTH-1:0] POLY        = 'b00000111  ,
  parameter logic [POLYWIDTH-1:0] INIT        = '0          
)(
  input                           clk             ,
  input                           rst             ,
  input                           crc_en          ,
  input   logic [DATAWIDTH-1:0]   data_i          ,
  output  logic [POLYWIDTH-1:0]   checksum_o      ,
  output                          checksum_rdy_o   
);
///////////////////////////////////////////////////////////////////////////////////////////////////

  logic [POLYWIDTH-1:0] crc_next, crc_reg;

///////////////////////////////////////////////////////////////////////////////////////////////////

  always_ff @(posedge clk) begin 
    if (rst) begin 
      //checksum_o <= '0;
      crc_reg    <= '0;
    end else begin 
      crc_reg <= crc_next;
    end 
  end 
    


  assign checksum_o = crc_reg;

//  top_bd_wrapper top_bd_wrapper_inst (
//    .clk100       (clk100           ),
//    .rstn         (rstn             ),
//    .led_div1_o   (led_div1         ),
//    .led_o        (RADIO_LED[0]     )//Yellow
//  );
//
//  led_cnt led_cnt_inst (
//    .rst      (~rstn        ),
//    .clk100   (clk100       ),
//    .div_i    (led_div1     ),
//    .wren_i   ('0           ),
//    .led_o    (RADIO_LED[1] ) //BLUE
//  );


endmodule