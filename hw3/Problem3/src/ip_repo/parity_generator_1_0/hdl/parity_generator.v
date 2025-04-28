`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2025 04:44:14 PM
// Design Name: 
// Module Name: parity_generator
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


module parity_generator(
    input clk,
    input rst,
    input start,
    input signed [31:0] data,
    output reg parity_bit,
    output reg done
    );
    
always @(posedge clk or negedge rst) begin
    if (!rst) begin
        parity_bit <= 1'b0;
        done <= 1'b0;
    end else if (start) begin
        done <= 1'b1;
        parity_bit <= ^data;
    end else begin
        done <= 0;
    end
end

endmodule
