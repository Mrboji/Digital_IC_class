`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/22 23:25:06
// Design Name: 
// Module Name: tb_seq_detect
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


module tb_seq_detect();
// seq_detect Parameters
parameter PERIOD        = 10       ;
parameter SEQ_WIDTH     = 6        ;
parameter TARGET_SEQ_1  = 6'b111000;
parameter TARGET_SEQ_2  = 6'b101110;

// seq_detect Inputs
reg   clk                                  = 0 ;
reg   rst_n                                = 0 ;
reg   din                                  = 0 ;
reg   din_vld                              = 0 ;

// seq_detect Outputs
wire  result                               ;

// test seq
parameter TEST_SEQ = 18'b001110001101110000;
// clk rstn
initial
begin
    forever #(PERIOD/2)  clk=~clk;
end
initial
begin
    #(PERIOD) rst_n  =  1;
end
// din
integer i = 0;
initial
begin
    #PERIOD;
    for (i=17; i>=0; i=i-1) begin
        din = TEST_SEQ[i];
        #PERIOD;
    end
    #(PERIOD*3);
    $finish;
end
// din_vld
initial
begin
    #PERIOD din_vld = 1;
end
seq_detect #(
    .SEQ_WIDTH    ( SEQ_WIDTH    ),
    .TARGET_SEQ_1 ( TARGET_SEQ_1 ),
    .TARGET_SEQ_2 ( TARGET_SEQ_2 ))
 u_seq_detect (
    .clk                     ( clk       ),
    .rst_n                   ( rst_n     ),
    .din                     ( din       ),
    .din_vld                 ( din_vld   ),
    .result                  ( result    )
);   

endmodule
