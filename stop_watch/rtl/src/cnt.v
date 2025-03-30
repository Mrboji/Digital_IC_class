module cnt
#(
    parameter CNT_MAX = 4'b1001
)
(
    input clk,
    input rstn,
    input clear,
    input cnt_en,
    output reg [3:0] cnt_out,
    output full
    
);
    always @(posedge clk or negedge rstn) begin
        if(~rstn) begin
            cnt_out <= 4'b0;
        end
        else begin
            if(clear) begin
                cnt_out <= 4'b0;
            end
            else if(cnt_en & full) begin
                cnt_out <= 4'b0;
            end
            else if(cnt_en) begin
                cnt_out <= cnt_out+1;
            end
            else begin
                cnt_out <= cnt_out;
            end
        end
    end

    
    assign full = cnt_out == CNT_MAX;

endmodule

