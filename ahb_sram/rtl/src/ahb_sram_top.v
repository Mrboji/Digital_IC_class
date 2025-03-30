module ahb_sram_top (input hclk,
                     input hresetn,
                     input hsel,
                     input hready,
                     input hwrite,
                     input [1:0] htrans,
                     input [2:0] hsize,
                     input [2:0] hburst,
                     input [31:0] haddr,
                     input [31:0] hwdata,
                     output [1:0] hresp,
                     output hready_resp,
                     output [31:0] hrdata);
    //--------------------------------------------------------------------------------------------------------
    //----------------------------------------------ahb_sram interface------------------------------------------
    //--------------------------------------------------------------------------------------------------------
    // sram Parameters
    parameter ADDR_DEPTH = 12;
    parameter DATA_WIDTH = 8 ;
    parameter DATA_DEPTH = 4096;
    // sram out
    wire  [7:0]  sram_q0;
    wire  [7:0]  sram_q1;
    wire  [7:0]  sram_q2;
    wire  [7:0]  sram_q3;
    // sram read or write enable signals
    wire sram_w_en;
    wire sram_r_en;
    // sram chip selection
    wire  [3:0]  ahb_sram_csn;
    // signals to sram_core in normal operation, it contains sram address and data writing into sram
    wire  [ADDR_DEPTH-1:0]  sram_addr;
    wire  [31:0]  sram_wdata;
    
    ahb_slave_if x_ahb_slave_if (
    .hclk                    (hclk),
    .hresetn                 (hresetn),
    .hsel                    (hsel),
    .hready                  (hready),
    .hwrite                  (hwrite),
    .htrans                  (htrans         [1:0]),
    .hsize                   (hsize          [2:0]),
    .hburst                  (hburst         [2:0]),
    .haddr                   (haddr          [31:0]),
    .hwdata                  (hwdata         [31:0]),
    .sram_q0                 (sram_q0        [7:0]),
    .sram_q1                 (sram_q1        [7:0]),
    .sram_q2                 (sram_q2        [7:0]),
    .sram_q3                 (sram_q3        [7:0]),
    .hresp                   (hresp          [1:0]),
    .hready_resp             (hready_resp),
    .hrdata                  (hrdata         [31:0]),
    .sram_w_en               (sram_w_en),
    .sram_r_en               (sram_r_en),
    .ahb_sram_csn            (ahb_sram_csn   [3:0]),
    .sram_addr               (sram_addr  [ADDR_DEPTH-1:0]),
    .sram_wdata              (sram_wdata     [31:0])
    );
    
    //--------------------------------------------------------------------------------------------------------
    //----------------------------------------------sram------------------------------------------
    //--------------------------------------------------------------------------------------------------------
    // sram 0
    sram #(
    .ADDR_DEPTH (ADDR_DEPTH),
    .DATA_WIDTH (DATA_WIDTH),
    .DATA_DEPTH (DATA_DEPTH))
    u_sram_0 (
    .clk                     (hclk),
    .rst_n                   (hresetn),
    .cs_n                    (ahb_sram_csn[0]),
    .w_en                    (sram_w_en),
    .r_en                    (sram_r_en),
    .addr                    (sram_addr[ADDR_DEPTH-1:0]),
    .din                     (sram_wdata[DATA_WIDTH-1:0]),
    .dout                    (sram_q0[DATA_WIDTH-1:0])
    );
    // sram 1
    sram #(
    .ADDR_DEPTH (ADDR_DEPTH),
    .DATA_WIDTH (DATA_WIDTH),
    .DATA_DEPTH (DATA_DEPTH))
    u_sram_1 (
    .clk                     (hclk),
    .rst_n                   (hresetn),
    .cs_n                    (ahb_sram_csn[1]),
    .w_en                    (sram_w_en),
    .r_en                    (sram_r_en),
    .addr                    (sram_addr[ADDR_DEPTH-1:0]),
    .din                     (sram_wdata[2*DATA_WIDTH-1:DATA_WIDTH]),
    .dout                    (sram_q1[DATA_WIDTH-1:0])
    );
    // sram 2
    sram #(
    .ADDR_DEPTH (ADDR_DEPTH),
    .DATA_WIDTH (DATA_WIDTH),
    .DATA_DEPTH (DATA_DEPTH))
    u_sram_2 (
    .clk                     (hclk),
    .rst_n                   (hresetn),
    .cs_n                    (ahb_sram_csn[2]),
    .w_en                    (sram_w_en),
    .r_en                    (sram_r_en),
    .addr                    (sram_addr[ADDR_DEPTH-1:0]),
    .din                     (sram_wdata[3*DATA_WIDTH-1:2*DATA_WIDTH]),
    .dout                    (sram_q2[DATA_WIDTH-1:0])
    );
    // sram 3
    sram #(
    .ADDR_DEPTH (ADDR_DEPTH),
    .DATA_WIDTH (DATA_WIDTH),
    .DATA_DEPTH (DATA_DEPTH))
    u_sram_3 (
    .clk                     (hclk),
    .rst_n                   (hresetn),
    .cs_n                    (ahb_sram_csn[3]),
    .w_en                    (sram_w_en),
    .r_en                    (sram_r_en),
    .addr                    (sram_addr[ADDR_DEPTH-1:0]),
    .din                     (sram_wdata[4*DATA_WIDTH-1:3*DATA_WIDTH]),
    .dout                    (sram_q3[DATA_WIDTH-1:0])
    );
endmodule
