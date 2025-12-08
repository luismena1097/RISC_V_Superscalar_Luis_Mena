`timescale 1ns/1ps

module tb_issue_unit;

    // Señales del DUT
    logic clk;
    logic rst;

    logic ready_int;
    logic ready_mult;
    logic ready_div;
    logic ready_mem;

    logic div_exec_ready;

    logic issue_int;
    logic issue_mult;
    logic issue_div;
    logic issue_mem;

    // Instanciar DUT
    issue_unit dut(
        .clk(clk),
        .rst(rst),
        .ready_int(ready_int),
        .ready_mult(ready_mult),
        .ready_div(ready_div),
        .ready_mem(ready_mem),
        .div_exec_ready(div_exec_ready),
        .issue_int(issue_int),
        .issue_mult(issue_mult),
        .issue_div(issue_div),
        .issue_mem(issue_mem)
    );

    // Generación de reloj
    always #5 clk = ~clk;

    // Tarea para mostrar estado
    task print_status(string msg);
        $display("[%0t] %s | INT=%0b MULT=%0b DIV=%0b MEM=%0b  ||  issue: int=%0b mult=%0b div=%0b mem=%0b",
                 $time, msg,
                 ready_int, ready_mult, ready_div, ready_mem,
                 issue_int, issue_mult, issue_div, issue_mem );
    endtask

    // Estímulos
    initial begin
        clk = 0;
        rst = 1;
        ready_int  = 0;
        ready_mult = 0;
        ready_div  = 0;
        ready_mem  = 0;
        div_exec_ready = 0;

        repeat(3) @(posedge clk);
        rst = 0;

        // ============================
        // 1. Probar INT listo
        // ============================
        @(posedge clk);
        ready_int = 1;
        print_status("INT listo");
        @(posedge clk);

        ready_int = 0;

        // ============================
        // 2. Probar MULT listo
        // ============================
        @(posedge clk);
        ready_mult = 1;
        print_status("MULT listo");
        @(posedge clk);

        ready_mult = 0;

        // ============================
        // 3. Probar DIV listo (div_exec_ready=0)
        // ============================
        @(posedge clk);
        ready_div = 1;
        div_exec_ready = 0;
        print_status("DIV listo");
        @(posedge clk);

        ready_div = 0;

        // ============================
        // 4. Probar MEM listo
        // ============================
        @(posedge clk);
        ready_mem = 1;
        print_status("MEM listo");
        @(posedge clk);

        ready_mem = 0;

        // ============================
        // 5. Conflicto INT vs MEM (LRU decide)
        // ============================
        @(posedge clk);
        ready_int = 1;
        ready_mem = 1;
        print_status("INT y MEM listos (LRU)");
        @(posedge clk);

        ready_int = 0;
        ready_mem = 0;

        // ============================
        // 6. DIV bloqueado por div_exec_ready
        // ============================
        @(posedge clk);
        ready_div = 1;
        div_exec_ready = 1;   // bloqueado
        print_status("DIV listo pero bloqueado");
        @(posedge clk);

        ready_div = 0;
        div_exec_ready = 0;

        // ============================
        // 7. MULT bloqueado por CDB slot
        // (Debes simular internamente CDB_reservation_reg)
        // ============================

        $display("\n*** Fin de simulación ***\n");
        $finish;
    end

endmodule
