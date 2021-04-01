`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 22.03.2021 20:44:41
// Design Name: 
// Module Name: Display_Menu
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


module Display_Menu(
    input clk1hz,
    input clk6p25m,
    input [6:0]x,
    input [5:0]y,
    input [1:0] option,
    input [3:0] flag,
    output reg [15:0]oled_data  
    );
    
    reg [15:0] RED = 16'hF800, GREEN = 16'h07E0, YELLOW = 16'hFFE0;
    

    
    always @(posedge clk6p25m) begin
        if (flag == 4'd0) begin
        if((x == 0 || x == 95 ||  y == 0 || y == 63))
            oled_data = 16'hFFFF;  
        
        else if ((y == 3) && ((x == 36) || (x == 40) || (x == 43) || (x == 44) || (x == 45) || (x == 48)
        || (x == 52) || (x == 55) || (x == 58)))
            oled_data = GREEN;
        
        else if ((y == 4) && ((x == 36) || (x == 37) || (x == 39) || (x == 40) || (x == 43) || (x == 48)
        || (x == 49) || (x == 52) || (x == 55) || (x == 58)))
            oled_data = GREEN;
            
        else if ((y == 5) && ((x == 36) || (x == 38) || (x == 40) || (x == 43) || (x == 44) || (x == 45)
        || (x == 48) || (x == 50) || (x == 52) || (x == 55) || (x == 58)))
            oled_data = GREEN;
                    
        else if ((y == 6) && ((x == 36) || (x == 40) || (x == 43) || (x == 48) || (x == 51) || (x == 52)
        || (x == 55) || (x == 58)))
            oled_data = GREEN;
            
        else if ((y == 7) && ((x == 36) || (x == 40) || (x == 43) || (x == 44) || (x == 45) || (x == 48)
        || (x == 52) || (x == 55) || (x == 56) || (x == 57) || (x == 58)))
            oled_data = GREEN;
        //--------------------------------------------------
        else if ((option== 2'd0) && (y == 10) && ((x == 3)))
            oled_data = GREEN;
        
        else if ((option== 2'd0) && (y == 11) && ((x == 4)))
            oled_data = GREEN;
        
        else if ((option== 2'd0) && (y == 12) && ((x == 5)))
            oled_data = GREEN;
            
//        else if ((y == 12) && ((x >= 10) && (x <= 20)))
//            oled_data = GREEN;
        
        else if ((option== 2'd0) && (y == 13) && ((x == 4)))
            oled_data = GREEN;
        
        else if ((option== 2'd0) && (y == 14) && ((x == 3)))
            oled_data = GREEN;      
        else if ((y == 10) && (x == 10 || x == 14 || x == 17 || x == 18 || x == 19 || x == 20 || x == 23 ||
        x == 29 || x == 32 || x == 35 || x == 39 || x == 42 || x == 43 || x == 44 || x == 45))
            oled_data = GREEN;
        
        else if ((y == 11) && (x == 10 || x == 14 || x == 17 || x == 20 || x == 23 || x == 29 || x == 32 || 
        x == 35 || x == 36 ||  x == 38 || x == 39 || x == 42))
            oled_data = GREEN;
        
        else if ((y == 12) && (x == 10 || x == 14 || x == 17 || x == 20 || x == 23 || x == 29 || x == 32 ||
        x == 35 || x == 37 || x == 39 || x == 42 || x == 43 || x == 44 || x == 45))
            oled_data = GREEN;
        
        else if ((y == 13) && (x == 11 || x == 13 || x == 17 || x == 20 || x == 23 || x == 29 || x == 32 ||
        x == 35 || x == 39 || x == 42))
            oled_data = GREEN;
        
        else if ((y == 14) && (x == 12 || x == 17 || x == 18 || x == 19 || x == 20 || x == 23 || x == 24 ||
        x == 25 || x == 26 || x == 29 || x == 30 || x  == 31 || x == 32 || x == 35 || x == 39 || x == 42 ||
        x == 43 || x == 44 || x == 45))
            oled_data = GREEN;
            
            
        //-------------------------------------------------- first option
        
        //--------------------------------------------------
        else if ((option == 2'd1) && (y == 19) && ((x == 3)))
            oled_data = GREEN;
        
        else if ((option == 2'd1) && (y == 20) && ((x == 4)))
            oled_data = GREEN;
        
        else if ((option == 2'd1) && (y == 21) && ((x == 5)))
            oled_data = GREEN;
            
//        else if ((y == 21) && ((x >= 10) && (x <= 20)))
//            oled_data = GREEN;
        
        else if ((option == 2'd1) && (y == 22) && ((x == 4)))
            oled_data = GREEN;
        
        else if ((option == 2'd1) && (y == 23) && ((x == 3)))
            oled_data = GREEN;     
        
        else if ((y == 19) && (x == 10 || x == 11 || x == 12 || x == 13 || x == 16 || x == 17 || x == 18 ||
        x == 19 || x == 22 || x == 25 || x == 28 || x == 32 || x == 35 || x == 36 || x == 37 || x == 38 ||
        x == 41 || x == 44))
            oled_data = GREEN;
        
        else if ((y == 20) && (x == 10 || x == 13 || x == 16 || x == 19 || x == 22 || x == 25 || x == 28 || 
        x == 29 || x == 32 || x == 35 || x == 41 || x == 44))
            oled_data = GREEN;
            
        else if ((y == 21) && (x == 10 || x == 11 || x == 12 || x == 13 || x == 16 || x == 19 || x == 22 || 
        x == 25 || x == 28 || x == 30 || x == 32 || x == 35 || x == 41 || x == 42 || x == 43 || x == 44))
            oled_data = GREEN;
        
        else if ((y == 22) && (x == 10 || x == 13 || x == 16 || x == 19 || x == 22 || x == 25 || x == 28 || 
        x == 31 || x == 32 || x == 35 || x == 44))
            oled_data = GREEN;
            
        else if ((y == 23) && (x == 10 || x == 11 || x == 12 || x == 13 || x == 16 || x == 17 || x == 18 || 
        x == 19 || x == 22 || x == 23 ||  x == 24 || x == 25 || x == 28 || x == 32 || x == 35 || x == 36 ||
        x == 37 || x == 38 || x == 41 || x == 42 || x == 43 || x == 44))
            oled_data = GREEN;
            
        //-------------------------------------------------- second option

        //--------------------------------------------------
        else if ((option == 2'd2) && (y == 28) && ((x == 3)))
            oled_data = GREEN;
        
        else if ((option == 2'd2) && (y == 29) && ((x == 4)))
            oled_data = GREEN;
        
        else if ((option == 2'd2) && (y == 30) && ((x == 5)))
            oled_data = GREEN;
            
//        else if ((y == 30) && ((x >= 10) && (x <= 20)))
//            oled_data = GREEN;
        
        else if ((option == 2'd2) && (y == 31) && ((x == 4)))
            oled_data = GREEN;
        
        else if ((option == 2'd2) && (y == 32) && ((x == 3)))
            oled_data = GREEN;      
            
        else if ((y == 28) && (x == 10 || x == 11 || x == 12 || x == 13  || x == 14|| x == 17 || x == 20 ||
        x == 23 || x == 24 || x == 25 || x == 26 || x == 29 || x == 30 || x == 31 || x == 32 || x == 35 ||
        x == 41 || x == 42 || x == 43 ||  x == 44))
            oled_data = GREEN;
        
        else if ((y == 29) && (x == 12 || x == 17 || x == 20 || x == 23 || x == 26 || x == 29 || x == 32 ||
        x == 35 || x == 41))
            oled_data = GREEN;
        
        else if ((y == 30) && (x == 12 || x == 17 || x == 20 || x == 23 || x == 24 || x == 25 || x == 26 ||
        x == 29 || x == 30 || x == 31 || x == 32 || x == 35 || x == 41 || x == 42 || x == 43 || x == 44))
            oled_data = GREEN;
            
        else if ((y == 31) && (x == 12 || x == 17 || x == 20 || x == 26 || x == 32 || x == 35 || x == 41))
            oled_data = GREEN;
        
        else if ((y == 32) && (x == 10 || x == 11 || x == 12 || x == 17 || x == 18 || x == 19 || x == 20 ||
        x == 23 || x == 24 || x == 25 || x == 26 || x == 29 || x == 30 || x == 31 || x == 32 || x == 35 ||
        x == 36 || x == 37 || x == 38 || x == 41 || x == 42 || x == 43 || x == 44))
            oled_data = GREEN;
             
            
        //-------------------------------------------------- third option
        //--------------------------------------------------
        else if ((option == 2'd3) && (y == 37) && ((x == 3)))
            oled_data = GREEN;
        
        else if ((option == 2'd3) && (y == 38) && ((x == 4)))
            oled_data = GREEN;
        
        else if ((option == 2'd3) && (y == 39) && ((x == 5)))
            oled_data = GREEN;
            
        else if ((y == 39) && ((x >= 10) && (x <= 20)))
            oled_data = GREEN;   // comment out ltr
        
        else if ((option == 2'd3) && (y == 40) && ((x == 4)))
            oled_data = GREEN;
        
        else if ((option == 2'd3) && (y == 41) && ((x == 3)))
            oled_data = GREEN;      
            
        //else if ((y == 37) && ....
        //-------------------------------------------------- fourth option
//        else if ((option == 2'd4) && (y == 46) && ((x == 3)))
//            oled_data = GREEN;
        
        
        
        //-----------------------------------------------------fifth option
        
        
   
        else
            oled_data = 0;
        end
    end
endmodule
