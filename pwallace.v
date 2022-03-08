//flipflop
module dflipflop1(d,q,clk,reset);
input d;
input clk,reset;
output reg q;
always@(posedge clk)
begin
if(reset==1'b1)
	q<=1'b0;
else
	q<=d;
end
endmodule
module dflipflop16(d,q,clk,reset);
input [15:0]d;
input clk,reset;
output reg [15:0]q;
always@(posedge clk)
begin
if(reset==1'b1)
	q<=16'b0;
else
	q<=d;
end
endmodule 
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
//Wallace multiplier with pipeline
module wallace(a,b,out,clk,reset);
input [7:0] a,b; 
output [15:0] out; 
input clk,reset;
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
wire [15:0]qpp0,qpp1,qpp2,qpp3,qpp4,qpp5,qpp6,qpp7;
dflipflop16 mod0001(pp0,qpp0,clk,reset); 
dflipflop16 mod0002(pp1,qpp1,clk,reset);
dflipflop16 mod0003(pp2,qpp2,clk,reset);
dflipflop16 mod0004(pp3,qpp3,clk,reset);
dflipflop16 mod0005(pp4,qpp4,clk,reset);
dflipflop16 mod0006(pp5,qpp5,clk,reset);
dflipflop16 mod0007(pp6,qpp6,clk,reset);
dflipflop16 mod0008(pp7,qpp7,clk,reset); 
//---------------------------Level 1-------------------------------------
//--------------------First Carry Save Adder-----------------------------
//qpp0[0]                                            
half_adder mod01(qpp0[1],qpp1[1],s0,c0);              
full_adder mod02(qpp0[2],qpp1[2],qpp2[2],s1,c1);       
full_adder mod03(qpp0[3],qpp1[3],qpp2[3],s2,c2);       
full_adder mod04(qpp0[4],qpp1[4],qpp2[4],s3,c3);       
full_adder mod05(qpp0[5],qpp1[5],qpp2[5],s4,c4);       
full_adder mod06(qpp0[6],qpp1[6],qpp2[6],s5,c5);       
full_adder mod07(qpp0[7],qpp1[7],qpp2[7],s6,c6);       
half_adder mod08(qpp1[8],qpp2[8],s7,c7);              
//qpp2[9] 
//-------------------Second Carry Save Adder------------------------------
//qpp3[3]
half_adder mod10(qpp3[4],qpp4[4],s00,c00);
full_adder mod11(qpp3[5],qpp4[5],qpp5[5],s11,c11);
full_adder mod12(qpp3[6],qpp4[6],qpp5[6],s22,c22);
full_adder mod13(qpp3[7],qpp4[7],qpp5[7],s33,c33);
full_adder mod14(qpp3[8],qpp4[8],qpp5[8],s44,c44);
full_adder mod15(qpp3[9],qpp4[9],qpp5[9],s55,c55);
full_adder mod16(qpp3[10],qpp4[10],qpp5[10],s66,c66);
half_adder mod17(qpp4[11],qpp5[11],s77,c77);
//qpp5[12]
dflipflop1 mod127(s0,qs0,clk,reset);
dflipflop1 mod001(s1,qs1,clk,reset);
dflipflop1 mod002(s2,qs2,clk,reset);
dflipflop1 mod003(s3,qs3,clk,reset);
dflipflop1 mod004(s4,qs4,clk,reset);
dflipflop1 mod005(s5,qs5,clk,reset);
dflipflop1 mod006(s6,qs6,clk,reset);
dflipflop1 mod007(s7,qs7,clk,reset);
dflipflop1 mod008(s00,qs00,clk,reset);
dflipflop1 mod009(s11,qs11,clk,reset);
dflipflop1 mod010(s22,qs22,clk,reset);
dflipflop1 mod011(s33,qs33,clk,reset);
dflipflop1 mod012(s44,qs44,clk,reset);
dflipflop1 mod013(s55,qs55,clk,reset);
dflipflop1 mod014(s66,qs66,clk,reset);
dflipflop1 mod015(s77,qs77,clk,reset);

dflipflop1 mod128(c0,qc0,clk,reset);
dflipflop1 mod016(c1,qc1,clk,reset);    
dflipflop1 mod017(c2,qc2,clk,reset);    
dflipflop1 mod018(c3,qc3,clk,reset);    
dflipflop1 mod019(c4,qc4,clk,reset);    
dflipflop1 mod020(c5,qc5,clk,reset);    
dflipflop1 mod021(c6,qc6,clk,reset);    
dflipflop1 mod022(c7,qc7,clk,reset);    
dflipflop1 mod023(c00,qc00,clk,reset);  
dflipflop1 mod024(c11,qc11,clk,reset);  
dflipflop1 mod025(c22,qc22,clk,reset);  
dflipflop1 mod026(c33,qc33,clk,reset);  
dflipflop1 mod027(c44,qc44,clk,reset);  
dflipflop1 mod028(c55,qc55,clk,reset);  
dflipflop1 mod029(c66,qc66,clk,reset);  
dflipflop1 mod030(c77,qc77,clk,reset); 

dflipflop1 mod129(qpp0[0],qppp0,clk,reset); 
                                       
//----------------------------Level 2-------------------------------------
//---------------------Third Carry Save Adder-----------------------------   
//qppp0
//qs0
half_adder mod18(qs1,qc0,s111,c111);
full_adder mod19(qs2,qc1,qpp3[3],s222,c222);
full_adder mod20(qs3,qc2,qs00,s333,c333);
full_adder mod21(qs4,qc3,qs11,s444,c444);
full_adder mod22(qs5,qc4,qs22,s555,c555);
full_adder mod23(qs6,qc5,qs33,s666,c666);
full_adder mod24(qs7,qc6,qs44,s777,c777);
full_adder mod25(qpp2[9],qc7,qs55,s888,c888);
//qs66
//qs77  
//qpp5[12]
//--------------------Fourth Carry Save Adder-------------------------------
//qpp6[6]
half_adder mod26(qpp6[6],qc11,s1111,c1111);
full_adder mod27(qpp6[7],qpp7[7],qc22,s2222,c2222);
full_adder mod28(qpp6[8],qpp7[8],qc33,s3333,c3333);
full_adder mod29(qpp6[9],qpp7[9],qc44,s4444,c4444);
full_adder mod30(qpp6[10],qpp7[10],qc55,s5555,c5555);
full_adder mod31(qpp6[11],qpp7[11],qc66,s6666,c6666);
full_adder mod32(qpp6[12],qpp7[12],qc77,s7777,c7777);
half_adder mod33(qpp6[13],qpp7[13],s8888,c8888);
//qpp7[14]
dflipflop1 mod031(s111,qs111,clk,reset);    
dflipflop1 mod032(s222,qs222,clk,reset);    
dflipflop1 mod033(s333,qs333,clk,reset);    
dflipflop1 mod034(s444,qs444,clk,reset);    
dflipflop1 mod035(s555,qs555,clk,reset);    
dflipflop1 mod036(s666,qs666,clk,reset);    
dflipflop1 mod037(s777,qs777,clk,reset);    
dflipflop1 mod038(s888,qs888,clk,reset);  
dflipflop1 mod039(s1111,qs1111,clk,reset);  
dflipflop1 mod040(s2222,qs2222,clk,reset);  
dflipflop1 mod041(s3333,qs3333,clk,reset);  
dflipflop1 mod042(s4444,qs4444,clk,reset);  
dflipflop1 mod043(s5555,qs5555,clk,reset);  
dflipflop1 mod044(s6666,qs6666,clk,reset);  
dflipflop1 mod045(s7777,qs7777,clk,reset); 
dflipflop1 mod046(s8888,qs8888,clk,reset); 
                                     
dflipflop1 mod047(c111,qc111,clk,reset);    
dflipflop1 mod048(c222,qc222,clk,reset);    
dflipflop1 mod049(c333,qc333,clk,reset);    
dflipflop1 mod050(c444,qc444,clk,reset);    
dflipflop1 mod051(c555,qc555,clk,reset);    
dflipflop1 mod052(c666,qc666,clk,reset);    
dflipflop1 mod053(c777,qc777,clk,reset);    
dflipflop1 mod054(c888,qc888,clk,reset);  
dflipflop1 mod055(c1111,qc1111,clk,reset);  
dflipflop1 mod056(c2222,qc2222,clk,reset);  
dflipflop1 mod057(c3333,qc3333,clk,reset);  
dflipflop1 mod058(c4444,qc4444,clk,reset);  
dflipflop1 mod059(c5555,qc5555,clk,reset);  
dflipflop1 mod060(c6666,qc6666,clk,reset);  
dflipflop1 mod061(c7777,qc7777,clk,reset); 
dflipflop1 mod062(c8888,qc8888,clk,reset);

dflipflop1 mod130(qppp0,qpppp0,clk,reset);
dflipflop1 mod131(qs0,qqs0,clk,reset);  
                                       
//------------------------------Level 3-------------------------------------
//----------------------Fifth Carry Save Adder------------------------------
//qpppp0
//qqs0
//qs111
half_adder mod34(qs222,qc111,s11111,c11111);
half_adder mod35(qs333,qc222,s22222,c22222);
half_adder mod36(qs444,qc333,s33333,c33333);
full_adder mod37(qs555,qc444,qs1111,s44444,c44444);
full_adder mod38(qs666,qc555,qs2222,s55555,c55555);
full_adder mod39(qs777,qc666,qs3333,s66666,c66666);
full_adder mod40(qs888,qc777,qs4444,s77777,c77777);
full_adder mod41(qs66,qc888,qs5555,s88888,c88888);
half_adder mod42(qs77,qs6666,s99999,c99999);
half_adder mod43(qpp5[12],qs7777,ss11111,cc11111);
//qs8888
//qpp7[14] 
dflipflop1 mod063(s11111,qs11111,clk,reset);    
dflipflop1 mod064(s22222,qs22222,clk,reset);    
dflipflop1 mod065(s33333,qs33333,clk,reset);    
dflipflop1 mod066(s44444,qs44444,clk,reset);    
dflipflop1 mod067(s55555,qs55555,clk,reset);    
dflipflop1 mod068(s66666,qs66666,clk,reset);    
dflipflop1 mod069(s77777,qs77777,clk,reset);    
dflipflop1 mod070(s88888,qs88888,clk,reset);  
dflipflop1 mod071(s99999,qs99999,clk,reset);  
dflipflop1 mod072(ss11111,qss11111,clk,reset); 

dflipflop1 mod073(c11111,qc11111,clk,reset);    
dflipflop1 mod074(c22222,qc22222,clk,reset);    
dflipflop1 mod075(c33333,qc33333,clk,reset);    
dflipflop1 mod076(c44444,qc44444,clk,reset);    
dflipflop1 mod077(c55555,qc55555,clk,reset);    
dflipflop1 mod078(c66666,qc66666,clk,reset);    
dflipflop1 mod079(c77777,qc77777,clk,reset);    
dflipflop1 mod080(c88888,qc88888,clk,reset);  
dflipflop1 mod081(c99999,qc99999,clk,reset);  
dflipflop1 mod082(cc11111,qcc11111,clk,reset);      

dflipflop1 mod132(qpppp0,qppppp0,clk,reset);
dflipflop1 mod133(qqs0,qqqs0,clk,reset);
dflipflop1 mod134(qs111,qqs111,clk,reset);
//------------------------------Level 4-------------------------------------
//-----------------------Sixth Carry Save Adder-----------------------------
//qppppp0
//qqqs0
//qqs111
//qs11111
half_adder mod44(qs22222,qc11111,s111111,c111111);
half_adder mod45(qs33333,qc22222,s222222,c222222);
half_adder mod46(qs44444,qc33333,s333333,c333333);
full_adder mod47(qs55555,qc44444,qc1111,s444444,c444444);
full_adder mod48(qs66666,qc55555,qc2222,s555555,c555555);
full_adder mod49(qs77777,qc66666,qc3333,s666666,c666666);
full_adder mod50(qs88888,qc77777,qc4444,s777777,c777777);
full_adder mod51(qs99999,qc88888,qc5555,s888888,c888888);
full_adder mod52(qss11111,qc99999,qc6666,s999999,c999999);
full_adder mod53(qs8888,qcc11111,qc7777,ss111111,cc111111);
half_adder mod54(qpp7[14],qc8888,ss222222,cc222222);

dflipflop1 mod083(s111111,qs111111,clk,reset);   
dflipflop1 mod084(s222222,qs222222,clk,reset);   
dflipflop1 mod085(s333333,qs333333,clk,reset);   
dflipflop1 mod086(s444444,qs444444,clk,reset);   
dflipflop1 mod087(s555555,qs555555,clk,reset);   
dflipflop1 mod088(s666666,qs666666,clk,reset);   
dflipflop1 mod089(s777777,qs777777,clk,reset);   
dflipflop1 mod090(s888888,qs888888,clk,reset);   
dflipflop1 mod091(s999999,qs999999,clk,reset);   
dflipflop1 mod092(ss111111,qss111111,clk,reset); 
dflipflop1 mod093(ss222222,qss222222,clk,reset);    
              
dflipflop1 mod094(c111111,qc111111,clk,reset);   
dflipflop1 mod095(c222222,qc222222,clk,reset);   
dflipflop1 mod096(c333333,qc333333,clk,reset);   
dflipflop1 mod097(c444444,qc444444,clk,reset);   
dflipflop1 mod098(c555555,qc555555,clk,reset);   
dflipflop1 mod099(c666666,qc666666,clk,reset);   
dflipflop1 mod100(c777777,qc777777,clk,reset);   
dflipflop1 mod101(c888888,qc888888,clk,reset);   
dflipflop1 mod102(c999999,qc999999,clk,reset);   
dflipflop1 mod103(cc111111,qcc111111,clk,reset); 
dflipflop1 mod104(cc222222,qcc222222,clk,reset);
 
dflipflop1 mod135(qppppp0,qpppppp0,clk,reset);
dflipflop1 mod136(qs11111,qqs11111,clk,reset);
dflipflop1 mod137(qqqs0,qqqqs0,clk,reset); 
dflipflop1 mod138(qqs111,qqqs111,clk,reset);                                             


//----------------------------Level 5---------------------------------------
//---------------------Carry Lookahead Adder--------------------------------
//qpppppp0
//qqqqs0
//qqqs111
//qqs11111
//qs111111
half_adder mod55(qs222222,qc111111,ss0,cc0);
full_adder mod56(qs333333,qc222222,cc0,ss1,cc1);
full_adder mod57(qs444444,qc333333,cc1,ss2,cc2);
full_adder mod58(qs555555,qc444444,cc2,ss3,cc3);
full_adder mod59(qs666666,qc555555,cc3,ss4,cc4);
full_adder mod60(qs777777,qc666666,cc4,ss5,cc5);
full_adder mod61(qs888888,qc777777,cc5,ss6,cc6);
full_adder mod62(qs999999,qc888888,cc6,ss7,cc7);
full_adder mod63(qss111111,qc999999,cc7,ss8,cc8);
full_adder mod64(qss222222,qcc111111,cc8,ss9,cc9);
half_adder mod65(cc9,qcc222222,ss10,cc10);    

assign out = {ss10,ss9,ss8,ss7,ss6,ss5,ss4,ss3,ss2,ss1,ss0,qs111111,qqs11111,qqqs111,qqqqs0,qpppppp0};
endmodule




