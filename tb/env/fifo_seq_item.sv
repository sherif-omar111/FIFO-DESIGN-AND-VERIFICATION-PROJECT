`ifndef FIFO_SEQ_ITEM_SV
    `define FIFO_SEQ_ITEM_SV

class fifo_seq_item extends uvm_sequence_item;

`uvm_object_utils(fifo_seq_item)

rand bit [7:0] data_in;

bit [7:0] data_out;

rand bit w_en;

rand bit r_en;

rand bit rst_n;

bit full; // output

bit empty; // output
    

bit hard_reset ; 

virtual function string convert2string();

    string result =  $sformatf("data_in=%0d data_out=%0d w_en=%0d r_en=%0d full=%0d empty=%0d", data_in , data_out, w_en,r_en,full,empty);

    return result;

  endfunction

constraint reset_constraint {
            rst_n dist {0:/2, 1:/98};  
        }

        constraint w_en_constraint {
            w_en dist {1:=70, 0:=(30)}; 
        }

        constraint r_en_constraint {
            r_en dist {1:=30, 0:=(70)}; 
        }

function new (string name = "" );
    super.new(name);
endfunction

endclass

`endif 