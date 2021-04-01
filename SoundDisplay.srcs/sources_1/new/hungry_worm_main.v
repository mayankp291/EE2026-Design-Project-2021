`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/02/2021 02:46:44 AM
// Design Name: 
// Module Name: hungry_worm_main
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


module hungry_worm_main(
    input oled_clk,
    input clk5hz,
    input clk10hz,
    input clk15hz,
    input sw0,
    input sw1,
    input btnL, btnR, btnU,
    input [6:0]x,
    input [5:0]y,
    input [3:0]flag,
    output [15:0]oled_data
    );
    wire [15:0]oled_data_worm;
    reg clock_selector;
    wire btnU_press, btnL_press, btnR_press, RESET, LEFT, RIGHT;
    single_pulse_circuit RESET_BUTTON(clock_selector, btnU, btnU_press);
    single_pulse_circuit LEFT_BUTTON(clock_selector, btnL, btnL_press);
    single_pulse_circuit RIGHT_BUTTON(clock_selector, btnR, btnR_press);    
    
    worm_controls CONTROLS(oled_clk, clock_selector, flag, btnU_press, btnL_press, btnR_press, RESET, LEFT, RIGHT);
    hungry_worm GAME(oled_clk, clock_selector, LEFT, RIGHT, RESET, x, y, flag, oled_data_worm);
    
    always @(*) begin
    if(flag == 4'd4) begin
        if(sw0 == 1)
            clock_selector = clk10hz;
        else if(sw1 == 1)
            clock_selector = clk15hz;
        else
            clock_selector = clk5hz;    
    end
    end        
   
   assign oled_data = oled_data_worm;     
endmodule
