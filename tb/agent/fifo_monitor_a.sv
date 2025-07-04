`ifndef FIFO_MONITOR_A_SV
  `define FIFO_MONITOR_A_SV

  class fifo_monitor_a extends uvm_monitor;
  `uvm_component_utils(fifo_monitor_a)

   uvm_analysis_port  #(fifo_seq_item) mon_analysis_port;

    virtual fifo_if vif;
    
  function new(string name ="", uvm_component parent);
    super.new(name, parent);

    mon_analysis_port = new ("mon_analysis_port", this);

  endfunction

  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))
      `uvm_fatal("MONITOR_A", "Could not get vif") 
  endfunction

virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);

    #(100ns);

    `uvm_info("DEBUG", $sformatf("Monitoring in monitor_A"), UVM_NONE)

    forever begin
				fifo_seq_item item = fifo_seq_item::type_id::create("item");
				@ (negedge vif.clk);
          #20;
          item.rst_n    = vif.rst_n;
          item.data_in  = vif.data_in;
          item.w_en     = vif.w_en;
          item.r_en     = vif.r_en; 
          item.data_out = vif.data_out;
          item.full     = vif.full;
          item.empty    = vif.empty;   
				mon_analysis_port.write(item);
        `uvm_info("MONITOR_A", $sformatf("Saw item %s in active monitor", item.convert2string()), UVM_NONE)
			end
  

        endtask

   endclass

`endif