module sort_32_u8 #(
    parameter W_DATA = 8 ,
    parameter NUM = 32 

) (
    input  wire clk,
    input  wire rst_n,
    input  wire vld_in,
    input  wire [W_DATA-1:0] din_0 ,din_1 ,din_2 ,din_3 ,din_4 ,din_5 ,din_6 ,din_7 ,din_8 ,din_9 ,
                             din_10,din_11,din_12,din_13,din_14,din_15,din_16,din_17,din_18,din_19,
                             din_20,din_21,din_22,din_23,din_24,din_25,din_26,din_27,din_28,din_29,
                             din_30,din_31  , 
    output reg vld_out , 
    output wire [W_DATA-1:0] dout_0 ,dout_1 ,dout_2 ,dout_3 ,dout_4 ,dout_5 ,dout_6 ,dout_7 ,dout_8 ,dout_9  ,
                             dout_10,dout_11,dout_12,dout_13,dout_14,dout_15,dout_16,dout_17,dout_18,dout_19 ,
                             dout_20,dout_21,dout_22,dout_23,dout_24,dout_25,dout_26,dout_27,dout_28,dout_29 ,
                             dout_30,dout_31  
);
// pipe0 输入端---------------------------------------------------------------------------------
// wire vld_in;
wire [W_DATA-1:0] din [NUM-1:0];
assign {
din[0 ],din[1 ],din[2 ],din[3 ],din[4 ],din[5 ],din[6 ],din[7 ],din[8 ],din[9 ] ,
din[10],din[11],din[12],din[13],din[14],din[15],din[16],din[17],din[18],din[19] ,
din[20],din[21],din[22],din[23],din[24],din[25],din[26],din[27],din[28],din[29] ,
din[30],din[31]
} = {
din_0 ,din_1 ,din_2 ,din_3 ,din_4 ,din_5 ,din_6 ,din_7 ,din_8 ,din_9   ,
din_10,din_11,din_12,din_13,din_14,din_15,din_16,din_17,din_18,din_19  ,
din_20,din_21,din_22,din_23,din_24,din_25,din_26,din_27,din_28,din_29  ,
din_30,din_31 
};
genvar i,j;
// pipeline 1:compare--------------------------------------------------------------------------------
reg [W_DATA-1:0] pipe1_data [NUM-1:0];
reg [4:0] pipe1_flag  [NUM-1:0][NUM-1:0];
reg pipe1_valid [NUM-1:0][NUM-1:0];
wire pipe1_valid_sum1[NUM-1:0];
wire pipe1_valid_sum;
generate
    for (j = 0; j<NUM; j=j+1) begin
        assign pipe1_valid_sum1[j] = &{
                                        pipe1_valid[j][0 ],pipe1_valid[j][1 ],pipe1_valid[j][2 ],pipe1_valid[j][3 ],pipe1_valid[j][4 ],pipe1_valid[j][5 ],pipe1_valid[j][6 ],pipe1_valid[j][7 ],pipe1_valid[j][8 ],pipe1_valid[j][9 ] ,
                                        pipe1_valid[j][10],pipe1_valid[j][11],pipe1_valid[j][12],pipe1_valid[j][13],pipe1_valid[j][14],pipe1_valid[j][15],pipe1_valid[j][16],pipe1_valid[j][17],pipe1_valid[j][18],pipe1_valid[j][19] ,
                                        pipe1_valid[j][20],pipe1_valid[j][21],pipe1_valid[j][22],pipe1_valid[j][23],pipe1_valid[j][24],pipe1_valid[j][25],pipe1_valid[j][26],pipe1_valid[j][27],pipe1_valid[j][28],pipe1_valid[j][29] ,
                                        pipe1_valid[j][30],pipe1_valid[j][31]
                                        } ;
    end
