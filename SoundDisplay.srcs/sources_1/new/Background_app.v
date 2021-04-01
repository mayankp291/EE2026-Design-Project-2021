`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2021 18:21:57
// Design Name: 
// Module Name: Background_app
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


module Background_app(
    input sw15,
    input sw14,
    input [3:0] volume_level,
    input clk5hz,
    input clk6p25m,
    input [6:0]x,
    input [5:0]y,
    input [3:0] flag,
    output reg [15:0]oled_data  
    );
    
    integer  x_v = 1;
    integer  y_v = 1;
    integer  x_v2 = 1;
    integer  y_v2 = 1;
    integer  x_v3 = 1;
    integer  y_v3 = 1;
    reg [15:0] COLOURS[0:7];
    
    reg [15:0] RED = 16'hF800, GREEN = 16'h07E0, YELLOW = 16'hFFE0;
    reg [15:0] BLUE = 16'h30BD, PINK = 16'hC8BD, ORANGE = 16'hED02;
    reg [15:0] LBLUE = 16'h175A, LGREEN = 16'h7F42;
    
    reg [2:0] colour;
    reg [2:0] colour2;
    reg [2:0] colour3;
    
    initial begin
    colour = 3'd0;
    colour2 = 3'd0;
    colour3 = 3'd0;
    COLOURS[0] = RED;
    COLOURS[1] = GREEN;
    COLOURS[2] = YELLOW;
    COLOURS[3] = BLUE;
    COLOURS[4] = PINK;
    COLOURS[5] = ORANGE;
    COLOURS[6] = LBLUE;
    COLOURS[7] = LGREEN;
    end
    
    reg [6:0] initialx = 7'd20;
    reg [5:0] initialy = 6'd40;
    reg [6:0] initialx2 = 7'd60;
    reg [5:0] initialy2 = 6'd50;
    reg [6:0] initialx3 = 7'd1;
    reg [5:0] initialy3 = 6'd1;
    
    
    
    
    
    always @ (posedge  clk5hz) begin
    
        if (volume_level >= 4'd6) begin
            colour <= colour + 1;
            colour2 <= colour2 + 1;
            colour3 <= colour3 + 1;
        end
        if (initialx - 1 == 7'd0 && initialy - 1 == 6'd0 && x_v == -1 && y_v == -1) begin
            x_v <= 1;
            y_v <= 1;
            colour <= colour + 1;
            
        end
        else if (initialx + 15 == 7'd95 && initialy + 5 == 6'd63 && x_v == 1 && y_v == 1) begin
            x_v <= -1;
            y_v <= -1;
            colour <= colour + 1;
        end
        else if (initialx + 15 == 7'd95 && initialy - 1 == 6'd0 && x_v == 1 && y_v == -1) begin
            x_v <= -1;
            y_v <= 1;
            colour <= colour + 1;
        end
        else if (initialx -1 == 7'd0 && initialy + 5 == 6'd63 && x_v == -1 && y_v == 1) begin
            x_v <= 1;
            y_v <= -1;
            colour <= colour + 1;
        end
        //-------------------------- corner cases -------------------------------------
        else if (initialx - 1 == 7'd0 && x_v == -1) begin//
            x_v <= 1;
           colour <= colour + 1;
            
        end
        else if (initialx + 15 == 7'd95 && x_v == 1) begin//
            x_v <= -1;
            colour <= colour + 1;
        end
        else if (initialy - 1 == 6'd0 && y_v == -1) begin//
            y_v <= 1;
            colour <= colour + 1;
        end
        else if (initialy + 5 == 6'd63 && y_v == 1) begin//
            y_v <= -1;
          colour <= colour + 1;
        end        
        //----------------------second
        else if (initialx2 - 1 == 7'd0 && initialy2 - 1 == 6'd0 && x_v2 == -1 && y_v2 == -1) begin
            x_v2 <= 1;
            y_v2 <= 1;
            colour2 <= colour2 + 1;
            
        end
        else if (initialx2 + 15 == 7'd95 && initialy2 + 5 == 6'd63 && x_v2 == 1 && y_v2 == 1) begin
            x_v2 <= -1;
            y_v2 <= -1;
            colour2 <= colour2 + 1;
        end
        else if (initialx2 + 15 == 7'd95 && initialy2 - 1 == 6'd0 && x_v2 == 1 && y_v2 == -1) begin
            x_v2 <= -1;
            y_v2 <= 1;
            colour2 <= colour2 + 1;
        end
        else if (initialx2 -1 == 7'd0 && initialy2 + 5 == 6'd63 && x_v2 == -1 && y_v2 == 1) begin
            x_v2 <= 1;
            y_v2 <= -1;
            colour2 <= colour2 + 1;
        end
        //-------------------------- corner cases -------------------------------------
        else if (initialx2 - 1 == 7'd0 && x_v2 == -1) begin//
            x_v2 <= 1;
           colour2 <= colour2 + 1;
            
        end
        else if (initialx2 + 15 == 7'd95 && x_v2 == 1) begin//
            x_v2 <= -1;
            colour2 <= colour2 + 1;
        end
        else if (initialy2 - 1 == 6'd0 && y_v2 == -1) begin//
            y_v2 <= 1;
            colour2 <= colour2 + 1;
        end
        else if (initialy2 + 5 == 6'd63 && y_v2 == 1) begin//
            y_v2 <= -1;
          colour2 <= colour2 + 1;
        end        
        
        //----------------------------------third
        
        else if (initialx3 - 1 == 7'd0 && initialy3 - 1 == 6'd0 && x_v3 == -1 && y_v3 == -1) begin
            x_v3 <= 1;
            y_v3 <= 1;
            colour3 <= colour3 + 1;
            
        end
        else if (initialx3 + 15 == 7'd95 && initialy3 + 5 == 6'd63 && x_v3 == 1 && y_v3 == 1) begin
            x_v3 <= -1;
            y_v3 <= -1;
            colour3 <= colour3 + 1;
        end
        else if (initialx3 + 15 == 7'd95 && initialy3 - 1 == 6'd0 && x_v3 == 1 && y_v3 == -1) begin
            x_v3 <= -1;
            y_v3 <= 1;
            colour3 <= colour3 + 1;
        end
        else if (initialx3 -1 == 7'd0 && initialy3 + 5 == 6'd63 && x_v3 == -1 && y_v3 == 1) begin
            x_v3 <= 1;
            y_v3 <= -1;
            colour3 <= colour3 + 1;
        end
        //-------------------------- corner cases -------------------------------------
        else if (initialx3 - 1 == 7'd0 && x_v3 == -1) begin//
            x_v3 <= 1;
           colour3 <= colour3 + 1;
            
        end
        else if (initialx3 + 15 == 7'd95 && x_v3 == 1) begin//
            x_v3 <= -1;
            colour3 <= colour3 + 1;
        end
        else if (initialy3 - 1 == 6'd0 && y_v3 == -1) begin//
            y_v3 <= 1;
            colour3 <= colour3 + 1;
        end
        else if (initialy3 + 5 == 6'd63 && y_v3 == 1) begin//
            y_v3 <= -1;
          colour3 <= colour3 + 1;
        end        
       
        
        
        initialx2 <= initialx2 + x_v2;
        initialy2 <= initialy2 + y_v2;
             
        initialx <= initialx + x_v;
        initialy <= initialy + y_v;
        
        initialx3 <= initialx3 + x_v3;
        initialy3 <= initialy3 + y_v3;
      
        

        
        
        
    end
    
    
    always @ (posedge clk6p25m) begin
        if (flag == 4'd2) begin
//            if (y >= initialy && y < initialy + 10 && x >= initialx && x < initialx + 10)
//                oled_data = COLOURS[colour];
//            else
//                oled_data = 0;        
            
            if ((y == initialy) && (x == initialx || x == initialx + 1 || x == initialx + 2 || x == initialx + 4
            || x == initialx + 5 || x == initialx + 6 || x == initialx + 8 || x == initialx + 9 || x == initialx + 10
            || x == initialx + 12 || x == initialx + 13 || x == initialx + 14))
                oled_data = COLOURS[colour];
            else if ((y == initialy + 1) && (x == initialx + 2 || x == initialx + 4 || x == initialx + 6 || x == initialx + 10
            || x == initialx + 12))
                oled_data = COLOURS[colour];
            else if ((y == initialy + 2) && (x == initialx || x == initialx + 1 || x == initialx + 2 || x == initialx + 4
            || x == initialx + 6 || x == initialx + 8 || x == initialx + 9 || x == initialx + 10
            || x == initialx + 12 || x == initialx + 13 || x == initialx + 14))
                oled_data = COLOURS[colour];
            else if ((y == initialy + 3) && (x == initialx || x == initialx + 4
            || x == initialx + 6 || x == initialx + 8 || x == initialx + 12 || x == initialx + 14))
                oled_data = COLOURS[colour];
            else if ((y == initialy + 4) && (x == initialx || x == initialx + 1 || x == initialx + 2 || x == initialx + 4
            || x == initialx + 5 || x == initialx + 6 || x == initialx + 8 || x == initialx + 9 || x == initialx + 10
            || x == initialx + 12 || x == initialx + 13 || x == initialx + 14))
                oled_data = COLOURS[colour];
           
                
           //---------------------------------------------------------
            else if ( sw15 == 1 && (y == initialy2) && (x == initialx2 || x == initialx2 + 1 || x == initialx2 + 2 || x == initialx2 + 4
            || x == initialx2 + 5 || x == initialx2 + 6 || x == initialx2 + 8 || x == initialx2 + 9 || x == initialx2 + 10
            || x == initialx2 + 12 || x == initialx2 + 13 || x == initialx2 + 14))
                oled_data = COLOURS[colour2];
            else if (sw15 == 1 && (y == initialy2 + 1) && (x == initialx2 + 2 || x == initialx2 + 4 || x == initialx2 + 6 || x == initialx2 + 10
            || x == initialx2 + 12))
                oled_data = COLOURS[colour2];
            else if (sw15 == 1 && (y == initialy2 + 2) && (x == initialx2 || x == initialx2 + 1 || x == initialx2 + 2 || x == initialx2 + 4
            || x == initialx2 + 6 || x == initialx2 + 8 || x == initialx2 + 9 || x == initialx2 + 10
            || x == initialx2 + 12 || x == initialx2 + 13 || x == initialx2 + 14))
                oled_data = COLOURS[colour2];
            else if (sw15 == 1 && (y == initialy2 + 3) && (x == initialx2 || x == initialx2 + 4
            || x == initialx2 + 6 || x == initialx2 + 8 || x == initialx2 + 12 || x == initialx2 + 14))
                oled_data = COLOURS[colour2];
            else if (sw15 == 1 && (y == initialy2 + 4) && (x == initialx2 || x == initialx2 + 1 || x == initialx2 + 2 || x == initialx2 + 4
            || x == initialx2 + 5 || x == initialx2 + 6 || x == initialx2 + 8 || x == initialx2 + 9 || x == initialx2 + 10
            || x == initialx2 + 12 || x == initialx2 + 13 || x == initialx2 + 14))
                oled_data = COLOURS[colour2];
           //-----------------------------------------
            else if ( sw14 == 1 && (y == initialy3) && (x == initialx3 || x == initialx3 + 1 || x == initialx3 + 2 || x == initialx3 + 4
                || x == initialx3 + 5 || x == initialx3 + 6 || x == initialx3 + 8 || x == initialx3 + 9 || x == initialx3 + 10
                || x == initialx3 + 12 || x == initialx3 + 13 || x == initialx3 + 14))
                    oled_data = COLOURS[colour3];
                else if (sw14 == 1 && (y == initialy3 + 1) && (x == initialx3 + 2 || x == initialx3 + 4 || x == initialx3 + 6 || x == initialx3 + 10
                || x == initialx3 + 12))
                    oled_data = COLOURS[colour3];
                else if (sw14 == 1 && (y == initialy3 + 2) && (x == initialx3 || x == initialx3 + 1 || x == initialx3 + 2 || x == initialx3 + 4
                || x == initialx3 + 6 || x == initialx3 + 8 || x == initialx3 + 9 || x == initialx3 + 10
                || x == initialx3 + 12 || x == initialx3 + 13 || x == initialx3 + 14))
                    oled_data = COLOURS[colour3];
                else if (sw14 == 1 && (y == initialy3 + 3) && (x == initialx3 || x == initialx3 + 4
                || x == initialx3 + 6 || x == initialx3 + 8 || x == initialx3 + 12 || x == initialx3 + 14))
                    oled_data = COLOURS[colour3];
                else if (sw14 == 1 && (y == initialy3 + 4) && (x == initialx3 || x == initialx3 + 1 || x == initialx3 + 2 || x == initialx3 + 4
                || x == initialx3 + 5 || x == initialx3 + 6 || x == initialx3 + 8 || x == initialx3 + 9 || x == initialx3 + 10
                || x == initialx3 + 12 || x == initialx3 + 13 || x == initialx3 + 14))
                    oled_data = COLOURS[colour3]; 
           
            else
                oled_data = 0;        
                           
        
        end    
    end
        
        
endmodule
