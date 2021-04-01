`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2021 01:46:49 PM
// Design Name: 
// Module Name: visualize
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


module visualize(
    input clk,
    input [11:0]adc,
    input [6:0]x,y,
    output reg [15:0] oled_data
    );
    integer i;
    reg [6:0]h;
    always @(posedge clk) begin
    i = 0;
        while(i < 96) begin
            h = adc % 64;
            if(x == i && y <= h)
                oled_data = 16'hF800;
            else
                oled_data = 0;
            i = i+1;
        end 
    end
endmodule
