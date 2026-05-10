`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 28.01.2026 22:05:40
// Design Name: 
// Module Name: traffic_light
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


module traffic_light(
    input clk,rst_n,
    output reg [2:0]ledN,
    output reg [2:0]ledS,
    output reg [2:0]ledW,
    output reg [2:0]ledE
    );
    
    parameter threshold=100_000_000;
    reg [2:0]state;
    reg clk_1s;
    reg [26:0]counter;
    reg [31:0]traffic_counter;
    reg hold;
    
    localparam s0_time = 10; 
    localparam s1_time = 10;
    localparam s2_time = 7;
    localparam s3_time = 7;
    localparam s4_time = 18;
    localparam s5_time = 20; 
    
    localparam s0 = 3'b000;
    localparam s1 = 3'b001;
    localparam s2 = 3'b010;
    localparam s3 = 3'b011;
    localparam s4 = 3'b100;
    localparam s5 = 3'b101;
    
    always@(posedge clk or negedge rst_n)
    begin
    if(!rst_n)
        begin
        counter<=0;
        clk_1s<=0;
        end
    else
        begin
            if(counter>=(threshold-1))
                begin
                    counter<=0;
                    clk_1s<=~clk_1s;
                end
            else
                begin
                    counter<=counter+1;
                    clk_1s<=0;
                end    
        end
    end
    

    always@(posedge clk or negedge rst_n)
    begin
    if(!rst_n)
        begin
        state<=s0;
        traffic_counter<=0;
        end
    else if(clk_1s)
        begin
        traffic_counter<=traffic_counter+1;
        
        case(state)
         s0:if(traffic_counter>=s0_time-1)
                begin
                state<=s1;
                traffic_counter<=0;
                end
                
         s1:if(traffic_counter>=s1_time-1)
                begin
                state<=s2;
                traffic_counter<=0;
                end       
                
         s2:if(traffic_counter>=s2_time-1)
                begin
                state<=s3;
                traffic_counter<=0;
                end
         
         s3:if(traffic_counter>=s3_time-1)
                begin
                state<=s4;
                traffic_counter<=0;
                end         
                
          s4:if(traffic_counter>=s4_time-1)
                begin
                state<=s5;
                traffic_counter<=0;
                end     
                
           s5:if(traffic_counter>=s5_time-1)
                begin
                state<=s0;
                traffic_counter<=0;
                end                                 
        endcase        
        end
            
    end
    
always@(*)
begin    
ledN = 3'b100; ledS = 3'b100; ledW = 3'b100; ledE = 3'b100;

    case(state)
        s0: begin 
        ledN<=3'b100;ledS<=3'b100;ledE<=3'b010;ledW<=3'b100;
        end
        
       s1: begin 
        ledN<=3'b100;ledS<=3'b100;ledE<=3'b100;ledW<=3'b010;
        end
        
       s2: begin 
        ledN=3'b010;ledS=3'b100;ledE=3'b100;ledW=3'b100;
        end 
        
       s3: begin 
        ledN=3'b100;ledS=3'b010;ledE=3'b100;ledW=3'b100;
        end 
        
       s4: begin 
        ledN=3'b100;ledS=3'b100;ledE=3'b010;ledW=3'b010;
        end  
        
       s5: begin 
        ledN=3'b010;ledS=3'b010;ledE=3'b100;ledW=3'b100;
        end  
     endcase
    end       
endmodule


