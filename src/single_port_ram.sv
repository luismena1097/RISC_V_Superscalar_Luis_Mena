/*
    Description: Single port RAM with single read/write address
    Date: 08/February/2025
*/
module single_port_ram #(
    parameter int DATA_WIDTH = 32,
    parameter int ADDR_WIDTH = 7
)(
    input  logic [DATA_WIDTH-1:0] data,
    input  logic [ADDR_WIDTH-1:0] addr,
    input  logic                  we,
    input  logic                  clk,
    output logic [DATA_WIDTH-1:0] q
);

    // Declaración del arreglo RAM
    logic [DATA_WIDTH-1:0] ram [2**ADDR_WIDTH-1:0];

    // Escritura en flanco positivo
    always_ff @(posedge clk) begin
        if (we) begin
            ram[addr] <= data;
        end
    end

    // Lectura continua
    assign q = ram[addr];

endmodule
