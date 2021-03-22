`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/16/2021 11:45:38 AM
// Design Name: 
// Module Name: display_volume
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
  

module display_volume(
    input clk6p25m,
    input [6:0]x,
    input [5:0]y,
    input [10:0]btnL,
    input [10:0]btnR,
    input [15:0]volume,
    input toggle_border,
    output reg [15:0]oled_data
    );
    
    //colors, can use MUX to toggle colors according to switch
    reg [15:0] RED = 16'hF800, GREEN = 16'h07E0, YELLOW = 16'hFFE0;
    always @(posedge clk6p25m) begin
        //1 bit border
        if((x == 0 || x == 95 ||  y == 0 || y == 63) && (toggle_border == 0))
            oled_data = 16'hFFFF;      
        //3 bit border
        else if((x == 0 || x == 1 || x == 2 || x == 93 || x == 94 || x == 95 || 
           y == 0 || y == 1 || y == 2 || y == 61 || y == 62 || y == 63) && (toggle_border == 1))
            oled_data = 16'hFFFF;
        
        //moving volume bar left and right       
        else if((x >= 40 - btnL + btnR) && (x <= 56 - btnL + btnR)) begin 
            //RED
            if (y >= 9 && y <= 10 && volume >= 16'b1111_1111_1111_1111)
                oled_data = RED;  
            else if (y >= 12 && y <= 13 && volume >= 16'b0111_1111_1111_1111)
                oled_data = RED;  
            else if (y >= 15 && y <= 16 && volume >= 16'b0011_1111_1111_1111)
                oled_data = RED;  
            else if (y >= 18 && y <= 19 && volume >= 16'b0001_1111_1111_1111)
                oled_data = RED;  
            else if (y >= 21 && y <= 22 && volume >= 16'b0000_1111_1111_1111)
                oled_data = RED;  
            //YELLOW
            else if (y >= 24 && y <= 25 && volume >= 16'b0000_0111_1111_1111) 
                oled_data = YELLOW;   
            else if (y >= 27 && y <= 28 && volume >= 16'b0000_0011_1111_1111)
                oled_data = YELLOW;   
            else if (y >= 30 && y <= 31 && volume >= 16'b0000_0001_1111_1111)
                oled_data = YELLOW;   
            else if (y >= 33 && y <= 34 && volume >= 16'b0000_0000_1111_1111)
                oled_data = YELLOW;   
            else if (y >= 36 && y <= 37 && volume >= 16'b0000_0000_0111_1111)
                oled_data = YELLOW;   
            //GREEN
            else if (y >= 39 && y <= 40 && volume >= 16'b0000_0000_0011_1111)  
                oled_data = GREEN; 
            else if (y >= 42 && y <= 43 && volume >= 16'b0000_0000_0001_1111)
                oled_data = GREEN;
            else if (y >= 45 && y <= 46 && volume >= 16'b0000_0000_0000_1111)
                oled_data = GREEN; 
            else if (y >= 48 && y <= 49 && volume >= 16'b0000_0000_0000_0111)
                oled_data = GREEN; 
            else if (y >= 51 && y <= 52 && volume >= 16'b0000_0000_0000_0011)
                oled_data = GREEN;     
            else if (y >= 54 && y <= 55 && volume >= 16'b0000_0000_0000_0001)    
                oled_data = GREEN;              
            else
                oled_data = 0;              
        end   
                   
        else
            oled_data = 0;
    end    
endmodule
