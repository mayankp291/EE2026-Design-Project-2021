`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2021 09:25:45
// Design Name: 
// Module Name: Volume_left_right
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


module Volume_left_right(
    input clk381hz,
    input btnL,
    input btnR,
    
    output reg [10:0] btnL_count,
    output reg [10:0] btnR_count
    );
    
    initial begin
        btnL_count = 0;
        btnR_count = 0;
    end
    
    wire btnL_press, btnR_press;
    single_pulse_circuit f1(clk381hz, btnL, btnL_press);
    single_pulse_circuit f2(clk381hz, btnR, btnR_press);
    
    always @(posedge clk381hz) begin
        if(btnL_press == 1)
            btnL_count <= btnL_count + 1;
        else if(btnR_press == 1)
            btnR_count <= btnR_count + 1;       
                
                ////for not out of bounds (btnL_count - btnR_count != ???)     
    end    
endmodule
