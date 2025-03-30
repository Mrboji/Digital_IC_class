`timescale  1ns / 1ps

module tb_mat_scan;

parameter PERIOD  = 10;

reg   clk  = 0 ;
reg   rst_n  = 0 ;
reg   vld_in  = 0 ;
reg   [9:0] din = 0 ;

wire  vld_out ;    
wire  [9:0]  dout;    

initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

mat_scan  u_mat_scan (
    .clk    ( clk   ),
    .rst_n  ( rst_n ),
    .vld_in ( vld_in),
    .din    ( din [9:0] ),

    .vld_out( vld_out ),
    .dout   ( dout [9:0] )
);


initial begin
        #(PERIOD*3)
        vld_in <= 1'b1;
        #(PERIOD*64)
        vld_in <= 1'b0;
        #(PERIOD*70)
        $finish;
    end
always @(posedge clk) begin
        if (vld_in == 1'b1) begin
           din <= din + 1'b1;
        end
    end
endmodule