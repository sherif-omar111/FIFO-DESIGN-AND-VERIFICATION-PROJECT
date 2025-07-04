`ifndef FIFO_ENV_SV
    `define FIFO_ENV_SV

class fifo_env extends uvm_env;

fifo_agent_a agent_a ;

fifo_agent_p agent_p ;

fifo_scoreboard	sc ; 

fifo_coverage	co ; 

`uvm_component_utils(fifo_env)

function new (string name = "" , uvm_component parent);
    super.new(name,parent);
endfunction

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    agent_a = fifo_agent_a::type_id::create("agent_a",this);

    agent_p = fifo_agent_p::type_id::create("agent_p",this);

    sc = fifo_scoreboard::type_id::create("sc",this);

    co = fifo_coverage::type_id::create("co",this);

    uvm_root::get().print_topology();

endfunction

virtual function void connect_phase (uvm_phase phase);

super.connect_phase(phase);

`uvm_info("DEBUG", $sformatf("Hello from env connect phase"), UVM_NONE)

    agent_a.monitor_a.mon_analysis_port.connect(sc.trn_fifo.analysis_export);

    agent_p.monitor_p.mon_p_analysis_port.connect(sc.p_trn_fifo.analysis_export);

    agent_a.monitor_a.mon_analysis_port.connect(co.coverage_analysis_export_1);

    agent_p.monitor_p.mon_p_analysis_port.connect(co.coverage_analysis_export_2);

    endfunction

endclass

`endif 