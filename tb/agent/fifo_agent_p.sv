`ifndef FIFO_AGENT_P_SV
    `define FIFO_AGENT_P_SV

class fifo_agent_p extends uvm_agent;

//Monitor handler
fifo_monitor_p monitor_p;

`uvm_component_utils(fifo_agent_p)

function new (string name = "" , uvm_component parent);
    super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
super.build_phase (phase);

    monitor_p   = fifo_monitor_p::type_id::create("monitor_p", this);

uvm_root::get().print_topology();

endfunction

virtual function void connect_phase (uvm_phase phase);

    super.connect_phase(phase);

    `uvm_info("DEBUG", $sformatf("Hello from fifo pasive agent connect phase dummmmmmy "), UVM_NONE)


    endfunction
    
endclass

`endif 

