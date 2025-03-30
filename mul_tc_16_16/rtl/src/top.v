module top(
    input wire [15:0] a,b,
    input clk,rstn,
    output reg [31:0] product
);

reg   [15:0]  a_pipe;
reg   [15:0]  b_pipe;
wire  [31:0]  product_t;    
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin 
        a_pipe <= 16'b0;
        b_pipe <= 16'b0;
        product <= 32'b0;
    end else begin 
        a_pipe <= a;
        b_pipe <= b;
        product <= product_t;
    end
end

mul_tc_16_16  u_mul_tc_16_16 (
    .a ( a_pipe[15:0] ),
    .b ( b_pipe[15:0] ),
    .product (product_t[31:0] )
);



endmodule