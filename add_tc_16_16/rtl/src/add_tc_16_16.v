module add_tc_16_16 (
    input wire [15:0] a,b,
    output wire [16:0] sum
);
    wire [15:0] g = a & b;
    wire [15:0] p = a ^ b; 

    wire [16:0] c;
    wire [3:0] G;
    wire [3:0] P;
    assign c[0] = 0;
    lca_4 x_lca4_3_0(g[3:0],p[3:0],1'b0,G[0],P[0],c[3:1]);
    lca_4 x_lca4_7_4(g[7:4],p[7:4],c[4],G[1],P[1],c[7:5]);
    lca_4 x_lca4_11_8(g[11:8],p[11:8],c[8],G[2],P[2],c[11:9]);
    lca_4 x_lca4_15_12(g[15:12],p[15:12],c[12],G[3],P[3],c[15:13]);
    lca_4 x_lca4_top(G[3:0],P[3:0],1'b0, , ,{c[12],c[8],c[4]});

    wire overflow;
    wire [15:0] sum_15_0;
    wire sign;
    assign sum_15_0 = a ^ b ^ c;
    assign c[16] = g[15] | p[15]&c[15];
    assign overflow = (sum_15_0[15] & ~a[15] & ~b[15]) | (~sum_15_0[15] & a[15] & b[15]);
    assign sign = (overflow & c[16]) | (~overflow & sum_15_0[15]);
    assign sum = {sign,sum_15_0};
endmodule

module lca_4(
	input [3:0] g,p,
    input ci,
 	output G,P,
	output [2:0] co
);
    assign co[0] = g[0] | (p[0] & ci);
    assign co[1] = g[1] | p[1]&g[0] | (p[1]&p[0] & ci);
    assign co[2] = g[2] | p[2]&g[1] | p[2]&p[1]&g[0] | (p[2]&p[1]&p[0] & ci);
    assign G = g[3] | p[3]&g[2] | p[3]&p[2]&g[1] | p[3]&p[2]&p[1]&g[0];
    assign P = p[3]&p[2]&p[1]&p[0];
endmodule

