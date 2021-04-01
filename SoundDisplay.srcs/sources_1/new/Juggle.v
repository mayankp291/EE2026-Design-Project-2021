`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 25.03.2021 19:38:12
// Design Name: 
// Module Name: Juggle
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


module Juggle(
    input [3:0] volume_level,
    input jug_speed,
    input clk381hz,
    input clk6p25m,
    input btnL_press_10hz,
    input btnR_press_10hz,
    
    input btnC_press_10hz,
    input sw2,
    input sw3,
    input [6:0]x,
    input [5:0]y,
    input [3:0] flag,
    output reg [15:0]oled_data  
    );
    
    integer subpath;
    integer subpath2;
    //rng q1 (clk10hz, subpath); 
    
    reg [1:0] subpath_r;
    reg [1:0] subpath_r2;
    reg [15:0] RED = 16'hF800, GREEN = 16'h07E0, YELLOW = 16'hFFE0;
    reg [15:0] BLUE = 16'h30BD, PINK = 16'hC8BD, ORANGE = 16'hED02;
    reg [15:0] LBLUE = 16'h175A, LGREEN = 16'h7F42;
    
    reg [1:0] hand1;
    reg [1:0] hand2;
    
    reg [6:0] ballonex;
    reg [5:0] balloney;
    
    reg [6:0] balltwox;
    reg [5:0] balltwoy;
    reg [3:0] pathf1;
    reg [3:0] pathf2;
    
    reg defeated;
    
    integer score;
 
    initial begin 
        hand1 <= 2'd0;
        hand2 <= 2'd0;
        ballonex <= 7'd34;
        balloney <= 6'd34;
        balltwox <= 7'd58;
        balltwoy <= 6'd34;
        pathf1 <= 4'd0;
        pathf2 <= 4'd3;
        subpath_r <= 2'd1;
        subpath_r2 <= 2'd2;
        subpath = 1;
        subpath2 = 1;
        defeated <= 0;
        score = 0;   
    end
    
    

    
    always @ (posedge jug_speed) begin
    if (flag == 4'd3) begin
        if (btnC_press_10hz == 1)
                defeated <= 0;
    
        if (defeated == 1) begin
    hand1 <= 2'd0;
    hand2 <= 2'd0;
    ballonex <= 7'd34;
    balloney <= 6'd34;
    balltwox <= 7'd58;
    balltwoy <= 6'd34;
    pathf1 <= 4'd0;
    pathf2 <= 4'd3;
    subpath_r <= 2'd1;
    subpath_r2 <= 2'd2;
    subpath = 1;
    subpath2 = 1;
    score = 0;
            
    end  

           
        
        
        if (sw3 == 1 && defeated == 0) begin
        
        if (sw2 == 1 && volume_level >= 4'd4) begin
            if ((hand2 >= 0 && hand2 <= 1))
                hand2 <= hand2 + 1;
            else if (hand2 == 2)
                hand2 <= 0;    
        end
             
            
        
//        subpath <= { subpath[2:0], ~(subpath[2]^subpath[3]) } ;

        if (btnL_press_10hz == 1 && (hand1 >= 0 && hand1 <= 1))
            hand1 <= hand1 + 1;
        else if (btnL_press_10hz == 1 && hand1 == 2)
            hand1 <= 0;
        if (sw2 == 0) begin
        if (btnR_press_10hz == 1 && (hand2 >= 0 && hand2 <= 1))
            hand2 <= hand2 + 1;
        else if (btnR_press_10hz == 1 && hand2 == 2)
            hand2 <= 0;    
        end  

if (balloney ==34) begin
if (balloney == 34 && ((ballonex == 18 && hand1 ==2) || (ballonex == 26 && hand1 ==1) || (ballonex == 34 && hand1 ==0) || (ballonex == 58 && hand2 ==0) || (ballonex == 66 && hand2 ==1) || (ballonex == 74 && hand2 ==2))) begin
 defeated <= 0;
 score = score + 1;
end
else
 defeated <= 1;
end

if (balltwoy == 34) begin
if (balltwoy == 34 && ((balltwox == 18 && hand1 ==2) || (balltwox == 26 && hand1 ==1) || (balltwox == 34 && hand1 ==0) || (balltwox == 58 && hand2 ==0) || (balltwox == 66 && hand2 ==1) || (balltwox == 74 && hand2 ==2))) begin
 defeated <= 0;
 score = score + 1;
end
else
 defeated <= 1; 
end

   

        if (balloney == 34 && ballonex == 34) begin
            pathf1 <= 4'd0;
//            if (subpath <= 4'd5)
//                subpath_r <= 2'd0;
//            else if (subpath <= 4'd10)
//                subpath_r <= 2'd1;
//            else 
//                subpath_r <= 2'd2;
            subpath = (subpath * 3 + 1) % 16;
        end
            
       
        if (pathf1 == 4'd0) begin
            if (subpath <= 4'd5) begin
            if (balloney >= 19 && ballonex == 34)
                balloney <= balloney - 1;
            else if (balloney <= 18 && balloney >= 14 && ballonex >= 34 && ballonex <= 38) begin
                balloney <= balloney -1;
                ballonex <= ballonex + 1;
            end
            else if (balloney == 13 && ballonex >= 39 && ballonex <= 44)
                ballonex <= ballonex + 1;
                
            else if (balloney >= 13 && balloney <= 25 && ballonex >= 45 && ballonex <= 57)begin
                balloney <= balloney + 1;
                ballonex <= ballonex + 1;
            end
            else if (balloney >= 26 && balloney <= 33 && ballonex == 58)
                balloney <= balloney + 1;
            end
            //---------------------------------------subpath 1---------
            else if (subpath <= 4'd10) begin
            if (balloney >= 19 && ballonex == 34)
                balloney <= balloney - 1;
            else if (balloney <= 18 && balloney >= 10 && ballonex >= 34 && ballonex <= 42) begin
                balloney <= balloney -1;
                ballonex <= ballonex + 1;
            end
            else if (balloney == 9 && ballonex >= 43 && ballonex <= 49)
                ballonex <= ballonex + 1;
                
            else if (balloney >= 9 && balloney <= 24 && ballonex >= 50 && ballonex <= 65)begin
                balloney <= balloney + 2;//////////chg
                ballonex <= ballonex + 2;/////////////////chg
            end
            else if (balloney >= 25 && balloney <= 33 && ballonex == 66)
                balloney <= balloney + 1;
            end
            //---------------------------------subpath 0------------------------------------
            else begin
            if (balloney >= 19 && ballonex == 34)
                balloney <= balloney - 2;//////chg
            else if (balloney <= 18 && balloney >= 10 && ballonex >= 34 && ballonex <= 42) begin
                balloney <= balloney -1;
                ballonex <= ballonex + 1;
            end
            else if (balloney == 9 && ballonex >= 43 && ballonex <= 57)
                ballonex <= ballonex + 1;
                
            else if (balloney >= 9 && balloney <= 24 && ballonex >= 58 && ballonex <= 73)begin
                balloney <= balloney + 2;///////chg
                ballonex <= ballonex + 2;///////chg
            end
            else if (balloney >= 25 && balloney <= 33 && ballonex == 74)
                balloney <= balloney + 1;
            end
            //-------------------------------------suboath 2            
        end
        //-------------------------path 0--------------
        if (balloney == 34 && ballonex == 26) begin
            pathf1 <= 4'd1;
//            if (subpath <= 4'd5)
//                subpath_r <= 2'd0;
//            else if (subpath <= 4'd10)
//                subpath_r <= 2'd1;
//            else 
//                subpath_r <= 2'd2;
 subpath = (subpath * 4 + 2) % 16;
                
        end
        if (pathf1 == 4'd1) begin
            if (subpath <= 4'd5) begin
            if (balloney >= 19 && ballonex == 26)
                balloney <= balloney - 1; 
            else if (balloney <= 18 && balloney >= 10 && ballonex >= 26 && ballonex <= 34) begin
                balloney <= balloney -2;
                ballonex <= ballonex + 2;
            end
            else if (balloney == 8 && ballonex >= 35 && ballonex <= 55)
                ballonex <= ballonex + 2;
                     
            else if (balloney >= 8 && balloney <= 18 && ballonex >= 56 && ballonex <= 65)begin
                balloney <= balloney + 2;
                ballonex <= ballonex + 2;
            end
            else if (balloney >= 18 && balloney <= 33 && ballonex == 66)
                balloney <= balloney + 1;
            end
            //---------------------------------subpath 1---------------------------------
            else if (subpath <= 4'd10) begin
            if (balloney >= 19 && ballonex == 26)
                balloney <= balloney - 1;
            else if (balloney <= 18 && balloney >= 10 && ballonex >= 26 && ballonex <= 34) begin
                balloney <= balloney -2;
                ballonex <= ballonex + 2;
            end
            else if (balloney == 8 && ballonex >= 36 && ballonex <= 57)
                ballonex <= ballonex + 2;
                    
            else if (balloney >= 8 && balloney <= 23 && ballonex >= 58 && ballonex <= 73)begin
                balloney <= balloney + 2;
                ballonex <= ballonex + 2;
            end
            else if (balloney >= 24 && balloney <= 33 && ballonex == 74)
                balloney <= balloney + 1;
            end      
            //---------------------------subpath 0-------------------------------------
            else begin
            if (balloney >= 19 && ballonex == 26)
                balloney <= balloney - 1;
            else if (balloney <= 18 && balloney >= 10 && ballonex >= 26 && ballonex <= 34) begin
                balloney <= balloney -2;
                ballonex <= ballonex + 2;
            end
            else if (balloney == 8 && ballonex >= 35 && ballonex <= 42)
                ballonex <= ballonex + 2;
                    
            else if (balloney >= 8 && balloney <= 23 && ballonex >= 43 && ballonex <= 57)begin
                balloney <= balloney + 1;
                ballonex <= ballonex + 1;
            end
            else if (balloney >= 22 && balloney <= 33 && ballonex == 58)
                balloney <= balloney + 1;
            end      
            //------------------------------subpath 2------------------------            
        end
        
        //-----------------------path 1 ------------------------------------
        if (balloney == 34 && ballonex == 18) begin
            pathf1 <= 4'd2;
//            if (subpath <= 4'd5)
//                subpath_r <= 2'd0;
//            else if (subpath <= 4'd10)
//                subpath_r <= 2'd1;
//            else 
//                subpath_r <= 2'd2;
 subpath = (subpath * 3 + 3) % 16;
        end
        
        if (pathf1 == 4'd2) begin
            if (subpath <= 4'd5) begin
            if (balloney >= 29 && ballonex == 18)
                balloney <= balloney - 2;
            else if (balloney <= 28 && balloney >= 9 && ballonex >= 18 && ballonex <= 37) begin
                balloney <= balloney -1;
                ballonex <= ballonex + 1;
            end
            else if (balloney == 8 && ballonex >= 38 && ballonex <= 55)
                ballonex <= ballonex + 2;
                            
            else if (balloney >= 8 && balloney <= 25 && ballonex >= 56 && ballonex <= 73)begin
                balloney <= balloney + 2;
                ballonex <= ballonex + 2;
            end
            else if (balloney >= 26 && balloney <= 33 && ballonex == 74)
                balloney <= balloney + 1;
            end
            //------------------------------sub path 0----------------------------------
            else if (subpath <= 4'd10) begin
            if (balloney >= 29 && ballonex == 18)
                balloney <= balloney - 1;
            else if (balloney <= 28 && balloney >= 9 && ballonex >= 18 && ballonex <= 37) begin
                balloney <= balloney -1;
                ballonex <= ballonex + 1;
            end
            else if (balloney == 8 && ballonex >= 38 && ballonex <= 47)
                ballonex <= ballonex + 2;
                            
            else if (balloney >= 8 && balloney <= 25 && ballonex >= 48 && ballonex <= 65)begin
                balloney <= balloney + 2;
                ballonex <= ballonex + 2;
            end
            else if (balloney >= 26 && balloney <= 33 && ballonex == 66)
                balloney <= balloney + 1;
            end            
            //-----------------------subpath 1---------------------------------
            else begin
            if (balloney >= 29 && ballonex == 18)
                balloney <= balloney - 1;
            else if (balloney <= 28 && balloney >= 9 && ballonex >= 18 && ballonex <= 37) begin
                balloney <= balloney -1;
                ballonex <= ballonex + 1;
            end
            else if (balloney == 8 && ballonex >= 38 && ballonex <= 47)
                ballonex <= ballonex + 2;
                            
            else if (balloney >= 8 && balloney <= 17 && ballonex >= 48 && ballonex <= 57)begin
                balloney <= balloney + 1;
                ballonex <= ballonex + 1;
            end
            else if (balloney >= 18 && balloney <= 33 && ballonex == 58)
                balloney <= balloney + 1;
            end                   
            //-------------------------------------subpath 2---------------------     
        end
        //--------------------------path 2 -------------------------------------------------
        if (balloney == 34 && ballonex == 58) begin
            pathf1 <= 4'd3;
//            if (subpath <= 4'd5)
//                subpath_r <= 2'd0;
//            else if (subpath <= 4'd10)
//                subpath_r <= 2'd1;
//            else 
//                subpath_r <= 2'd2;
 subpath = (subpath * 5 + 4) % 16;

        end
                
        if (pathf1 == 4'd3) begin
            if (subpath <= 4'd5) begin
            if (balloney >= 19 && ballonex == 58)
                balloney <= balloney - 1;
            else if (balloney <= 18 && balloney >= 14 && ballonex <= 58 && ballonex >= 54) begin
                balloney <= balloney -1;
                ballonex <= ballonex - 1;
            end
            else if (balloney == 13 && ballonex <= 53 && ballonex >= 47)
                ballonex <= ballonex - 1;
                    
            else if (balloney >= 13 && balloney <= 24 && ballonex <= 46 && ballonex >= 35)begin
                balloney <= balloney + 1;
                ballonex <= ballonex - 1;
            end
            else if (balloney >= 25 && balloney <= 33 && ballonex == 34)
                balloney <= balloney + 1;
            end
            //-------------------subpath 1--------------
            else if (subpath <= 4'd10) begin
            if (balloney >= 19 && ballonex == 58)
                balloney <= balloney - 2;
            else if (balloney <= 18 && balloney >= 14 && ballonex <= 58 && ballonex >= 54) begin
                balloney <= balloney -1;
                ballonex <= ballonex - 1;
            end
            else if (balloney == 13 && ballonex <= 53 && ballonex >= 39)
                ballonex <= ballonex - 1;
                    
            else if (balloney >= 13 && balloney <= 24 && ballonex <= 38 && ballonex >= 27)begin
                balloney <= balloney + 1;
                ballonex <= ballonex - 1;
            end
            else if (balloney >= 25 && balloney <= 33 && ballonex == 26)
                balloney <= balloney + 1;
            end
            //-------------------------------subpath 0---------------------------------
            else begin
            if (balloney >= 19 && ballonex == 58)
                balloney <= balloney - 1;
            else if (balloney <= 18 && balloney >= 13 && ballonex <= 58 && ballonex >= 53) begin
                balloney <= balloney -1;
                ballonex <= ballonex - 1;
            end
            else if (balloney == 12 && ballonex <= 52 && ballonex >= 32)
                ballonex <= ballonex - 2;
                    
            else if (balloney >= 12 && balloney <= 22 && ballonex <= 30 && ballonex >= 20)begin
                balloney <= balloney + 2;
                ballonex <= ballonex - 2;
            end
            else if (balloney >= 24 && balloney <= 33 && ballonex == 18)
                balloney <= balloney + 1;
            end         
            //------------------------------subpath 2----------------------------
        end
        //--------------------------------path 3-------------------------------------------      
        if (balloney == 34 && ballonex == 66) begin
            pathf1 <= 4'd4;
//            if (subpath <= 4'd5)
//                subpath_r <= 2'd0;
//            else if (subpath <= 4'd10)
//                subpath_r <= 2'd1;
//            else 
//                subpath_r <= 2'd2;
 subpath = (subpath * 6 + 1) % 16;
        end
                
        if (pathf1 == 4'd4) begin
            if (subpath <= 4'd5) begin
            if (balloney >= 19 && ballonex == 66)
                balloney <= balloney - 2;
            else if (balloney <= 18 && balloney >= 10 && ballonex <= 66 && ballonex >= 58) begin
                balloney <= balloney -1;
                ballonex <= ballonex - 1;
            end
            else if (balloney == 9 && ballonex <= 57 && ballonex >= 51)
                ballonex <= ballonex - 1;
                    
            else if (balloney >= 9 && balloney <= 24 && ballonex <= 50 && ballonex >= 35)begin
                balloney <= balloney + 1;
                ballonex <= ballonex - 1;
            end
            else if (balloney >= 25 && balloney <= 33 && ballonex == 34)
                balloney <= balloney + 1;
            end
            //-------------------subpath 0--------------
            else if (subpath <= 4'd10) begin
            if (balloney >= 19 && ballonex == 66)
                balloney <= balloney - 2;
            else if (balloney <= 18 && balloney >= 14 && ballonex <= 66 && ballonex >= 62) begin
                balloney <= balloney -2;
                ballonex <= ballonex - 2;
            end
            else if (balloney == 12 && ballonex <= 61 && ballonex >= 39)
                ballonex <= ballonex - 1;
                    
            else if (balloney >= 12 && balloney <= 24 && ballonex <= 38 && ballonex >= 27)begin
                balloney <= balloney + 2;
                ballonex <= ballonex - 2;
            end
            else if (balloney >= 24 && balloney <= 33 && ballonex == 26)
                balloney <= balloney + 1;
            end
            //-------------------------------subpath 1---------------------------------
            else begin
            if (balloney >= 19 && ballonex == 66)
                balloney <= balloney - 1;
            else if (balloney <= 18 && balloney >= 9 && ballonex <= 66 && ballonex >= 57) begin
                balloney <= balloney -2;
                ballonex <= ballonex - 2;
            end
            else if (balloney == 8 && ballonex <= 56 && ballonex >= 36)
                ballonex <= ballonex - 2;
                    
            else if (balloney >= 8 && balloney <= 24 && ballonex <= 35 && ballonex >= 19)begin
                balloney <= balloney + 2;
                ballonex <= ballonex - 2;
            end
            else if (balloney >= 24 && balloney <= 33 && ballonex == 18)
                balloney <= balloney + 1;
            end         
            //------------------------------subpath 2----------------------------
        end
        //--------------------------------path 4-------------------------------------------    
        if (balloney == 34 && ballonex == 74) begin
            pathf1 <= 4'd5;
//            if (subpath <= 4'd5)
//                subpath_r <= 2'd0;
//            else if (subpath <= 4'd10)
//                subpath_r <= 2'd1;
//            else 
//                subpath_r <= 2'd2;
 subpath = (subpath * 7 + 1) % 16;
        end
                
        if (pathf1 == 4'd5) begin
            if (subpath <= 4'd5) begin
            if (balloney >= 19 && ballonex == 74)
                balloney <= balloney - 2;
            else if (balloney <= 18 && balloney >= 14 && ballonex <= 74 && ballonex >= 70) begin
                balloney <= balloney -2;
                ballonex <= ballonex - 2;
            end
            else if (balloney == 12 && ballonex <= 68 && ballonex >= 47)
                ballonex <= ballonex - 1;
                    
            else if (balloney >= 12 && balloney <= 24 && ballonex <= 46 && ballonex >= 35)begin
                balloney <= balloney + 2;
                ballonex <= ballonex - 2;
            end
            else if (balloney >= 24 && balloney <= 33 && ballonex == 34)
                balloney <= balloney + 1;
            end
            //-------------------subpath 0--------------
            else if (subpath <= 4'd10) begin
            if (balloney >= 19 && ballonex == 74)
                balloney <= balloney - 1;
            else if (balloney <= 18 && balloney >= 10 && ballonex <= 74 && ballonex >= 66) begin
                balloney <= balloney -2;
                ballonex <= ballonex - 2;
            end
            else if (balloney == 8 && ballonex <= 64 && ballonex >= 44)
                ballonex <= ballonex - 2;
                    
            else if (balloney >= 8 && balloney <= 22 && ballonex <= 42 && ballonex >= 28)begin
                balloney <= balloney + 2;
                ballonex <= ballonex - 2;
            end
            else if (balloney >= 24 && balloney <= 33 && ballonex == 26)
                balloney <= balloney + 1;
            end
            //-------------------------------subpath 1---------------------------------
            else begin
            if (balloney >= 19 && ballonex == 74)
                balloney <= balloney - 2;
            else if (balloney <= 18 && balloney >= 13 && ballonex <= 74 && ballonex >= 69) begin
                balloney <= balloney -  1;
                ballonex <= ballonex - 1;
            end
            else if (balloney == 12 && ballonex <= 68 && ballonex >= 31)
                ballonex <= ballonex - 2;
                    
            else if (balloney >= 12 && balloney <= 24 && ballonex <= 30 && ballonex >= 19)begin
                balloney <= balloney + 2;
                ballonex <= ballonex - 2;
            end
            else if (balloney >= 24 && balloney <= 33 && ballonex == 18)
                balloney <= balloney + 1;
            end         
            //------------------------------subpath 2----------------------------
        end
        //--------------------------------path 5-------------------------------------------   
        
        
        
        
        
        
        //-------------------------------------------------balltwo-----------------
                if (balltwoy == 34 && balltwox == 34) begin
            pathf2 <= 4'd0;
//            if (subpath <= 4'd5)
//                subpath_r2 <= 2'd0;
//            else if (subpath <= 4'd10)
//                subpath_r2 <= 2'd1;
//            else 
//                subpath_r2 <= 2'd2;
subpath2 = (subpath2 * 3 + 4) % 16;
        end
            
       
        if (pathf2 == 4'd0) begin
            if (subpath2 <= 4'd5) begin
            if (balltwoy >= 19 && balltwox == 34)
                balltwoy <= balltwoy - 1;
            else if (balltwoy <= 18 && balltwoy >= 14 && balltwox >= 34 && balltwox <= 38) begin
                balltwoy <= balltwoy -1;
                balltwox <= balltwox + 1;
            end
            else if (balltwoy == 13 && balltwox >= 39 && balltwox <= 45)
                balltwox <= balltwox + 1;
                
            else if (balltwoy >= 13 && balltwoy <= 24 && balltwox >= 46 && balltwox <= 57)begin
                balltwoy <= balltwoy + 1;
                balltwox <= balltwox + 1;
            end
            else if (balltwoy >= 25 && balltwoy <= 33 && balltwox == 58)
                balltwoy <= balltwoy + 1;
            end
            //---------------------------------------subpath 1---------
            else if (subpath2 <= 4'd10) begin
            if (balltwoy >= 19 && balltwox == 34)
                balltwoy <= balltwoy - 1;
            else if (balltwoy <= 18 && balltwoy >= 10 && balltwox >= 34 && balltwox <= 42) begin
                balltwoy <= balltwoy -1;
                balltwox <= balltwox + 1;
            end
            else if (balltwoy == 9 && balltwox >= 43 && balltwox <= 49)
                balltwox <= balltwox + 1;
                
            else if (balltwoy >= 9 && balltwoy <= 24 && balltwox >= 50 && balltwox <= 65)begin
                balltwoy <= balltwoy + 2;//////////chg
                balltwox <= balltwox + 2;/////////////////chg
            end
            else if (balltwoy >= 25 && balltwoy <= 33 && balltwox == 66)
                balltwoy <= balltwoy + 1;
            end
            //---------------------------------subpath 0------------------------------------
            else begin
            if (balltwoy >= 19 && balltwox == 34)
                balltwoy <= balltwoy - 2;//////chg
            else if (balltwoy <= 18 && balltwoy >= 10 && balltwox >= 34 && balltwox <= 42) begin
                balltwoy <= balltwoy -1;
                balltwox <= balltwox + 1;
            end
            else if (balltwoy == 9 && balltwox >= 43 && balltwox <= 57)
                balltwox <= balltwox + 1;
                
            else if (balltwoy >= 9 && balltwoy <= 24 && balltwox >= 58 && balltwox <= 73)begin
                balltwoy <= balltwoy + 2;///////chg
                balltwox <= balltwox + 2;///////chg
            end
            else if (balltwoy >= 25 && balltwoy <= 33 && balltwox == 74)
                balltwoy <= balltwoy + 1;
            end
            //-------------------------------------suboath 2            
        end
        //-------------------------path 0--------------
        if (balltwoy == 34 && balltwox == 26) begin
            pathf2 <= 4'd1;
//            if (subpath <= 4'd5)
//                subpath_r2 <= 2'd0;
//            else if (subpath <= 4'd10)
//                subpath_r2 <= 2'd1;
//            else 
//                subpath_r2 <= 2'd2;
                subpath2 = (subpath2 * 3 + 1) % 16;
        end
        if (pathf2 == 4'd1) begin
            if (subpath2 <= 4'd5) begin
            if (balltwoy >= 19 && balltwox == 26)
                balltwoy <= balltwoy - 1; 
            else if (balltwoy <= 18 && balltwoy >= 10 && balltwox >= 26 && balltwox <= 34) begin
                balltwoy <= balltwoy -2;
                balltwox <= balltwox + 2;
            end
            else if (balltwoy == 8 && balltwox >= 35 && balltwox <= 55)
                balltwox <= balltwox + 2;
                     
            else if (balltwoy >= 8 && balltwoy <= 18 && balltwox >= 56 && balltwox <= 65)begin
                balltwoy <= balltwoy + 2;
                balltwox <= balltwox + 2;
            end
            else if (balltwoy >= 18 && balltwoy <= 33 && balltwox == 66)
                balltwoy <= balltwoy + 1;
            end
            //---------------------------------subpath 1---------------------------------
            else if (subpath2 <= 4'd10) begin
            if (balltwoy >= 19 && balltwox == 26)
                balltwoy <= balltwoy - 1;
            else if (balltwoy <= 18 && balltwoy >= 10 && balltwox >= 26 && balltwox <= 34) begin
                balltwoy <= balltwoy -2;
                balltwox <= balltwox + 2;
            end
            else if (balltwoy == 8 && balltwox >= 36 && balltwox <= 57)
                balltwox <= balltwox + 2;
                    
            else if (balltwoy >= 8 && balltwoy <= 23 && balltwox >= 58 && balltwox <= 73)begin
                balltwoy <= balltwoy + 2;
                balltwox <= balltwox + 2;
            end
            else if (balltwoy >= 24 && balltwoy <= 33 && balltwox == 74)
                balltwoy <= balltwoy + 1;
            end      
            //---------------------------subpath 0-------------------------------------
            else begin
            if (balltwoy >= 19 && balltwox == 26)
                balltwoy <= balltwoy - 1;
            else if (balltwoy <= 18 && balltwoy >= 10 && balltwox >= 26 && balltwox <= 34) begin
                balltwoy <= balltwoy -2;
                balltwox <= balltwox + 2;
            end
            else if (balltwoy == 8 && balltwox >= 35 && balltwox <= 42)
                balltwox <= balltwox + 2;
                    
            else if (balltwoy >= 8 && balltwoy <= 23 && balltwox >= 43 && balltwox <= 57)begin
                balltwoy <= balltwoy + 1;
                balltwox <= balltwox + 1;
            end
            else if (balltwoy >= 22 && balltwoy <= 33 && balltwox == 58)
                balltwoy <= balltwoy + 1;
            end      
            //------------------------------subpath 2------------------------            
        end
        
        //-----------------------path 1 ------------------------------------
        if (balltwoy == 34 && balltwox == 18) begin
            pathf2 <= 4'd2;
//            if (subpath <= 4'd5)
//                subpath_r2 <= 2'd0;
//            else if (subpath <= 4'd10)
//                subpath_r2 <= 2'd1;
//            else 
//                subpath_r2 <= 2'd2;
subpath2 = (subpath2 * 5 + 2) % 16;
        end
        
        if (pathf2 == 4'd2) begin
            if (subpath2 <= 4'd5) begin
            if (balltwoy >= 29 && balltwox == 18)
                balltwoy <= balltwoy - 2;
            else if (balltwoy <= 28 && balltwoy >= 9 && balltwox >= 18 && balltwox <= 37) begin
                balltwoy <= balltwoy -1;
                balltwox <= balltwox + 1;
            end
            else if (balltwoy == 8 && balltwox >= 38 && balltwox <= 55)
                balltwox <= balltwox + 2;
                            
            else if (balltwoy >= 8 && balltwoy <= 25 && balltwox >= 56 && balltwox <= 73)begin
                balltwoy <= balltwoy + 2;
                balltwox <= balltwox + 2;
            end
            else if (balltwoy >= 26 && balltwoy <= 33 && balltwox == 74)
                balltwoy <= balltwoy + 1;
            end
            //------------------------------sub path 0----------------------------------
            else if (subpath2 <= 4'd10) begin
            if (balltwoy >= 29 && balltwox == 18)
                balltwoy <= balltwoy - 1;
            else if (balltwoy <= 28 && balltwoy >= 9 && balltwox >= 18 && balltwox <= 37) begin
                balltwoy <= balltwoy -1;
                balltwox <= balltwox + 1;
            end
            else if (balltwoy == 8 && balltwox >= 38 && balltwox <= 47)
                balltwox <= balltwox + 2;
                            
            else if (balltwoy >= 8 && balltwoy <= 25 && balltwox >= 48 && balltwox <= 65)begin
                balltwoy <= balltwoy + 2;
                balltwox <= balltwox + 2;
            end
            else if (balltwoy >= 26 && balltwoy <= 33 && balltwox == 66)
                balltwoy <= balltwoy + 1;
            end            
            //-----------------------subpath 1---------------------------------
            else begin
            if (balltwoy >= 29 && balltwox == 18)
                balltwoy <= balltwoy - 1;
            else if (balltwoy <= 28 && balltwoy >= 9 && balltwox >= 18 && balltwox <= 37) begin
                balltwoy <= balltwoy -1;
                balltwox <= balltwox + 1;
            end
            else if (balltwoy == 8 && balltwox >= 38 && balltwox <= 47)
                balltwox <= balltwox + 2;
                            
            else if (balltwoy >= 8 && balltwoy <= 17 && balltwox >= 48 && balltwox <= 57)begin
                balltwoy <= balltwoy + 1;
                balltwox <= balltwox + 1;
            end
            else if (balltwoy >= 18 && balltwoy <= 33 && balltwox == 58)
                balltwoy <= balltwoy + 1;
            end                   
            //-------------------------------------subpath 2---------------------     
        end
        //--------------------------path 2 -------------------------------------------------
        if (balltwoy == 34 && balltwox == 58) begin
            pathf2 <= 4'd3;
//            if (subpath <= 4'd5)
//                subpath_r2 <= 2'd0;
//            else if (subpath <= 4'd10)
//                subpath_r2 <= 2'd1;
//            else 
//                subpath_r2 <= 2'd2;
subpath2 = (subpath2 * 7 + 4) % 16;
        end
                
        if (pathf2 == 4'd3) begin
            if (subpath2 <= 4'd5) begin
            if (balltwoy >= 19 && balltwox == 58)
                balltwoy <= balltwoy - 1;
            else if (balltwoy <= 18 && balltwoy >= 14 && balltwox <= 58 && balltwox >= 54) begin
                balltwoy <= balltwoy -1;
                balltwox <= balltwox - 1;
            end
            else if (balltwoy == 13 && balltwox <= 53 && balltwox >= 47)
                balltwox <= balltwox - 1;
                    
            else if (balltwoy >= 13 && balltwoy <= 24 && balltwox <= 46 && balltwox >= 35)begin
                balltwoy <= balltwoy + 1;
                balltwox <= balltwox - 1;
            end
            else if (balltwoy >= 25 && balltwoy <= 33 && balltwox == 34)
                balltwoy <= balltwoy + 1;
            end
            //-------------------subpath 1--------------
            else if (subpath2 <= 4'd10) begin
            if (balltwoy >= 19 && balltwox == 58)
                balltwoy <= balltwoy - 2;
            else if (balltwoy <= 18 && balltwoy >= 14 && balltwox <= 58 && balltwox >= 54) begin
                balltwoy <= balltwoy -1;
                balltwox <= balltwox - 1;
            end
            else if (balltwoy == 13 && balltwox <= 53 && balltwox >= 39)
                balltwox <= balltwox - 1;
                    
            else if (balltwoy >= 13 && balltwoy <= 24 && balltwox <= 38 && balltwox >= 27)begin
                balltwoy <= balltwoy + 1;
                balltwox <= balltwox - 1;
            end
            else if (balltwoy >= 25 && balltwoy <= 33 && balltwox == 26)
                balltwoy <= balltwoy + 1;
            end
            //-------------------------------subpath 0---------------------------------
            else begin
            if (balltwoy >= 19 && balltwox == 58)
                balltwoy <= balltwoy - 1;
            else if (balltwoy <= 18 && balltwoy >= 13 && balltwox <= 58 && balltwox >= 53) begin
                balltwoy <= balltwoy -1;
                balltwox <= balltwox - 1;
            end
            else if (balltwoy == 12 && balltwox <= 52 && balltwox >= 32)
                balltwox <= balltwox - 2;
                    
            else if (balltwoy >= 12 && balltwoy <= 22 && balltwox <= 30 && balltwox >= 20)begin
                balltwoy <= balltwoy + 2;
                balltwox <= balltwox - 2;
            end
            else if (balltwoy >= 24 && balltwoy <= 33 && balltwox == 18)
                balltwoy <= balltwoy + 1;
            end         
            //------------------------------subpath 2----------------------------
        end
        //--------------------------------path 3-------------------------------------------      
        if (balltwoy == 34 && balltwox == 66) begin
            pathf2 <= 4'd4;
//            if (subpath <= 4'd5)
//                subpath_r2 <= 2'd0;
//            else if (subpath <= 4'd10)
//                subpath_r2 <= 2'd1;
//            else 
//                subpath_r2 <= 2'd2;
subpath2 = (subpath2 * 1 + 1) % 16;
        end
                
        if (pathf2 == 4'd4) begin
            if (subpath2 <= 4'd5) begin
            if (balltwoy >= 19 && balltwox == 66)
                balltwoy <= balltwoy - 2;
            else if (balltwoy <= 18 && balltwoy >= 10 && balltwox <= 66 && balltwox >= 58) begin
                balltwoy <= balltwoy -1;
                balltwox <= balltwox - 1;
            end
            else if (balltwoy == 9 && balltwox <= 57 && balltwox >= 51)
                balltwox <= balltwox - 1;
                    
            else if (balltwoy >= 9 && balltwoy <= 24 && balltwox <= 50 && balltwox >= 35)begin
                balltwoy <= balltwoy + 1;
                balltwox <= balltwox - 1;
            end
            else if (balltwoy >= 25 && balltwoy <= 33 && balltwox == 34)
                balltwoy <= balltwoy + 1;
            end
            //-------------------subpath 0--------------
            else if (subpath2 <= 4'd10) begin
            if (balltwoy >= 19 && balltwox == 66)
                balltwoy <= balltwoy - 2;
            else if (balltwoy <= 18 && balltwoy >= 14 && balltwox <= 66 && balltwox >= 62) begin
                balltwoy <= balltwoy -2;
                balltwox <= balltwox - 2;
            end
            else if (balltwoy == 12 && balltwox <= 61 && balltwox >= 39)
                balltwox <= balltwox - 1;
                    
            else if (balltwoy >= 12 && balltwoy <= 24 && balltwox <= 38 && balltwox >= 27)begin
                balltwoy <= balltwoy + 2;
                balltwox <= balltwox - 2;
            end
            else if (balltwoy >= 24 && balltwoy <= 33 && balltwox == 26)
                balltwoy <= balltwoy + 1;
            end
            //-------------------------------subpath 1---------------------------------
            else begin
            if (balltwoy >= 19 && balltwox == 66)
                balltwoy <= balltwoy - 1;
            else if (balltwoy <= 18 && balltwoy >= 9 && balltwox <= 66 && balltwox >= 57) begin
                balltwoy <= balltwoy -2;
                balltwox <= balltwox - 2;
            end
            else if (balltwoy == 8 && balltwox <= 56 && balltwox >= 36)
                balltwox <= balltwox - 2;
                    
            else if (balltwoy >= 8 && balltwoy <= 24 && balltwox <= 35 && balltwox >= 19)begin
                balltwoy <= balltwoy + 2;
                balltwox <= balltwox - 2;
            end
            else if (balltwoy >= 24 && balltwoy <= 33 && balltwox == 18)
                balltwoy <= balltwoy + 1;
            end         
            //------------------------------subpath 2----------------------------
        end
        //--------------------------------path 4-------------------------------------------    
        if (balltwoy == 34 && balltwox == 74) begin
            pathf2 <= 4'd5;
//            if (subpath <= 4'd5)
//                subpath_r2 <= 2'd0;
//            else if (subpath <= 4'd10)
//                subpath_r2 <= 2'd1;
//            else 
//                subpath_r2 <= 2'd2;
subpath2 = (subpath2 * 3 + 7) % 16;
        end
                
        if (pathf2 == 4'd5) begin
            if (subpath2 <= 4'd5) begin
            if (balltwoy >= 19 && balltwox == 74)
                balltwoy <= balltwoy - 2;
            else if (balltwoy <= 18 && balltwoy >= 14 && balltwox <= 74 && balltwox >= 70) begin
                balltwoy <= balltwoy -2;
                balltwox <= balltwox - 2;
            end
            else if (balltwoy == 12 && balltwox <= 68 && balltwox >= 47)
                balltwox <= balltwox - 1;
                    
            else if (balltwoy >= 12 && balltwoy <= 24 && balltwox <= 46 && balltwox >= 35)begin
                balltwoy <= balltwoy + 2;
                balltwox <= balltwox - 2;
            end
            else if (balltwoy >= 24 && balltwoy <= 33 && balltwox == 34)
                balltwoy <= balltwoy + 1;
            end
            //-------------------subpath 0--------------
            else if (subpath2 <= 4'd10) begin
            if (balltwoy >= 19 && balltwox == 74)
                balltwoy <= balltwoy - 1;
            else if (balltwoy <= 18 && balltwoy >= 10 && balltwox <= 74 && balltwox >= 66) begin
                balltwoy <= balltwoy -2;
                balltwox <= balltwox - 2;
            end
            else if (balltwoy == 8 && balltwox <= 64 && balltwox >= 44)
                balltwox <= balltwox - 2;
                    
            else if (balltwoy >= 8 && balltwoy <= 22 && balltwox <= 42 && balltwox >= 28)begin
                balltwoy <= balltwoy + 2;
                balltwox <= balltwox - 2;
            end
            else if (balltwoy >= 24 && balltwoy <= 33 && balltwox == 26)
                balltwoy <= balltwoy + 1;
            end
            //-------------------------------subpath 1---------------------------------
            else begin
            if (balltwoy >= 19 && balltwox == 74)
                balltwoy <= balltwoy - 2;
            else if (balltwoy <= 18 && balltwoy >= 13 && balltwox <= 74 && balltwox >= 69) begin
                balltwoy <= balltwoy -  1;
                balltwox <= balltwox - 1;
            end
            else if (balltwoy == 12 && balltwox <= 68 && balltwox >= 31)
                balltwox <= balltwox - 2;
                    
            else if (balltwoy >= 12 && balltwoy <= 24 && balltwox <= 30 && balltwox >= 19)begin
                balltwoy <= balltwoy + 2;
                balltwox <= balltwox - 2;
            end
            else if (balltwoy >= 24 && balltwoy <= 33 && balltwox == 18)
                balltwoy <= balltwoy + 1;
            end         
            //------------------------------subpath 2----------------------------
        end
        //--------------------------------path 5-------------------------------------------    


        end //for sw3
        end
         
    end
    
    always @ (posedge clk6p25m) begin
        if (flag == 4'd3) begin
        
            
        if ((y == 63) && (x == 40 || x == 56))
            oled_data = GREEN;
        else if ((y == 62) && (x == 41 || x == 55))
            oled_data = GREEN;
        else if ((y == 61) && (x == 42 || x == 54))
            oled_data = GREEN;
        else if ((y == 60) && (x == 43 || x == 53))
            oled_data = GREEN;
        else if ((y == 59) && (x == 44 || x == 52))
            oled_data = GREEN;
        else if ((y == 58) && (x == 45 || x == 51))
            oled_data = GREEN;
        else if ((y == 57) && (x == 46 || x == 50))
            oled_data = GREEN;
        else if ((y == 56) && (x == 47 || x == 49))
            oled_data = GREEN;
        else if ((y == 55) && (x == 48))
            oled_data = GREEN;
        else if ((y == 54) && (x == 48))
            oled_data = GREEN;
        else if ((y == 53) && (x == 48))
            oled_data = GREEN;
        else if ((y == 52) && (x == 48))
            oled_data = GREEN;
        else if ((y == 51) && (x == 48))
            oled_data = GREEN;
        else if ((y == 50) && (x == 48))
            oled_data = GREEN;
        else if ((y == 49) && (x == 48))
            oled_data = GREEN;
        else if ((y == 48) && (x == 48))
            oled_data = GREEN;
        else if ((y == 47) && (x == 48))
            oled_data = GREEN;
        else if ((y == 46) && (x == 48))
            oled_data = GREEN;        
        else if ((y == 45) && (x == 47 || x == 48 || x == 49))
            oled_data = GREEN;
        else if ((y == 44) && (x == 46 || x == 50))
            oled_data = GREEN;
        else if ((y == 43) && (x == 45 || x == 51))
            oled_data = GREEN;
        else if ((y == 42) && (x == 44 || x == 52))
            oled_data = GREEN;
        else if ((y == 41) && (x == 43 || x == 53 || x == 46 || x == 47 || x == 48 || x == 49 || x == 50))
            oled_data = GREEN;      
        else if ((y == 40) && (x == 42 || x == 54))
            oled_data = GREEN;  
        else if ((y == 39) && (x == 41 || x == 55))
            oled_data = GREEN;
        else if ((y == 38) && (x == 41 || x == 55))
            oled_data = GREEN;
        else if ((y == 37) && (x == 41 || x == 55))
            oled_data =GREEN;
        else if ((y == 36) && (x == 41 || x == 55))
            oled_data =GREEN;
        else if ((y == 35) && (x == 41 || x == 45 || x == 51 || x == 55))
            oled_data = GREEN;
        else if ((y == 34) && (x == 42 || x == 54))
            oled_data = GREEN;
        else if ((y == 33) && (x == 43 || x == 53))
            oled_data = GREEN;
        else if ((y == 32) && (x == 44 || x == 52))
            oled_data = GREEN;
        else if ((y == 31) && (x == 45 || x == 51))
            oled_data = GREEN;
        else if ((y == 30) && (x == 46 || x == 50))
            oled_data = GREEN;
        else if ((y == 29) && (x == 47 || x == 48 || x == 49 ))
            oled_data = GREEN;
        //----------------------------------------------head/body/leg---------------------------
        
        else if ((y == 37) && (x == 33 || x == 39) && hand1 == 0)
            oled_data = GREEN;
        else if ((y == 38) && (x == 33 || x == 39) && hand1 == 0)
            oled_data = GREEN;
        else if ((y == 39) && (x == 33 || x == 39) && hand1 == 0)
            oled_data = GREEN;
        else if ((y == 40) && (x == 34 || x == 38) && hand1 == 0)
            oled_data = GREEN;
        else if ((y == 41) && (x == 35 || x == 37) && hand1 == 0)
            oled_data = GREEN;
        else if ((y == 42) && (x == 36) && hand1 == 0)
            oled_data = GREEN;
        //----------------------------------------
        else if ((y == 37) && (x == 57 || x == 63) && hand2 == 0)
            oled_data = GREEN;
        else if ((y == 38) && (x == 57 || x == 63) && hand2 == 0)
            oled_data = GREEN;
        else if ((y == 39) && (x == 57 || x == 63) && hand2 == 0)
            oled_data = GREEN;
        else if ((y == 40) && (x == 58 || x == 62) && hand2 == 0)
            oled_data = GREEN;
        else if ((y == 41) && (x == 59 || x == 61) && hand2 == 0)
            oled_data = GREEN;
        else if ((y == 42) && (x == 60) && hand2 == 0)
            oled_data = GREEN;        
        //-------------------------------------------------
        else if ((y == 37) && (x == 25 || x == 31) && hand1 == 1)
            oled_data = GREEN;
        else if ((y == 38) && (x == 25 || x == 31) && hand1 == 1)
            oled_data = GREEN;
        else if ((y == 39) && (x == 25 || x == 31) && hand1 == 1)
            oled_data = GREEN;
        else if ((y == 40) && (x == 26 || x == 30) && hand1 == 1)
            oled_data = GREEN;
        else if ((y == 41) && (x == 27 || x == 29) && hand1 == 1)
            oled_data = GREEN;
        else if ((y == 42) && (x == 28) && hand1 == 1)
            oled_data = GREEN;  
        //-----------------------------------------------------
        else if ((y == 37) && (x == 65 || x == 71) && hand2 == 1)
            oled_data = GREEN;
        else if ((y == 38) && (x == 65 || x == 71) && hand2 == 1)
            oled_data = GREEN;
        else if ((y == 39) && (x == 65 || x == 71) && hand2 == 1)
            oled_data = GREEN;
        else if ((y == 40) && (x == 66 || x == 70) && hand2 == 1)
            oled_data = GREEN;
        else if ((y == 41) && (x == 67 || x == 69) && hand2 == 1)
            oled_data = GREEN;
        else if ((y == 42) && (x == 68) && hand2 == 1)
            oled_data = GREEN;
        //----------------------------------------------------
        else if ((y == 37) && (x == 17 || x == 23) && hand1 == 2)
            oled_data = GREEN;
        else if ((y == 38) && (x == 17 || x == 23) && hand1 == 2)
            oled_data = GREEN;
        else if ((y == 39) && (x == 17 || x == 23) && hand1 == 2)
            oled_data = GREEN;
        else if ((y == 40) && (x == 18 || x == 22) && hand1 == 2)
            oled_data = GREEN;
        else if ((y == 41) && (x == 19 || x == 21) && hand1 == 2)
            oled_data = GREEN;
        else if ((y == 42) && (x == 20) && hand1 == 2)
            oled_data = GREEN;
        //--------------------------------------------
        else if ((y == 37) && (x == 73 || x == 79) && hand2 == 2)
            oled_data = GREEN;
        else if ((y == 38) && (x == 73 || x == 79) && hand2 == 2)
            oled_data = GREEN;
        else if ((y == 39) && (x == 73 || x == 79) && hand2 == 2)
            oled_data = GREEN;
        else if ((y == 40) && (x == 74 || x == 78) && hand2 == 2)
            oled_data = GREEN;
        else if ((y == 41) && (x == 75 || x == 77) && hand2 == 2)
            oled_data = GREEN;
        else if ((y == 42) && (x == 76) && hand2 == 2)
            oled_data = GREEN;
            
        else if ((y >= balloney && y < balloney + 5) && (x >= ballonex && x < ballonex + 5))
            oled_data = RED;
        else if ((y >= balltwoy && y < balltwoy + 5) && (x >= balltwox && x < balltwox + 5))
                oled_data = YELLOW;       
        
        
        
        else if ((y == 0)) begin
            if (x <= score && (score == 2 || score == 3 || score == 1 || score == 0))
            oled_data = 0;
            else if (x <= (score -2) /2 && score >= 6) 
            oled_data = GREEN;
            else
            oled_data = 0;
        end
        else 
            oled_data = 0;
             
        end
    end
endmodule
