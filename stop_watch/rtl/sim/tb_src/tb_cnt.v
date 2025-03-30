`timescale  1ns / 1ps

module tb_cnt;

parameter PERIOD = 10 ;
parameter CNT_MAX = 4'b1001;

reg   clk   = 0 ;
reg   rstn  = 0 ;
reg   clear = 0 ;
reg   cnt_en= 0 ;

wire  [3:0]  cnt_out ;
wire  full ;

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

cnt #(
    .CNT_MAX ( CNT_MAX ))
 u_cnt (
    .clk ( clk ),
    .rstn ( rstn  ),
    .clear( clear ),
    .cnt_en( cnt_en ),
    .cnt_out( cnt_out[3:0]),
    .full( full )
);

initial
begin
    #(PERIOD*3) cnt_en = 1;
    #(PERIOD*10) cnt_en = 0;
    #(PERIOD*2) cnt_en = 1;
    #(PERIOD*5); cnt_en = 0; clear = 1;
    #(PERIOD) clear = 0;
    #(PERIOD*2) $finish;

end

endmodule