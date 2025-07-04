`ifndef FIFO_COVERAGE_SV
    `define FIFO_COVERAGE_SV

class fifo_coverage extends uvm_subscriber#(fifo_seq_item);

  `uvm_component_utils(fifo_coverage)

    uvm_analysis_imp#(fifo_seq_item,fifo_coverage) coverage_analysis_export_1;

    uvm_analysis_imp#(fifo_seq_item,fifo_coverage) coverage_analysis_export_2;

    fifo_seq_item item ;

 covergroup  FIFO_CVG ;
    FIFO_W_EN       : coverpoint            item.w_en ;
    FIFO_R_EN       : coverpoint            item.r_en ;
    FIFO_FULL       : coverpoint            item.full;
    FIFO_EMPTY      : coverpoint            item.empty;
    
 // cross coverage
    full_C: cross FIFO_W_EN, FIFO_R_EN, FIFO_FULL{
        illegal_bins one_r_one = binsof(FIFO_R_EN) intersect {1} && binsof(FIFO_FULL) intersect {1}; 
    } // a full signal can't be riased if there is read 
    empty_C: cross FIFO_W_EN, FIFO_R_EN, FIFO_EMPTY; 
  
 endgroup

  function new(string name= "", uvm_component parent);
    super.new(name, parent);

    coverage_analysis_export_1 = new("coverage_analysis_export_1",this);

    coverage_analysis_export_2 = new("coverage_analysis_export_2",this);

     FIFO_CVG  = new();
  endfunction

function void build_phase (uvm_phase phase);
      `uvm_info(get_type_name(), $sformatf("We are in FIFO_COVERAGE build phase"), UVM_LOW)
      super.build_phase(phase);
      item = fifo_seq_item::type_id::create("item");
   endfunction

   function void write(fifo_seq_item t);

     `uvm_info("DEBUG", $sformatf("Hello from COVERAGE WRITE FUNCTION"), UVM_NONE)
        item = t;
        FIFO_CVG.sample();
   endfunction 


  endclass

`endif 