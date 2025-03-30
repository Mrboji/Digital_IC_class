`timescale  1ns / 1ps
module tb_mul_tc_16_16 ();

parameter PERIOD = 10;

reg  signed [15:0]  a= 0 ; 
reg  signed [15:0]  b= 0 ; 

wire signed [31:0]  product                      ;      
wire signed [31:0] product_expect;
assign product_expect = a*b;
initial
begin
    a[15:0] = 16'd24704;
    b[15:0] = -16'd32767;
    #PERIOD;
    $monitor("input A = %d, B = %d, product = %d, expect %d",a,b,product,product_expect);
    $srandom(1);
    repeat(20) begin
        a[15:0] = $random;
        b[15:0] = $random;
        #PERIOD;
    end
    #(PERIOD * 2) $finish;
end

mul_tc_16_16 u_uml_tc_16_16(
    .a(a),
    .b(b),
    .product(product)
);

endmodule
