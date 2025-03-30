`timescale 1ns / 1ps

module fft(
    input clk,
    input rst_n,
    input resort_complete,
    input inv,
    input signed [15:0] xm1_re,
    input signed [15:0] xm1_im,
    input signed [15:0] xm2_re,
    input signed [15:0] xm2_im,
    input signed [15:0] w_re,
    input signed [15:0] w_im, 
    input [9:0] N,
    input [3:0] M,
    output [8:0] rd_addr1,
    output [8:0] rd_addr2,
    output [8:0] wr_addr1,
    output [8:0] wr_addr2,
    output [7:0] rd_addr_wn,
    output rd_en,
    output wr_en,
    output wn_rd_en,
    output signed [15:0] xn1_re,
    output signed [15:0] xn1_im,
    output signed [15:0] xn2_re,
    output signed [15:0] xn2_im,
    output reg fft_complete
    );
    reg  cnt_m2;
    reg  [3:0] L;
    reg  [9:0] J;
    reg  [9:0] K;
    wire [9:0] B;
    wire [9:0] P;
    wire [9:0] B_W;
    // fft_start
    reg fft_start;
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            fft_start <= 0;
        else if(resort_complete == 1)
            fft_start <= ~fft_start;
        else if(L == M && cnt_m2 == 1 &&
                (K + B_W) > N - 2 && J == B - 1)
            fft_start <= ~fft_start; 
        else
            fft_start <= fft_start;
    end
    // fft_complete
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            fft_complete <= 0;
        else if(L == M && cnt_m2 == 1 &&
                (K + B_W) > N - 2 && J == B - 1)
            fft_complete <= 1;
        else
            fft_complete <= 0;
    end
    // cnt_m2
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            cnt_m2 <= 0;
        else if(fft_start == 1)
            cnt_m2 <= cnt_m2 + 1;
        else
            cnt_m2 <= 0;
    end

    // B B_W P
    assign B = 10'b1 << (L - 1);// distance of butfly input 2^(L-1)
    assign P = (10'b1 << (M - L))*J;// w cnt 2^[(M - L))*J]
    assign B_W = 10'b1 << L;// 2^L

    // K
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            K <= 0;
        else if(fft_start == 1 && cnt_m2 == 1) 
        begin
            if((K + B_W) <= N - 2)
                K <= K + B_W;
            else
            begin
                if(J + 1 <= B - 1)
                    K <= J + 1;
                else
                    K <= 0;
            end
        end
        else
            K <= K;
    end
    // J
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            J <= 0;
        else if(fft_start == 1 && cnt_m2 == 1 && (K + B_W) > N - 2)
        begin
            if(J < B - 1)
                J <= J + 1;
            else
                J <= 0;
        end
        else
            J <= J;
    end
    // L
    always@(posedge clk or negedge rst_n)
    begin
        if(~rst_n)
            L <= 4'd1;
        else if(fft_start == 1 && cnt_m2 == 1 &&
                (K + B_W) > N - 2 && J == B - 1)
        begin
            if(L < M)
                L <= L + 1;
            else
                L <= 4'd1;
        end
        else
            L <= L;
    end


    assign rd_en      = (fft_start == 1) ? (cnt_m2 == 0 ? 1 : 0) : 1'bz;
    assign wr_en      = (fft_start == 1) ? (cnt_m2 == 0 ? 0 : 1) : 1'bz;
    assign wn_rd_en   = (fft_start == 1) ? 1 : 1'bz;

    assign rd_addr1   = (fft_start == 1) ? K : 9'dz;
    assign rd_addr2   = (fft_start == 1) ? K + B : 9'dz;
    assign wr_addr1   = (fft_start == 1) ? K : 9'dz;
    assign wr_addr2   = (fft_start == 1) ? K + B : 9'dz;
    assign rd_addr_wn = (fft_start == 1) ? (P <<< (9 - M)) : 8'dz;
    
    wire signed [15:0] xn1_re_w;
    wire signed [15:0] xn1_im_w;
    wire signed [15:0] xn2_re_w;
    wire signed [15:0] xn2_im_w;

    butterfly_unit butterfly_unit_init(
        .clk(clk),
        .rst_n(rst_n),
        .fft_start(fft_start),
        .xm1_re(xm1_re),
        .xm1_im(xm1_im),
        .xm2_re(xm2_re),
        .xm2_im(xm2_im),
        .w_re(w_re),
        .w_im(w_im),

        .xn1_re(xn1_re_w),
        .xn1_im(xn1_im_w),
        .xn2_re(xn2_re_w),
        .xn2_im(xn2_im_w)
    );
    
    assign xn1_re = (inv == 0) ? xn1_re_w : (xn1_re_w >>> 1);
    assign xn1_im = (inv == 0) ? xn1_im_w : (xn1_im_w >>> 1);
    assign xn2_re = (inv == 0) ? xn2_re_w : (xn2_re_w >>> 1);
    assign xn2_im = (inv == 0) ? xn2_im_w : (xn2_im_w >>> 1);
endmodule


