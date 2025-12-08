/*
	Description: Integer execution unit with ALU
	Author: Luis Alberto Mena González
*/
`include "variables.sv"				//Data types to make easier the instantiation of modules
module int_exec_unit(
	input logic 		issue_int,
	input logic [6:0] 	Opcode,
	input logic [2:0] 	Funct3,
	input logic [6:0]   Funct7,
	input logic [31:0]	RS1, RS2,
	input logic [5:0]   RD_Tag,
	
	output cdb_bus		cdb_int_unit	
);

//ALU Wires
logic 			alu_zero_w;
logic [31:0]	ALU_Result_w; 
logic [3:0]		ALU_Opcode_w;

ALU_control alu_control_instance (
	.Opcode(Opcode), .Funct7(Funct7), .Funct3(Funct3),
   .ALU_op(ALU_Opcode_w)
);

ALU #(.LENGTH(32))alu_instance(
.A_i(RS1),	.B_i(RS2), .ALU_Control(ALU_Opcode_w),
.alu_zero(alu_zero_w),
.ALU_Result(ALU_Result_w)
);

always_comb begin
	cdb_int_unit.cdb_data = 'b0;
   	cdb_int_unit.cdb_tag = 'b0;
   	cdb_int_unit.cdb_valid = 'b0;
    cdb_int_unit.cdb_branch = 'b0;
    cdb_int_unit.cdb_branch_taken = 'b0;

	if(issue_int) begin
		cdb_int_unit.cdb_data	= ALU_Result_w;
		cdb_int_unit.cdb_tag	= RD_Tag;
		cdb_int_unit.cdb_valid	= 1'b1;
		case (Opcode)
			B_TYPE: begin
				cdb_int_unit.cdb_branch = 1'b1;
				cdb_int_unit.cdb_valid	= 1'b0;
				cdb_int_unit.cdb_data	= 'b0;
				cdb_int_unit.cdb_tag	= 'b0;
				if(Funct3 == 'b0)
					cdb_int_unit.cdb_branch_taken = alu_zero_w ? 'b1 : 'b0;
				else if(Funct3 == 'b1)
					cdb_int_unit.cdb_branch_taken = alu_zero_w ? 'b0 : 'b1;
			end
			default: cdb_int_unit.cdb_branch = 'b0;
		endcase
	end
	else begin
		cdb_int_unit.cdb_data = 'b0;
   		cdb_int_unit.cdb_tag = 'b0;
   		cdb_int_unit.cdb_valid = 'b0;
    	cdb_int_unit.cdb_branch = 'b0;
    	cdb_int_unit.cdb_branch_taken = 'b0;
	end
end

endmodule