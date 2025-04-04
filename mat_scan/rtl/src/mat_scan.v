module mat_scan (
    input clk,
    input rst_n,
    input vld_in,
    input [9:0] din,
    output reg vld_out,
    output [9:0] dout
);

    reg cs_n, w_en, r_en;
    reg [5:0] addr,cnt_input,cnt_output;
    reg output_flag;

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            output_flag <= 1'b0;
        end
        else if(cnt_input == 6'd62) begin
            output_flag <= 1'b1;
        end
        else if(cnt_output == 6'd63 & r_en) begin
            output_flag <= 1'b0;
        end
        else begin
            output_flag <= output_flag;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            vld_out <= 1'b0;
        end
        else if(r_en) begin
            vld_out <= 1'b1;
        end
        else begin
            vld_out <= 1'b0;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            cnt_input <= 6'b11_1111;
        end
        else if(vld_in) begin
            cnt_input <= cnt_input+1'b1;
        end
        else begin
            cnt_input <= cnt_input;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            cnt_output <= 6'b11_1111;
        end
        else if(output_flag) begin
            cnt_output <= cnt_output+1'b1;
        end
        else begin
            cnt_output <= cnt_output;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            w_en <= 1'b0;
            r_en <= 1'b0;
            cs_n <= 1'b1;
        end
        else if(vld_in) begin
            w_en <= 1'b1;
            r_en <= 1'b0;
            cs_n <= 1'b0;
        end
        else if(output_flag)begin
            w_en <= 1'b0;
            r_en <= 1'b1;
            cs_n <= 1'b0;
        end
        else begin 
            w_en <= 1'b0;
            r_en <= 1'b0;
            cs_n <= 1'b1;
        end
    end

    always @(posedge clk or negedge rst_n) begin
        if (rst_n == 1'b0) begin
            addr <= 6'b11_1111;
        end
        else if (vld_in) begin
            addr <= addr + 1'b1;
        end
        else if(output_flag)begin
            case (addr)
                6'b11_1111 : addr <= 6'b00_0000;
                6'b00_0000 : addr <= 6'b00_0001;
                6'b00_0001 : addr <= 6'b00_1000;
                6'b00_1000 : addr <= 6'b01_0000;
                6'b01_0000 : addr <= 6'b00_1001;
                6'b00_1001 : addr <= 6'b00_0010;
                6'b00_0010 : addr <= 6'b00_0011;
                6'b00_0011 : addr <= 6'b00_1010;
                6'b00_1010 : addr <= 6'b01_0001;
                6'b01_0001 : addr <= 6'b01_1000;
                6'b01_1000 : addr <= 6'b10_0000;
                6'b10_0000 : addr <= 6'b01_1001;
                6'b01_1001 : addr <= 6'b01_0010;
                6'b01_0010 : addr <= 6'b00_1011;
                6'b00_1011 : addr <= 6'b00_0100;
                6'b00_0100 : addr <= 6'b00_0101;
                6'b00_0101 : addr <= 6'b00_1100;
                6'b00_1100 : addr <= 6'b01_0011;
                6'b01_0011 : addr <= 6'b01_1010;
                6'b01_1010 : addr <= 6'b10_0001;
                6'b10_0001 : addr <= 6'b10_1000;
                6'b10_1000 : addr <= 6'b11_0000;
                6'b11_0000 : addr <= 6'b10_1001;
                6'b10_1001 : addr <= 6'b10_0010;
                6'b10_0010 : addr <= 6'b01_1011;
                6'b01_1011 : addr <= 6'b01_0100;
                6'b01_0100 : addr <= 6'b00_1101;
                6'b00_1101 : addr <= 6'b00_0110;
                6'b00_0110 : addr <= 6'b00_0111;
                6'b00_0111 : addr <= 6'b00_1110;
                6'b00_1110 : addr <= 6'b01_0101;
                6'b01_0101 : addr <= 6'b01_1100;
                6'b01_1100 : addr <= 6'b10_0011;
                6'b10_0011 : addr <= 6'b10_1010;
                6'b10_1010 : addr <= 6'b11_0001;
                6'b11_0001 : addr <= 6'b11_1000;
                6'b11_1000 : addr <= 6'b11_1001;
                6'b11_1001 : addr <= 6'b11_0010;
                6'b11_0010 : addr <= 6'b10_1011;
                6'b10_1011 : addr <= 6'b10_0100;
                6'b10_0100 : addr <= 6'b01_1101;
                6'b01_1101 : addr <= 6'b01_0110;
                6'b01_0110 : addr <= 6'b00_1111;
                6'b00_1111 : addr <= 6'b01_0111;
                6'b01_0111 : addr <= 6'b01_1110;
                6'b01_1110 : addr <= 6'b10_0101;
                6'b10_0101 : addr <= 6'b10_1100;
                6'b10_1100 : addr <= 6'b11_0011;
                6'b11_0011 : addr <= 6'b11_1010;
                6'b11_1010 : addr <= 6'b11_1011;
                6'b11_1011 : addr <= 6'b11_0100;
                6'b11_0100 : addr <= 6'b10_1101;
                6'b10_1101 : addr <= 6'b10_0110;
                6'b10_0110 : addr <= 6'b01_1111;
                6'b01_1111 : addr <= 6'b10_0111;
                6'b10_0111 : addr <= 6'b10_1110;
                6'b10_1110 : addr <= 6'b11_0101;
                6'b11_0101 : addr <= 6'b11_1100;
                6'b11_1100 : addr <= 6'b11_1101;
                6'b11_1101 : addr <= 6'b11_0110;
                6'b11_0110 : addr <= 6'b10_1111;
                6'b10_1111 : addr <= 6'b11_0111;
                6'b11_0111 : addr <= 6'b11_1110;
                6'b11_1110 : addr <= 6'b11_1111;
            endcase
        end
    end

    sram #(
        .ADDR_DEPTH(6),
        .DATA_WIDTH(10),
        .DATA_DEPTH(64)
    ) x_sram (
        .clk(clk),
        .rst_n(rst_n),
        .cs_n(cs_n),
        .w_en(w_en),
        .r_en(r_en),
        .addr(addr),
        .din(din),
        .dout(dout)
    );

endmodule

