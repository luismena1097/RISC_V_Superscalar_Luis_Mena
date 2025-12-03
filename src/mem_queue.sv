/*
    Description: Lw/SW Issue Queue
    Author: Luis Alberto Mena Gonzalez
*/

`include "variables.sv"				//Data types to make easier the instantiation of modules

module mem_issue_queue #(
    parameter DEPTH = 4
) (
    input  logic          clk,
    input  logic          reset,

    // Signals to dispatcher
	 input logic 				dispatch_enable,
	 input lw_sw_queue_data	  	  pkg_dispatch_lw_sw,
    output logic          issueque_full,

    //CDB signals
    input  logic [5:0]    cdb_tag,
    input  logic [31:0]   cdb_data,
    input  logic          cdb_valid,

    //Signals to unit
    output logic          issueque_ready,
    output logic [31:0]   issueque_rs_data,
    output logic [31:0]   issueque_rt_data,
    output logic [5:0]    issueque_rd_tag,
    output logic 		     issueque_opcode,
    input  logic          issueblk_done
);

entry_issue_mem_queue_t queue [DEPTH];

// The queue is full when all slots are valid and there is no instruction being issued.
assign issueque_full = queue[0].valid & queue[1].valid & queue[2].valid & queue[3].valid & !issueblk_done;

always_ff @(posedge clk or posedge reset) begin
    if (reset) begin
        for (int i = 0; i < DEPTH; i++) queue[i] <= '{default: '0};
    end else begin
        if (dispatch_enable && !issueque_full) begin
            for (int i = DEPTH-1; i > 0; i--) begin
                queue[i] <= queue[i-1];     //Shift to make room for the new instruction into the first slot of the queue
            end
            queue[0].valid   <= 1'b1;
            queue[0].lw_sw_data  <= pkg_dispatch_lw_sw;
        end

        else if (issueblk_done && issueque_ready) begin
            queue[0] <= queue[1];
            queue[1] <= queue[2];
            queue[2] <= queue[3];
            queue[3] <= 'b0;
        end
        // CDB Update 
        if (cdb_valid) begin
            for (int i = 0; i < DEPTH; i++) begin
                if (queue[i].valid) begin
                    if (!queue[i].lw_sw_data.common_data.rs1_data_valid && queue[i].lw_sw_data.common_data.rs1_tag == cdb_tag) begin
                        queue[i].lw_sw_data.common_data.rs1_data <= cdb_data;
                        queue[i].lw_sw_data.common_data.rs1_data_valid  <= 1'b1;
                    end
                    if (!queue[i].lw_sw_data.common_data.rs2_data_valid && queue[i].lw_sw_data.common_data.rs2_tag == cdb_tag) begin
                        queue[i].lw_sw_data.common_data.rs2_data <= cdb_data;
                        queue[i].lw_sw_data.common_data.rs2_data_valid  <= 1'b1;
                    end
                end
            end
        end
    end
end

// Only the oldest instruction in the queue can be issued when rs1 valid and rs2 valid are 1
assign issueque_ready    = queue[0].valid && queue[0].lw_sw_data.common_data.rs1_data_valid && queue[0].lw_sw_data.common_data.rs2_data_valid;
assign issueque_rs_data  = queue[0].lw_sw_data.common_data.rs1_data;
assign issueque_rt_data  = queue[0].lw_sw_data.common_data.rs2_data;
assign issueque_rd_tag   = queue[0].lw_sw_data.common_data.rd_tag;
assign issueque_opcode   = queue[0].lw_sw_data.lw_or_sw_instruction;

endmodule

