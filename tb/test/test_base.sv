`ifndef TEST_BASE_SV
    `define TEST_BASE_SV

class test_base extends uvm_test;

    fifo_env env;

    virtual  	fifo_if 	vif;

`uvm_component_utils(test_base)

function new (string name = "" , uvm_component parent);
    super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    env = fifo_env::type_id::create("env", this);
    
endfunction


endclass

`endif 