`ifndef VARIABLES_SV
`define VARIABLES_SV

typedef enum bit[6:0]{ 
    R_TYPE = 7'b0110011, 
    I_TYPE = 7'b0010011, 
    S_TYPE = 7'b0100011,
    B_TYPE = 7'b1100011, 
    J_TYPE = 7'b1101111, 
    U_TYPE = 7'b0010111, 
    JALR   = 7'b1100111,
    LW     = 7'b0000011,
    LUI    = 7'b0110111
} Opcode_enum;

typedef struct packed {
   logic [31:0] rs1_data;  
   logic [31:0] rs2_data;  
   logic rs1_data_valid;   
   logic rs2_data_valid;  
   logic [5:0] rs1_tag;    
   logic [5:0] rs2_tag;   
   logic [5:0] rd_tag;     
} queue_data;

typedef struct packed {
   queue_data common_data;
   logic [6:0] opcode;
   logic [2:0] func3;
   logic [6:0] func7;
} int_queue_data;

typedef struct packed {
	queue_data common_data;
	logic [31:0] imm;
	logic load_or_store_signal;
	logic [2:0] func3;
} lw_sw_queue_data;

typedef struct packed {
   logic [31:0]  cdb_data;
   logic [5:0]   cdb_tag;
   logic         cdb_valid;
   logic         cdb_branch;
   logic         cdb_branch_taken;
} cdb_bus;

typedef struct packed {
    logic          issueque_ready;
    logic [31:0]   issueque_rs_data;
    logic [31:0]   issueque_rt_data;
    logic [5:0]    issueque_rd_tag;
    logic [6:0]    issueque_opcode;
    logic [2:0]    func3;
    logic [6:0]    func7;
    logic          issueblk_done;    // Issued-instruction done
} int_issue_data_exec_unit;

typedef struct packed {
    logic          issueque_ready;
    logic [31:0]   issueque_rs_data;
    logic [31:0]   issueque_rt_data;
    logic [5:0]    issueque_rd_tag;
    logic [2:0]    issueque_opcode;
    logic          issueblk_done;    // Issued-instruction done
} int_data_exec_unit;

typedef struct packed {
   logic        valid;
   logic [2:0]  opcode;
   logic [5:0]  rd_tag;
   logic [5:0]  rs_tag;
   logic [31:0] rs_data;
   logic        rs_val;
   logic [5:0]  rt_tag;
   logic [31:0] rt_data;
   logic        rt_val;
} entry_issue_queue_t;

typedef struct packed {
   logic        valid;
   logic [6:0]  opcode;
   logic [2:0]  func3;
   logic [6:0]  func7;
   logic [5:0]  rd_tag;
   logic [5:0]  rs_tag;
   logic [31:0] rs_data;
   logic        rs_val;
   logic [5:0]  rt_tag;
   logic [31:0] rt_data;
   logic        rt_val;
} entry_int_issue_queue_t;

typedef struct packed {
   logic        valid;
   lw_sw_queue_data lw_sw_data;
} entry_issue_mem_queue_t;

typedef struct packed {
    logic          issueque_ready;
    logic [31:0]   issueque_rs_data;
    logic [31:0]   issueque_rt_data;
    logic [5:0]    issueque_rd_tag;
    logic     		 issueque_opcode;
    logic          issueblk_done;    // Issued-instruction done
} mem_data_exec_unit;

`endif