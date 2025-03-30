module partial_prod_gen (
    input [15:0] a,
    input [15:0] b,
    output [31:0] prod_0,
    output [31:0] prod_1,
    output [31:0] prod_2,
    output [31:0] prod_3,
    output [31:0] prod_4,
    output [31:0] prod_5,
    output [31:0] prod_6,
    output [31:0] prod_7
);
    wire [7:0] neg;
    wire [7:0] zero;
    wire [7:0] one;
    wire [7:0] two;

    booth_enc u_booth_enc_0(.code({b[1:0],1'b0}),.neg(neg[0]),.zero(zero[0]),.one(one[0]),.two(two[0]));
    booth_enc u_booth_enc_1(.code(b[3:1]),.neg(neg[1]),.zero(zero[1]),.one(one[1]),.two(two[1]));
    booth_enc u_booth_enc_2(.code(b[5:3]),.neg(neg[2]),.zero(zero[2]),.one(one[2]),.two(two[2]));
    booth_enc u_booth_enc_3(.code(b[7:5]),.neg(neg[3]),.zero(zero[3]),.one(one[3]),.two(two[3]));
    booth_enc u_booth_enc_4(.code(b[9:7]),.neg(neg[4]),.zero(zero[4]),.one(one[4]),.two(two[4]));
    booth_enc u_booth_enc_5(.code(b[11:9]),.neg(neg[5]),.zero(zero[5]),.one(one[5]),.two(two[5]));
    booth_enc u_booth_enc_6(.code(b[13:11]),.neg(neg[6]),.zero(zero[6]),.one(one[6]),.two(two[6]));
    booth_enc u_booth_enc_7(.code(b[15:13]),.neg(neg[7]),.zero(zero[7]),.one(one[7]),.two(two[7]));

    gen_prod gen_prod_0(.a(a),.neg(neg[0]),.zero(zero[0]),.one(one[0]),.two(two[0]),.prod(prod_0));
    gen_prod gen_prod_1(.a(a),.neg(neg[1]),.zero(zero[1]),.one(one[1]),.two(two[1]),.prod(prod_1));
    gen_prod gen_prod_2(.a(a),.neg(neg[2]),.zero(zero[2]),.one(one[2]),.two(two[2]),.prod(prod_2));
    gen_prod gen_prod_3(.a(a),.neg(neg[3]),.zero(zero[3]),.one(one[3]),.two(two[3]),.prod(prod_3));
    gen_prod gen_prod_4(.a(a),.neg(neg[4]),.zero(zero[4]),.one(one[4]),.two(two[4]),.prod(prod_4));
    gen_prod gen_prod_5(.a(a),.neg(neg[5]),.zero(zero[5]),.one(one[5]),.two(two[5]),.prod(prod_5));
    gen_prod gen_prod_6(.a(a),.neg(neg[6]),.zero(zero[6]),.one(one[6]),.two(two[6]),.prod(prod_6));
    gen_prod gen_prod_7(.a(a),.neg(neg[7]),.zero(zero[7]),.one(one[7]),.two(two[7]),.prod(prod_7));
endmodule




module booth_enc (
    input [2:0] code,
    output neg,
    output zero,
    output one,
    output two
);

    assign neg = code[2];
    assign zero = (code == 3'b000) || (code == 3'b111);
    assign two = (code == 3'b100) || (code == 3'b011);
    assign one = !zero & !two;

endmodule

module gen_prod (
    input [15:0] a,
    input neg,
    input zero,
    input one,
    input two,
    output [31:0] prod
);

    reg [31:0] prod_pre;
    always @(*) begin
        prod_pre = 32'b0;
        if(zero) prod_pre = 32'b0;
        else if(one) prod_pre = {{16{a[15]}},a};
        else if(two) prod_pre = {{15{a[15]}},a,1'b0};
    end
    assign prod = neg ? (~prod_pre + 1'b1) : prod_pre;

endmodule



