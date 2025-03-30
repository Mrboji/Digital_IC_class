`timescale  1ns / 1ps

module tb_stop_watch;

parameter PERIOD     = 10 ;
parameter CNT_MAX_9  = 4'd9;
parameter CNT_MAX_5  = 4'd5;
parameter START      = 1'b1 ;
parameter STOP       = 1'b0 ;

reg   clk = 0;
reg   rstn = 0;
reg   clear = 0;
reg   start_stop = 0;

wire  [3:0]  hr_h  ;
wire  [3:0]  hr_l  ;
wire  [3:0]  min_h ;
wire  [3:0]  min_l ;
wire  [3:0]  sec_h ;
wire  [3:0]  sec_l ;

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rstn  =  1;
end

stop_watch #(
    .CNT_MAX_9 ( CNT_MAX_9 ),
    .CNT_MAX_5 ( CNT_MAX_5 ),
    .START( START),
    .STOP ( STOP ))
 u_stop_watch (
    .clk ( clk  ),
    .rstn ( rstn ),
    .clear( clear),
    .start_stop( start_stop),
    .hr_h  ( hr_h [3:0] ),
    .hr_l  ( hr_l [3:0] ),
    .min_h ( min_h[3:0] ),
    .min_l ( min_l[3:0] ),
    .sec_h ( sec_h[3:0] ),
    .sec_l ( sec_l[3:0] )
);

initial
begin
    #(PERIOD*3) start_stop = 1;
    #(PERIOD*1) start_stop = 0;
    #(PERIOD*3600);
    #(PERIOD*2) start_stop = 1;
    #(PERIOD*1) start_stop = 0;
    #(PERIOD*2) clear = 1;
    #(PERIOD*1) clear = 0;
    #(PERIOD*2) 
    start_stop = 1;
    #(PERIOD*5);
    $finish;
end

endmodule