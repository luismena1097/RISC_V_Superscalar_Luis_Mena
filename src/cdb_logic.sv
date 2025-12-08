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

always_ff @(posedge clk or posedge rst) begin
    if(rst)begin
        for (int i = 0; i < 7; i++) begin
            cdb_rsv_inst[i] <= 'b0;
        end
    end
    else begin
        if(issue_int)
            cdb_rsv_inst[0] <= 'h1;
        else if(issue_mem)
            cdb_rsv_inst[0] <= 'h2;
        else if(issue_mult)
            cdb_rsv_inst[3] <= 'h3;
        else if(issue_div)
            cdb_rsv_inst[6] <= 'h4;
        else
            cdb_rsv_inst <= {'b0,cdb_rsv_inst[6:1]};
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
        default: CDB_output = CDB_output;
    endcase
end


endmodule