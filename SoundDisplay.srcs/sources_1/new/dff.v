`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2021 10:49:31 AM
// Design Name: 
// Module Name: dff
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


module dff(
    input CLOCK,
    input D,
    output reg Q
    );
    always @ (posedge CLOCK) begin
        Q <= D;
    end
endmodule