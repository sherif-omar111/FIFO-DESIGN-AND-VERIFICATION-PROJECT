`ifndef FIFO_WRITE_READ_SEQUENCE_SV
    `define FIFO_WRITE_READ_SEQUENCE_SV

class fifo_write_read_sequence extends uvm_sequence#(.REQ(fifo_seq_item));

//Item to drive
fifo_seq_item item;

`uvm_object_utils(fifo_write_read_sequence)

function new (string name = "");
    super.new(name);
endfunction

virtual task body();
repeat(10) begin
      item = fifo_seq_item::type_id::create("item");
    	start_item(item);
            item.rst_n = 1;
            item.data_in = $random;
            item.w_en = 1;
            item.r_en = 1;
            item.hard_reset = 0;
        `uvm_info("SEQ", $sformatf("Generate new item: %s", item.convert2string()), UVM_HIGH)
      	finish_item(item);
end
    `uvm_info("SEQ", $sformatf("Done generation of write read items"), UVM_LOW)
  endtask

  endclass

`endif 