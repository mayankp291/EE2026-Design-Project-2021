`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2021 06:18:15 PM
// Design Name: 
// Module Name: snake_signal
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


module snake_signal(
    input oled_clk,
    input slowclk,
    input btnU,
    input btnL,
    input btnR,
    output reg RESET = 1,
    output reg Left,
    output reg Right
);

reg COUNTER;
always @ (posedge oled_clk) begin
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
endmodule
