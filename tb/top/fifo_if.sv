
`ifndef FIFO_IF_SV
  `define FIFO_IF_SV

interface fifo_if (input clk);

  	logic rst_n;

    logic w_en;

    logic r_en;

    logic [15:0] data_in;

    logic [15:0] data_out;

    logic full;

    logic empty;
    
endinterface

`endif


