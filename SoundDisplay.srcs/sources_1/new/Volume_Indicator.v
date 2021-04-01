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
    input sw2,
    input sw3,
    input [3:0] flag,
    input KHZ20,
    input [11:0] audio_in,
    output reg [15:0] volume,
    output reg [3:0] an,
    output reg [7:0] seg,
    output reg [3:0] level
    );
    
    reg [7:0] seg1;
    reg [7:0] seg2_3;
    reg [7:0] seg2_2;
    reg [7:0] volume_level [2:0];
    reg [11:0] sample;
    reg [31:0] freq2p5;
    reg [1:0] switcher;
    initial begin
        volume[15:0] = 16'b0;   //0 for now
        seg[7:0] = 8'b11111111;     //off 7 seg first
        volume_level[2] = 8'b10001001;  // H
        volume_level[1] = 8'b11101010;  //M
        volume_level[0] = 8'b11000111;  //L
        sample[11:0] = 12'b0;   //0 for now
        freq2p5[31:0] = 32'b0;   //counter start @ 0
        level = 4'b0;
    end
    
    always @ (posedge KHZ20) begin  
        if (flag == 4'd1 || flag == 4'd2) begin
        freq2p5 <= freq2p5 + 1;
        switcher <= switcher + 1;
        
        if (audio_in[11:0] > sample[11:0]) 
            sample[11:0] <= audio_in;   //keep looking for the peak max:4095
        
        if ((freq2p5 == 3999)) begin
            if (sample[11:0] <= 12'd2200    ) begin
                
                seg1[7:0] <= volume_level[0];
                seg2_3[7:0] <= 8'b11000000;
                seg2_2[7:0] <= 8'b11000000;
                level <= 4'd0;
                volume <= 16'b0000000000000001;
               
            end
            else if (sample[11:0] <= 12'd2310    ) begin
                seg1[7:0] <= volume_level[0];
                seg2_3[7:0] <= 8'b11000000;
                seg2_2[7:0] <= 8'b11111001;
                level <= 4'd1;
                volume <= 16'b0000000000000011;
             
            end
            else if (sample[11:0] <= 12'd2420   ) begin
                seg1[7:0] <= volume_level[0];
                seg2_3[7:0] <= 8'b11000000;
                                seg2_2[7:0] <= 8'b10100100;
                level <= 4'd2;
                volume <= 16'b0000000000000111;//2
            end
            else if (sample[11:0] <= 12'd2530   ) begin
                seg1[7:0] <= volume_level[0];
                seg2_3[7:0] <= 8'b11000000;
                                seg2_2[7:0] <= 8'b10110000;
                level <= 4'd3;
                volume <= 16'b0000000000001111;//3
            end
            else if (sample[11:0] <= 12'd2640   ) begin
                seg1[7:0] <= volume_level[0];
                seg2_3[7:0] <= 8'b11000000;
                                seg2_2[7:0] <= 8'b10011001;
                level <= 4'd4;
                volume <= 16'b0000000000011111;//4
            end
            else if (sample[11:0] <= 12'd2750   ) begin
                seg1[7:0] <= volume_level[0];
                seg2_3[7:0] <= 8'b11000000;
                                seg2_2[7:0] <= 8'b10010010;
                level <= 4'd5;
                volume <= 16'b0000000000111111;//5
            end
            else if (sample[11:0] <= 12'd2860   ) begin
                seg1[7:0] <= volume_level[1];
                seg2_3[7:0] <= 8'b11000000;
                                seg2_2[7:0] <= 8'b10000010;
                level <= 4'd6;
                volume <= 16'b0000000001111111;//6
            end
            else if (sample[11:0] <= 12'd2970   ) begin
                seg1[7:0] <= volume_level[1];
                seg2_3[7:0] <= 8'b11000000;
                                seg2_2[7:0] <= 8'b11111000;//7
                level <= 4'd7;
                volume <= 16'b0000000011111111;
            end
            else if (sample[11:0] <= 12'd3080   ) begin
                seg1[7:0] <= volume_level[1];
                seg2_3[7:0] <= 8'b11000000;
                                seg2_2[7:0] <= 8'b10000000;//8
                level <= 4'd8;
                volume <= 16'b0000000111111111;
            end
            else if (sample[11:0] <= 12'd3190   ) begin
                seg1[7:0] <= volume_level[1];
                seg2_3[7:0] <= 8'b11000000;
                                seg2_2[7:0] <= 8'b10010000;//9
                level <= 4'd9;
                volume <= 16'b0000001111111111;
            end
            else if (sample[11:0] <= 12'd3300   ) begin
                seg1[7:0] <= volume_level[1];
                seg2_3[7:0] <= 8'b11111001;
                                seg2_2[7:0] <= 8'b11000000;//10
                level <= 4'd10;
                volume <= 16'b0000011111111111;
            end
            else if (sample[11:0] <= 12'd3410   ) begin
                seg1[7:0] <= volume_level[1];
                seg2_3[7:0] <= 8'b11111001;
                                                seg2_2[7:0] <= 8'b11111001;//11
                level <= 4'd11;
                volume <= 16'b0000111111111111;
            end
            else if (sample[11:0] <= 12'd3520   ) begin
                seg1[7:0] <= volume_level[2];
                seg2_3[7:0] <= 8'b11111001;
                                                seg2_2[7:0] <= 8'b10100100;//12
                level <= 4'd12;
                volume <= 16'b0001111111111111;
            end
            else if (sample[11:0] <= 12'd3630   ) begin
                seg1[7:0] <= volume_level[2];
                seg2_3[7:0] <= 8'b11111001;
                                                seg2_2[7:0] <= 8'b10110000;//13
                level <= 4'd13;
                volume <= 16'b0011111111111111;
            end
            else if (sample[11:0] <= 12'd3740   ) begin
                seg1[7:0] <= volume_level[2];
                seg2_3[7:0] <= 8'b11111001;
                                                seg2_2[7:0] <= 8'b10011001;//14
                level <= 4'd14;
                volume <= 16'b0111111111111111;
            end
                
            else begin
                seg1[7:0] <= volume_level[2];
                seg2_3[7:0] <= 8'b11111001;
                                                seg2_2[7:0] <= 8'b10010010;//15
                level <= 4'd15;
                volume <= 16'b1111111111111111;
            end
                
            freq2p5 <= 0;
            sample <= 12'b0;
        end
        
        if (sw2 == 0) begin
            an <= 1;
            
        end
        else if (sw2 == 1 && sw3 == 0) begin
            case (switcher)
                2'b00: begin
                    an[3:0] <= 4'b0111;
                    seg[7:0] <= seg2_3[7:0];
                    end
                2'b01: begin
                    an[3:0] <= 4'b1011;
                    seg[7:0] <= seg2_2[7:0];
                    end
                2'b10: begin
                    an[3:0] <= 4'b1111;
                    end
                2'b11: begin
                    an[3:0] <= 4'b1111;
                    end
            endcase
                
            end
            else if (sw2 == 1 && sw3 == 1) begin
                case (switcher)
                            2'b00: begin
                                an[3:0] <= 4'b0111;
                                seg[7:0] <= seg2_3[7:0];
                                end
                            2'b01: begin
                                an[3:0] <= 4'b1011;
                                seg[7:0] <= seg2_2[7:0];
                                end
                            2'b10: begin
                                an[3:0] <= 4'b1111;
                                
                                end
                            2'b11: begin
                                an[3:0] <= 4'b1110;
                                seg[7:0] <= seg1[7:0];
                                end
                                endcase
            end
                
            
        end
    end
                   
endmodule

