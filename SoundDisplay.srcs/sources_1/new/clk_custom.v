`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/09/2021 10:21:58 AM
// Design Name: 
// Module Name: clk_custom
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


module clk_custom(
    input CLOCK,
    input [31:0] flip_count,       //formula flip_count = (100/(2 * clk_req_in_mhz)) - 1
    output reg new_clk = 0
    );
    reg[31:0] count = 32'b0;
    always @(posedge CLOCK) begin
        count <= (count == flip_count) ? 0 : count + 1;
        new_clk <= (count == flip_count) ? ~new_clk : new_clk;
    end
endmodule
