module ahb_slave_if(input hclk,
                    input hresetn,
                    input hsel,
                    input hready,
                    input hwrite,
                    input [1:0] htrans,
                    input [2:0] hsize,
                    input [2:0] hburst,
                    input [31:0] haddr,
                    input [31:0] hwdata,
                    input [7:0] sram_q0,
                    input [7:0] sram_q1,
                    input [7:0] sram_q2,
                    input [7:0] sram_q3,
                    output [1:0] hresp,
                    output hready_resp,
                    output [31:0] hrdata,
                    output sram_w_en,
                    output sram_r_en,
                    output [3:0] ahb_sram_csn,
                    output [9:0] sram_addr,
                    output [31:0] sram_wdata);
    // sram parameters
    parameter ADDR_DEPTH = 10;
    // internal registers used for temp the input ahb signals
    // temperate all the AHB input signals
    reg         hwrite_r;
    reg  [2:0]  hsize_r; 
    reg  [2:0]  hburst_r;
    reg  [1:0]  htrans_r;
    reg  [31:0] haddr_r; 
    reg  [3:0]  sram_csn;

    wire  [1:0]  haddr_sel;
    wire  [1:0]  hsize_sel;
    
    wire sram_csn_en;  
    wire sram_write;
    wire sram_read; 
    
    // transfer type signal encoding
    parameter   IDLE = 2'b00,
                BUSY = 2'b01,
                NONSEQ = 2'b10,
                SEQ = 2'b11;
    
    
    //--------------------------------------------------------------------------------------------------------
    //----------------------------------------------Main code------------------------------------------
    //--------------------------------------------------------------------------------------------------------
    // Combitional portion
    // assign the response and read data of the AHB slave
    // To implement sram writing or reading in one cycle, value of hready_resp is always "1"
    assign  hready_resp = 1'b1;    //hready_resp always 1
    assign  hresp       = 2'b00;   //always OKAY，not support ERROR、RETRY、SPLIT
    
    // sram data output to AHB bus
    assign  hrdata = {sram_q3,sram_q2,sram_q1,sram_q0};
    
    // Generate sram address
    assign  sram_addr = haddr_r[ADDR_DEPTH+1:2];
    
    // data from AHB writing into sram.
    assign  sram_wdata = hwdata;
    
    // Generate sram write and read enable signals
    assign  sram_write = ((htrans_r == NONSEQ) || (htrans_r == SEQ)) && hwrite_r;
    assign  sram_read  = ((htrans_r == NONSEQ) || (htrans_r == SEQ)) && (! hwrite_r);
    assign  sram_w_en  = sram_write;
    assign  sram_r_en  = sram_read;
    // Generate the sram chip selecting signals in one bank.
    // results show the AHB bus write or read how many data once a time:byte(8),halfword(16) or word(32).
    assign  haddr_sel   = haddr_r[1:0];
    assign  hsize_sel   = hsize_r[1:0];
    assign  sram_csn_en = (sram_write || sram_read);
    always@(hsize_sel or haddr_sel) begin
        if (hsize_sel == 2'b10)            //32bits:word operation
            sram_csn = 4'b0;
        else if (hsize_sel == 2'b01)       //16bits:halfword
        begin
            if (haddr_sel[1] == 1'b0)      //low halfword
                sram_csn = 4'b1100;
            else                          //high halfword
                sram_csn = 4'b0011;
        end
            else if (hsize_sel == 2'b00)       //8bits:byte
            begin
            case(haddr_sel)
                2'b00:sram_csn   = 4'b1110;
                2'b01:sram_csn   = 4'b1101;
                2'b10:sram_csn   = 4'b1011;
                2'b11:sram_csn   = 4'b0111;
                default:sram_csn = 4'b1111;
            endcase
            end
        else
            sram_csn = 4'b1111;
    end
    assign ahb_sram_csn = (sram_csn_en == 1) ? sram_csn : 4'b1111;
    // Sequential portion
    // tmp the ahb address and control signals
    always@(posedge hclk or negedge hresetn) begin
        if (!hresetn)
        begin
            hwrite_r <= 1'b0;
            hsize_r  <= 3'b0;
            hburst_r <= 3'b0;
            htrans_r <= 2'b0;
            haddr_r  <= 32'b0;
        end
        else if (hsel && hready)
        begin
            hwrite_r <= hwrite;
            hsize_r  <= hsize;
            hburst_r <= hburst;
            htrans_r <= htrans;
            haddr_r  <= haddr;
        end
        else
        begin
            hwrite_r <= 1'b0;
            hsize_r  <= 3'b0;
            hburst_r <= 3'b0;
            htrans_r <= 2'b0;
            haddr_r  <= 32'b0;
        end
    end
    
endmodule
    
    
