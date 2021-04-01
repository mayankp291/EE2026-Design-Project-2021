`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2021 01:09:39 PM
// Design Name: 
// Module Name: snake_game
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


module snake_game(
input CLOCK,
input slowclk,
input btnL, btnR, btnU,
input [6:0]x,
input [5:0]y,
output reg [15:0]oled_data
);

integer i, j, k, l;
reg [1:0]dir = 0;
reg [10:0]len = 0;
reg [6:0]snakeX[0:31];
reg [6:0]snakeY[0:31];
wire [6:0]fruitX, fruitY;
reg eat;
reg found, snake_body, collision;
reg die = 0;
reg start = 1;
random_coor (slowclk, eat, btnU, fruitX, fruitY);
always @(posedge slowclk) begin
    if(btnL == 1)
        dir = dir - 1;
    else if(btnR == 1)
        dir = dir + 1;
    
    if(btnU) begin
        for(i = 0; i < 32; i = i + 1) begin
            snakeX[i] = 32;
            snakeY[i] = 60 + 2*i;
            len = 3;
        end
        dir = 0;
    end   
    
    else if(~btnU && ~die) begin
        for(j = 31; j > 0; j = j - 1) begin
            snakeX[j] = snakeX[j-1];    
            snakeY[j] = snakeY[j-1];   
        end  
     
    case(dir)
        0: snakeY[0] = (snakeY[0] - 2);
        1: snakeX[0] = (snakeX[0] + 2);
        2: snakeY[0] = (snakeY[0] + 2);
        3: snakeX[0] = (snakeX[0] - 2);
    endcase    
    end
    
    if(snakeX[0] == fruitX && snakeY[0] == fruitY) begin
        eat = 1;
        if(len < 31)
            len = len + 1;
    end
    
    else
        eat = 0;
end

always @(posedge CLOCK) begin
    found = 0;
    die = collision;
        for(k = 0; k < len && k < 100; k = k + 1) begin
        if (~found) begin                
            snake_body = ((x == snakeX[k] || x == snakeX[k] + 1) && (y == snakeY[k] || y == snakeY[k] + 1));
            found = snake_body;
        end
    end  
    
    for(l = 1; l < len && l < 100; l = l + 1) begin
        if(collision == 0)
            collision = (snakeX[0] == snakeX[l]) && (snakeY[0] == snakeY[l]);
    end
    
    if(x == 0 || x == 95 || y == 0 || y == 63)
        oled_data = 16'hFFFF;  
    else if(x == fruitX && y == fruitY)
        oled_data = 16'hF800;
    else if(snake_body)
        oled_data = 16'h07E0;
    else
        oled_data = 0;
end

endmodule
