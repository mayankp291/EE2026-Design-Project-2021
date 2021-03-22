`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/20/2021 05:31:22 PM
// Design Name: 
// Module Name: convert_to_coordinate
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

`define OLED_WIDTH 96
`define OLED_HEIGHT 64 

module convert_to_coordinate(
    input [12:0] pixel_index,
    output [6:0]x,
    output [5:0]y
    );
    
    assign x = pixel_index % `OLED_WIDTH;
    assign y = pixel_index / `OLED_WIDTH;    
endmodule
