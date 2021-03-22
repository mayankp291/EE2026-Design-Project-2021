`timescale 1ns / 1ps

//////////////////////////////////////////////////////////////////////////////////
//
//  FILL IN THE FOLLOWING INFORMATION:
//
//  LAB SESSION DAY (Delete where applicable): MONDAY P.M, TUESDAY P.M, WEDNESDAY P.M, THURSDAY A.M., THURSDAY P.M
//
//  STUDENT A NAME: 
//  STUDENT A MATRICULATION NUMBER: 
//
//  STUDENT B NAME: 
//  STUDENT B MATRICULATION NUMBER: 
//
//////////////////////////////////////////////////////////////////////////////////
 
    
module Top_Student (
    input CLK100MHZ,
    input btnC,
    input btnL,
    input btnR,
    input btnU,
    input btnD,
    input [15:0] sw,
    input  J_MIC3_Pin3,   // Connect from this signal to Audio_Capture.v
    
    output J_MIC3_Pin1,   // Connect to this signal from Audio_Capture.v
    output J_MIC3_Pin4,   // Connect to this signal from Audio_Capture.v
    output [15:0] led,
    output [7:0] seg,
    output [7:0] JC
    );
    
    reg [3:0] flag = 0;

    reg clk_freq625 = 32'd7;
    reg clk_freq381 = 32'd131233;
    //counters for btnL and btnR
    wire clk6p25m, clk381hz;
    clk_custom c1 (CLK100MHZ, clk_freq625, clk6p25m);
    clk_custom c2 (CLK100MHZ, clk_freq381, clk381hz);
    //clk for btnL and btnR
    wire KHZ20;
    clk_custom c3 (CLK100MHZ, 32'd2499, KHZ20);
    //clk for audio_capture
    
    wire [11:0] mic_in;
    Audio_Capture f0 (CLK100MHZ, KHZ20, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, mic_in); 
    //to obtain audio data from audio_capture
    
    wire [15:0] volume;     //so can map to led easier
    wire [3:0] level;       //to store 0 to 15
    Volume_Indicator f1 (KHZ20, mic_in, volume, seg, level);
    //to indicate voume loudness
    
    assign led = volume;
    //map to led
    
    wire [10:0] btnL_count, btnR_count;
    wire [15:0] oled_data;
    wire [15:0] oled_data_volume;
    wire [15:0] oled_data_menu;
    assign oled_data = (sw[1] == 1) ? oled_data_volume : oled_data_menu;
    
    wire btnL_press, btnR_press, btnC_press;
//    wire btnL_press, btnR_press;
    single_pulse_circuit f2(clk381hz, btnC, btnC_press);
    single_pulse_circuit f3(clk381hz, btnL, btnL_press);
    single_pulse_circuit f4(clk381hz, btnR, btnR_press);
    //single pulse
    
    Volume_left_right f9 (clk381hz, btnL_press, btnR_press, btnC_press, btnL_count, btnR_count);
    
    wire [6:0] x;
    wire [5:0] y;
    wire [12:0] pixel_index;
    convert_to_coordinate f5 (pixel_index, x, y);
    
    
    wire A, B, C, E;
    Oled_Display f6 (clk6p25m, btnC_press, A, B, C, pixel_index, oled_data, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7], E);
    //converts pixel_index to cartesian coordinates (0 - 63, 0 - 95)
                              
    display_volume f7 (clk6p25m, sw[1], x, y, btnL_count, btnR_count, volume, sw[0], oled_data_volume);                               
    //volume bar and other display stuff 
    
    Display_Menu f8 (clk6p25m, x , y, oled_data_menu);
    
endmodule