endgenerate
assign pipe1_valid_sum = &{
pipe1_valid_sum1[0 ],pipe1_valid_sum1[1 ],pipe1_valid_sum1[2 ],pipe1_valid_sum1[3 ],pipe1_valid_sum1[4 ],pipe1_valid_sum1[5 ],pipe1_valid_sum1[6 ],pipe1_valid_sum1[7 ],pipe1_valid_sum1[8 ],pipe1_valid_sum1[9 ] ,
pipe1_valid_sum1[10],pipe1_valid_sum1[11],pipe1_valid_sum1[12],pipe1_valid_sum1[13],pipe1_valid_sum1[14],pipe1_valid_sum1[15],pipe1_valid_sum1[16],pipe1_valid_sum1[17],pipe1_valid_sum1[18],pipe1_valid_sum1[19] ,
pipe1_valid_sum1[20],pipe1_valid_sum1[21],pipe1_valid_sum1[22],pipe1_valid_sum1[23],pipe1_valid_sum1[24],pipe1_valid_sum1[25],pipe1_valid_sum1[26],pipe1_valid_sum1[27],pipe1_valid_sum1[28],pipe1_valid_sum1[29] ,
pipe1_valid_sum1[30],pipe1_valid_sum1[31]
} ;
generate
    for (j = 0; j<NUM; j=j+1) begin:unfold_j
        for(i=0;i<NUM;i=i+1) begin:unfold_i
            always@(posedge	clk) begin
                if(~rst_n) begin
                    pipe1_valid[j][i] <= 0;
                    pipe1_flag[j][i]  <= 0;	
                end
                else if(vld_in) begin
                    if(din[j] < din[i]) pipe1_flag[j][i] <= 0;
                    else if(din[j] == din[i]) begin
                        if(j >= i) pipe1_flag[j][i] <= 0;
                        else       pipe1_flag[j][i] <= 1;
                        end
                    else pipe1_flag[j][i] <= 1;
                    pipe1_valid[j][i] <= vld_in;
                end
                else begin
                    pipe1_flag[j][i] <= 0;
                    pipe1_valid[j][i] <= 0;
                end
            end
        end
		// data pipedown to 
        always @(posedge clk) begin
            if (~rst_n) begin
                pipe1_data[j] <= 0;
            end
            else if (vld_in) begin
                pipe1_data[j] <= din[j];
            end
            else begin
                pipe1_data[j] <= 0;
            end
        end
    end
