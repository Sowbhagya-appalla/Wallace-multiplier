//Full adder
module full_adder(a,b,c,sum,carry);
input a,b,c;
output sum,carry;
assign sum=a^b^c;
assign carry = ((a&b)| (b&c)|(c&a));
endmodule 
  
//Half adder
module half_adder(a,b,sum,carry);
input a,b;
output sum,carry;
assign sum=a^b;
assign carry = (a&b);
endmodule

//Wallace multiplier
module wallace(a,b,out);
input [7:0] a,b; 
output [15:0] out; 

wire [7:0] p0,p1,p2,p3,p4,p5,p6,p7;
//Partial Products
assign  p0 ={a[0]&b[7],a[0]&b[6],a[0]&b[5],a[0]&b[4],a[0]&b[3],a[0]&b[2],a[0]&b[1],a[0]&b[0]};
assign  p1 ={a[1]&b[7],a[1]&b[6],a[1]&b[5],a[1]&b[4],a[1]&b[3],a[1]&b[2],a[1]&b[1],a[1]&b[0]};
assign  p2 ={a[2]&b[7],a[2]&b[6],a[2]&b[5],a[2]&b[4],a[2]&b[3],a[2]&b[2],a[2]&b[1],a[2]&b[0]};
assign  p3 ={a[3]&b[7],a[3]&b[6],a[3]&b[5],a[3]&b[4],a[3]&b[3],a[3]&b[2],a[3]&b[1],a[3]&b[0]};
assign  p4 ={a[4]&b[7],a[4]&b[6],a[4]&b[5],a[4]&b[4],a[4]&b[3],a[4]&b[2],a[4]&b[1],a[4]&b[0]};
assign  p5 ={a[5]&b[7],a[5]&b[6],a[5]&b[5],a[5]&b[4],a[5]&b[3],a[5]&b[2],a[5]&b[1],a[5]&b[0]};
assign  p6 ={a[6]&b[7],a[6]&b[6],a[6]&b[5],a[6]&b[4],a[6]&b[3],a[6]&b[2],a[6]&b[1],a[6]&b[0]};
assign  p7 ={a[7]&b[7],a[7]&b[6],a[7]&b[5],a[7]&b[4],a[7]&b[3],a[7]&b[2],a[7]&b[1],a[7]&b[0]};
                                                            
wire [15:0]pp0,pp1,pp2,pp3,pp4,pp5,pp6,pp7;

