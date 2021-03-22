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
    input clk6p25m,
    input [6:0]x,
    input [5:0]y,
    output reg [15:0]oled_data  
    );
    
    reg [15:0] RED = 16'hF800, GREEN = 16'h07E0, YELLOW = 16'hFFE0;
    
    always @(posedge clk6p25m) begin
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
        
        else
            oled_data = 0;
    end
endmodule
