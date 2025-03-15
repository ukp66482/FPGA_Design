`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/15/2025 03:54:15 PM
// Design Name: 
// Module Name: Decoder
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


module Decoder(sw, rgb);
    input [1:0] sw;
    output reg [2:0] rgb;
    
    always @(*)begin
        case(sw)
            2'b00:  rgb = 3'b111;
            2'b01:  rgb = 3'b100;
            2'b10:  rgb = 3'b010;
            2'b11:  rgb = 3'b110;
            default : rgb = 3'b111;
        endcase
    end
    
endmodule
