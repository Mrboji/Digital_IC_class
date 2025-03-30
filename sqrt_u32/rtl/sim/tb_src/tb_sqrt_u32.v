`timescale  1ns / 1ps

module tb_sqrt_u32;  

parameter PERIOD    = 10 ;
parameter DATA_WIDTH= 32 ;
parameter Q_WIDTH   = DATA_WIDTH/2;
parameter R_WIDTH   = Q_WIDTH + 1 ;

reg   clk      = 0 ;
reg   rst_n    = 0 ;
reg   valid_in = 0 ;
reg   [DATA_WIDTH-1:0]  data_i = 0 ;

wire  valid_out;
wire  [Q_WIDTH-1:0] data_o;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

sqrt_u32 #(
    .DATA_WIDTH ( DATA_WIDTH ),
    .Q_WIDTH    ( Q_WIDTH    ),
    .R_WIDTH    ( R_WIDTH    ))
 u_sqrt_u32 (
    .clk      ( clk      ),
    .rst_n    ( rst_n    ),
    .valid_in ( valid_in ),
    .data_i   ( data_i     [DATA_WIDTH-1:0] ),

    .valid_out( valid_out ),
    .data_o   ( data_o     [Q_WIDTH-1:0])
);

initial
begin
    #(PERIOD*4)
    valid_in <= 1'b1;
    data_i <= 256;
    #(PERIOD*2)
    data_i <= 255;
    #(PERIOD*2)
    data_i <= 32'd2147483648;
    #(PERIOD*2)
    data_i <= 32'd4294967295;
    #(PERIOD*20)
    $finish;
end

endmodule