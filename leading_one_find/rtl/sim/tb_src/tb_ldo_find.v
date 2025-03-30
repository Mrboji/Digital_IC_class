`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/22 17:43:51
// Design Name: 
// Module Name: tb_ldo_find
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


module tb_ldo_find( );
reg [31:0] data_in;
wire [5:0] pos_out;
 
initial begin
	data_in = 32'b0000_0000_0000_0000_0000_0000_0000_0000;// expect pos_out = 32
	#100
    data_in = 32'b0001_1000_1000_0000_0000_0000_0000_0000;
    #100
	data_in = 32'b0000_0000_1111_1111_0000_0000_0000_1101;// expect pos_out = 8
	#100
	data_in = 32'b0000_0000_0000_0000_0000_0000_0000_1010;// expect pos_out = 28
	#100
	data_in = 32'b0000_0000_0000_0000_0000_0000_0000_1010;// expect pos_out = 28
end
ldo_find x_ldo_find(
	.data_in (data_in),
	.pos_out (pos_out)
);
endmodule
