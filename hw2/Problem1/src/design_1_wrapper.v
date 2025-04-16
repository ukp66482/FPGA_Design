//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2023 Advanced Micro Devices, Inc. All Rights Reserved.
//--------------------------------------------------------------------------------
//Tool Version: Vivado v.2023.2 (win64) Build 4029153 Fri Oct 13 20:14:34 MDT 2023
//Date        : Fri Mar 28 12:49:58 2025
//Host        : Charmender running 64-bit major release  (build 9200)
//Command     : generate_target design_1_wrapper.bd
//Design      : design_1_wrapper
//Purpose     : IP block netlist
//--------------------------------------------------------------------------------
`timescale 1 ps / 1 ps

module design_1_wrapper
   (clk,
    led4_b,
    led4_g,
    led4_r,
    led5_b,
    led5_g,
    led5_r,
    rst,
    sw);
  input clk;
  output led4_b;
  output led4_g;
  output led4_r;
  output led5_b;
  output led5_g;
  output led5_r;
  input rst;
  input [1:0]sw;

  wire clk;
  wire led4_b;
  wire led4_g;
  wire led4_r;
  wire led5_b;
  wire led5_g;
  wire led5_r;
  wire rst;
  wire [1:0]sw;

  design_1 design_1_i
       (.clk(clk),
        .led4_b(led4_b),
        .led4_g(led4_g),
        .led4_r(led4_r),
        .led5_b(led5_b),
        .led5_g(led5_g),
        .led5_r(led5_r),
        .rst(rst),
        .sw(sw));
endmodule
