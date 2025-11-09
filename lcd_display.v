module lcd_display(
    input clk,
    input rst_n,
    input [7:0] dac_value,
    output reg [7:0] lcd_data,
    output reg lcd_rs,
    output reg lcd_rw,
    output reg lcd_e
);
    // 简化版：输出 "DAC IN = XX"
    // 可在初始化FSM基础上扩展
    reg [7:0] msg [0:15];
    integer i;

    always @(posedge clk or negedge rst_n) begin
        if(!rst_n) begin
            lcd_e <= 0;
            lcd_rs <= 0;
            lcd_rw <= 0;
            lcd_data <= 8'h00;
        end else begin
            // 十位和个位转ASCII
            msg[0]  = "D"; msg[1]  = "A"; msg[2]  = "C"; msg[3]  = " ";
            msg[4]  = "I"; msg[5]  = "N"; msg[6]  = " "; msg[7]  = "="; msg[8]  = " ";
            msg[9]  = 8'd48 + (dac_value / 10);
            msg[10] = 8'd48 + (dac_value % 10);
            // 实际显示由你之前LCD初始化FSM驱动，这里只说明文字组成部分
        end
    end
endmodule
