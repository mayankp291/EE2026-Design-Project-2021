`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2021 06:34:54 PM
// Design Name: 
// Module Name: bouncing_ball_game
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


module bouncing_ball_game(
//input [3:0] volume_level,
input clk20hz,
input clk6p25m,
input btnU, btnL, btnR,
input [6:0]x,
input [5:0]y,
//input [3:0] flag,
output reg [15:0]oled_data  
    );
    
    integer  x_v = 1;
    integer  y_v = 1;    
    reg [15:0] COLOURS[0:7];    
    reg [15:0] RED = 16'hF800, GREEN = 16'h07E0, YELLOW = 16'hFFE0;
    reg [15:0] BLUE = 16'h30BD, PINK = 16'hC8BD, ORANGE = 16'hED02;
    reg [15:0] LBLUE = 16'h175A, LGREEN = 16'h7F42;
    reg exist;
    
    reg [2:0] colour;
    initial begin
    colour = 3'd0;
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
    
    reg [6:0]player1[0:19];
    reg [6:0]player2[0:19];
    integer i, j, k, l;
    always @ (posedge  clk20hz) begin  
//        if (volume_level >= 4'd6) begin
//            colour <= colour + 1;
//            colour2 <= colour2 + 1;
//            colour3 <= colour3 + 1;
//        end
    if(btnU) begin
        for(i = 0; i < 20; i = i + 1) begin
            player1[i] = 30 + i;
            player2[i] = 30 + i;
        end
    end
    if(~btnU) begin
    for(j = 0; j < 20; j = j + 1) begin
        player1[j] = player1[j] - 3*btnL + 3*btnR;
        player2[j] = player2[j] - 3*btnL + 3*btnR;
    end    
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
          
        //modify these
        else if (initialy - 1 == 6'd0 && y_v == -1) begin//
            y_v <= 1;
            colour <= colour + 1;
        end
        else if (initialy + 5 == 6'd63 && y_v == 1) begin//
            y_v <= -1;
          colour <= colour + 1;
        end     
        
        
        //modify these
        else if (initialy - 1 == 6'd2 && ((((initialx - player2[19]) >= 0) && ((initialx - player2[19]) <= 15)) || (((initialx + 15 - player2[0]) >= 0) && ((initialx + 15 - player2[0]) <= 15))) && y_v == -1) begin//
            y_v <= 1;
            colour <= colour + 1;
        end
        else if (initialy + 5 == 6'd61 && ((((initialx - player1[19]) >= 0) && ((initialx - player1[19]) <= 15)) || (((initialx + 15 - player1[0]) >= 0) && ((initialx + 15 - player1[0]) <= 15))) && y_v == 1) begin//
            y_v <= -1;
          colour <= colour + 1;
        end
        
        
                
        initialx <= initialx + x_v;
        initialy <= initialy + y_v;        
 end  
  
    always @ (posedge clk6p25m) begin
      //if (flag == 4'd2) begin
      exist = 0;
          for(k = 0; k < 20; k = k + 1) begin
            if((y == 0 || y == 1) && player2[k] == x)
                exist = 1;
            if((y == 62 || y == 63) && player1[k] == x)
                exist = 1;                                
          end 
          if (exist == 1)
            oled_data = 16'hFFFF;             
          else if ((y == initialy) && (x == initialx || x == initialx + 1 || x == initialx + 2 || x == initialx + 4
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
          else
            oled_data = 0;
       //end
    end
endmodule
