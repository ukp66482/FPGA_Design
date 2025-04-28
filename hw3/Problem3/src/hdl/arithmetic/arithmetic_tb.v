`timescale 1ns / 1ps
`include "arithmetic.v"
module arithmetic_tb;

    reg clk = 0;
    reg rst = 0;
    reg start = 0;
    reg signed [7:0] a, b;
    reg [7:0] opcode;
    wire [15:0] result;
    wire overflow;
    wire cal_done;

    // DUT
    arithmetic dut (
        .clk(clk),
        .rst(rst),
        .start(start),
        .a(a),
        .b(b),
        .opcode(opcode),
        .result(result),
        .overflow(overflow),
        .cal_done(cal_done)
    );

    // Clock
    always #5 clk = ~clk;

    // ASCII opcode
    localparam ADD = 8'd43;
    localparam SUB = 8'd45;
    localparam MUL = 8'd42;

    // 測試 task
    task run_case(input signed [7:0] op_a, input signed [7:0] op_b, input [7:0] op_code);
        begin
            @(negedge clk);
            a <= op_a;
            b <= op_b;
            opcode <= op_code;
            start <= 1;
            @(negedge clk);
            start <= 0;
            wait (cal_done == 1);
            @(posedge clk);
            $display("%0d %s %0d = %0d (%s)",
                op_a,
                (op_code == ADD) ? "+" : (op_code == SUB) ? "-" : "*",
                op_b,
                $signed(result),
                overflow ? "overflow" : "non-overflow");
            @(negedge clk);
        end
    endtask

    initial begin
        // FSDB dump 開始
        $fsdbDumpfile("arithmetic.fsdb");
        $fsdbDumpvars(0, arithmetic_tb, "+all");
        $display("===== Start Simulation =====");

        // Reset
        #2 rst = 1;
        #10 rst = 0;
        #10 rst = 1;

        // 測試圖片的例子
        run_case(-128, -1, ADD);
        run_case(-128, -1, SUB);
        run_case(-128, -1, MUL);
        run_case(127, -1, ADD);
        run_case(127, -1, SUB);
        run_case(127, -1, MUL);

        #20 $finish;
    end

endmodule
