module stop_watch (
    input clk,
    input rstn,
    input clear,
    input start_stop,
    output [3:0] hr_h,
    output [3:0] hr_l,
    output [3:0] min_h,
    output [3:0] min_l,
    output [3:0] sec_h,
    output [3:0] sec_l
);

    parameter CNT_MAX_5 = 4'd5;
    parameter CNT_MAX_9 = 4'd9;
    
    reg cnt_en;
    wire cnt_en_sec_h;
    wire cnt_en_min_l;
    wire cnt_en_min_h;
    wire cnt_en_hr_l;
    wire cnt_en_hr_h;
    wire full_sec_l;
    wire full_sec_h;
    wire full_min_l;
    wire full_min_h;
    wire full_hr_l;
    wire start_posedge, clear_posedge;

    parameter START = 1'b1;
    parameter STOP = 1'b0;
    reg current_state;
    reg next_state;

    always @(posedge clk or negedge rstn) begin
        if(rstn == 1'b0) begin
            current_state <= STOP;
        end
        else begin
            current_state <= next_state;
        end
    end

    always @(*) begin
        case(current_state)
            START: begin
                if (clear_posedge|start_posedge) begin
                    next_state = STOP;
                    cnt_en = 1'b0;
                end
            end
            STOP: begin
                if (start_posedge) begin
                    next_state = START;
                    cnt_en = 1'b1;
                end
            end
            default: next_state = STOP;
        endcase
    end

    reg [1:0] clr_detect;
    always @(posedge clk or negedge rstn)begin
	    if(~rstn)begin
	        clr_detect <= 2'b00;
	    end
	    else begin
	        clr_detect <= {clr_detect[0], clear}; 
	    end
	end
    assign clear_posedge = ~clr_detect[1] & clr_detect[0];
    reg [1:0] start_detect;
    always @(posedge clk or negedge rstn)begin
	    if(~rstn)begin
	        start_detect <= 2'b00;
	    end
	    else begin
	        start_detect <= {start_detect[0], start_stop}; 
	    end
	end
    assign start_posedge = ~start_detect[1] & start_detect[0];

    cnt #(.CNT_MAX(CNT_MAX_9)) u_cnt_0 (.clk(clk),.rstn(rstn),.clear(clear_posedge),.full(full_sec_l),.cnt_out(sec_l),.cnt_en(cnt_en));
    cnt #(.CNT_MAX(CNT_MAX_5)) u_cnt_1 (.clk(clk),.rstn(rstn),.clear(clear_posedge),.full(full_sec_h),.cnt_out(sec_h),.cnt_en(cnt_en_sec_h));
    cnt #(.CNT_MAX(CNT_MAX_9)) u_cnt_2 (.clk(clk),.rstn(rstn),.clear(clear_posedge),.full(full_min_l),.cnt_out(min_l),.cnt_en(cnt_en_min_l));
    cnt #(.CNT_MAX(CNT_MAX_5)) u_cnt_3 (.clk(clk),.rstn(rstn),.clear(clear_posedge),.full(full_min_h),.cnt_out(min_h),.cnt_en(cnt_en_min_h));
    cnt #(.CNT_MAX(CNT_MAX_9)) u_cnt_4 (.clk(clk),.rstn(rstn),.clear(clear_posedge),.full(full_hr_l),.cnt_out(hr_l),.cnt_en(cnt_en_hr_l));
    cnt #(.CNT_MAX(CNT_MAX_9)) u_cnt_5 (.clk(clk),.rstn(rstn),.clear(clear_posedge),.full(),.cnt_out(hr_h),.cnt_en(cnt_en_hr_h));
    assign cnt_en_sec_h = cnt_en & full_sec_l;
    assign cnt_en_min_l = cnt_en & full_sec_h  & full_sec_l;
    assign cnt_en_min_h = cnt_en & full_min_l & full_sec_h  & full_sec_l;
    assign cnt_en_hr_l = cnt_en & full_min_h & full_min_l & full_sec_h  & full_sec_l;
    assign cnt_en_hr_h = cnt_en & full_hr_l & full_min_h & full_min_l & full_sec_h  & full_sec_l;
endmodule

