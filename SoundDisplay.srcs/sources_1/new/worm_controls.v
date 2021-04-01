`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2021 02:09:19 AM
// Design Name: 
// Module Name: worm_controls
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


module worm_controls(
    input oled_clk,
    input slowclk,
    input [3:0]flag,
    input btnU,
    input btnL,
    input btnR,
    output reg RESET = 1,
    output reg Left,
    output reg Right
    );
    
    reg COUNTER;
    always @ (posedge oled_clk) begin
    if(flag == 4'd4) begin
    if (btnR == 1) begin
        Left = 0;
        Right = 1;
    end
    else if (btnL == 1) begin
        Left = 1;
        Right = 0;
    end        
    if (btnU == 1)
        RESET = 1;
        
    if (COUNTER == 0 && slowclk == 1)
        begin
            Left = 0;
            Right = 0;
            RESET = 0;
        end
    COUNTER <= slowclk;
    end
    
    else begin
    Left = 0;
    Right = 0;
    RESET = 1;       
    end
    end
endmodule
