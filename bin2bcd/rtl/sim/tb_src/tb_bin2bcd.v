`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/10/23 14:03:05
// Design Name: 
// Module Name: tb_bin2bcd
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


module tb_bin2bcd;

// bin2bcd Parameters
parameter PERIOD  = 10;
// bin2bcd Inputs
reg   [7:0]  bin_in                        = 0 ;
// bin2bcd Outputs
wire  [9:0]  bcd_out                       ;


bin2bcd  u_bin2bcd (
    .bin_in                  ( bin_in   [7:0] ),
    .bcd_out                 ( bcd_out  [9:0] )
);

initial
begin
    $monitor("input(decimal): %d, output(hex): %h", bin_in, bcd_out);
    repeat(20) begin
        bin_in = $random;
        #PERIOD;
    end
    #(PERIOD * 2) $finish;
end

endmodule
