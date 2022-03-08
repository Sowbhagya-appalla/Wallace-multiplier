`include "wallace2.v"
module wallace_tb;
  
reg [7:0] a,b;
wire [15:0]out;
  
wallace mod1(a,b,out);
initial
begin

$dumpfile("assi7.vcd");
$dumpvars(0,wallace_tb);
                                  
                                  
a=8'b01010111;
b=8'b00111111;

#2
a=8'b11010111;
b=8'b11101010;

#4
a=8'b11100111;
b=8'b10000111;
#6
a=8'b01110111;
b=8'b00111100;
 
end
always
begin

#20 $finish;
end 
initial
$monitor($time,"a=%d,b=%d,out=%d",a,b,out);

endmodule