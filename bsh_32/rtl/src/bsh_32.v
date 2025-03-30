module bsh_32 (
    input [31:0] data_in,
    input dir,
    input [4:0] sh,
    output [31:0] data_out
);

    reg [31:0] out;

    always @(*) begin
        case(dir)
            1'b0: begin
                out = sh[0] ? {data_in[30:0], data_in[31]} : data_in;
                out = sh[1] ? {out[29:0], out[31:30]} : out;
                out = sh[2] ? {out[27:0], out[31:28]} : out;
                out = sh[3] ? {out[23:0], out[31:24]} : out;
                out = sh[4] ? {out[15:0], out[31:16]} : out;
            end
            1'b1:begin
                out = sh[0] ? {data_in[0], data_in[31:1]} : data_in;
                out = sh[1] ? {out[1:0], out[31:2]} : out;
                out = sh[2] ? {out[3:0], out[31:4]} : out;
                out = sh[3] ? {out[7:0], out[31:8]} : out;
                out = sh[4] ? {out[15:0], out[31:16]} : out;
            end
        endcase
    end

    assign data_out = out;

endmodule

