/*
	Description: ALU with operations of 32 bits for RISC-V
	Operations: 0 - add
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

module ALU #(
    parameter int LENGTH = 32
)(
    input  logic signed [LENGTH-1:0] A_i, 
    input  logic signed [LENGTH-1:0] B_i,
    input  logic [3:0]        ALU_Control,
    output logic              alu_zero,
    output logic signed [LENGTH-1:0] ALU_Result
);

    logic [LENGTH-1:0] temp_result;

    always_comb begin
        unique case (ALU_Control)
            4'h0 : temp_result = A_i + B_i;
            4'h1 : temp_result = A_i + (~B_i + 1'b1);
            4'h2 : temp_result = A_i * B_i;
            4'h3 : temp_result = A_i << B_i;
            4'h4 : temp_result = (A_i < B_i) ? {{LENGTH-1{1'b0}},1'b1} : {LENGTH{1'b0}};
            4'h5 : temp_result = A_i ^ B_i;
            4'h6 : temp_result = A_i >> B_i;
            4'h7 : temp_result = A_i | B_i;
            4'h8 : temp_result = A_i & B_i;
            4'h9 : temp_result = A_i << B_i[4:0];
            4'hA : temp_result = A_i >> B_i[4:0];
            default: temp_result = {LENGTH{1'b0}};
        endcase
    end

    assign alu_zero   = (temp_result == {LENGTH{1'b0}});
    assign ALU_Result = temp_result;

endmodule