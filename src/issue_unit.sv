`include "variables.sv"				//Data types to make easier the instantiation of modules
/*
	Issue Unit to control execution flow and CDB data
	Author: Luis Alberto Mena González
*/

module issue_unit(
	input logic clk,
	input logic rst,
    //From queues to let know the issue unit that an instruction is ready to be executed
    input logic ready_int,
    input logic ready_mult,
    input logic ready_div,
    input logic ready_mem,

    //From division execution unit
    input logic div_exec_ready,
   
    //To the queues to let know that execution unit is free and can execute another instruction
    output logic issue_int,
    output logic issue_mult,
    output logic issue_div,
    output logic issue_mem
);

logic lru;              //LRU Bit to change priority between int and mem operations since this can be executed in just 1 cycle
logic issue_oneclk;     //Bit to signal issue_int or issue_mem
logic [6:0] CDB_reservation_reg_aux, CDB_reservation_reg;

//Changes the priority for int or mem instruction depending on the last instruction executed
always_ff @(posedge clk or posedge rst) begin 
    if(rst)
        lru <= 1'b1;        //Initial value for LRU
    else begin
        if(issue_int)
            lru <= 1'b0;
        else if (issue_mem)
            lru <= 1'b1;
        else 
            lru <= lru;
    end
end

//Control of the instruction entry to the CDB reservation register
always_comb begin
    issue_int    = 1'b0;
    issue_mult  = 1'b0;
    issue_div    = 1'b0;
    issue_mem    = 1'b0;
    issue_oneclk = 1'b0;

    if(ready_div && !CDB_reservation_reg[6] && !div_exec_ready)
        issue_div = 1'b1;
    //Check for CDB Reservation register to be free at slot 4 before entering multiplication to slot 3 
    else if(ready_mult && !CDB_reservation_reg[4] && !CDB_reservation_reg[3])
        issue_mult = 1'b1;
    //Check for CDB Reservation register slot 1 to be free for Int or mem execution
    else if((ready_int && ready_mem) && !CDB_reservation_reg[1]) begin
        //LRU = 1, int has priority
        if(lru)
            issue_int = 1'b1;
        else
            issue_mem = 1'b1;
    end
    else if(ready_int && !ready_mem && !CDB_reservation_reg[1])
        issue_int = 1'b1;
    else if(!ready_int && ready_mem && !CDB_reservation_reg[1])
        issue_mem = 1'b1;
end

//Shift register for CDB reservation register

always_ff @(posedge clk or posedge rst) begin
    if(rst)begin
        CDB_reservation_reg <= 'b0;
    end
    else begin
        if(issue_int || issue_mem)
            CDB_reservation_reg[0] <= 1'b1;
        else if(issue_mult)
            CDB_reservation_reg[3] <= 1'b1;
        else if(issue_div)
            CDB_reservation_reg[6] <= 1'b1;
        else
            CDB_reservation_reg <= {1'b0,CDB_reservation_reg[6:1]};
    end
end


endmodule