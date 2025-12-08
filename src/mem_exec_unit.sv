/*
	Description: Integer execution unit with ALU
	Author: Luis Alberto Mena González
*/
`include "variables.sv"				//Data types to make easier the instantiation of modules

module mem_exec_unit(
    input mem_data_exec_unit  mem_data_exec_unit,
    output cdb_bus		cdb_mem_unit	
);

logic [31:0] Address_w;             //Address calculation RS1 + Imm
logic [31:0] Data_from_RAM;         //Data from the memory RAM
logic [31:0] HWData_w;              //Data to that is going to be written in the memory
logic [31:0] HAddress_w;            //Address decoded
logic [31:0] Mem_Data_w;
logic write_en_w;

assign Address_w = mem_data_exec_unit.issueque_rs_data + mem_data_exec_unit.issueque_imm;

memory_master #(.LENGTH(32)) memory_master_instance(
    .Address(Address_w),
    .Write_Data(mem_data_exec_unit.issueque_rt_data),
    .write_en(mem_data_exec_unit.issueque_opcode), //1 = SW and 0 = LW
    .HRData1(Data_from_RAM),
    .HRData2('b0),      //This is for UART, not used in this implementation 

    .HWData(HWData_w),
    .HAddress(HAddress_w),
    .Mem_Data(Mem_Data_w),
    .write_data_en(write_en_w)
);

//Memory RAM (data memory)
single_port_ram #(.DATA_WIDTH(32), .ADDR_WIDTH(5)) data_mem_instance (
.data(HWData_w), .addr(HAddress_w),
.we(write_en_w), .clk(clk),
.q(Data_from_RAM) 
);

always_comb begin 
    cdb_mem_unit.cdb_data = 'b0;
   	cdb_mem_unit.cdb_tag = 'b0;
   	cdb_mem_unit.cdb_valid = 'b0;
    cdb_mem_unit.cdb_branch = 'b0;
    cdb_mem_unit.cdb_branch_taken = 'b0;

    if(mem_data_exec_unit.issueblk_done) begin
        //Store word
        if(mem_data_exec_unit.issueque_opcode == 1'b1) begin
            cdb_mem_unit.cdb_data = 'b0;
            cdb_mem_unit.cdb_tag = 'b0;
            cdb_mem_unit.cdb_valid = 'b0;
            cdb_mem_unit.cdb_branch = 'b0;
            cdb_mem_unit.cdb_branch_taken = 'b0;
        end
        //Load woard
        else if(mem_data_exec_unit.issueque_opcode == 1'b0) begin
            cdb_mem_unit.cdb_data = Mem_Data_w;
            cdb_mem_unit.cdb_tag = mem_data_exec_unit.issueque_rd_tag;
            cdb_mem_unit.cdb_valid = 'b1;
            cdb_mem_unit.cdb_branch = 'b0;
            cdb_mem_unit.cdb_branch_taken = 'b0;
        end
    end
    else begin
        cdb_mem_unit.cdb_data = 'b0;
   	    cdb_mem_unit.cdb_tag = 'b0;
   	    cdb_mem_unit.cdb_valid = 'b0;
        cdb_mem_unit.cdb_branch = 'b0;
        cdb_mem_unit.cdb_branch_taken = 'b0;
    end
end


endmodule