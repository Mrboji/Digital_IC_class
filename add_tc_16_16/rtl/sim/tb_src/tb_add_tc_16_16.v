`timescale  1ns / 1ps
module tb_add_tc_16_16;

parameter PERIOD = 10;

reg  signed [15:0]  a = 0;
reg  signed [15:0]  b = 0;

wire signed [16:0]  sum;    
wire signed [16:0] sum_expect;
assign sum_expect = a+b;
add_tc_16_16  u_add_tc_16_16 (
    .a (a[15:0]),
    .b (b[15:0]),
    .sum (sum[16:0])
);

initial
begin
    $monitor("input A = %d, B = %d, sum =  %d, expect %d",a,b,sum,sum_expect);
    $srandom(1);
    repeat(20) begin
        a[15:0] = $random;
        b[15:0] = $random;
        #PERIOD;
    end
    #(PERIOD * 2) $finish;
end

endmodule