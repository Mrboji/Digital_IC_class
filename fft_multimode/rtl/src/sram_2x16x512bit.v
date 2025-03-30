`timescale 1ns / 1ps

module sram_2x16x512bit(
    input clk,
    input rst_n,
    input wr_en,
    input rd_en,
    input [8:0] wr_addr1,
    input [8:0] wr_addr2,
    input [8:0] rd_addr1,
    input [8:0] rd_addr2,
    input [15:0] xn1_re_in,
    input [15:0] xn1_im_in,
    input [15:0] xn2_re_in,
    input [15:0] xn2_im_in,

    output reg [15:0] xm1_re_out,
    output reg [15:0] xm1_im_out,
    output reg [15:0] xm2_re_out,
    output reg [15:0] xm2_im_out
    );

    reg [15:0] re_sram[511:0];
    reg [15:0] im_sram[511:0];

    //write, delay for 1 cycle
    integer i;
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
        begin
            for(i = 0;i < 512;i = i + 1)
            begin
                re_sram[i] = 16'd0;
                im_sram[i] = 16'd0;
            end
        end
        else if(wr_en == 1)
        begin
            re_sram[wr_addr1] = xn1_re_in;
            im_sram[wr_addr1] = xn1_im_in;

            re_sram[wr_addr2] = xn2_re_in;
            im_sram[wr_addr2] = xn2_im_in;
        end
        else;
    end

    //read
    always@(*)
    begin
        if(rd_en == 1)
        begin
            xm1_re_out = re_sram[rd_addr1];
            xm1_im_out = im_sram[rd_addr1];

            xm2_re_out = re_sram[rd_addr2];
            xm2_im_out = im_sram[rd_addr2];
        end
        else;
    end
endmodule