endgenerate
// pipe2 sum socre-------------------------------------------------------------------------------
reg [W_DATA-1:0] pipe2_data [NUM-1:0];
reg [4:0] pipe2_flag_sum  [NUM-1:0];
reg pipe2_valid [NUM-1:0];
wire pipe2_valid_sum = &{
&pipe2_valid[0 ],&pipe2_valid[1 ],&pipe2_valid[2 ],&pipe2_valid[3 ],&pipe2_valid[4 ],&pipe2_valid[5 ],&pipe2_valid[6 ],&pipe2_valid[7 ],&pipe2_valid[8 ],&pipe2_valid[9 ] ,
&pipe2_valid[10],&pipe2_valid[11],&pipe2_valid[12],&pipe2_valid[13],&pipe2_valid[14],&pipe2_valid[15],&pipe2_valid[16],&pipe2_valid[17],&pipe2_valid[18],&pipe2_valid[19] ,
&pipe2_valid[20],&pipe2_valid[21],&pipe2_valid[22],&pipe2_valid[23],&pipe2_valid[24],&pipe2_valid[25],&pipe2_valid[26],&pipe2_valid[27],&pipe2_valid[28],&pipe2_valid[29] ,
&pipe2_valid[30],&pipe2_valid[31]
} == 1'b1;
generate
    for (j = 0; j<NUM; j=j+1) begin
        always @(posedge clk) begin
            if (~rst_n) begin
                pipe2_valid[j] <= 0;
                pipe2_flag_sum[j] <= 0;
                pipe2_data[j] <= 0;
            end
            else if (pipe1_valid_sum) begin
                pipe2_valid[j] <= pipe1_valid_sum;
                pipe2_flag_sum[j] <=    pipe1_flag[j][0 ] + pipe1_flag[j][1 ] + pipe1_flag[j][2 ] + pipe1_flag[j][3 ] + 
                                        pipe1_flag[j][4 ] + pipe1_flag[j][5 ] + pipe1_flag[j][6 ] + pipe1_flag[j][7 ] + 
                                        pipe1_flag[j][8 ] + pipe1_flag[j][9 ] + pipe1_flag[j][10] + pipe1_flag[j][11] + 
                                        pipe1_flag[j][12] + pipe1_flag[j][13] + pipe1_flag[j][14] + pipe1_flag[j][15] + 
                                        pipe1_flag[j][16] + pipe1_flag[j][17] + pipe1_flag[j][18] + pipe1_flag[j][19] + 
                                        pipe1_flag[j][20] + pipe1_flag[j][21] + pipe1_flag[j][22] + pipe1_flag[j][23] + 
                                        pipe1_flag[j][24] + pipe1_flag[j][25] + pipe1_flag[j][26] + pipe1_flag[j][27] + 
                                        pipe1_flag[j][28] + pipe1_flag[j][29] + pipe1_flag[j][30] + pipe1_flag[j][31] ;
                pipe2_data[j] <= pipe1_data[j];
            end 
            else begin
                pipe2_valid[j] <= 0;
                pipe2_flag_sum[j] <= 0;
                pipe2_data[j] <= 0;
            end
        end
    end
