`ifndef FIFO_SCOREBOARD_SV
    `define FIFO_SCOREBOARD_SV

class fifo_scoreboard extends uvm_scoreboard;

  `uvm_component_utils(fifo_scoreboard)

  // uvm_analysis_export #(fifo_seq_item) sb_export;

  uvm_tlm_analysis_fifo #(fifo_seq_item) trn_fifo;

  uvm_tlm_analysis_fifo #(fifo_seq_item) p_trn_fifo;

  fifo_seq_item item;

  //fifo_seq_item item_out;

  // parameters
      parameter FIFO_WIDTH = 16;
      parameter FIFO_DEPTH = 8;

      // correct and error counter
      int error_count = 0;
      int correct_count = 0;

      // reference outputs
      logic [FIFO_WIDTH-1:0] data_out_ref;
      logic full_ref, empty_ref;
      
      // internal signals
      int count = 0;
      
      // queue to verify FIFO functionality
      reg [FIFO_WIDTH-1:0] queue_ref[$];
  
    function new(string name= "", uvm_component parent);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);

        trn_fifo = new("trn_fifo", this);  

        p_trn_fifo = new("p_trn_fifo", this);  

        // sb_export = new("sb_export", this);
         
    endfunction

      function void connect_phase(uvm_phase phase);
          super.connect_phase(phase);
          // sb_export.connect(trn_fifo.analysis_export);
      endfunction

  task run_phase(uvm_phase phase);

    super.run_phase(phase);

     `uvm_info("DEBUG", $sformatf("Hello from scoreboard run phase"), UVM_NONE)
   
      forever begin
                trn_fifo.get(item);
                ref_model(item);
                // compare
                if (item.data_out !== data_out_ref) begin
                    error_count++;
                    $display("error in data out at %0d", error_count);
                    `uvm_error("run_phase", $sformatf("comparison failed transaction received by the DUT:%s while the reference out:0b%0b",
                    item.convert2string(), data_out_ref));
                end
                else begin
                    `uvm_info("run_phase", $sformatf("correct fifo out: %s", item.convert2string()), UVM_NONE);
                    correct_count++;
                end
            end

  endtask

  // reference model
    task ref_model (fifo_seq_item seq_item_chk);
        // assigning reference variables
        if(!seq_item_chk.rst_n) begin
            full_ref = 0;
            empty_ref = 1;
            queue_ref.delete();
            count = 0;
        end
        else begin

            // writing
            if (seq_item_chk.w_en && count < FIFO_DEPTH) begin
                queue_ref.push_back(seq_item_chk.data_in); // filling queue
            end
            
            // reading
            if (seq_item_chk.r_en && count != 0) begin
                data_out_ref = queue_ref.pop_front(); // evacuating queue
            end

            // count combinations
            if (({seq_item_chk.w_en, seq_item_chk.r_en} == 2'b11) && empty_ref)
                count = count + 1;
            else if (({seq_item_chk.w_en, seq_item_chk.r_en} == 2'b11) && full_ref)
                count = count - 1;
            else if (({seq_item_chk.w_en, seq_item_chk.r_en} == 2'b10) && !full_ref)
                count = count + 1;
            else if (({seq_item_chk.w_en, seq_item_chk.r_en} == 2'b01) && !empty_ref)
                count = count - 1;
            
            // flags
            if(count == FIFO_DEPTH) full_ref = 1; else full_ref = 0;
            if(count == 0) empty_ref = 1; else empty_ref = 0;      
        end
    endtask

// report
    function void report_phase(uvm_phase phase);
        super.report_phase(phase);
        `uvm_info("report_phase", $sformatf("total successful transactions: %0d", correct_count), UVM_MEDIUM);
        `uvm_info("report_phase", $sformatf("total failed transactions: %0d", error_count), UVM_MEDIUM);
    endfunction

  endclass

`endif 
