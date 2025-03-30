module wallace_tree (
    input [31:0] prod_0,
    input [31:0] prod_1,
    input [31:0] prod_2,
    input [31:0] prod_3,
    input [31:0] prod_4,
    input [31:0] prod_5,
    input [31:0] prod_6,
    input [31:0] prod_7,
    output [31:0] product
);
    wire [31:0] csa_0_c;
    wire [31:0] csa_0_s;
    wire [31:0] csa_1_c;
    wire [31:0] csa_1_s;    
    wire [31:0] csa_2_c;
    wire [31:0] csa_2_s;
    wire [31:0] csa_3_c;
    wire [31:0] csa_3_s;
    wire [31:0] csa_4_c;
    wire [31:0] csa_4_s;
    wire [31:0] csa_5_c;
    wire [31:0] csa_5_s;

    csa #(.DATA_WIDTH(32)) u_csa_0(.a(prod_0),.b(prod_1<<2),.cin(prod_2<<4),.cout(csa_0_c),.s(csa_0_s));
    csa #(.DATA_WIDTH(32)) u_csa_1(.a(prod_3<<6),.b(prod_4<<8),.cin(prod_5<<10),.cout(csa_1_c),.s(csa_1_s));
    csa #(.DATA_WIDTH(32)) u_csa_2(.a(csa_1_c<<1),.b(prod_6<<12),.cin(prod_7<<14),.cout(csa_2_c),.s(csa_2_s));
    csa #(.DATA_WIDTH(32)) u_csa_3(.a(csa_0_c<<1),.b(csa_0_s),.cin(csa_1_s),.cout(csa_3_c),.s(csa_3_s));
    csa #(.DATA_WIDTH(32)) u_csa_4(.a(csa_2_s),.b(csa_3_s),.cin(csa_3_c<<1),.cout(csa_4_c),.s(csa_4_s));
    csa #(.DATA_WIDTH(32)) u_csa_5(.a(csa_2_c<<1),.b(csa_4_s),.cin(csa_4_c<<1),.cout(csa_5_c),.s(csa_5_s));

    assign product = (csa_5_c<<1) + csa_5_s;
endmodule


module csa#(parameter DATA_WIDTH = 32) (
    input [DATA_WIDTH-1:0] a,
    input [DATA_WIDTH-1:0] b,
    input [DATA_WIDTH-1:0] cin,
    output [DATA_WIDTH-1:0] cout,
    output [DATA_WIDTH-1:0] s
);
    generate
        genvar index;
        for (index = 0; index < DATA_WIDTH ; index = index + 1'b1) begin
            assign s[index] = a[index] ^ b[index] ^ cin[index];
            assign cout[index] = a[index]&b[index] | a[index]&cin[index] | b[index]&cin[index];
        end
    endgenerate
endmodule