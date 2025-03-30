`timescale 1ns / 1ps

module butterfly_unit(
    input clk,
    input rst_n,
    input fft_start,
    input signed [15:0] xm1_re,
    input signed [15:0] xm1_im,
    input signed [15:0] xm2_re,
    input signed [15:0] xm2_im,
    input signed [15:0] w_re,
    input signed [15:0] w_im,

    output reg [15:0] xn1_re,
    output reg [15:0] xn1_im,
    output reg [15:0] xn2_re,
    output reg [15:0] xn2_im
    );

    // calculate 4 term
    wire signed [31:0] xm2_reXw_re,
                       xm2_reXw_im,
                       xm2_imXw_im,
                       xm2_imXw_re;

    mult_16x16bit mult_16x16bit_init1 (
        .A(xm2_re),  // input wire [7 : 0] A
        .B(w_re),  // input wire [7 : 0] B
        .P(xm2_reXw_re)  // output wire [15 : 0] P
    );
    mult_16x16bit mult_16x16bit_init2 (
        .A(xm2_re),  // input wire [7 : 0] A
        .B(w_im),  // input wire [7 : 0] B
        .P(xm2_reXw_im)  // output wire [15 : 0] P
    );
    mult_16x16bit mult_16x16bit_init3 (
        .A(xm2_im),  // input wire [7 : 0] A
        .B(w_im),  // input wire [7 : 0] B
        .P(xm2_imXw_im)  // output wire [15 : 0] P
    );
    mult_16x16bit mult_16x16bit_init4 (
        .A(xm2_im),  // input wire [7 : 0] A
        .B(w_re),  // input wire [7 : 0] B
        .P(xm2_imXw_re)  // output wire [15 : 0] P
    );
    // mul result reg 
    reg [15:0] xm1_re_r, xm1_im_r;
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
        begin
            xm1_re_r <= 0;
            xm1_im_r <= 0;
        end
        else
        begin
            xm1_re_r <= xm1_re;
            xm1_im_r <= xm1_im;
        end
    end
    // calculate sum
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
        begin
            xn1_re = 16'dz;
            xn1_im = 16'dz;
            xn2_re = 16'dz;
            xn2_im = 16'dz;
        end
        else if(fft_start == 1)
        begin
            xn1_re = xm1_re + (xm2_reXw_re >>> 14) - (xm2_imXw_im >>> 14);
            xn1_im = xm1_im + (xm2_reXw_im >>> 14) + (xm2_imXw_re >>> 14);

            xn2_re = xm1_re - (xm2_reXw_re >>> 14) + (xm2_imXw_im >>> 14);
            xn2_im = xm1_im - (xm2_reXw_im >>> 14) - (xm2_imXw_re >>> 14);
        end
        else
        begin
            xn1_re = 16'dz;
            xn1_im = 16'dz;
            xn2_re = 16'dz;
            xn2_im = 16'dz;
        end
    end
endmodule
