import uvm_pkg::*;

`include "uvm_macros.svh"
`include "fifo_assertions.sv"
`include "fifo_if.sv"
`include "fifo_seq_item.sv"
`include "fifo_reset_sequence.sv"
`include "fifo_read_sequence.sv"
`include "fifo_write_sequence.sv"
`include "fifo_write_read_sequence.sv"
`include "fifo_random_sequence.sv"
`include "fifo_sequencer.sv"
`include "fifo_driver.sv"
`include "fifo_monitor_a.sv"
`include "fifo_monitor_p.sv"
`include "fifo_agent_a.sv"
`include "fifo_agent_p.sv"
`include "fifo_scoreboard.sv"
`include "fifo_coverage.sv"
`include "fifo_env.sv"
// ////////////////// Test Scenarios ////////////////
`include "test_base.sv"
`include "sanity_test.sv"

module testbench;

  reg clk;

initial begin 
    clk = 0 ;
    forever begin
    clk = #10ns ~clk ;
    end 
end 

fifo_if vif (clk);

initial begin
$dumpfile ("dump.vcd");
$dumpvars;

uvm_config_db#(virtual fifo_if)::set(null, "", "vif", vif);

// start uvm test and phases
run_test ("sanity_test");
end


	synchronous_fifo DUT (                              
                    .clk(clk),     
                    .rst_n(vif.rst_n),      
                    .w_en(vif.w_en),      
                    .r_en(vif.r_en),   
                    .data_in(vif.data_in), 
                    .data_out(vif.data_out),    
                    .full(vif.full),  
                    .empty(vif.empty)
                    );

bind synchronous_fifo fifo_assertions fifo_assert (.*);

endmodule