assign pp0 = {8'b0,p0};
assign pp1 = {7'b0,p1,1'b0};
assign pp2 = {6'b0,p2,2'b0};
assign pp3 = {5'b0,p3,3'b0};
assign pp4 = {4'b0,p4,4'b0};
assign pp5 = {3'b0,p5,5'b0};
assign pp6 = {2'b0,p6,6'b0};
assign pp7 = {1'b0,p7,7'b0};
            
//---------------------------Level 1------------------------------------
//--------------------First Carry Save Adder-----------------------------
//pp0[0]                                            
half_adder mod01(pp0[1],pp1[1],s0,c0);              
full_adder mod02(pp0[2],pp1[2],pp2[2],s1,c1);       
full_adder mod03(pp0[3],pp1[3],pp2[3],s2,c2);       
full_adder mod04(pp0[4],pp1[4],pp2[4],s3,c3);       
full_adder mod05(pp0[5],pp1[5],pp2[5],s4,c4);       
full_adder mod06(pp0[6],pp1[6],pp2[6],s5,c5);       
full_adder mod07(pp0[7],pp1[7],pp2[7],s6,c6);       
half_adder mod08(       pp1[8],pp2[8],s7,c7);              
//pp2[9] 
//-------------------Second Carry Save Adder--------------------------------
//pp3[3]
half_adder mod10(pp3[4],pp4[4],s00,c00);
full_adder mod11(pp3[5],pp4[5],pp5[5],s11,c11);
full_adder mod12(pp3[6],pp4[6],pp5[6],s22,c22);
full_adder mod13(pp3[7],pp4[7],pp5[7],s33,c33);
full_adder mod14(pp3[8],pp4[8],pp5[8],s44,c44);
full_adder mod15(pp3[9],pp4[9],pp5[9],s55,c55);
full_adder mod16(pp3[10],pp4[10],pp5[10],s66,c66);
half_adder mod17(        pp4[11],pp5[11],s77,c77);
//pp5[12]
//----------------------------Level 2---------------------------------------
//---------------------Third Carry Save Adder-------------------------------   
//pp0[0]
//s0
half_adder mod18(s1,c0,s111,c111);
full_adder mod19(s2,c1,pp3[3],s222,c222);
full_adder mod20(s3,c2,s00,s333,c333);
full_adder mod21(s4,c3,s11,s444,c444);
full_adder mod22(s5,c4,s22,s555,c555);
full_adder mod23(s6,c5,s33,s666,c666);
full_adder mod24(s7,c6,s44,s777,c777);
full_adder mod25(pp2[9],c7,s55,s888,c888);
//s66
//s77  
//pp5[12]
//--------------------Fourth Carry Save Adder-------------------------------
//pp6[6]
half_adder mod26(pp6[6],c11,s1111,c1111);
full_adder mod27(pp6[7],pp7[7],c22,s2222,c2222);
full_adder mod28(pp6[8],pp7[8],c33,s3333,c3333);
full_adder mod29(pp6[9],pp7[9],c44,s4444,c4444);
full_adder mod30(pp6[10],pp7[10],c55,s5555,c5555);
full_adder mod31(pp6[11],pp7[11],c66,s6666,c6666);
full_adder mod32(pp6[12],pp7[12],c77,s7777,c7777);
half_adder mod33(pp6[13],pp7[13],s8888,c8888);
//pp7[14]
//------------------------------Level 3-------------------------------------
//----------------------Fifth Carry Save Adder------------------------------
//pp0[0]
//s0
//s111
half_adder mod34(s222,c111,s11111,c11111);
half_adder mod35(s333,c222,s22222,c22222);
half_adder mod36(s444,c333,s33333,c33333);
full_adder mod37(s555,c444,s1111,s44444,c44444);
full_adder mod38(s666,c555,s2222,s55555,c55555);
full_adder mod39(s777,c666,s3333,s66666,c66666);
full_adder mod40(s888,c777,s4444,s77777,c77777);
full_adder mod41(s66,c888,s5555,s88888,c88888);
half_adder mod42(s77,s6666,s99999,c99999);
half_adder mod43(pp5[12],s7777,ss11111,cc11111);
//s8888
//pp7[14]
//------------------------------Level 4-------------------------------------
//-----------------------Sixth Carry Save Adder-----------------------------
//pp0[0]
//s0
//s111
//s11111
half_adder mod44(s22222,c11111,s111111,c111111);
half_adder mod45(s33333,c22222,s222222,c222222);
half_adder mod46(s44444,c33333,s333333,c333333);
full_adder mod47(s55555,c44444,c1111,s444444,c444444);
full_adder mod48(s66666,c55555,c2222,s555555,c555555);
full_adder mod49(s77777,c66666,c3333,s666666,c666666);
full_adder mod50(s88888,c77777,c4444,s777777,c777777);
full_adder mod51(s99999,c88888,c5555,s888888,c888888);
full_adder mod52(ss11111,c99999,c6666,s999999,c999999);
full_adder mod53(s8888,cc11111,c7777,ss111111,cc111111);
half_adder mod54(pp7[14],c8888,ss222222,cc222222);
//----------------------------Level 5---------------------------------------
//---------------------Carry Lookahead Adder--------------------------------
//pp0[0]
//s0
//s111
//s11111
//s111111
half_adder mod55(s222222,c111111,ss0,cc0);
full_adder mod56(s333333,c222222,cc0,ss1,cc1);
full_adder mod57(s444444,c333333,cc1,ss2,cc2);
full_adder mod58(s555555,c444444,cc2,ss3,cc3);
full_adder mod59(s666666,c555555,cc3,ss4,cc4);
full_adder mod60(s777777,c666666,cc4,ss5,cc5);
full_adder mod61(s888888,c777777,cc5,ss6,cc6);
full_adder mod62(s999999,c888888,cc6,ss7,cc7);
full_adder mod63(ss111111,c999999,cc7,ss8,cc8);
full_adder mod64(ss222222,cc111111,cc8,ss9,cc9);
half_adder mod65(cc9,cc222222,ss10,cc10);

assign out = {ss10,ss9,ss8,ss7,ss6,ss5,ss4,ss3,ss2,ss1,ss0,s111111,s11111,s111,s0,pp0[0]};



endmodule





