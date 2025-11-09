//-------------------------------------------------------------
// Title : DAC + 7-Segment + LCD Control (E Assignment)
// Board : XCS75FGGA484-1 (SeoulTech FPGA Lab Board)
// DAC   : AD7302 8-bit DAC
// Author: 梦想实现家
//-------------------------------------------------------------

module DAC_7SEG_LCD_XCS75(
    input clk,               // System Clock 50MHz
    input rst_n,             // Reset Active Low
    input [11:0] key,        // Button Switches SM_1~SM_12
    output reg [7:0] DAC_D,  // DAC Data Pins
    output reg DAC_WRN,      // DAC Write (Active Low)
    output reg DAC_A_B,      // DAC Channel Select (A=0, B=1)
    output [6:0] seg,        // 7-segment segments
    output [7:0] seg_sel,    // 7-segment digit select
    output [7:0] lcd_data,   // LCD Data
    output lcd_rs, lcd_rw, lcd_e // LCD Control
);

    //---------------------------------------------------------
    // 1. DAC 数字输入值控制 (按钮输入)
    //---------------------------------------------------------
    reg [7:0] dac_input;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n)
            dac_input <= 8'd0;
        else begin
            if(key[1]) dac_input <= dac_input - 1;   // SM_1 : -1
            if(key[3]) dac_input <= dac_input + 1;   // SM_3 : +1
            if(key[4]) dac_input <= dac_input - 2;   // SM_4 : -2
            if(key[6]) dac_input <= dac_input + 2;   // SM_6 : +2
            if(key[7]) dac_input <= dac_input - 8;   // SM_7 : -8
            if(key[9]) dac_input <= dac_input + 8;   // SM_9 : +8
        end
    end

    //---------------------------------------------------------
    // 2. DAC Write Pulse (WRN)
    //---------------------------------------------------------
    reg [15:0] cnt;
    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            DAC_WRN <= 1'b1;
            DAC_D   <= 8'd0;
            cnt <= 0;
        end else begin
            cnt <= cnt + 1;
            if(cnt == 16'd1000) begin
                DAC_D   <= dac_input;
                DAC_WRN <= 1'b0;     // write active
            end 
            else if(cnt == 16'd2000) begin
                DAC_WRN <= 1'b1;     // release
                cnt <= 0;
            end
        end
    end

    //---------------------------------------------------------
    // 3. 7-Segment 显示模块
    //---------------------------------------------------------
    wire [3:0] tens = dac_input / 10;
    wire [3:0] ones = dac_input % 10;
    wire [6:0] seg_tens, seg_ones;

    seg7_decoder U1 (.bin(tens), .seg(seg_tens));
    seg7_decoder U2 (.bin(ones), .seg(seg_ones));

    // 只显示两位数
    assign seg_sel = 8'b11111100;
    assign seg = seg_ones;  // 如果想动态扫描，可组合两位显示

    //---------------------------------------------------------
    // 4. LCD 显示模块
    //---------------------------------------------------------
    lcd_display U3(
        .clk(clk),
        .rst_n(rst_n),
        .dac_value(dac_input),
        .lcd_data(lcd_data),
        .lcd_rs(lcd_rs),
        .lcd_rw(lcd_rw),
        .lcd_e(lcd_e)
    );

endmodule
