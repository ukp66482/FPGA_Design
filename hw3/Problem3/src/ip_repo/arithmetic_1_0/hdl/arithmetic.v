`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/18/2025 02:36:14 PM
// Design Name: 
// Module Name: arithmetic
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module arithmetic(
    input clk,
    input rst,
    input start,
    input signed [7:0] a,
    input signed [7:0] b,
    input [7:0] opcode, //op ascii code * + -
    output reg [15:0] result,
    output reg overflow,
    output reg cal_done
    );
    
wire signed [15:0] mul_result;
wire signed [8:0] add_result;
wire signed [8:0] sub_result;

assign mul_result = a * b;
assign add_result = a + b;
assign sub_result = a - b;

always @(posedge clk or negedge rst) begin
    if (!rst) begin
        result <= 8'd0;
        overflow <= 1'b0;
        cal_done <= 1'b0;
    end else if (start) begin
        cal_done <= 1'b1;
        case (opcode)
            8'd43: begin // '+'
                result <= add_result;
                overflow <= (add_result > 9'sd127 || add_result < -9'sd128) ? 1'b1 : 1'b0;
            end
            8'd45: begin // '-'
                result <= sub_result;
                overflow <= (sub_result > 9'sd127 || sub_result < -9'sd128) ? 1'b1 : 1'b0;
            end
            8'd42: begin // '*'
                result <= mul_result;
                overflow <= (mul_result > 16'sd127 || mul_result < -16'sd128) ? 1'b1 : 1'b0;
            end
        endcase
    end else begin
        cal_done <= 0;
    end
end

endmodule