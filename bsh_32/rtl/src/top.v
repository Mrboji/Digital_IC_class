module top(
    input [31:0] data_in,
    input dir,
    input [4:0] sh,
    input clk,rstn,
    output reg [31:0] data_out
);

reg [31:0] data_in_pipe;
reg dir_pipe;
reg [4:0] sh_pipe;
wire [31:0] data_out_t;

always @(posedge clk or negedge rstn) begin
    if(~rstn)begin 
        data_in_pipe <= 32'b0;
        dir_pipe <= 1'b0;
        sh_pipe <= 5'b0;
        data_out <= 32'b0;
    end 
    else begin 
        data_in_pipe <= data_in;
        dir_pipe <= dir;
        sh_pipe <= sh;
        data_out <= data_out_t;
    end
end

bsh_32 u_bsh_32(
    .data_in(data_in_pipe),
    .dir(dir_pipe),
    .sh(sh_pipe),
    .data_out(data_out_t)
);

endmodule