endgenerate
// pipe3 output-----------------------------------------------------------------------------------
reg [W_DATA-1:0] pipe3_data [NUM-1:0];
reg [NUM-1:0] pipe3_flag_sum  [NUM-1:0];
reg pipe3_valid [NUM-1:0];
generate
    always @(posedge clk) begin
        if (~rst_n) begin
            vld_out <= 0;
            {
            pipe3_data[0 ],pipe3_data[1 ],pipe3_data[2 ],pipe3_data[3 ],pipe3_data[4 ],pipe3_data[5 ],pipe3_data[6 ],pipe3_data[7 ],pipe3_data[8 ],pipe3_data[9 ] ,
            pipe3_data[10],pipe3_data[11],pipe3_data[12],pipe3_data[13],pipe3_data[14],pipe3_data[15],pipe3_data[16],pipe3_data[17],pipe3_data[18],pipe3_data[19] ,
            pipe3_data[20],pipe3_data[21],pipe3_data[22],pipe3_data[23],pipe3_data[24],pipe3_data[25],pipe3_data[26],pipe3_data[27],pipe3_data[28],pipe3_data[29] ,
            pipe3_data[30],pipe3_data[31]
            } <= 0;
        end
        else if (pipe2_valid_sum) begin
            vld_out <= 1;
            {
            pipe3_data[pipe2_flag_sum[0 ]],pipe3_data[pipe2_flag_sum[1 ]],pipe3_data[pipe2_flag_sum[2 ]],pipe3_data[pipe2_flag_sum[3 ]],pipe3_data[pipe2_flag_sum[4 ]],pipe3_data[pipe2_flag_sum[5 ]],pipe3_data[pipe2_flag_sum[6 ]],pipe3_data[pipe2_flag_sum[7 ]],pipe3_data[pipe2_flag_sum[8 ]],pipe3_data[pipe2_flag_sum[9 ]] ,
            pipe3_data[pipe2_flag_sum[10]],pipe3_data[pipe2_flag_sum[11]],pipe3_data[pipe2_flag_sum[12]],pipe3_data[pipe2_flag_sum[13]],pipe3_data[pipe2_flag_sum[14]],pipe3_data[pipe2_flag_sum[15]],pipe3_data[pipe2_flag_sum[16]],pipe3_data[pipe2_flag_sum[17]],pipe3_data[pipe2_flag_sum[18]],pipe3_data[pipe2_flag_sum[19]] ,
            pipe3_data[pipe2_flag_sum[20]],pipe3_data[pipe2_flag_sum[21]],pipe3_data[pipe2_flag_sum[22]],pipe3_data[pipe2_flag_sum[23]],pipe3_data[pipe2_flag_sum[24]],pipe3_data[pipe2_flag_sum[25]],pipe3_data[pipe2_flag_sum[26]],pipe3_data[pipe2_flag_sum[27]],pipe3_data[pipe2_flag_sum[28]],pipe3_data[pipe2_flag_sum[29]] ,
            pipe3_data[pipe2_flag_sum[30]],pipe3_data[pipe2_flag_sum[31]]
            } <= {
            pipe2_data[0 ],pipe2_data[1 ],pipe2_data[2 ],pipe2_data[3 ],pipe2_data[4 ],pipe2_data[5 ],pipe2_data[6 ],pipe2_data[7 ],pipe2_data[8 ],pipe2_data[9 ] ,
            pipe2_data[10],pipe2_data[11],pipe2_data[12],pipe2_data[13],pipe2_data[14],pipe2_data[15],pipe2_data[16],pipe2_data[17],pipe2_data[18],pipe2_data[19] ,
            pipe2_data[20],pipe2_data[21],pipe2_data[22],pipe2_data[23],pipe2_data[24],pipe2_data[25],pipe2_data[26],pipe2_data[27],pipe2_data[28],pipe2_data[29] ,
            pipe2_data[30],pipe2_data[31]
            };
        end
        else begin
            vld_out <= 0;
            {
            pipe3_data[0 ],pipe3_data[1 ],pipe3_data[2 ],pipe3_data[3 ],pipe3_data[4 ],pipe3_data[5 ],pipe3_data[6 ],pipe3_data[7 ],pipe3_data[8 ],pipe3_data[9 ] ,
            pipe3_data[10],pipe3_data[11],pipe3_data[12],pipe3_data[13],pipe3_data[14],pipe3_data[15],pipe3_data[16],pipe3_data[17],pipe3_data[18],pipe3_data[19] ,
            pipe3_data[20],pipe3_data[21],pipe3_data[22],pipe3_data[23],pipe3_data[24],pipe3_data[25],pipe3_data[26],pipe3_data[27],pipe3_data[28],pipe3_data[29] ,
            pipe3_data[30],pipe3_data[31]
            } <= 0;
        end
    end
endgenerate
assign {
dout_0 ,dout_1 ,dout_2 ,dout_3 ,dout_4 ,dout_5 ,dout_6 ,dout_7 ,dout_8 ,dout_9  ,
dout_10,dout_11,dout_12,dout_13,dout_14,dout_15,dout_16,dout_17,dout_18,dout_19 ,
dout_20,dout_21,dout_22,dout_23,dout_24,dout_25,dout_26,dout_27,dout_28,dout_29 ,
dout_30,dout_31
} = {
pipe3_data[0 ],pipe3_data[1 ],pipe3_data[2 ],pipe3_data[3 ],pipe3_data[4 ],pipe3_data[5 ],pipe3_data[6 ],pipe3_data[7 ],pipe3_data[8 ],pipe3_data[9 ] ,
pipe3_data[10],pipe3_data[11],pipe3_data[12],pipe3_data[13],pipe3_data[14],pipe3_data[15],pipe3_data[16],pipe3_data[17],pipe3_data[18],pipe3_data[19] ,
pipe3_data[20],pipe3_data[21],pipe3_data[22],pipe3_data[23],pipe3_data[24],pipe3_data[25],pipe3_data[26],pipe3_data[27],pipe3_data[28],pipe3_data[29] ,
pipe3_data[30],pipe3_data[31]
} ;

endmodule