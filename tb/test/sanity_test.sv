`ifndef SANITY_TEST_SV
    `define SANITY_TEST_SV

class sanity_test extends test_base;

`uvm_component_utils(sanity_test)

function new (string name = "" , uvm_component parent);
    super.new(name,parent);
endfunction

fifo_reset_sequence 		    rst_seq;
fifo_read_sequence 		        read_seq;
fifo_write_sequence 		    write_seq;
fifo_write_read_sequence 		write_read_seq;
fifo_random_sequence 		    random_seq;
// fifo_sequence_2 		    seq_2;

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    rst_seq         = fifo_reset_sequence::type_id::create("rst_seq");
    read_seq        = fifo_read_sequence::type_id::create("read_seq");
    write_seq       = fifo_write_sequence::type_id::create("write_seq");
    write_read_seq  = fifo_write_read_sequence::type_id::create("write_read_seq");
    random_seq      = fifo_random_sequence::type_id::create("write_read_seq");
    // seq = fifo_sequence::type_id::create("seq");

    uvm_root::get().print_topology();

    endfunction

virtual task run_phase (uvm_phase phase);

    phase.raise_objection(this , "----------------------TEST STAETED----------------------");

    rst_seq.start(env.agent_a.sequencer);
    write_seq.start(env.agent_a.sequencer);
    read_seq.start(env.agent_a.sequencer);
    write_read_seq.start(env.agent_a.sequencer);
    random_seq.start(env.agent_a.sequencer);

    #(100ns);

    phase.drop_objection(this, "----------------------TEST FINISHED----------------------"); 

endtask

endclass

`endif 
