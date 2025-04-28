`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/19/2025 06:55:46 PM
// Design Name: 
// Module Name: comp_unit
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


module compare_unit(
    input  wire [3:0] in1,
    input  wire [3:0] in2,
    input  wire direction, // 1 for ascending, 0 for descending
    output wire [3:0] out1,
    output wire [3:0] out2
);

assign {out1, out2} = (direction == 1'b1) ?
                      ((in1 > in2) ? {in2, in1} : {in1, in2}) : // ascending
                      ((in1 < in2) ? {in2, in1} : {in1, in2});  // descending

endmodule

