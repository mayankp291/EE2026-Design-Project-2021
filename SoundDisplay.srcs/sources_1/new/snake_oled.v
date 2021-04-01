`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/30/2021 01:12:42 PM
// Design Name: 
// Module Name: snake_oled
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


module snake_oled(
    input clk,
    input start,
    input btnL,
    input btnR,
    input [6:0]x,
    input [5:0]y,
    output [15:0]oled_data
    );
    reg [6:0] snakeX[0:31];
    reg [6:0] snakeY[0:31];
    integer count1, count2, count3, count4;
    reg found, hit_body;
    wire [6:0] appleX, appleY;
    reg [4:0] len;
    reg snake_body, snake_head, apple, border, eat, die;
    
    random_coor (clk, eat, start, appleX, appleY);
    
    always @ (posedge clk) begin
        eat = 0;
        
        if (btnL == 1)
            dir = dir - 1;
        else if (btnR == 1)
            dir = dir + 1;
        
        if (start) begin
            for(count1 = 0; count1 < 32; count1 = count1+1) begin
                snakeX[count1] = 32;
                snakeY[count1] = 60 + 2*count1; // changed to * 2
                len = 3;
            end
            dir = 0;
        end
        else if (~start && ~die) begin
            for(count2 = 31; count2 > 0; count2 = count2 - 1) begin
                snakeX[count2] = snakeX[count2 - 1];
                snakeY[count2] = snakeY[count2 - 1];
            end
            
            case(dir)
                0: snakeY[0] = (snakeY[0] - 2);
                1: snakeX[0] = (snakeX[0] + 2);
                2: snakeY[0] = (snakeY[0] + 2);
                3: snakeX[0] = (snakeX[0] - 2);
            endcase
        end
        
        hit_body = 0;
        for(count4 = 1; count4 < len; count4 = count4 + 1) begin
            if (~hit_body)           
                hit_body = (snakeX[0] == snakeX[count4] && snakeY[0] == snakeY[count4]);
        end
        
        if (snakeX[0] == 16 || snakeX[0] == 78 || snakeY[0] == 0 || snakeY[0] == 62 || hit_body)
            die = 1;
        else
            die = 0;
            
        if (snakeX[0] == appleX && snakeY[0] == appleY) begin
            eat = 1;
            if (len < 31)
                len = len + 1;
        end
        else
            eat = 0;
    end
    
    always @ (*) begin
        found = 0;
        
        for(count3 = 1; count3 < len; count3 = count3 + 1) begin
            if (~found) begin                
                snake_body = ((x == snakeX[count3] || x == snakeX[count3] + 1) && (y == snakeY[count3] || y == snakeY[count3] + 1));
                found = snake_body;
            end
        end
        
        border = (x == 16 || x == 17 || x == 78 || x == 79 || ((y == 0 || y == 1 || y == 62 || y == 63) && (x > 16 && x < 78)));
        snake_head = ((x == snakeX[0] || x == snakeX[0] + 1) && (y == snakeY[0] || y == snakeY[0] + 1));
        apple = ((x == appleX || x == appleX + 1) && (y == appleY || y == appleY + 1));
    end
    
    assign oled_data =  border ? 16'b0000000000011111 :
                        (snake_body || snake_head) ? (die ? 16'b1111111111111111 : 16'b0000011111100000) :
                        apple ? 16'b1111100000000000 : 16'b0;
    
endmodule