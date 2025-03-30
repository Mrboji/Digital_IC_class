`timescale  1ns / 1ps   

module tb_sort_32_u8;   

parameter PERIOD  = 10;
parameter W_DATA  = 8 ;
parameter NUM     = 32;

reg   clk    = 0 ;
reg   rst_n  = 0 ;
reg   vld_in = 0 ;
reg   [W_DATA-1:0]  din_0  = 0 ;
reg   [W_DATA-1:0]  din_1  = 0 ;
reg   [W_DATA-1:0]  din_2  = 0 ;
reg   [W_DATA-1:0]  din_3  = 0 ;
reg   [W_DATA-1:0]  din_4  = 0 ;
reg   [W_DATA-1:0]  din_5  = 0 ;
reg   [W_DATA-1:0]  din_6  = 0 ;
reg   [W_DATA-1:0]  din_7  = 0 ;
reg   [W_DATA-1:0]  din_8  = 0 ;
reg   [W_DATA-1:0]  din_9  = 0 ;
reg   [W_DATA-1:0]  din_10 = 0 ;
reg   [W_DATA-1:0]  din_11 = 0 ;
reg   [W_DATA-1:0]  din_12 = 0 ;
reg   [W_DATA-1:0]  din_13 = 0 ;
reg   [W_DATA-1:0]  din_14 = 0 ;
reg   [W_DATA-1:0]  din_15 = 0 ;
reg   [W_DATA-1:0]  din_16 = 0 ;
reg   [W_DATA-1:0]  din_17 = 0 ;
reg   [W_DATA-1:0]  din_18 = 0 ;
reg   [W_DATA-1:0]  din_19 = 0 ;
reg   [W_DATA-1:0]  din_20 = 0 ;
reg   [W_DATA-1:0]  din_21 = 0 ;
reg   [W_DATA-1:0]  din_22 = 0 ;
reg   [W_DATA-1:0]  din_23 = 0 ;
reg   [W_DATA-1:0]  din_24 = 0 ;
reg   [W_DATA-1:0]  din_25 = 0 ;
reg   [W_DATA-1:0]  din_26 = 0 ;
reg   [W_DATA-1:0]  din_27 = 0 ;
reg   [W_DATA-1:0]  din_28 = 0 ;
reg   [W_DATA-1:0]  din_29 = 0 ;
reg   [W_DATA-1:0]  din_30 = 0 ;
reg   [W_DATA-1:0]  din_31 = 0 ;

wire  vld_out;
wire  [W_DATA-1:0]  dout_0 ;
wire  [W_DATA-1:0]  dout_1 ;
wire  [W_DATA-1:0]  dout_2 ;
wire  [W_DATA-1:0]  dout_3 ;
wire  [W_DATA-1:0]  dout_4 ;
wire  [W_DATA-1:0]  dout_5 ;
wire  [W_DATA-1:0]  dout_6 ;
wire  [W_DATA-1:0]  dout_7 ;
wire  [W_DATA-1:0]  dout_8 ;
wire  [W_DATA-1:0]  dout_9 ;
wire  [W_DATA-1:0]  dout_10;
wire  [W_DATA-1:0]  dout_11;
wire  [W_DATA-1:0]  dout_12;
wire  [W_DATA-1:0]  dout_13;
wire  [W_DATA-1:0]  dout_14;
wire  [W_DATA-1:0]  dout_15;
wire  [W_DATA-1:0]  dout_16;
wire  [W_DATA-1:0]  dout_17;
wire  [W_DATA-1:0]  dout_18;
wire  [W_DATA-1:0]  dout_19;
wire  [W_DATA-1:0]  dout_20;
wire  [W_DATA-1:0]  dout_21;
wire  [W_DATA-1:0]  dout_22;
wire  [W_DATA-1:0]  dout_23;
wire  [W_DATA-1:0]  dout_24;
wire  [W_DATA-1:0]  dout_25;
wire  [W_DATA-1:0]  dout_26;
wire  [W_DATA-1:0]  dout_27;
wire  [W_DATA-1:0]  dout_28;
wire  [W_DATA-1:0]  dout_29;
wire  [W_DATA-1:0]  dout_30;
wire  [W_DATA-1:0]  dout_31;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

sort_32_u8 #(
    .W_DATA ( W_DATA ),
    .NUM    ( NUM    ))
 u_sort_32_u8 (
    .clk      ( clk   ),
    .rst_n    ( rst_n ),
    .vld_in   ( vld_in),
    .din_0    ( din_0    [W_DATA-1:0] ),
    .din_1    ( din_1    [W_DATA-1:0] ),
    .din_2    ( din_2    [W_DATA-1:0] ),
    .din_3    ( din_3    [W_DATA-1:0] ),
    .din_4    ( din_4    [W_DATA-1:0] ),
    .din_5    ( din_5    [W_DATA-1:0] ),
    .din_6    ( din_6    [W_DATA-1:0] ),
    .din_7    ( din_7    [W_DATA-1:0] ),
    .din_8    ( din_8    [W_DATA-1:0] ),
    .din_9    ( din_9    [W_DATA-1:0] ),
    .din_10   ( din_10   [W_DATA-1:0] ),
    .din_11   ( din_11   [W_DATA-1:0] ),
    .din_12   ( din_12   [W_DATA-1:0] ),
    .din_13   ( din_13   [W_DATA-1:0] ),
    .din_14   ( din_14   [W_DATA-1:0] ),
    .din_15   ( din_15   [W_DATA-1:0] ),
    .din_16   ( din_16   [W_DATA-1:0] ),
    .din_17   ( din_17   [W_DATA-1:0] ),
    .din_18   ( din_18   [W_DATA-1:0] ),
    .din_19   ( din_19   [W_DATA-1:0] ),
    .din_20   ( din_20   [W_DATA-1:0] ),
    .din_21   ( din_21   [W_DATA-1:0] ),
    .din_22   ( din_22   [W_DATA-1:0] ),
    .din_23   ( din_23   [W_DATA-1:0] ),
    .din_24   ( din_24   [W_DATA-1:0] ),
    .din_25   ( din_25   [W_DATA-1:0] ),
    .din_26   ( din_26   [W_DATA-1:0] ),
    .din_27   ( din_27   [W_DATA-1:0] ),
    .din_28   ( din_28   [W_DATA-1:0] ),
    .din_29   ( din_29   [W_DATA-1:0] ),
    .din_30   ( din_30   [W_DATA-1:0] ),
    .din_31   ( din_31   [W_DATA-1:0] ),

    .vld_out  ( vld_out               ),
    .dout_0   ( dout_0   [W_DATA-1:0] ),
    .dout_1   ( dout_1   [W_DATA-1:0] ),
    .dout_2   ( dout_2   [W_DATA-1:0] ),
    .dout_3   ( dout_3   [W_DATA-1:0] ),
    .dout_4   ( dout_4   [W_DATA-1:0] ),
    .dout_5   ( dout_5   [W_DATA-1:0] ),
    .dout_6   ( dout_6   [W_DATA-1:0] ),
    .dout_7   ( dout_7   [W_DATA-1:0] ),
    .dout_8   ( dout_8   [W_DATA-1:0] ),
    .dout_9   ( dout_9   [W_DATA-1:0] ),
    .dout_10  ( dout_10  [W_DATA-1:0] ),
    .dout_11  ( dout_11  [W_DATA-1:0] ),
    .dout_12  ( dout_12  [W_DATA-1:0] ),
    .dout_13  ( dout_13  [W_DATA-1:0] ),
    .dout_14  ( dout_14  [W_DATA-1:0] ),
    .dout_15  ( dout_15  [W_DATA-1:0] ),
    .dout_16  ( dout_16  [W_DATA-1:0] ),
    .dout_17  ( dout_17  [W_DATA-1:0] ),
    .dout_18  ( dout_18  [W_DATA-1:0] ),
    .dout_19  ( dout_19  [W_DATA-1:0] ),
    .dout_20  ( dout_20  [W_DATA-1:0] ),
    .dout_21  ( dout_21  [W_DATA-1:0] ),
    .dout_22  ( dout_22  [W_DATA-1:0] ),
    .dout_23  ( dout_23  [W_DATA-1:0] ),
    .dout_24  ( dout_24  [W_DATA-1:0] ),
    .dout_25  ( dout_25  [W_DATA-1:0] ),
    .dout_26  ( dout_26  [W_DATA-1:0] ),
    .dout_27  ( dout_27  [W_DATA-1:0] ),
    .dout_28  ( dout_28  [W_DATA-1:0] ),
    .dout_29  ( dout_29  [W_DATA-1:0] ),
    .dout_30  ( dout_30  [W_DATA-1:0] ),
    .dout_31  ( dout_31  [W_DATA-1:0] )
);

initial
begin
     #(PERIOD*3);
    din_0  = 31;
    din_1  = 29;
    din_2  = 27;
    din_3  = 25;
    din_4  = 23;
    din_5  = 21;
    din_6  = 19;
    din_7  = 17;
    din_8  = 15;
    din_9  = 13;
    din_10 = 11;
    din_11 = 9;
    din_12 = 7;
    din_13 = 5;
    din_14 = 3;
    din_15 = 1;
    din_16 = 2;
    din_17 = 2;
    din_18 = 4;
    din_19 = 4;
    din_20 = 4;
    din_21 = 4;
    din_22 = 8;
    din_23 = 16;
    din_24 = 8;
    din_25 = 16;
    din_26 = 32;
    din_27 = 32;
    din_28 = 0;
    din_29 = 10;
    din_30 = 20;
    din_31 = 30;
    vld_in = 1'b1;
     #(PERIOD) vld_in = 0;
     #(PERIOD*6);
    $finish;
end

endmodule