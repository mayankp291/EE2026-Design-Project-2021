`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/31/2021 05:21:17 PM
// Design Name: 
// Module Name: random_coor
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


module random_coor(
    input clk, eat, start,
    output [6:0] x, y
);

reg [6:0]listX[0:9];
reg [6:0]listY[0:9];
reg [3:0]temp = 0;

always @(posedge clk) begin
listX[0] = 50;
listX[1] = 68;
listX[2] = 23;
listX[3] = 72;
listX[4] = 39;
listX[5] = 47;
listX[6] = 90;
listX[7] = 30;
listX[8] = 10;
listX[9] = 60;

listY[0] = 29;
listY[1] = 60;
listY[2] = 10;
listY[3] = 21;
listY[4] = 39;
listY[5] = 47;
listY[6] = 30;
listY[7] = 27;
listY[8] = 50;
listY[9] = 15;
    if(start || eat) begin
//        x = listX[temp];
//        y = listY[temp];
        temp = temp + 1;
    end
end
assign x = listX[temp];
assign y = listY[temp];
    
endmodule
