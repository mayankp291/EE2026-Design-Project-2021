`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 03/22/2021 04:47:28 PM
// Design Name: 
// Module Name: Volume_Indicator
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


module Volume_Indicator( 
    input KHZ20,
    input [11:0] audio_in,
    output reg [15:0] volume,
    output reg [7:0] seg,
    output reg [3:0] level
    );
    
    reg [7:0] volume_level [2:0];
    reg [11:0] sample;
    reg [31:0] counter_2s;
    
    initial begin
        volume[15:0] = 16'b0;   //0 for now
        seg[7:0] = 8'b11111111;     //off 7 seg first
        volume_level[2] = 8'b10001001;  // H
        volume_level[1] = 8'b11101010;  //M
        volume_level[0] = 8'b11000111;  //L
        sample[11:0] = 12'b0;   //0 for now
        counter_2s[31:0] = 32'b0;   //counter start @ 0
        level = 4'b0;
    end
    
    always @ (posedge KHZ20) begin  
        counter_2s <= counter_2s + 1;
        
        if (audio_in[11:0] > sample[11:0]) 
            sample[11:0] <= audio_in;   //keep looking for the peak max:4095
        
        if (counter_2s == 19999) begin
            if (sample[11:0] <= 12'd2200    ) begin
                seg[7:0] <= volume_level[0];
                level <= 4'd0;
                volume <= 16'b0000000000000001;
               
            end
            else if (sample[11:0] <= 12'd2310    ) begin
                seg[7:0] <= volume_level[0];
                level <= 4'd1;
                volume <= 16'b0000000000000011;
             
            end
            else if (sample[11:0] <= 12'd2420   ) begin
                seg[7:0] <= volume_level[0];
                level <= 4'd2;
                volume <= 16'b0000000000000111;
            end
            else if (sample[11:0] <= 12'd2530   ) begin
                seg[7:0] <= volume_level[0];
                level <= 4'd3;
                volume <= 16'b0000000000001111;
            end
            else if (sample[11:0] <= 12'd2640   ) begin
                seg[7:0] <= volume_level[0];
                level <= 4'd4;
                volume <= 16'b0000000000011111;
            end
            else if (sample[11:0] <= 12'd2750   ) begin
                seg[7:0] <= volume_level[0];
                level <= 4'd5;
                volume <= 16'b0000000000111111;
            end
            else if (sample[11:0] <= 12'd2860   ) begin
                seg[7:0] <= volume_level[1];
                level <= 4'd6;
                volume <= 16'b0000000001111111;
            end
            else if (sample[11:0] <= 12'd2970   ) begin
                seg[7:0] <= volume_level[1];
                level <= 4'd7;
                volume <= 16'b0000000011111111;
            end
            else if (sample[11:0] <= 12'd3080   ) begin
                seg[7:0] <= volume_level[1];
                level <= 4'd8;
                volume <= 16'b0000000111111111;
            end
            else if (sample[11:0] <= 12'd3190   ) begin
                seg[7:0] <= volume_level[1];
                level <= 4'd9;
                volume <= 16'b0000001111111111;
            end
            else if (sample[11:0] <= 12'd3300   ) begin
                seg[7:0] <= volume_level[1];
                level <= 4'd10;
                volume <= 16'b0000011111111111;
            end
            else if (sample[11:0] <= 12'd3410   ) begin
                seg[7:0] <= volume_level[1];
                level <= 4'd11;
                volume <= 16'b0000111111111111;
            end
            else if (sample[11:0] <= 12'd3520   ) begin
                seg[7:0] <= volume_level[2];
                level <= 4'd12;
                volume <= 16'b0001111111111111;
            end
            else if (sample[11:0] <= 12'd3630   ) begin
                seg[7:0] <= volume_level[2];
                level <= 4'd13;
                volume <= 16'b0011111111111111;
            end
            else if (sample[11:0] <= 12'd3740   ) begin
                seg[7:0] <= volume_level[2];
                level <= 4'd14;
                volume <= 16'b0111111111111111;
            end
                
            else begin
                seg[7:0] <= volume_level[2];
                level <= 4'd15;
                volume <= 16'b1111111111111111;
            end
                
            counter_2s <= 0;
            sample <= 12'b0;
        end
    end
                   
endmodule

