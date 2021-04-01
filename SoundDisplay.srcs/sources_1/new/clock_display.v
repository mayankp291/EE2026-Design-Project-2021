`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 29.03.2021 20:54:00
// Design Name: 
// Module Name: clock_display
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


module clock_display(
    input CLK100MHZ,
    input clk6p25m,
    input [3:0] flag,
    input [6:0] x,
    input [5:0] y,
    
    output reg [15:0]oled_data  
    
    );
    reg [15:0] RED = 16'hF800, GREEN = 16'h07E0, YELLOW = 16'hFFE0;
    reg [34:0] sec0 = 35'd49999999;
    reg [34:0] sec1 = 35'd499999999;
    reg [34:0] min0 = 35'd2999999999;
    reg [34:0] min1 = 35'd29999999999;
    
    reg [34:0] countsec0 = 0;
    reg [34:0] countsec1 = 0;
    reg [34:0] countmin0 = 0;
    reg [34:0] countmin1 = 0;
    
    reg clksec0 = 0;
    reg clksec1 = 0;
    reg clkmin0 = 0;
    reg clkmin1 = 0;
    
    reg [3:0] sec0_cases = 0;
        reg [3:0] sec1_cases = 0;
            reg [3:0] min0_cases = 0;
                reg [3:0] min1_cases = 0;
    always @ (posedge CLK100MHZ) begin
        countsec0 <= (countsec0 == sec0) ? 0 : countsec0 + 1;
        clksec0 <= (countsec0 == sec0) ? ~clksec0 : clksec0;
        
        countsec1 <= (countsec1 == sec1) ? 0 : countsec1 + 1;
        clksec1 <= (countsec1 == sec1) ? ~clksec1 : clksec1;      
        
        countmin0 <= (countmin0 == min0) ? 0 : countmin0 + 1;
        clkmin0 <= (countmin0 == min0) ? ~clkmin0 : clkmin0;
        
        countmin1 <= (countmin1 == min1) ? 0 : countmin1 + 1;
        clkmin1 <= (countmin1 == min1) ? ~clkmin1 : clkmin1;
        
    end
    
    always @ (posedge clksec0) begin
        if (sec0_cases >= 0 && sec0_cases <= 8)
        sec0_cases <= sec0_cases + 1;
        else if (sec0_cases == 9)
        sec0_cases <= 0;
    end     
    always @ (posedge clksec1) begin
        if (sec1_cases >= 0 && sec1_cases <= 8)
        sec1_cases <= sec1_cases + 1;
        else if (sec1_cases == 9)
        sec1_cases <= 0;
    end   
    always @ (posedge clkmin0) begin
        if (min0_cases >= 0 && min0_cases <= 8)
        min0_cases <= min0_cases + 1;
        else if (min0_cases == 9)
        min0_cases <= 0;
    end   
    always @ (posedge clkmin1) begin
        if (min1_cases >= 0 && min1_cases <= 8)
        min1_cases <= min1_cases + 1;
        else if (min1_cases == 9)
        min1_cases <= 0;
    end    
    
    always @ (posedge clk6p25m) begin
        if (y == 17) begin
            case (sec0_cases)
                0 : begin
                    if ((y == 17) && (x == 76 || x == 77 || x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end
                1 : begin
                    if ((y == 17) &&(x == 77)) begin
                        oled_data <= GREEN;
                    end
                    end
                2 : begin
                    if ((y == 17) &&(x == 76 || x == 77 || x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end
                3 : begin
                    if ((y == 17) &&(x == 76 || x == 77 || x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end
                4 : begin
                    if ((y == 17) &&(x == 76 || x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end       
                5 : begin
                    if ((y == 17) &&(x == 76 || x == 77 || x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end         
                6 : begin
                    if ((y == 17) &&(x == 76 || x == 77 || x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end     
                7 : begin
                    if ((y == 17) &&(x == 76 || x == 77 || x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end         
                8 : begin
                    if ((y == 17) &&(x == 76 || x == 77 || x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end         
                9 : begin
                    if ((y == 17) &&(x == 76 || x == 77 || x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end                                          
            endcase
            case (sec1_cases)
                0 : begin
                    if ((y == 17) &&(x == 71 || x == 72 || x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end
                1 : begin
                    if ((y == 17) &&(x == 72)) begin
                        oled_data <= GREEN;
                    end
                    end
                2 : begin
                    if ((y == 17) &&(x == 71 || x == 72 || x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end
                3 : begin
                    if ((y == 17) &&(x == 71 || x == 72 || x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end
                4 : begin
                    if ((y == 17) &&(x == 71 || x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end       
                5 : begin
                    if ((y == 17) &&(x == 71 || x == 72 || x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end         
                6 : begin
                    if ((y == 17) &&(x == 71 || x == 72 || x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end     
                7 : begin
                    if ((y == 17) &&(x == 71 || x == 72 || x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end         
                8 : begin
                    if ((y == 17) &&(x == 71 || x == 72 || x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end         
                9 : begin
                    if ((y == 17) &&(x == 71 || x == 72 || x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end                                          
            endcase
            case (min0_cases)
                0 : begin
                    if ((y == 17) &&(x == 65 || x == 66 || x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end
                1 : begin
                    if ((y == 17) &&(x == 66)) begin
                        oled_data <= GREEN;
                    end
                    end
                2 : begin
                    if ((y == 17) &&(x == 65 || x == 66 || x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end
                3 : begin
                    if ((y == 17) &&(x == 65 || x == 66 || x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end
                4 : begin
                    if ((y == 17) &&(x == 65 || x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end       
                5 : begin
                    if ((y == 17) &&(x == 65 || x == 66 || x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end         
                6 : begin
                    if ((y == 17) &&(x == 65 || x == 66 || x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end     
                7 : begin
                    if ((y == 17) &&(x == 65 || x == 66|| x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end         
                8 : begin
                    if ((y == 17) &&(x == 65 || x == 66 || x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end         
                9 : begin
                    if ((y == 17) &&(x == 65 || x == 66 || x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end                                          
            endcase
            case (min1_cases)
                0 : begin
                    if ((y == 17) &&(x == 60 || x == 61 || x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end
                1 : begin
                    if ((y == 17) &&(x == 61)) begin
                        oled_data <= GREEN;
                    end
                    end
                2 : begin
                    if ((y == 17) &&(x == 60 || x == 61 || x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end
                3 : begin
                    if ((y == 17) &&(x == 60 || x == 61 || x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end
                4 : begin
                    if ((y == 17) &&(x == 60 || x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end       
                5 : begin
                    if ((y == 17) &&(x == 60 || x == 61 || x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end         
                6 : begin
                    if ((y == 17) &&(x == 60 || x == 61 || x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end     
                7 : begin
                    if ((y == 17) &&(x == 60 || x == 61 || x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end         
                8 : begin
                    if ((y == 17) &&(x == 60 || x == 61 || x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end         
                9 : begin
                    if ((y == 17) &&(x == 60 || x == 61 || x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end                                          
            endcase
        end
 //------------------------------------------------------------------------------------------------------       
 //------------------------------------------------------------------------------------------------------       
 //------------------------------------------------------------------------------------------------------       
 //------------------------------------------------------------------------------------------------------       
 //------------------------------------------------------------------------------------------------------       
 //------------------------------------------------------------------------------------------------------       
 //------------------------------------------------------------------------------------------------------       
        else if (y == 18) begin
            case (sec0_cases)
                0 : begin
                    if ((x == 76 || x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end
                1 : begin
                    if ((x == 77)) begin
                        oled_data <= GREEN;
                    end
                    end
                2 : begin
                    if ((x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end
                3 : begin
                    if ((x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end
                4 : begin
                    if ((x == 76 || x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end       
                5 : begin
                    if ((x == 76)) begin
                        oled_data <= GREEN;
                    end
                    end         
                6 : begin
                    if ((x == 76)) begin
                        oled_data <= GREEN;
                    end
                    end     
                7 : begin
                    if ((x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end         
                8 : begin
                    if ((x == 76 || x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end         
                9 : begin
                    if ((x == 76 || x == 78)) begin
                        oled_data <= GREEN;
                    end
                    end                                          
            endcase
            case (sec1_cases)
                0 : begin
                    if ((x == 71 || x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end
                1 : begin
                    if ((x == 72)) begin
                        oled_data <= GREEN;
                    end
                    end
                2 : begin
                    if ((x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end
                3 : begin
                    if ((x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end
                4 : begin
                    if ((x == 71 || x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end       
                5 : begin
                    if ((x == 71)) begin
                        oled_data <= GREEN;
                    end
                    end         
                6 : begin
                    if ((x == 71)) begin
                        oled_data <= GREEN;
                    end
                    end     
                7 : begin
                    if ((x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end         
                8 : begin
                    if ((x == 71 || x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end         
                9 : begin
                    if ((x == 71 || x == 73)) begin
                        oled_data <= GREEN;
                    end
                    end                                          
            endcase
            case (min0_cases)
                0 : begin
                    if ((x == 65 || x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end
                1 : begin
                    if ((x == 66)) begin
                        oled_data <= GREEN;
                    end
                    end
                2 : begin
                    if ((x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end
                3 : begin
                    if ((x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end
                4 : begin
                    if ((x == 65 || x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end       
                5 : begin
                    if ((x == 65)) begin
                        oled_data <= GREEN;
                    end
                    end         
                6 : begin
                    if ((x == 65)) begin
                        oled_data <= GREEN;
                    end
                    end     
                7 : begin
                    if ((x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end         
                8 : begin
                    if ((x == 65 || x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end         
                9 : begin
                    if ((x == 65 || x == 67)) begin
                        oled_data <= GREEN;
                    end
                    end                                          
            endcase
            case (min1_cases)
                0 : begin
                    if ((x == 60 || x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end
                1 : begin
                    if ((x == 61)) begin
                        oled_data <= GREEN;
                    end
                    end
                2 : begin
                    if ((x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end
                3 : begin
                    if ((x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end
                4 : begin
                    if ((x == 60 || x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end       
                5 : begin
                    if ((x == 60)) begin
                        oled_data <= GREEN;
                    end
                    end         
                6 : begin
                    if ((x == 60)) begin
                        oled_data <= GREEN;
                    end
                    end     
                7 : begin
                    if ((x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end         
                8 : begin
                    if ((x == 60 || x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end         
                9 : begin
                    if ((x == 60 || x == 62)) begin
                        oled_data <= GREEN;
                    end
                    end                                          
            endcase
        end        
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
        else if (y == 19) begin
    case (sec0_cases)
        0 : begin
            if ((x == 76 || x == 78)) begin
                oled_data <= GREEN;
            end
            end
        1 : begin
            if ((x == 77)) begin
                oled_data <= GREEN;
            end
            end
        2 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end
        3 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end
        4 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end       
        5 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end         
        6 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end     
        7 : begin
            if ((x == 78)) begin
                oled_data <= GREEN;
            end
            end         
        8 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end         
        9 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end                                          
    endcase
    case (sec1_cases)
        0 : begin
            if ((x == 71 || x == 73)) begin
                oled_data <= GREEN;
            end
            end
        1 : begin
            if ((x == 72)) begin
                oled_data <= GREEN;
            end
            end
        2 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end
        3 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end
        4 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end       
        5 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end         
        6 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end     
        7 : begin
            if ((x == 73)) begin
                oled_data <= GREEN;
            end
            end         
        8 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end         
        9 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end                                          
    endcase
    case (min0_cases)
        0 : begin
            if ((x == 65 || x == 67)) begin
                oled_data <= GREEN;
            end
            end
        1 : begin
            if ((x == 66)) begin
                oled_data <= GREEN;
            end
            end
        2 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end
        3 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end
        4 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end       
        5 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end         
        6 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end     
        7 : begin
            if ((x == 67)) begin
                oled_data <= GREEN;
            end
            end         
        8 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end         
        9 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end                                          
    endcase
    case (min1_cases)
        0 : begin
            if ((x == 60 ||x == 62)) begin
                oled_data <= GREEN;
            end
            end
        1 : begin
            if ((x == 61)) begin
                oled_data <= GREEN;
            end
            end
        2 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end
        3 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end
        4 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end       
        5 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end         
        6 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end     
        7 : begin
            if ((x == 62)) begin
                oled_data <= GREEN;
            end
            end         
        8 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end         
        9 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end                                          
    endcase
end
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
        else if (y == 20) begin
    case (sec0_cases)
        0 : begin
            if ((x == 76 || x == 78)) begin
                oled_data <= GREEN;
            end
            end
        1 : begin
            if ((x == 77)) begin
                oled_data <= GREEN;
            end
            end
        2 : begin
            if ((x == 76 )) begin
                oled_data <= GREEN;
            end
            end
        3 : begin
            if ((x == 78)) begin
                oled_data <= GREEN;
            end
            end
        4 : begin
            if ((x == 78)) begin
                oled_data <= GREEN;
            end
            end       
        5 : begin
            if ((x == 78)) begin
                oled_data <= GREEN;
            end
            end         
        6 : begin
            if ((x == 76 ||x == 78)) begin
                oled_data <= GREEN;
            end
            end     
        7 : begin
            if ((x == 78)) begin
                oled_data <= GREEN;
            end
            end         
        8 : begin
            if ((x == 76 ||x == 78)) begin
                oled_data <= GREEN;
            end
            end         
        9 : begin
            if ((x == 78)) begin
                oled_data <= GREEN;
            end
            end                                          
    endcase
    case (sec1_cases)
        0 : begin
            if ((x == 71 ||x == 73)) begin
                oled_data <= GREEN;
            end
            end
        1 : begin
            if ((x == 72)) begin
                oled_data <= GREEN;
            end
            end
        2 : begin
            if ((x == 71 )) begin
                oled_data <= GREEN;
            end
            end
        3 : begin
            if ((x == 73)) begin
                oled_data <= GREEN;
            end
            end
        4 : begin
            if ((x == 73)) begin
                oled_data <= GREEN;
            end
            end       
        5 : begin
            if ((x == 73)) begin
                oled_data <= GREEN;
            end
            end         
        6 : begin
            if ((x == 71 || x == 73)) begin
                oled_data <= GREEN;
            end
            end     
        7 : begin
            if ((x == 73)) begin
                oled_data <= GREEN;
            end
            end         
        8 : begin
            if ((x == 71 ||x == 73)) begin
                oled_data <= GREEN;
            end
            end         
        9 : begin
            if ((x == 73)) begin
                oled_data <= GREEN;
            end
            end                                          
    endcase
    case (min0_cases)
        0 : begin
            if ((x == 65 ||x == 67)) begin
                oled_data <= GREEN;
            end
            end
        1 : begin
            if ((x == 66)) begin
                oled_data <= GREEN;
            end
            end
        2 : begin
            if ((x == 65 )) begin
                oled_data <= GREEN;
            end
            end
        3 : begin
            if ((x == 67)) begin
                oled_data <= GREEN;
            end
            end
        4 : begin
            if ((x == 67)) begin
                oled_data <= GREEN;
            end
            end       
        5 : begin
            if ((x == 67)) begin
                oled_data <= GREEN;
            end
            end         
        6 : begin
            if ((x == 65 || x == 67)) begin
                oled_data <= GREEN;
            end
            end     
        7 : begin
            if ((x == 67)) begin
                oled_data <= GREEN;
            end
            end         
        8 : begin
            if ((x == 65 ||x == 67)) begin
                oled_data <= GREEN;
            end
            end         
        9 : begin
            if ((x == 67)) begin
                oled_data <= GREEN;
            end
            end                                          
    endcase
    case (min1_cases)
        0 : begin
            if ((x == 60 ||x == 62)) begin
                oled_data <= GREEN;
            end
            end
        1 : begin
            if ((x == 61)) begin
                oled_data <= GREEN;
            end
            end
        2 : begin
            if ((x == 60 )) begin
                oled_data <= GREEN;
            end
            end
        3 : begin
            if ((x == 62)) begin
                oled_data <= GREEN;
            end
            end
        4 : begin
            if ((x == 62)) begin
                oled_data <= GREEN;
            end
            end       
        5 : begin
            if ((x == 62)) begin
                oled_data <= GREEN;
            end
            end         
        6 : begin
            if ((x == 60 ||x == 62)) begin
                oled_data <= GREEN;
            end
            end     
        7 : begin
            if ((x == 62)) begin
                oled_data <= GREEN;
            end
            end         
        8 : begin
            if ((x == 60 || x == 62)) begin
                oled_data <= GREEN;
            end
            end         
        9 : begin
            if ((x == 62)) begin
                oled_data <= GREEN;
            end
            end                                          
    endcase
end
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
//------------------------------------------------------------------------------------------------
        else if (y == 21) begin
    case (sec0_cases)
        0 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end
        1 : begin
            if ((x == 77)) begin
                oled_data <= GREEN;
            end
            end
        2 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end
        3 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end
        4 : begin
            if ((x == 78)) begin
                oled_data <= GREEN;
            end
            end       
        5 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end         
        6 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end     
        7 : begin
            if ((x == 78)) begin
                oled_data <= GREEN;
            end
            end         
        8 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end         
        9 : begin
            if ((x == 76 || x == 77 || x == 78)) begin
                oled_data <= GREEN;
            end
            end                                          
    endcase
    case (sec1_cases)
        0 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end
        1 : begin
            if ((x == 72)) begin
                oled_data <= GREEN;
            end
            end
        2 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end
        3 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end
        4 : begin
            if ((x == 73)) begin
                oled_data <= GREEN;
            end
            end       
        5 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end         
        6 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end     
        7 : begin
            if ((x == 73)) begin
                oled_data <= GREEN;
            end
            end         
        8 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end         
        9 : begin
            if ((x == 71 || x == 72 || x == 73)) begin
                oled_data <= GREEN;
            end
            end                                          
    endcase
    case (min0_cases)
        0 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end
        1 : begin
            if ((x == 66)) begin
                oled_data <= GREEN;
            end
            end
        2 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end
        3 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end
        4 : begin
            if ((x == 67)) begin
                oled_data <= GREEN;
            end
            end       
        5 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end         
        6 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end     
        7 : begin
            if ((x == 67)) begin
                oled_data <= GREEN;
            end
            end         
        8 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end         
        9 : begin
            if ((x == 65 || x == 66 || x == 67)) begin
                oled_data <= GREEN;
            end
            end                                          
    endcase
    case (min1_cases)
        0 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end
        1 : begin
            if ((x == 61)) begin
                oled_data <= GREEN;
            end
            end
        2 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end
        3 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end
        4 : begin
            if ((x == 62)) begin
                oled_data <= GREEN;
            end
            end       
        5 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end         
        6 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end     
        7 : begin
            if ((x == 62)) begin
                oled_data <= GREEN;
            end
            end         
        8 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end         
        9 : begin
            if ((x == 60 || x == 61 || x == 62)) begin
                oled_data <= GREEN;
            end
            end                                          
    endcase
end
    else
        oled_data <= 0;

    end
            
    
endmodule
