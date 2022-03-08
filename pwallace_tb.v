`include "pwallace.v"
module pwallace_tb;
  
reg [7:0] a,b;
wire [15:0]out;
reg clk,reset;
  
wallace mod1(a,b,out,clk,reset);
initial
begin

$dumpfile("assi9.vcd");
$dumpvars(0,pwallace_tb);
reset=1'b1;
clk=1'b1;
a=8'b00000011;
b=8'b00110111;
#2                                 
reset=1'b0;                                  
a=8'b00000111;
b=8'b00111111;
#4
a=8'b01110111;
b=8'b01101010;
#6
a=8'b01100111;
b=8'b00111111;
#8
a=8'b11110111;
b=8'b10111100;
#10
b=8'b10000001;
#12            
a=8'b00000001;
#14           
a=8'b00001111;
b=8'b00000011;
#16            
b=8'b00001011;
#18
a=8'b00001111;
#20            
b=8'b00011111;
end          
always       
begin        
#1 clk=~clk;  
end
always
begin

#200 $finish;
end 
initial
$monitor($time,"a=%d,b=%d,out=%d",a,b,out);

endmodule