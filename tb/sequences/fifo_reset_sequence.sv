`ifndef FIFO_RESET_SEQUENCE_SV
    `define FIFO_RESET_SEQUENCE_SV

class fifo_reset_sequence extends uvm_sequence#(.REQ(fifo_seq_item));

//Item to drive
fifo_seq_item item;

`uvm_object_utils(fifo_reset_sequence)

function new (string name = "");
    super.new(name);
endfunction

virtual task body();
      item = fifo_seq_item::type_id::create("item");
    	start_item(item);

       item.hard_reset = 1;

      finish_item(item);
    `uvm_info("SEQ", $sformatf("RESET SEQUENCE Done "), UVM_LOW)
  endtask

  endclass

`endif 