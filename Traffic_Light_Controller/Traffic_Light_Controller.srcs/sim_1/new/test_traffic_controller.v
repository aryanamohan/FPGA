`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07.02.2026 23:05:03
// Design Name: 
// Module Name: test_traffic_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module test_traffic_controller();
reg t_clk=0, t_rst_n;
wire [2:0]t_ledN;
wire[2:0]t_ledS;
wire[2:0]t_ledW;
wire[2:0]t_ledE;

traffic_light #(.threshold(10)) dut(.clk(t_clk), .rst_n(t_rst_n), .ledN(t_ledN), .ledS(t_ledS), .ledW(t_ledW), .ledE(t_ledE));

always#5 t_clk=~t_clk;
initial
begin
t_rst_n=0;
#20;
t_rst_n=1;
#5000;
$stop;
end
endmodule
