/*
	Description: Integer execution unit with ALU
	Author: Luis Alberto Mena González
*/
`include "variables.sv"				//Data types to make easier the instantiation of modules

module div_exec_unit(
    input logic clk,
    input logic rst,
    input int_data_exec_unit    div_data_exec_unit,

    output cdb_bus		cdb_div_unit,
    output logic        div_exec_unit_busy	 
);
cdb_bus cdb_div_aux,cdb_div_aux1,cdb_div_aux2,cdb_div_aux3, cdb_div_aux4, cdb_div_aux5, cdb_div_aux6;
logic busy_aux,busy_aux1,busy_aux2,busy_aux3,busy_aux4,busy_aux5,busy_aux6;

always_comb begin 
    cdb_div_aux.cdb_data = 'b0;
   	cdb_div_aux.cdb_tag = 'b0;
   	cdb_div_aux.cdb_valid = 'b0;
    cdb_div_aux.cdb_branch = 'b0;
    cdb_div_aux.cdb_branch_taken = 'b0;
    busy_aux = 1'b0;
    
    if(div_data_exec_unit.issueblk_done) begin
        cdb_div_aux.cdb_data = div_data_exec_unit.issueque_rs_data / div_data_exec_unit.issueque_rt_data;
        cdb_div_aux.cdb_tag = div_data_exec_unit.issueque_rd_tag;
        cdb_div_aux.cdb_valid = 'b1;
        cdb_div_aux.cdb_branch = 'b0;
        cdb_div_aux.cdb_branch_taken = 'b0;
        busy_aux = 1'b1;
    end
    else begin
        cdb_div_aux.cdb_data = 'b0;
        cdb_div_aux.cdb_tag = 'b0;
        cdb_div_aux.cdb_valid = 'b0;
        cdb_div_aux.cdb_branch = 'b0;
        cdb_div_aux.cdb_branch_taken = 'b0;
        busy_aux = 1'b0;
    end
end

/* Fake latency to simulate a real divider that is not ready in 1 cycle*/
//For this project we are assuming that multiplication takes 6 cycles

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        cdb_div_aux1 <= 'b0;
        busy_aux1 <= 1'b0;
    end
    else begin
        cdb_div_aux1 <= cdb_div_aux;
        busy_aux1 <= busy_aux;
    end
end

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        cdb_div_aux2 <= 'b0;
        busy_aux2 <= 1'b0;
    end
    else begin
        cdb_div_aux2 <= cdb_div_aux1;
        busy_aux2 <= busy_aux1;
    end
end

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        cdb_div_aux3 <= 'b0;
        busy_aux3 <= 1'b0;
    end
    else begin
        cdb_div_aux3 <= cdb_div_aux2;
        busy_aux3 <= busy_aux2;
    end
end

always_ff @(posedge clk or posedge rst) begin
    if (rst)begin
        cdb_div_aux4 <= 'b0;
        busy_aux4 <= 1'b0;
    end
    else begin
        cdb_div_aux4 <= cdb_div_aux3;
        busy_aux4 <= busy_aux3;
    end
end

always_ff @(posedge clk or posedge rst) begin
    if (rst)begin
        cdb_div_aux5 <= 'b0;
        busy_aux5 <= 1'b0;
    end
    else begin
        cdb_div_aux5 <= cdb_div_aux4;
        busy_aux5 <= busy_aux4;
    end
end

always_ff @(posedge clk or posedge rst) begin
    if (rst)begin
        cdb_div_aux6 <= 'b0;
        busy_aux6 <= 1'b0;
    end
    else begin
        cdb_div_aux6 <= cdb_div_aux5;
        busy_aux6 <= busy_aux5;
    end
end

always_ff @(posedge clk or posedge rst) begin
    if (rst) begin
        cdb_div_unit <= 'b0;
        div_exec_unit_busy <= 1'b0;
    end
    else begin
        cdb_div_unit <= cdb_div_aux6;
        div_exec_unit_busy <= busy_aux6;
    end
end

endmodule