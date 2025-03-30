module top(
    input wire [15:0] a,b,
    input clk,rstn,
    output reg [16:0] sum
);

reg   [15:0]  a_pipe;
reg   [15:0]  b_pipe;

wire  [16:0]  sum_t;    
always @(posedge clk or negedge rstn) begin
    if(~rstn)begin 
        a_pipe <= 16'b0;
        b_pipe <= 16'b0;
        sum <= 17'b0;
    end else begin 
        a_pipe <= a;
        b_pipe <= b;
        sum <= sum_t;
    end
end

add_tc_16_16  u_add_tc_16_16 (
    .a (a_pipe[15:0]),
    .b (b_pipe[15:0]),
    .sum (sum_t[16:0])
);



endmodule