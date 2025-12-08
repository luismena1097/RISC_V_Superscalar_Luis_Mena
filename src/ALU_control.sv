/*
    Description: ALU with operations of 32 bits for RISC-V
                 This module sends the ALU OP signal to the ALU
    Operations:  0 - add
                 1 - sub
                 2 - mult
                 3 - shift left
                 4 - set less than
                 5 - xor
                 6 - shift right
                 7 - or 
                 8 - and
                 9 - shift left imm
                 10 - shift right imm
    Author: Luis Alberto Mena González
*/
`include "variables.sv"				//Data types to make easier the instantiation of modules
module ALU_control (
    input  logic [6:0] Opcode, Funct7,
    input  logic [2:0] Funct3,
    output logic [3:0] ALU_op
);

always_comb begin
case (Opcode)
	R_TYPE: begin
	unique case ({Funct3, Funct7})
		 10'b000_0000000: ALU_op = 4'b0000; // ADD
		 10'b000_0100000: ALU_op = 4'b0001; // SUB
		 10'b000_0000001: ALU_op = 4'b0010; // MULT
		 10'b001_0000000: ALU_op = 4'b0011; // SHIFT LEFT
		 10'b010_0000000: ALU_op = 4'b0100; // SLT
		 10'b011_0000000: ALU_op = 4'b0100; // SLTU
		 10'b100_0000000: ALU_op = 4'b0101; // XOR
		 10'b101_0100000: ALU_op = 4'b0110; // SRA
		 10'b101_0000000: ALU_op = 4'b0110; // SRL
		 10'b110_0000000: ALU_op = 4'b0111; // OR
		 10'b111_0000000: ALU_op = 4'b1000; // AND
		 default:          ALU_op = 4'b0000;
	endcase
end
I_TYPE: begin
	unique case (Funct3)
		 3'b000: ALU_op = 4'b0000; // ADDI
		 3'b010: ALU_op = 4'b0100; // SLTI
		 3'b011: ALU_op = 4'b0100; // SLTIU
		 3'b100: ALU_op = 4'b0101; // XORI
		 3'b110: ALU_op = 4'b0111; // ORI
		 3'b111: ALU_op = 4'b1000; // ANDI
		 3'b001: ALU_op = 4'b1001; // SLLI
		 3'b101: ALU_op = 4'b1010; // SRLI/SRAI
		 default: ALU_op = 4'b0000;
	endcase
end
B_TYPE: begin
	unique case (Funct3)
		3'b000: ALU_op = 4'b0001; // SUBB BEQ
		3'b001: ALU_op = 4'b0001; // SUBB BNE
		3'b100: ALU_op = 4'b0100; // SLTIU BLT
		3'b101: ALU_op = 4'b0100;  // SLTIU BGE
		default: ALU_op = 4'b0000;
	endcase
end
default: ALU_op = 4'b0000;
endcase
end
endmodule
