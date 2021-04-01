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
    output [3:0] an,
    output [7:0] seg,
    output [7:0] JC
    );
    

    
    //////      DECLARATIONS       //////
    reg [31:0]clk_freq625 = 32'd7;
    reg [31:0]clk_freq381 = 32'd131233;
    reg [31:0]clk_freq5 = 32'd9999999;
    reg [31:0]clk_freq10 = 32'd4999999;
    reg [31:0]clk_freq1 = 32'd49999999;
    reg [31:0]clk_freq15 = 32'd3333332;
    wire clk6p25m, clk381hz, clk5hz, clk10hz, clk1hz, clk15hz, KHZ20, btnU_press, btnD_press, btnC_press, btnL_press, btnR_press;
    wire btnL_press_10hz, btnR_press_10hz, btnC_press_10hz, btnL_press_15hz, btnR_press_15hz, btnC_press_15hz;
    wire [3:0] flag;
    wire [1:0] option;
    wire [11:0] mic_in; 
    wire [15:0] volume;     //so can map to led easier
    wire [3:0] level;       //to store 0 to 15
    wire [3:0] level_4_jug_slow;
    wire [3:0] level_4_jug_fast;
    wire [7:0]seg_volume_level;
    wire [15:0] oled_data;
    wire [15:0] oled_data_volume;
    wire [15:0] oled_data_menu;
    wire [15:0] oled_data_back;
    wire [15:0] oled_data_jug;    
    wire [15:0] oled_data_worm;
    wire oled_reset;
    assign oled_reset = 0;
    wire [10:0] btnL_count, btnR_count;    
    wire [6:0] x;
    wire [5:0] y;
    wire [12:0] pixel_index;    
    wire A, B, C, E;        
    wire background_speed;       
    wire juggle_speed;    
    wire [3:0] level_4_jug;
    wire jug_btnL, jug_btnR, jug_btnC;
    
            
    //////       CUSTOM CLOCKS       //////
    clk_custom CLK6P25M (CLK100MHZ, clk_freq625, clk6p25m);
    clk_custom CLK381HZ (CLK100MHZ, clk_freq381, clk381hz);
    clk_custom CLK5HZ (CLK100MHZ, clk_freq5, clk5hz);
    clk_custom CLK10HZ (CLK100MHZ, clk_freq10, clk10hz);
    clk_custom CLK1HZ (CLK100MHZ, clk_freq1, clk1hz);
    clk_custom CLK15HZ (CLK100MHZ, clk_freq15, clk15hz);
    clk_custom c4 (CLK100MHZ, 32'd2499, KHZ20);
        
    //////       SINGLE BUTTON PULSE       //////
    single_pulse_circuit s1(clk381hz, btnU, btnU_press);
    single_pulse_circuit s2(clk381hz, btnD, btnD_press);
    single_pulse_circuit s3(clk381hz, btnC, btnC_press);
    single_pulse_circuit f3(clk381hz, btnL, btnL_press);
    single_pulse_circuit f4(clk381hz, btnR, btnR_press);

    single_pulse_circuit f12(clk10hz, btnL, btnL_press_10hz);
    single_pulse_circuit f13(clk10hz, btnR, btnR_press_10hz);
    single_pulse_circuit f14(clk10hz, btnC, btnC_press_10hz);   
   
    single_pulse_circuit (clk15hz, btnL, btnL_press_15hz);   
    single_pulse_circuit (clk15hz, btnR, btnR_press_15hz);   
    single_pulse_circuit (clk15hz, btnC, btnC_press_15hz); 
    
    
    //////      MODULES     //////
    Flag_gen(clk381hz,sw,btnU_press,btnD_press,btnC_press,flag, option);
    Audio_Capture f0 (CLK100MHZ, KHZ20, J_MIC3_Pin3, J_MIC3_Pin1, J_MIC3_Pin4, mic_in); 
    Volume_Indicator f1 (sw[2], sw[3], flag, KHZ20, mic_in, volume,an, seg_volume_level, level);
    Volume_Indicator_4_jug f15 (flag, KHZ20, mic_in, level_4_jug_slow);
    Volume_Indicator_4_jug_fast (flag, KHZ20, mic_in, level_4_jug_fast);
    Volume_left_right f9 (clk381hz, btnL_press, btnR_press,flag, btnL_count, btnR_count);    
    convert_to_coordinate f5 (pixel_index, x, y);   
    Oled_Display f6 (clk6p25m, oled_reset, A, B, C, pixel_index, oled_data, JC[0], JC[1], JC[3], JC[4], JC[5], JC[6], JC[7], E);    
    display_volume f7 (flag ,clk6p25m, x, y, btnL_count, btnR_count, volume, sw[1], oled_data_volume);     
    Display_Menu f8 (clk1hz, clk6p25m, x , y, option, flag, oled_data_menu);
    Background_app f10 (sw[15], sw[14], level, background_speed, clk6p25m, x, y, flag, oled_data_back);
    Juggle f11 (level_4_jug, juggle_speed, clk381hz, clk6p25m, jug_btnL, jug_btnR, jug_btnC, sw[2], sw[3], x, y, flag, oled_data_jug);      
    hungry_worm_main (clk6p25m, clk5hz, clk10hz, clk15hz, sw[4], sw[5], btnL, btnR, btnU, x, y, flag, oled_data_worm);
    
    assign oled_data = (flag == 4'd1) ? oled_data_volume : (flag == 4'd2) ? oled_data_back : (flag == 4'd3)? oled_data_jug : (flag == 4'd4)? oled_data_worm : oled_data_menu;
    assign led = (flag == 4'd1 || flag == 4'd2) ? (sw[2] == 1)?volume : mic_in : 15'd0;
    assign seg = (flag == 4'd1 || flag == 4'd2) ? (sw[2] == 0) ? 8'b11111111 : seg_volume_level : 8'b11111111;
    assign background_speed = (sw[13] == 1) ? clk10hz : clk5hz;
    assign juggle_speed = (sw[13] == 1) ? clk15hz : clk10hz;
    assign level_4_jug = (sw[13] == 1 )? level_4_jug_fast : level_4_jug_slow;    
    assign jug_btnL = (sw[13] == 1) ? btnL_press_15hz : btnL_press_10hz;
    assign jug_btnR = (sw[13] == 1) ? btnR_press_15hz : btnR_press_10hz;
    assign jug_btnC = (sw[13] == 1) ? btnC_press_15hz : btnC_press_10hz;

    //clock_display f16 (CLK100MHZ,clk6p25m,flag,x,y,oled_data_time);  
  
    //fftmain f16 (clk1hz, 0, clk1hz, mic_in, mic_out, sync);
    //show_fft f17 (clk6p25m, mic_out, x , y, oled_data_time);
         

//    //counts btn presses   
//    always @(posedge clk381hz) begin
//        if(btnL_press == 1)
//            btnL_count <= btnL_count + 1;
//        else if(btnR_press == 1)
//            btnR_count <= btnR_count + 1;       
            
//            ////for not out of bounds (btnL_count - btnR_count != ???)     
//    end    
        
    
//        always @(posedge CLK100MHZ)
//        begin
//        oled_data[10:5] = mic_in[11:6];
//        end
//        wire [11:0] zero_signal;
//        assign zero_signal = 12'b0; 
//        assign led = (sw[0] == 1) ? mic_in : zero_signal;
    
endmodule