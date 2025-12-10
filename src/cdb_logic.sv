`include "variables.sv"				//Data types to make easier the instantiation of modules
/*
	Module for CDB logic depending on the instruction that is ready
	Author: Luis Alberto Mena González
*/

module cdb_logic(
	input logic clk,
	input logic rst,
    input logic issue_int,
    input logic issue_mem,
    input logic issue_div,
    input logic issue_mult,

    input cdb_bus     CDB_Int,
    input cdb_bus     CDB_Mem,
    input cdb_bus     CDB_Mult,
    input cdb_bus     CDB_Div,

    output cdb_bus    CDB_output  	
);

//Keep track of the type of instructions that are currently on the CDB Reservation register
// empty = 0, int = 1, mem = 2, mult = 3 , div = 4
logic [2:0] cdb_rsv_inst [6:0];
logic [2:0] cdb_rsv_inst_reg [6:0];

always_comb begin
    cdb_rsv_inst[0] = 3'b000;
    for (int i = 1; i < 7; i++) begin
        if (i == 'h6) begin
            cdb_rsv_inst[6] = 'b000;  
        end else begin
            cdb_rsv_inst[i] = cdb_rsv_inst_reg[i]; 
        end
    end
    if(issue_int)
        cdb_rsv_inst[0] = 'h1;
    if(issue_mem)
        cdb_rsv_inst[0] = 'h2;
    if(!issue_int && !issue_mem)
        cdb_rsv_inst[0] = cdb_rsv_inst_reg[1];
    if(issue_mult)
        cdb_rsv_inst[3] = 'h3;
    if(issue_mult == 'h0)
        cdb_rsv_inst[3] = cdb_rsv_inst_reg[4];
    if(issue_div)
        cdb_rsv_inst[6] = 'h4;
    if(issue_div == 'h0)
        cdb_rsv_inst[6] = 'h0; 

    cdb_rsv_inst[5] = cdb_rsv_inst_reg[6];
    cdb_rsv_inst[4] = cdb_rsv_inst_reg[5];
    cdb_rsv_inst[2] = cdb_rsv_inst_reg[3];
    cdb_rsv_inst[1] = cdb_rsv_inst_reg[2];

end

always_comb begin
    if (rst) begin
        for (int i = 0; i < 7; i++) begin
            cdb_rsv_inst_reg[i] = 3'b000;
        end
    end else begin
        for (int i = 0; i < 7; i++) begin
            cdb_rsv_inst_reg[i] = cdb_rsv_inst[i];
        end
    end
end

always_comb begin
    case(cdb_rsv_inst[0])
        'h1: 
            CDB_output = CDB_Int;
        'h2:
            CDB_output = CDB_Mem;
        'h3:
            CDB_output = CDB_Mult;
        'h4:
            CDB_output = CDB_Div;
        default: ;
    endcase
end

endmodule