`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2025/03/10 10:43:21
// Design Name: 
// Module Name: traffic_light
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


module traffic_light(
    input   clk,
    input   rst,
    input   [1:0] sw,
    input   [2:0] btn,
    output reg  [2:0] T1,
    output reg  [2:0] T2,
    output reg  [3:0] leds

    );

wire    clk_div ;
wire [2:0] normal_T1,normal_T2;
divider div_0( .clk(clk), .rst(rst), .clk_div(clk_div));

reg [3:0] R_time,Y_time,G_time;

//RGB_time

//Red
always @(posedge clk_div or posedge rst)
    if(rst)
        R_time <= 4'd2;
    else
        case(sw)
            2'b00 : R_time <= R_time;
            2'b01 : R_time <= R_time;
            2'b10 : R_time <= R_time;
            2'b11 : if(btn[0])
                        R_time <= 4'd2;
                    else if(btn[1])
                        R_time <= R_time + 4'd1;
                    else if(btn[2])
                        R_time <= R_time - 4'd1;
                    else
                        R_time <= R_time;
        
        endcase

//Yellow
always @(posedge clk_div or posedge rst)
    if(rst)
        Y_time <= 4'd1;
    else
        case(sw)
            2'b00 : Y_time <= Y_time;
            2'b01 : Y_time <= Y_time;
            2'b11 : Y_time <= Y_time;
            2'b10 : if(btn[0])
                        Y_time <= 4'd1;
                    else if(btn[1])
                        Y_time <= Y_time + 4'd1;
                    else if(btn[2])
                        Y_time <= Y_time - 4'd1;
                    else
                        Y_time <= Y_time;
        
        endcase

//Green
always @(posedge clk_div or posedge rst)
    if(rst)
        G_time <= 4'd5;
    else
        case(sw)
            2'b00 : G_time <= G_time;
            2'b10 : G_time <= G_time;
            2'b11 : G_time <= G_time;
            2'b01 : if(btn[0])
                        G_time <= 4'd5;
                    else if(btn[1])
                        G_time <= G_time + 4'd1;
                    else if(btn[2])
                        G_time <= G_time - 4'd1;
                    else
                        G_time <= G_time;
        
        endcase

wire [3:0] remain;
normal switch_00( .clk(clk_div), .rst(rst), .R_G_time(G_time), .R_Y_time(Y_time), .R_R_time(R_time), .T1(normal_T1), .T2(normal_T2), .remain(remain));


//leds
always @(posedge clk_div or posedge rst)
    if(rst)
        leds <= 4'b0000;
    else
        case(sw)
            2'b00 : leds <= remain;
            2'b01 : leds <= G_time;
            2'b10 : leds <= Y_time;
            2'b11 : leds <= R_time;

        endcase

//T1
always @(posedge clk_div or posedge rst)
    if(rst)
        T1 <= 3'b111;
    else
        case(sw)
            2'b00 : T1 <= normal_T1;
            2'b01 : T1 <= 3'b010;
            2'b10 : T1 <= 3'b110;
            2'b11 : T1 <= 3'b100;
        endcase

always @(posedge clk_div or posedge rst)
    if(rst)
        T2 <= 3'b111;
    else
        case(sw)
            2'b00 : T2 <= normal_T2;
            2'b01 : T2 <= 3'b100;
            2'b10 : T2 <= 3'b110;
            2'b11 : T2 <= 3'b100;
        endcase


endmodule
