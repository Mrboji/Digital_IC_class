`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/23 12:58:41
// Design Name: 
// Module Name: bin2bcd
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


module bin2bcd (
    input [7:0] bin_in,
    output [9:0] bcd_out
);
    wire [1:0] hundred_bits;
    wire [3:0] ten_bits;
    wire [3:0] one_bits;
// modifier out
wire [3:0] o0,o1, o2, o3, o4, o5, o6;
// shift
modifier x_modifier_0({1'b0,bin_in[7:5]},o0);
// shift
modifier x_modifier_1({o0[2:0],bin_in[4]},o1);
// shift
modifier x_modifier_2({o1[2:0],bin_in[3]},o2);
// shift
modifier x_modifier_3({o2[2:0],bin_in[2]},o3);
modifier x_modifier_5({1'b0,o0[3],o1[3],o2[3]},o5);
// shift
modifier x_modifier_4({o3[2:0],bin_in[1]},o4);
modifier x_modifier_6({o5[2:0],o3[3]},o6);

// assign to bcd out
assign one_bits = {o4[2:0],bin_in[0]};
assign ten_bits = {o6[2:0],o4[3]};
assign hundred_bits = {o5[3],o6[3]};
assign bcd_out = {hundred_bits[1:0],ten_bits[3:0],one_bits[3:0]};
endmodule

module modifier (
    input [3:0] din,
    output [3:0] dout
);
    assign dout = (din > 4'd4) ? (din + 4'd3) : din;
endmodule
