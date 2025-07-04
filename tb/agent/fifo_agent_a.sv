`ifndef FIFO_AGENT_A_SV
    `define FIFO_AGENT_A_SV

class fifo_agent_a extends uvm_agent;

//Driver handler
fifo_driver driver;

//Sequencer handler
fifo_sequencer sequencer;

//Monitor handler
fifo_monitor_a monitor_a;

`uvm_component_utils(fifo_agent_a)

function new (string name = "" , uvm_component parent);
    super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase (phase);

    driver      = fifo_driver::type_id::create("driver", this);
    sequencer   = fifo_sequencer::type_id::create("sequencer", this);
    monitor_a   = fifo_monitor_a::type_id::create("monitor_a", this);

    uvm_root::get().print_topology();

endfunction

virtual function void connect_phase (uvm_phase phase);

    super.connect_phase(phase);
    `uvm_info("DEBUG", $sformatf("Hello from fifo active agent connect phase"), UVM_NONE)

    driver.seq_item_port.connect(sequencer.seq_item_export);

    endfunction
    
endclass

`endif 

