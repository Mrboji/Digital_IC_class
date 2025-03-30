module sqrt_u32
	#(
			parameter  DATA_WIDTH = 32,
			parameter  Q_WIDTH = DATA_WIDTH/2,
			parameter  R_WIDTH = Q_WIDTH + 1	)
	(
	input	wire clk,
	input	wire rst_n,
	input	wire valid_in,
	input	wire [DATA_WIDTH-1:0]	data_i,
	
	output	reg	valid_out,
	output	reg	[Q_WIDTH-1:0]	data_o
    );

	reg 	[DATA_WIDTH-1:0] D  [Q_WIDTH:1];
	reg 	[Q_WIDTH-1:0] Q_z	[Q_WIDTH:1]; 
	reg	 	[Q_WIDTH-1:0] Q_q	[Q_WIDTH:1];
	reg 	valid_flag		    [Q_WIDTH:1];

	always@(posedge	clk or negedge	rst_n)
		begin
			if(!rst_n)
				begin
					D[Q_WIDTH] <= 0;
					Q_z[Q_WIDTH] <= 0;
					Q_q[Q_WIDTH] <= 0;
					valid_flag[Q_WIDTH] <= 0;
				end
			else if(valid_in)
				begin
					D[Q_WIDTH] <= data_i;  //被开方数据
					Q_z[Q_WIDTH] <= {1'b1,{(Q_WIDTH-1){1'b0}}}; //实验值设置，先将最高位设为1
					Q_q[Q_WIDTH] <= 0; //实际计算结果
					valid_flag[Q_WIDTH] <= 1;
				end
			else
				begin
					D[Q_WIDTH] <= 0;
					Q_z[Q_WIDTH] <= 0;
					Q_q[Q_WIDTH] <= 0;
					valid_flag[Q_WIDTH] <= 0;
				end
		end

		generate
			genvar i;
				for(i=Q_WIDTH-1;i>=1;i=i-1)
					begin
						always@(posedge clk or negedge	rst_n)
							begin
								if(!rst_n)
									begin
										D[i] <= 0;
										Q_z[i] <= 0;
										Q_q[i] <= 0;
										valid_flag[i] <= 0;
									end
								else	if(valid_flag[i+1])
									begin
										if(Q_z[i+1]*Q_z[i+1] > D[i+1])
											begin
												Q_z[i] <= {Q_q[i+1][Q_WIDTH-1:i],1'b1,{{i-1}{1'b0}}};
												Q_q[i] <= Q_q[i+1];
											end
										else
											begin
												Q_z[i] <= {Q_z[i+1][Q_WIDTH-1:i],1'b1,{{i-1}{1'b0}}};
												Q_q[i] <= Q_z[i+1];
											end
										D[i] <= D[i+1];
										valid_flag[i] <= 1;
									end
								else
									begin
										valid_flag[i] <= 0;
										D[i] <= 0;
										Q_q[i] <= 0;
										Q_z[i] <= 0;
									end
							end
					end
		endgenerate

		always@(posedge	clk or negedge	rst_n) 
			begin
				if(!rst_n)
					begin
						data_o <= 0;
						valid_out <= 0;
					end
				else	if(valid_flag[1])
					begin
						if(Q_z[1]*Q_z[1] > D[1])
							begin
								data_o <= Q_q[1];
								valid_out <= 1;
							end
						else
							begin
								data_o <= {Q_q[1][Q_WIDTH-1:1],Q_z[1][0]};
								valid_out <= 1;
							end
					end
				else
					begin
						data_o <= 0;
						valid_out <= 0;
					end
			end
endmodule
