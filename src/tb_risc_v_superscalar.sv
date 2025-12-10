`timescale 1ns/1ps

module tb_risc_v_superscalar();
// =========================
// Señales del testbench
// =========================
logic clk;
logic rst;

// =========================
// DUT Instance
// =========================
risc_v_superscalar dut (
  .clk(clk),
  .rst(rst)
);

// =========================
// Reloj
// =========================
initial begin
  clk = 0;
  forever #5 clk = ~clk;   // Reloj de 100 MHz (10 ns período)
end

initial begin
  rst = 1'b0;
  #10;
  rst = 1'b1;
  #20;
  rst = 1'b0;
end

endmodule