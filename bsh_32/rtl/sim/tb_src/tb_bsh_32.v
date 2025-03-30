`timescale  1ns / 1ps
module tb_bsh_32();

reg [31:0] data_in;
reg dir;
reg [4:0] sh;
wire [31:0] data_out;

initial begin
    data_in <= $random;
    dir <= 1'b0;
    sh <= 5'd1;
    #10
    dir <= 1'b1;
    sh <= 5'd5;
    #10
    dir <= 1'b1;
    sh <= 5'd20;
    #20
    $finish;
end

bsh_32 u_bsh_32(
    .data_in(data_in),
    .dir(dir),
    .sh(sh),
    .data_out(data_out)
);

endmodule

