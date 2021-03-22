`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2021 10:47:20 AM
// Design Name: 
// Module Name: single_pulse_circuit
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


module single_pulse_circuit(
    input clk,
    input btnC,
    output reset
    );
    wire S1, S2;
    
    dff f1 (clk, btnC, S1);
    dff f2 (clk, S1, S2);
    assign reset = S1 & (~S2);
endmodule
