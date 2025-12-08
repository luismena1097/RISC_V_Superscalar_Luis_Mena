`include "variables.sv"				//Data types to make easier the instantiation of modules
/*
	Top module for RISC_V Superscalar 
	Author: Luis Alberto Mena González
*/

module risc_v_superscalar(
	input logic clk,
	input logic rst
);

/*I_Cache to IFQ signals*/
logic [31:0]       PC_in;			//PC to fetch the cache line
logic              rd_en_o;		//Rd en from IFQ to the cache line
logic 				 abort;			//Abort signal from IFQ to cache 
logic [127:0] 		 D_out;			//Data out from the cache to IFQ (4x32)
logic              d_out_valid;	//Signal to verify the data from cache is valid

/*IFQ to Dispatcher signals*/
logic [31:0]       PC_out;			//PC+4 to calculate for branch address
logic              rd_en;			//Rd en from dispatcher to IFQ 
logic [31:0]       Jmp_branch_address;		//Jump or branch address from the dispatcher
logic              jmp_branch_valid;		//Jump or branch are valid
logic [31:0]       Instr;			//Instruction to the dispatcher to be decoded
logic              empty;			//Signal from the IFQ to the dispacher to let know that there IFQ is empty
	 
/*Dispatcher to queue signals*/
logic					 en_div_dispatch;		//Signal to let know the div queue that dispatcher has an instruction of this type
logic 				 en_mult_dispatch;	//Signal to let know the mult queue that dispatcher has an instruction of this type
logic 				 en_store_load_dispatch; 		//Signal to let know the lw/sw queue that dispatcher has an instruction of this typee
logic 				 en_int_dispatch;		//Signal to let know the int queue that dispatcher has an instruction of this type
int_queue_data 	 dispatcher_2_int_queue;		//Pkg that contains data and tags to perform int execution 
lw_sw_queue_data 	 dispatcher_2_lw_sw_queue;		//Pkg that contains data and tags to perform lw/sw execution
queue_data			 dispatcher_2_mult_or_div;		//Pkg that contains data and tags to peform mult/div execution. 
logic 				 int_queue_full;					//Signal to the dispatcher from the int queue that it is full
logic 				 mult_queue_full;					//Signal to the dispatcher from the mult queue that it is full
logic 				 div_queue_full;	            //Signal to the dispatcher from the div queue that it is full
logic              mem_queue_full;              //Signal to the dispatcher from the mem queue that it is full
/*CDB Bus*/
cdb_bus 				CDB_Bus_w;		//CDB Bus to all modules that need feedback from CDB
cdb_bus           CDB_Int_exec_w;//CDB with data from int exec unit
/*ALU to int queue*/
logic [3:0]			ALU_Opcode;

/*Queue to issue unit*/
int_issue_data_exec_unit int_data_queue_2_exec_unit;
int_data_exec_unit mult_data_queue_2_exec_unit;
int_data_exec_unit div_data_queue_2_exec_unit;
mem_data_exec_unit mem_data_queue_2_exec_unit;

/*Memory cache for instructions*/
//This cache outputs 4 instructions (4x32 = 128 bits)
//4 LSB of PC are tied to 0000
//Using the bits 9:4 of the PC we can know which cache line is needed
i_cache #(.DATA_WIDTH(32), .CACHE_LINE_WIDTH(128), .CACHE_DEPTH(64)) i_cache_instance (
	.PC_in({PC_in[31:4],4'b0}), 
   .rd_en(rd_en_o),
   .abort(abort),
   .D_out(D_out),
   .d_out_valid(d_out_valid)
);

/*IFQ*/
//FIFO to divide the cache line into 4 instructions and keep the instructions flowing
ifq #(.DATA_WIDTH(32), .CACHE_LINE_WIDTH(128), .FIFO_DEPTH(4)) ifq_instance (
	.clk(clk),
   .rst(rst),
   .D_out(D_out),
   .d_out_valid(d_out_valid),
   .rd_en(rd_en),
   .Jmp_branch_address(Jmp_branch_address),
   .jmp_branch_valid(jmp_branch_valid),

   .PC_in(PC_in),
	.PC_out(PC_out),
   .Instr(Instr),
   .rd_en_o(rd_en_o),
   .abort(abort),
   .empty(empty)
);

/*Dispatcher*/
dispatcher dispatcher_instance(
	.clk(clk),
	.rst(rst),
	//From IFQ
	.ifetch_pc_plus_four(PC_out),
	.ifetch_instruction(Instr),
	.ifetch_empty_flag(empty),
	
	//To IFQ			
	.dispatch_jmp_branch_addr(Jmp_branch_address),
	.dispatch_jump_branch(jmp_branch_valid),
	.dispatch_ren(rd_en),	//Goes to the IFQ and stall the fetch in case there is a branch
	 
	//CDB
	.cdb_tag(CDB_Bus_w.cdb_tag),
	.cdb_valid(CDB_Bus_w.cdb_valid),
	.cdb_data(CDB_Bus_w.cdb_data),
	.cdb_branch(CDB_Bus_w.cdb_branch),
	.cdb_branch_taken(CDB_Bus_w.cdb_branch_taken), //1 = taken / 0 = not taken
	 
	//Enable to each of the Queues
	.en_div_dispatch(en_div_dispatch),
	.en_mult_dispatch(en_mult_dispatch),
	.en_store_load_dispatch(en_store_load_dispatch),
	.en_int_dispatch(en_int_dispatch),
	 
	.dispatcher_2_int_queue(dispatcher_2_int_queue),
	.dispatcher_2_lw_sw_queue(dispatcher_2_lw_sw_queue),
	.dispatcher_2_mult_or_div(dispatcher_2_mult_or_div),
	
	.issueque_int_full(int_queue_full)
);

//Integer issue queue
integer_issue_queue #(.DEPTH(4)) integer_queue_instance (
	.clk(clk),
	.reset(rst),

   // Signals to dispatcher
   .dispatch_enable(en_int_dispatch),  //1 = Dispatcher wants to write a new instruction
   //RS1
   .dispatch_rs_data(dispatcher_2_int_queue.common_data.rs1_data),
   .dispatch_rs_tag(dispatcher_2_int_queue.common_data.rs1_tag),
   .dispatch_rs_data_val(dispatcher_2_int_queue.common_data.rs1_data_valid),
   //RS2
   .dispatch_rt_data(dispatcher_2_int_queue.common_data.rs2_data),
   .dispatch_rt_tag(dispatcher_2_int_queue.common_data.rs2_tag),
   .dispatch_rt_data_val(dispatcher_2_int_queue.common_data.rs2_data_valid),
   //Opcode, Funct3 and Funct7 for the ALU
   .dispatch_opcode(dispatcher_2_int_queue.opcode),
   .dispatch_func3(dispatcher_2_int_queue.func3),
   .dispatch_func7(dispatcher_2_int_queue.func7),
   //RD TAG
   .dispatch_rd_tag(dispatcher_2_int_queue.common_data.rd_tag),
   .issueque_full(int_queue_full),

   //CDB Signals
   .cdb_tag(CDB_Bus_w.cdb_tag),
   .cdb_data(CDB_Bus_w.cdb_data),
   .cdb_valid(CDB_Bus_w.cdb_valid),

   //Signals to unit
   .issueque_ready(int_data_queue_2_exec_unit.issueque_ready),
   .issueque_rs_data(int_data_queue_2_exec_unit.issueque_rs_data),
   .issueque_rt_data(int_data_queue_2_exec_unit.issueque_rt_data),
   .issueque_rd_tag(int_data_queue_2_exec_unit.issueque_rd_tag),
   .issueque_opcode(int_data_queue_2_exec_unit.issueque_opcode),
   .issueque_funct3(int_data_queue_2_exec_unit.func3),
   .issueque_funct7(int_data_queue_2_exec_unit.func7),
   .issueblk_done(int_data_queue_2_exec_unit.issueblk_done)    // Issued-instruction done
);

//Mult issue queue
queue #(.DEPTH(4)) mult_queue_instance (
	.clk(clk),
	.reset(rst),

   // Signals to dispatcher
   .dispatch_enable(en_mult_dispatch),  //1 = Dispatcher wants to write a new instruction
   //RS1
   .dispatch_rs_data(dispatcher_2_mult_or_div.rs1_data),
   .dispatch_rs_tag(dispatcher_2_mult_or_div.rs1_tag),
   .dispatch_rs_data_val(dispatcher_2_mult_or_div.rs1_data_valid),
   //RS2
   .dispatch_rt_data(dispatcher_2_mult_or_div.rs2_data),
   .dispatch_rt_tag(dispatcher_2_mult_or_div.rs2_tag),
   .dispatch_rt_data_val(dispatcher_2_mult_or_div.rs2_data_valid),
   //Opcode not used for this queue
   .dispatch_opcode('b0),
   //RD TAG
   .dispatch_rd_tag(dispatcher_2_mult_or_div.rd_tag),
   .issueque_full(mult_queue_full),

   //CDB Signals
   .cdb_tag(CDB_Bus_w.cdb_tag),
   .cdb_data(CDB_Bus_w.cdb_data),
   .cdb_valid(CDB_Bus_w.cdb_valid),

   //Signals to unit
   .issueque_ready(mult_data_queue_2_exec_unit.issueque_ready),
   .issueque_rs_data(mult_data_queue_2_exec_unit.issueque_rs_data),
   .issueque_rt_data(mult_data_queue_2_exec_unit.issueque_rt_data),
   .issueque_rd_tag(mult_data_queue_2_exec_unit.issueque_rd_tag),
   .issueque_opcode(mult_data_queue_2_exec_unit.issueque_opcode),
   .issueblk_done(mult_data_queue_2_exec_unit.issueblk_done)    // Issued-instruction done
);

//Div issue queue
queue #(.DEPTH(4)) div_queue_instance (
	.clk(clk),
	.reset(rst),

   // Signals to dispatcher
   .dispatch_enable(en_div_dispatch),  //1 = Dispatcher wants to write a new instruction
   //RS1
   .dispatch_rs_data(dispatcher_2_mult_or_div.rs1_data),
   .dispatch_rs_tag(dispatcher_2_mult_or_div.rs1_tag),
   .dispatch_rs_data_val(dispatcher_2_mult_or_div.rs1_data_valid),
   //RS2
   .dispatch_rt_data(dispatcher_2_mult_or_div.rs2_data),
   .dispatch_rt_tag(dispatcher_2_mult_or_div.rs2_tag),
   .dispatch_rt_data_val(dispatcher_2_mult_or_div.rs2_data_valid),
   //Opcode not used for this queue
   .dispatch_opcode('b0),
   //RD TAG
   .dispatch_rd_tag(dispatcher_2_mult_or_div.rd_tag),
   .issueque_full(div_queue_full),

   //CDB Signals
   .cdb_tag(CDB_Bus_w.cdb_tag),
   .cdb_data(CDB_Bus_w.cdb_data),
   .cdb_valid(CDB_Bus_w.cdb_valid),

   //Signals to unit
   .issueque_ready(div_data_queue_2_exec_unit.issueque_ready),
   .issueque_rs_data(div_data_queue_2_exec_unit.issueque_rs_data),
   .issueque_rt_data(div_data_queue_2_exec_unit.issueque_rt_data),
   .issueque_rd_tag(div_data_queue_2_exec_unit.issueque_rd_tag),
   .issueque_opcode(div_data_queue_2_exec_unit.issueque_opcode),
   .issueblk_done(div_data_queue_2_exec_unit.issueblk_done)    // Issued-instruction done
);

//LW/SW issue queue 
mem_issue_queue #(.DEPTH(4)) mem_queue_instance (
   .clk(clk),
   .reset(rst),

    // Signals to dispatcher
    .dispatch_enable(en_store_load_dispatch),
    //Data from dispatcher to mem issue queue
	 .pkg_dispatch_lw_sw(dispatcher_2_lw_sw_queue),
    .issueque_full(mem_queue_full),

   //CDB Signals
   .cdb_tag(CDB_Bus_w.cdb_tag),
   .cdb_data(CDB_Bus_w.cdb_data),
   .cdb_valid(CDB_Bus_w.cdb_valid),

   //Signals to unit
   .issueque_ready(mem_data_queue_2_exec_unit.issueque_ready),
   .issueque_rs_data(mem_data_queue_2_exec_unit.issueque_rs_data),
   .issueque_rt_data(mem_data_queue_2_exec_unit.issueque_rt_data),
   .issueque_rd_tag(mem_data_queue_2_exec_unit.issueque_rd_tag),
   .issueque_opcode(mem_data_queue_2_exec_unit.issueque_opcode),
   .issueblk_done(mem_data_queue_2_exec_unit.issueblk_done)    // Issued-instruction done
);

//CDB logic 
//Issue unit + Execution Units + CDB Mux  

//Issue Unit
//It is the module that checks which queue has an instruction ready and if the CDB Reservation Register 
//has space to start the execution of the instruction. 

issue_unit issue_unit_instance(
   .clk(clk),
   .rst(rst),
    //From queues to let know the issue unit that an instruction is ready to be executed
    .ready_int(int_data_queue_2_exec_unit.issueque_ready),
    .ready_mult(mult_data_queue_2_exec_unit.issueque_ready),
    .ready_div(div_data_queue_2_exec_unit.issueque_ready),
    .ready_mem(mem_data_queue_2_exec_unit.issueque_ready),

    //From division execution unit
    .div_exec_ready(),
   
    //To the queues to let know that execution unit is free and can execute another instruction
    .issue_int(int_data_queue_2_exec_unit.issueblk_done),
    .issue_mult(mult_data_queue_2_exec_unit.issueblk_done),
    .issue_div(div_data_queue_2_exec_unit.issueblk_done),
    .issue_mem(mem_data_queue_2_exec_unit.issueblk_done)
);

//Integer execution unit
int_exec_unit int_exec_unit_instance(
   .issue_int(int_data_queue_2_exec_unit.issueblk_done),
	.Opcode(int_data_queue_2_exec_unit.issueque_opcode),
	.Funct3(int_data_queue_2_exec_unit.func3),
   .Funct7(int_data_queue_2_exec_unit.func7),
	.RS1(int_data_queue_2_exec_unit.issueque_rs_data), 
   .RS2(int_data_queue_2_exec_unit.issueque_rt_data),
	.RD_Tag(int_data_queue_2_exec_unit.issueque_rd_tag),
	
	.cdb_int_unit(CDB_Int_exec_w)	
);	 

cdb_logic cdb_logic_feedback_instance(
   .clk(clk),
	.rst(rst),
   .issue_int(int_data_queue_2_exec_unit.issueblk_done),
   .issue_mult(mult_data_queue_2_exec_unit.issueblk_done),
   .issue_div(div_data_queue_2_exec_unit.issueblk_done),
   .issue_mem(mem_data_queue_2_exec_unit.issueblk_done),

   .CDB_Int(CDB_Int_exec_w),
   .CDB_Mem(),
   .CDB_Mult(),
   .CDB_Div(),

   .CDB_output(CDB_Bus_w)  	
);


endmodule