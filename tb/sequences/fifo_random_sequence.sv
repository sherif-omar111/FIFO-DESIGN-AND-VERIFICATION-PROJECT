`ifndef FIFO_RANDOM_SEQUENCE_SV
    `define FIFO_RANDOM_SEQUENCE_SV

class fifo_random_sequence extends uvm_sequence#(.REQ(fifo_seq_item));

//Item to drive
fifo_seq_item item;

`uvm_object_utils(fifo_random_sequence)

function new (string name = "");
    super.new(name);
endfunction

virtual task body();
repeat(10) begin
      item = fifo_seq_item::type_id::create("item");
    	start_item(item);
          assert(item.randomize());
        `uvm_info("SEQ", $sformatf("Generate new item: %s", item.convert2string()), UVM_HIGH)
      finish_item(item);
end
    `uvm_info("SEQ", $sformatf("Done generation of random items"), UVM_LOW)
  endtask

  endclass

`endif 