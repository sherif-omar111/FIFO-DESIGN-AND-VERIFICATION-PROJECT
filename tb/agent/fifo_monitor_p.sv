`ifndef FIFO_MONITOR_P_SV
  `define FIFO_MONITOR_P_SV

  class fifo_monitor_p extends uvm_monitor;
  `uvm_component_utils(fifo_monitor_p)

   uvm_analysis_port  #(fifo_seq_item) mon_p_analysis_port;

    virtual fifo_if vif;
    
  function new(string name ="", uvm_component parent);
    super.new(name, parent);

    mon_p_analysis_port = new ("mon_p_analysis_port", this);

  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))
      `uvm_fatal("MONITOR_A", "Could not get vif") 
  endfunction

virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    #(100ns);

    `uvm_info("DEBUG", $sformatf("Monitoring in monitor_P"), UVM_NONE)

    forever begin
				fifo_seq_item item = fifo_seq_item::type_id::create("item");
				@ (negedge vif.clk);
          #20;
          item.data_out = vif.data_out;
          item.full     = vif.full;
          item.empty    = vif.empty; 
				mon_p_analysis_port.write(item);
        `uvm_info("MONITOR_P", $sformatf("Saw item %s in passive monitor", item.convert2string()), UVM_NONE)
			end
   
        endtask

   endclass

`endif