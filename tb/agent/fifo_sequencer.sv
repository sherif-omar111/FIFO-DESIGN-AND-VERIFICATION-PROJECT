`ifndef FIFO_SEQUENCER_SV
    `define FIFO_SEQUENCER_SV

class fifo_sequencer extends uvm_sequencer#(.REQ(fifo_seq_item));

`uvm_component_utils(fifo_sequencer)

function new (string name = "" , uvm_component parent);
    super.new(name,parent);
endfunction

endclass

`endif 