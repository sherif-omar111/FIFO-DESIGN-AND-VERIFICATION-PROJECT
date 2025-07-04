`ifndef FIFO_DRIVER_SV
    `define FIFO_DRIVER_SV

class fifo_driver extends uvm_driver#(.REQ(fifo_seq_item));

`uvm_component_utils(fifo_driver)

function new (string name = "" , uvm_component parent);
    super.new(name,parent);
endfunction

virtual fifo_if vif;

fifo_seq_item item;

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual fifo_if)::get(this, "", "vif", vif))
      `uvm_fatal("DRIVER_M", "Could not get vif")
  endfunction
  
virtual task run_phase(uvm_phase phase);
    super.run_phase(phase);
    // do_reset();
    `uvm_info("DEBUG", $sformatf("Hello from DRIVER connect phase"), UVM_NONE)
    forever begin
        item = fifo_seq_item::type_id::create("item");
        seq_item_port.get_next_item(item);

        if (item.hard_reset) begin
                    do_reset();
            end

        drive_item(item);

        `uvm_info("DEBUG", $sformatf("Driving \"%0s\": %0s", item.get_full_name(), item.convert2string()), UVM_NONE)  
           
        seq_item_port.item_done();
        end
    endtask

virtual task drive_item(fifo_seq_item item);
    @(posedge vif.clk);
        vif.rst_n   = item.rst_n;
        vif.data_in = item.data_in;
        vif.w_en    = item.w_en;
        vif.r_en    = item.r_en;
        #20;
  endtask

  task do_reset();
  `uvm_info("DEBUG", $sformatf("Hello from do reset task"), UVM_NONE)
    vif.rst_n <= 0;
    vif.w_en <= 0;
    vif.r_en <= 0;
    vif.data_in <= 0;
    repeat(2) begin
    @(posedge vif.clk);
    end
    vif.rst_n <= 1; 
  endtask

endclass

`endif