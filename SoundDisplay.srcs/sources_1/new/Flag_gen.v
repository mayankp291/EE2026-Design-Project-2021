`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 23.03.2021 10:27:56
// Design Name: 
// Module Name: Flag_gen
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


module Flag_gen(
    input clk381hz,
    input [15:0] sw,
    input btnU_press,
    input btnD_press,
    input btnC_press,
    output reg [3:0] flag,
    output reg [1:0] option
    );
    
  
    
    
    initial begin
        option = 2'd0;
        flag = 4'd0;
    end
      

    
    always @ (posedge clk381hz) begin
       
        if (sw == 16'd1)
            flag <= 4'd0;
        if (btnD_press == 1)
            option <= option + 1;
        else if (btnU_press == 1)
            option <= option - 1;
        
        if ((option == 2'd0) && btnC_press == 1)
            flag <= 4'd1;
        
        else if ((option == 2'd1) && btnC_press == 1)
            flag <= 4'd2;
            
        else if ((option == 2'd2) && btnC_press == 1)
            flag <= 4'd3;
        
        else if ((option == 2'd3) && btnC_press == 1)
            flag <= 4'd4;
       
    end
endmodule
