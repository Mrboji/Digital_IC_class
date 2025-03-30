`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/22 17:54:54
// Design Name: 
// Module Name: seq_detect
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


module seq_detect(
    input clk,
    input rst_n,
    input din_vld,
    input din,
    output result
);

parameter SEQ_WIDTH = 6;
parameter TARGET_SEQ_1 = 6'b111000;
parameter TARGET_SEQ_2 = 6'b101110;

reg [SEQ_WIDTH-1: 0] seq_reg;
always @(posedge clk or negedge rst_n)begin
if(!rst_n)
    seq_reg <= 0;
else if(din_vld)
    seq_reg <= {seq_reg[SEQ_WIDTH-2: 0], din};
else
    seq_reg <= seq_reg;
end

reg result_reg;
always @(posedge clk or negedge rst_n)begin
if(!rst_n)
    result_reg <= 0;
else if(seq_reg == TARGET_SEQ_1 || seq_reg == TARGET_SEQ_2)
    result_reg <= 1;
else
    result_reg <= 0;
end

    
assign result = result_reg;
endmodule
