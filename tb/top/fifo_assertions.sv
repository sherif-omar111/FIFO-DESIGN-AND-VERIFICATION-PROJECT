module fifo_assertions (
   input  wire       clk,     
   input  wire       rst_n,       
   input  wire       w_en,       
   input  wire       r_en,         
   input  wire  [15:0] data_in,     
   input  wire  [15:0] data_out,     
   input  wire        full,     
   input  wire        empty
   );

property reset_check;
  @(negedge rst_n) 1'b1 |-> @(posedge clk) (w_en == 0 && r_en == 0 && data_in == 0);
endproperty

reset_check_assert: assert property(reset_check)
  else $error("Assertion reset_check failed!");

endmodule