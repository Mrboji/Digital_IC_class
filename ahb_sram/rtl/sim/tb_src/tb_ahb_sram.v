`timescale  1ns / 1ps

module tb_ahb_sram;

parameter PERIOD  = 10  ;
parameter ADDR_DEPTH  = 10  ;
parameter DATA_WIDTH  = 8   ;
parameter DATA_DEPTH  = 1024;

reg hclk   = 0 ;
reg hresetn= 0 ;
reg hsel   = 0 ;
reg hready = 0 ;
reg hwrite = 0 ;
reg [1:0]  htrans = 0 ;
reg [2:0]  hsize  = 0 ;
reg [2:0]  hburst = 0 ;
reg [31:0]  haddr = 0 ;
reg [31:0]  hwdata= 0 ;

wire  [1:0]  hresp  ;
wire  hready_resp   ;
wire  [31:0]  hrdata;


initial
begin
    forever #(PERIOD/2)  hclk=~hclk;
end

initial
begin
    #(PERIOD) hresetn = 1;
end

ahb_sram_top #(
    .ADDR_DEPTH ( ADDR_DEPTH ),
    .DATA_WIDTH ( DATA_WIDTH ),
    .DATA_DEPTH ( DATA_DEPTH ))
 u_ahb_sram_top (
    .hclk   ( hclk   ),
    .hresetn( hresetn),
    .hsel   ( hsel   ),
    .hready ( hready ),
    .hwrite ( hwrite ),
    .htrans ( htrans [1:0]  ),
    .hsize  ( hsize  [2:0]  ),
    .hburst ( hburst [2:0]  ),
    .haddr  ( haddr  [31:0] ),
    .hwdata ( hwdata [31:0] ),

    .hresp  ( hresp  [1:0]  ),
    .hready_resp( hready_resp ),
    .hrdata ( hrdata [31:0] )
);
    parameter   IDLE = 2'b00,
                BUSY = 2'b01,
                NONSEQ = 2'b10,
                SEQ = 2'b11;
initial
begin
    // write data 32bit
    #(2*PERIOD);
    hsel =1;
    hready = 1;
    htrans = NONSEQ;
    hwrite = 1;
    hsize = 2'b10;// 32 bit
    //hsize = 2'b01;// 16 bit
    //hsize = 2'b00;// 8 bit
    haddr = 32'h00000ABC;
    #(PERIOD);
    hwdata = 32'h12345678;
    // read data from same addr
    hsel =1;
    hready = 1;
    htrans = SEQ;
    hwrite = 0;
    //hsize = 2'b00;
    haddr = 32'h00000ABC;
    #(10*PERIOD);
    $finish;
end

// INCR 4 addr and control
// initial
// begin
//     //----------clk 1: addr=0000
//     #(2*PERIOD);
//     hsel =1;
//     hready = 1;
//     htrans = NONSEQ;
//     hwrite = 1;
//     hsize = 2'b10;// 32 bit
//     haddr = 32'h00000000;
//     //----------clk 2: addr=0004
//     #(PERIOD);
//     hsel =1;
//     hready = 1;
//     htrans = SEQ;
//     hwrite = 1;
//     hsize = 2'b10;// 32 bit
//     haddr = 32'h00000004;
//     //----------clk 3: addr=0008
//     #(PERIOD);
//     hsel =1;
//     hready = 1;
//     htrans = SEQ;
//     hwrite = 1;
//     hsize = 2'b10;// 32 bit
//     haddr = 32'h00000008;
//     //----------clk 4: addr=000C
//     #(PERIOD);
//     hsel =1;
//     hready = 1;
//     htrans = SEQ;
//     hwrite = 1;
//     hsize = 2'b10;// 32 bit
//     haddr = 32'h0000000C;

//     //--------------- read ---------------
//     //----------clk 1: addr=0000
//     #(PERIOD);
//     hsel =1;
//     hready = 1;
//     htrans = NONSEQ;
//     hwrite = 0;
//     hsize = 2'b10;// 32 bit
//     haddr = 32'h00000000;
//     //----------clk 2: addr=0004
//     #(PERIOD);
//     hsel =1;
//     hready = 1;
//     htrans = SEQ;
//     hwrite = 0;
//     hsize = 2'b10;// 32 bit
//     haddr = 32'h00000004;
//     //----------clk 3: addr=0008
//     #(PERIOD);
//     hsel =1;
//     hready = 1;
//     htrans = SEQ;
//     hwrite = 0;
//     hsize = 2'b10;// 32 bit
//     haddr = 32'h00000008;
//     //----------clk 4: addr=000C
//     #(PERIOD);
//     hsel =1;
//     hready = 1;
//     htrans = SEQ;
//     hwrite = 0;
//     hsize = 2'b10;// 32 bit
//     haddr = 32'h0000000C;
//     #(10*PERIOD);
//     $finish;
// end
// // INCR 4 data
// // INCR 4 addr and control
// initial
// begin
//     //----------clk 1: hwdata=0001
//     #(3*PERIOD);
//     hwdata = 32'h00000001;
//     //----------clk 2: hwdata=0002
//     #(PERIOD);
//     hwdata = 32'h00000002;
//     //----------clk 1: hwdata=0003
//     #(PERIOD);
//     hwdata = 32'h00000003;
//     //----------clk 1: hwdata=0004
//     #(PERIOD);
//     hwdata = 32'h00000004;
//     // write end
//     #(PERIOD);
//     hwdata = 32'h0000000;
// end
endmodule