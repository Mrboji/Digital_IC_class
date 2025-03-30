module mul_tc_16_16 (
    input [15:0] a,
    input [15:0] b,
    output [31:0] product
);

    wire [31:0] prod_0;
    wire [31:0] prod_1;
    wire [31:0] prod_2;
    wire [31:0] prod_3;
    wire [31:0] prod_4;
    wire [31:0] prod_5;
    wire [31:0] prod_6;
    wire [31:0] prod_7;
    
    partial_prod_gen u_partial_prod_gen(
        .a(a),
        .b(b),
        .prod_0(prod_0),
        .prod_1(prod_1),
        .prod_2(prod_2),
        .prod_3(prod_3),
        .prod_4(prod_4),
        .prod_5(prod_5),
        .prod_6(prod_6),
        .prod_7(prod_7)
    );

    wallace_tree u_wallace_tree(
        .prod_0(prod_0),
        .prod_1(prod_1),
        .prod_2(prod_2),
        .prod_3(prod_3),
        .prod_4(prod_4),
        .prod_5(prod_5),
        .prod_6(prod_6),
        .prod_7(prod_7),
        .product(product)
    );

endmodule

