/*
	Description: Integer execution unit with ALU
	Author: Luis Alberto Mena González
*/
`include "variables.sv"				//Data types to make easier the instantiation of modules

module mult_exec_unit(
    input logic clk,
    input logic rst,
    input int_data_exec_unit    mult_data_exec_unit,

    output cdb_bus		cdb_mult_unit	 
);
cdb_bus cdb_mult_aux,cdb_mult_aux1,cdb_mult_aux2,cdb_mult_aux3;

always_comb begin 
    cdb_mult_aux.cdb_data = 'b0;
   	cdb_mult_aux.cdb_tag = 'b0;
   	cdb_mult_aux.cdb_valid = 'b0;
    cdb_mult_aux.cdb_branch = 'b0;
    cdb_mult_aux.cdb_branch_taken = 'b0;
    
    if(mult_data_exec_unit.issueblk_done) begin
        cdb_mult_aux.cdb_data = mult_data_exec_unit.issueque_rs_data * mult_data_exec_unit.issueque_rt_data;
        cdb_mult_aux.cdb_tag = mult_data_exec_unit.issueque_rd_tag;
        cdb_mult_aux.cdb_valid = 'b1;
        cdb_mult_aux.cdb_branch = 'b0;
        cdb_mult_aux.cdb_branch_taken = 'b0;
    end
    else begin
        cdb_mult_aux.cdb_data = 'b0;
        cdb_mult_aux.cdb_tag = 'b0;
        cdb_mult_aux.cdb_valid = 'b0;
        cdb_mult_aux.cdb_branch = 'b0;
        cdb_mult_aux.cdb_branch_taken = 'b0;
    end
end

/* Fake latency to simulate a real multiplier that is not ready in 1 cycle*/
//For this project we are assuming that multiplication takes 3 cycles

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        cdb_mult_aux1 <= 'b0;
    else
        cdb_mult_aux1 <= cdb_mult_aux;
end

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        cdb_mult_aux2 <= 'b0;
    else
        cdb_mult_aux2 <= cdb_mult_aux1;
end

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        cdb_mult_aux3 <= 'b0;
    else
        cdb_mult_aux3 <= cdb_mult_aux2;
end

always_ff @(posedge clk or posedge rst) begin
    if (rst)
        cdb_mult_unit <= 'b0;
    else
        cdb_mult_unit <= cdb_mult_aux3;
end

endmodule