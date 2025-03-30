`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/22 17:22:50
// Design Name: 
// Module Name: ldo_find
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


module ldo_find(
    input [31:0] data_in,
    output [5:0] pos_out
 );
 // divide data_in then conquer
 wire [4:0]  one_check;
 wire [15:0] data_16;
 wire [7:0]  data_8;
 wire [3:0]  data_4;
 wire [1:0]  data_2;
 // 32-16
 assign one_check[4] = |data_in[31:16];
 assign data_16 = one_check[4] ? data_in[31:16] : data_in[15:0];
 // 16-8
 assign one_check[3] = |data_16[15:8];
 assign data_8 = one_check[3] ? data_16[15:8] : data_16[7:0];
 // 8-4
 assign one_check[2] = |data_8[7:4];
 assign data_4 = one_check[2] ? data_8[7:4] : data_8[3:0];
 // 4-2
 assign one_check[1] = |data_4[3:2];
 assign data_2 = one_check[1] ? data_4[3:2] : data_4[1:0];
 // 2-1
 assign one_check[0] = data_2[1];
 // get pos
 assign pos_out = (|data_in) ? {1'b0, ~one_check} : 6'd32;
 
endmodule
