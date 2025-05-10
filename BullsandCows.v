`timescale 1ns / 1ps

module oneshot(in, clk, tick);
    input in, clk;
    output reg tick;
    reg in_delayed;
   
    always @(posedge clk) begin
        if(in && !in_delayed) tick <= 1'b1;
        else if(!in) tick <= 1'b0;
        in_delayed <= in;
    end
endmodule
           
//////////////////////////////////////////////////////////////////////////////////
// Company:
// Engineer:
//
// Create Date: 2023/11/11 18:02:48
// Design Name:
// Module Name: test
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

module mid_proj(clk, reset, SW1a, SW2a, SW3a, ANODE, SEG, LED);
   
    parameter RESET = 6'd0;
   
    parameter SET000 = 6'd1;
    parameter SET001 = 6'd2;
    parameter SET010 = 6'd3;
    parameter SET0 = 6'd26;
    parameter SET010a = 6'd35;

    parameter SET100 = 6'd4;
    parameter SET101 = 6'd5;
    parameter SET110 = 6'd6;
    parameter SET1 = 6'd27;
    parameter SET110a = 6'd36;
   
    parameter SET200 = 6'd7;
    parameter SET201 = 6'd8;
    parameter SET210 = 6'd9;
    parameter SET2 = 6'd28;
    parameter SET210a = 6'd37;
   
    parameter SET300 = 6'd10;
    parameter SET301 = 6'd11;
    parameter SET310 = 6'd12;
    parameter SET3 = 6'd29;
    parameter SET33 = 6'd33;
    parameter SET310a = 6'd38;
   
    parameter SOLVE000 = 6'd13;
    parameter SOLVE001 = 6'd14;
    parameter SOLVE010 = 6'd15;
    parameter SOLVE0 = 6'd30;
    parameter SOLVE010a = 6'd39;
   
    parameter SOLVE100 = 6'd16;
    parameter SOLVE101 = 6'd17;
    parameter SOLVE110 = 6'd18;
    parameter SOLVE1 = 6'd31;
    parameter SOLVE110a = 6'd40;
   
    parameter SOLVE200 = 6'd19;
    parameter SOLVE201 = 6'd20;
    parameter SOLVE210 = 6'd21;
    parameter SOLVE2 = 6'd32;
    parameter SOLVE210a = 6'd41;
   
    parameter SOLVE300 = 6'd22;
    parameter SOLVE301 = 6'd23;
    parameter SOLVE310 = 6'd24;
    parameter SOLVE3 = 6'd34;
    parameter SOLVE310a = 6'd42;
   
    parameter SOLVE400 = 6'd25;
   
    parameter ZERO = 8'b00000011;
    parameter ONE = 8'b10011111;
    parameter TWO = 8'b00100101;
    parameter THREE = 8'b00001101;
    parameter FOUR = 8'b10011001;
    parameter FIVE = 8'b01001001;
    parameter SIX = 8'b01000001;
    parameter SEVEN = 8'b00011011;
    parameter EIGHT = 8'b00000001;
    parameter NINE = 8'b00001001;
    parameter BAR = 8'b11111101;
    parameter S = 8'b01001000;
    parameter B = 8'b00000000;
    parameter OFF = 8'b11111111;
   
    input clk, reset;
    input SW1a, SW2a, SW3a;
    output reg [7:0] ANODE;
    output reg [7:0] SEG;
    output reg [15:0] LED;
   
    wire SW1, SW2, SW3;
   
    oneshot u1(.in(SW1a), .clk(clk), .tick(SW1));
    oneshot u2(.in(SW2a), .clk(clk), .tick(SW2));
    oneshot u3(.in(SW3a), .clk(clk), .tick(SW3));
   
    reg [2:0] cnt, strike_cnt;
    reg [7:0] val [8:1];
    reg [7:0] set [3:0];
    reg [7:0] solve [3:0];
    reg [5:0] state, next_state;
    reg [19:0] counter = 20'd0;
   
    always @(posedge clk) begin
        counter <= counter + 1;
    end
   
    wire [2:0] iter = counter[19:17];
   
    always @(iter) begin
        case(iter)
            3'd0: begin
                ANODE <= 8'b11111110;
                SEG <= val[8];
            end
            3'd1: begin
                ANODE <= 8'b11111101;
                SEG <= val[7];
            end
            3'd2: begin
                ANODE <= 8'b11111011;
                SEG <= val[6];
            end
            3'd3: begin
                ANODE <= 8'b11110111;
                SEG <= val[5];
            end
            3'd4: begin
                ANODE <= 8'b11101111;
                SEG <= val[4];
            end
            3'd5: begin
                ANODE <= 8'b11011111;
                SEG <= val[3];
            end
            3'd6: begin
                ANODE <= 8'b10111111;
                SEG <= val[2];
            end
            3'd7: begin
                ANODE <= 8'b01111111;
                SEG <= val[1];
            end
            default: begin
                ANODE <= 8'b11111111;
                SEG <= OFF;
            end
        endcase
    end
   
    always @(posedge clk or posedge reset) begin
        if(reset) begin
            val[1] = BAR; val[2] = BAR; val[3] = BAR; val[4] = BAR; val[5] = OFF; val[6] = OFF; val[7] = OFF; val[8] = OFF;
            set[0] = BAR; set[1] = BAR; set[2] = BAR; set[3] = BAR;
            solve[0] = BAR; solve[1] = BAR; solve[2] = BAR; solve[3] = BAR;
            LED = 16'b0000000000000000;
            state = RESET;
        end
        else begin
            case(state)
            RESET: begin
                LED = 16'b0000000000000000;
                if(!reset) begin
                    val[1] = BAR; val[2] = BAR; val[3] = BAR; val[4] = BAR; val[5] = OFF; val[6] = OFF; val[7] = OFF; val[8] = OFF;
                    next_state = SET000;
                end
            end
            SET000: begin
                LED = 16'b0000000000000000;
                if(SW2) begin
                    if(val[1] == BAR) val[1] = ONE;
                    else if(val[1] == ZERO) val[1] = ONE;
                    else if(val[1] == ONE) val[1] = TWO;
                    else if(val[1] == TWO) val[1] = THREE;
                    else if(val[1] == THREE) val[1] = FOUR;
                    else if(val[1] == FOUR) val[1] = FIVE;
                    else if(val[1] == FIVE) val[1] = SIX;
                    else if(val[1] == SIX) val[1] = SEVEN;
                    else if(val[1] == SEVEN) val[1] = EIGHT;
                    else if(val[1] == EIGHT) val[1] = NINE;
                    else if(val[1] == NINE) val[1] = ZERO;
                    next_state = SET010;
                end
                else if(SW3) next_state = SET001;
                else next_state = SET000;  
            end
            SET001: begin
                LED = 16'b0000000000000000;
                if(!SW3) next_state = SET000;
            end
            SET010: begin
                LED = 16'b0000000000000000;
                if(!SW2) begin
                    set[0] = val[1];
                    next_state = SET010a;
                end
            end
            SET0: begin
                LED = 16'b0000000000000000;
                if(!SW1) next_state = SET100;
            end
            SET010a: begin
                LED = 16'b0000000000000000;
                if(SW1) begin
                    val[1] = set[0];
                    next_state = SET0;
                end
                else if(SW2) next_state = SET000;
            end
            SET100: begin
                LED = 16'b0000000000000000;
                if(SW2) begin
                    if(val[2] == BAR) val[2] = ONE;
                    else if(val[2] == ZERO) val[2] = ONE;
                    else if(val[2] == ONE) val[2] = TWO;
                    else if(val[2] == TWO) val[2] = THREE;
                    else if(val[2] == THREE) val[2] = FOUR;
                    else if(val[2] == FOUR) val[2] = FIVE;
                    else if(val[2] == FIVE) val[2] = SIX;
                    else if(val[2] == SIX) val[2] = SEVEN;
                    else if(val[2] == SEVEN) val[2] = EIGHT;
                    else if(val[2] == EIGHT) val[2] = NINE;
                    else if(val[2] == NINE) val[2] = ZERO;
                    next_state = SET110;
                end
                else if(SW3) next_state = SET101;
                else next_state = SET100;
            end
            SET101: begin
                LED = 16'b0000000000000000;
                if(!SW3) next_state = SET100;
            end
            SET110: begin
                LED = 16'b0000000000000000;
                if(!SW2) begin
                    set[1] = val[2];
                    next_state = SET110a;
                end
            end
            SET1: begin
                LED = 16'b0000000000000000;
                if(!SW1) next_state = SET200;
            end
            SET110a: begin
                LED = 16'b0000000000000000;
                if(SW1) begin
                    val[2] = set[1];
                    next_state = SET1;
                end
                else if(SW2) next_state = SET100;
            end
            SET200: begin
                LED = 16'b0000000000000000;
                if(SW2) begin
                    if(val[3] == BAR) val[3] = ONE;
                    else if(val[3] == ZERO) val[3] = ONE;
                    else if(val[3] == ONE) val[3] = TWO;
                    else if(val[3] == TWO) val[3] = THREE;
                    else if(val[3] == THREE) val[3] = FOUR;
                    else if(val[3] == FOUR) val[3] = FIVE;
                    else if(val[3] == FIVE) val[3] = SIX;
                    else if(val[3] == SIX) val[3] = SEVEN;
                    else if(val[3] == SEVEN) val[3] = EIGHT;
                    else if(val[3] == EIGHT) val[3] = NINE;
                    else if(val[3] == NINE) val[3] = ZERO;
                    next_state = SET210;
                end
                else if(SW3) next_state = SET201;
                else next_state = SET200;
            end
            SET201: begin
                LED = 16'b0000000000000000;
                if(!SW3) next_state = SET200;
            end
            SET210: begin
                LED = 16'b0000000000000000;
                if(!SW2) begin
                    set[2] = val[3];
                    next_state = SET210a;
                end
            end
            SET2: begin
                LED = 16'b0000000000000000;
                if(!SW1) next_state = SET300;
            end
            SET210a: begin
                LED = 16'b0000000000000000;
                if(SW1) begin
                    val[3] = set[2];
                    next_state = SET2;
                end
                else if(SW2) next_state = SET200;
            end
            SET300: begin
                LED = 16'b0000000000000000;
                if(SW2) begin
                    if(val[4] == BAR) val[4] = ONE;
                    else if(val[4] == ZERO) val[4] = ONE;
                    else if(val[4] == ONE) val[4] = TWO;
                    else if(val[4] == TWO) val[4] = THREE;
                    else if(val[4] == THREE) val[4] = FOUR;
                    else if(val[4] == FOUR) val[4] = FIVE;
                    else if(val[4] == FIVE) val[4] = SIX;
                    else if(val[4] == SIX) val[4] = SEVEN;
                    else if(val[4] == SEVEN) val[4] = EIGHT;
                    else if(val[4] == EIGHT) val[4] = NINE;
                    else if(val[4] == NINE) val[4] = ZERO;
                    next_state = SET310;
                end
                else if(SW3) next_state = SET301;
                else next_state = SET300;
            end
            SET301: begin
                LED = 16'b0000000000000000;
                if(!SW3) next_state = SET300;
            end
            SET310: begin
                LED = 16'b0000000000000000;
                if(!SW2) begin
                    set[3] = val[4];
                    next_state = SET310a;
                end
            end
            SET3: begin
                LED = 16'b1111111111111111;
                if(!SW1) next_state = SOLVE000;
            end
            SET33: begin
                LED = 16'b0000000000000000;
                if(!SW1) next_state = SET000;
            end
            SET310a: begin
                if(SW1) begin
                    val[4] = set[3];
                    if(set[0] != set[1] && set[0] != set[2] && set[0] != set[3] && set[1] != set[2] && set[1] != set[3] && set[2] != set[3]) begin
                        LED = 16'b1111111111111111;
                        next_state = SET3;
                    end
                    else begin
                        LED = 16'b0000000000000000;
                        set[0] = BAR; set[1] = BAR; set[2] = BAR; set[3] = BAR;
                        next_state = SET33;
                    end
                    val[1] = BAR; val[2] = BAR; val[3] = BAR; val[4] = BAR; val[5] = OFF; val[6] = OFF; val[7] = OFF; val[8] = OFF;
                end
                else if(SW2) next_state = SET300;
            end
            SOLVE000: begin
                LED = 16'b1111111111111111;
                if(SW2) begin
                    if(val[1] == BAR) val[1] = ONE;
                    else if(val[1] == ZERO) val[1] = ONE;
                    else if(val[1] == ONE) val[1] = TWO;
                    else if(val[1] == TWO) val[1] = THREE;
                    else if(val[1] == THREE) val[1] = FOUR;
                    else if(val[1] == FOUR) val[1] = FIVE;
                    else if(val[1] == FIVE) val[1] = SIX;
                    else if(val[1] == SIX) val[1] = SEVEN;
                    else if(val[1] == SEVEN) val[1] = EIGHT;
                    else if(val[1] == EIGHT) val[1] = NINE;
                    else if(val[1] == NINE) val[1] = ZERO;
                    next_state = SOLVE010;
                end
                else if(SW3) begin
                    val[5] = set[0]; val[6] = set[1]; val[7] = set[2]; val[8] = set[3];
                    next_state = SOLVE001;
                end
                else next_state = SOLVE000;
            end
            SOLVE001: begin
                LED = 16'b1111111111111111;
                if(!SW3) begin
                    val[5] = OFF; val[6] = OFF; val[7] = OFF; val[8] = OFF;
                    next_state = SOLVE000;
                end
            end
            SOLVE010: begin
                LED = 16'b1111111111111111;
                if(!SW2) begin
                    solve[0] = val[1];
                    next_state = SOLVE010a;
                end
            end
            SOLVE0: begin
                LED = 16'b1111111111111111;
                if(!SW1) next_state = SOLVE100;
            end
            SOLVE010a: begin
                LED = 16'b1111111111111111;
                if(SW1) begin
                    val[1] = solve[0];
                    next_state = SOLVE0;
                end
                else if(SW2) next_state = SOLVE000;
                else if(SW3) next_state = SOLVE000;
            end
            SOLVE100: begin
                LED = 16'b1111111111111111;
                if(SW2) begin
                    if(val[2] == BAR) val[2] = ONE;
                    else if(val[2] == ZERO) val[2] = ONE;
                    else if(val[2] == ONE) val[2] = TWO;
                    else if(val[2] == TWO) val[2] = THREE;
                    else if(val[2] == THREE) val[2] = FOUR;
                    else if(val[2] == FOUR) val[2] = FIVE;
                    else if(val[2] == FIVE) val[2] = SIX;
                    else if(val[2] == SIX) val[2] = SEVEN;
                    else if(val[2] == SEVEN) val[2] = EIGHT;
                    else if(val[2] == EIGHT) val[2] = NINE;
                    else if(val[2] == NINE) val[2] = ZERO;
                    next_state = SOLVE110;
                end
                else if(SW3) begin
                    val[5] = set[0]; val[6] = set[1]; val[7] = set[2]; val[8] = set[3];
                    next_state = SOLVE101;
                end
                else next_state = SOLVE100;
            end
            SOLVE101: begin
                LED = 16'b1111111111111111;
                if(!SW3) begin
                    val[5] = OFF; val[6] = OFF; val[7] = OFF; val[8] = OFF;
                    next_state = SOLVE100;
                end
            end
            SOLVE110: begin
                LED = 16'b1111111111111111;
                if(!SW2) begin
                    solve[1] = val[2];
                    next_state = SOLVE110a;
                end
            end
            SOLVE1: begin
                LED = 16'b1111111111111111;
                if(!SW1) next_state = SOLVE200;
            end
            SOLVE110a: begin
                LED = 16'b1111111111111111;
                if(SW1) begin
                    val[2] = solve[1];
                    next_state = SOLVE1;
                end
                else if(SW2) next_state = SOLVE100;
                else if(SW3) next_state = SOLVE100;
            end
            SOLVE200: begin
                LED = 16'b1111111111111111;
                if(SW2) begin
                    if(val[3] == BAR) val[3] = ONE;
                    else if(val[3] == ZERO) val[3] = ONE;
                    else if(val[3] == ONE) val[3] = TWO;
                    else if(val[3] == TWO) val[3] = THREE;
                    else if(val[3] == THREE) val[3] = FOUR;
                    else if(val[3] == FOUR) val[3] = FIVE;
                    else if(val[3] == FIVE) val[3] = SIX;
                    else if(val[3] == SIX) val[3] = SEVEN;
                    else if(val[3] == SEVEN) val[3] = EIGHT;
                    else if(val[3] == EIGHT) val[3] = NINE;
                    else if(val[3] == NINE) val[3] = ZERO;
                    next_state = SOLVE210;
                end
                else if(SW3) begin
                    val[5] = set[0]; val[6] = set[1]; val[7] = set[2]; val[8] = set[3];
                    next_state = SOLVE201;
                end
                else next_state = SOLVE200;
            end
            SOLVE201: begin
                LED = 16'b1111111111111111;
                if(!SW3) begin
                    val[5] = OFF; val[6] = OFF; val[7] = OFF; val[8] = OFF;
                    next_state = SOLVE200;
                end
            end
            SOLVE210: begin
                LED = 16'b1111111111111111;
                if(!SW2) begin
                    solve[2] = val[3];
                    next_state = SOLVE210a;
                end
            end
            SOLVE2: begin
                LED = 16'b1111111111111111;
                if(!SW1) next_state = SOLVE300;
            end
            SOLVE210a: begin
                LED = 16'b1111111111111111;
                if(SW1) begin
                    val[3] = solve[2];
                    next_state = SOLVE2;
                end
                else if(SW2) next_state = SOLVE200;
                else if(SW3) next_state = SOLVE200;
            end
            SOLVE300: begin
                LED = 16'b1111111111111111;
                if(SW2) begin
                    if(val[4] == BAR) val[4] = ONE;
                    else if(val[4] == ZERO) val[4] = ONE;
                    else if(val[4] == ONE) val[4] = TWO;
                    else if(val[4] == TWO) val[4] = THREE;
                    else if(val[4] == THREE) val[4] = FOUR;
                    else if(val[4] == FOUR) val[4] = FIVE;
                    else if(val[4] == FIVE) val[4] = SIX;
                    else if(val[4] == SIX) val[4] = SEVEN;
                    else if(val[4] == SEVEN) val[4] = EIGHT;
                    else if(val[4] == EIGHT) val[4] = NINE;
                    else if(val[4] == NINE) val[4] = ZERO;
                    next_state = SOLVE310;
                end
                else if(SW3) begin
                    val[5] = set[0]; val[6] = set[1]; val[7] = set[2]; val[8] = set[3];
                    next_state = SOLVE301;
                end
                else next_state = SOLVE300;
            end
            SOLVE301: begin
                LED = 16'b1111111111111111;
                if(!SW3) begin
                    val[5] = OFF; val[6] = OFF; val[7] = OFF; val[8] = OFF;
                    next_state = SOLVE300;
                end
            end
            SOLVE310: begin
                LED = 16'b1111111111111111;
                if(!SW2) begin
                    solve[3] = val[4];
                    next_state = SOLVE310a;
                end
            end
            SOLVE3: begin
                LED = 16'b1111111111111111;
                if(!SW1) next_state = SOLVE000;
            end
            SOLVE310a: begin
                LED = 16'b1111111111111111;
                if(SW1) begin
                    val[4] = solve[3];
                    if(solve[0] != solve[1] && solve[0] != solve[2] && solve[0] != solve[3] && solve[1] != solve[2] && solve[1] != solve[3] && solve[2] != solve[3]) begin
                        val[6] = S; val[8] = B;
                        if(set[0] == solve[0] || set[0] == solve[1] || set[0] == solve[2] || set[0] == solve[3]) cnt = cnt + 1;
                        if(set[1] == solve[0] || set[1] == solve[1] || set[1] == solve[2] || set[1] == solve[3]) cnt = cnt + 1;
                        if(set[2] == solve[0] || set[2] == solve[1] || set[2] == solve[2] || set[2] == solve[3]) cnt = cnt + 1;
                        if(set[3] == solve[0] || set[3] == solve[1] || set[3] == solve[2] || set[3] == solve[3]) cnt = cnt + 1;
                           
                        if(set[0] == solve[0]) strike_cnt = strike_cnt + 1;
                        if(set[1] == solve[1]) strike_cnt = strike_cnt + 1;
                        if(set[2] == solve[2]) strike_cnt = strike_cnt + 1;
                        if(set[3] == solve[3]) strike_cnt = strike_cnt + 1;
                           
                        if(strike_cnt == 0) val[5] = ZERO;
                        else if(strike_cnt == 1) val[5] = ONE;
                        else if(strike_cnt == 2) val[5] = TWO;
                        else if(strike_cnt == 3) val[5] = THREE;
                        else if(strike_cnt == 4) val[5] = FOUR;
                           
                        if(cnt - strike_cnt == 0) val[7] = ZERO;
                        else if(cnt - strike_cnt == 1) val[7] = ONE;
                        else if(cnt - strike_cnt == 2) val[7] = TWO;
                        else if(cnt - strike_cnt == 3) val[7] = THREE;
                        else if(cnt - strike_cnt == 4) val[7] = FOUR;
                 
                        next_state = SOLVE400;
                    end
                    else begin
                        val[1] = BAR; val[2] = BAR; val[3] = BAR; val[4] = BAR; val[5] = OFF; val[6] = OFF; val[7] = OFF; val[8] = OFF;
                        solve[0] = BAR; solve[1] = BAR; solve[2] = BAR; solve[3] = BAR;
                        next_state = SOLVE3;
                    end
                end
                else if(SW2) next_state = SOLVE300;
                else if(SW3) next_state = SOLVE300;
            end
            SOLVE400:
                if(!SW1) begin
                    if(val[5] == FOUR) begin
                        LED = 16'b0000000000000000;
                        set[0] = BAR; set[1] = BAR; set[2] = BAR; set[3] = BAR;
                        solve[0] = BAR; solve[1] = BAR; solve[2] = BAR; solve[3] = BAR;
                        next_state = SET000;
                    end
                    else begin
                        LED = 16'b1111111111111111;
                        solve[0] = BAR; solve[1] = BAR; solve[2] = BAR; solve[3] = BAR;
                        next_state = SOLVE000;
                    end
                    val[1] = BAR; val[2] = BAR; val[3] = BAR; val[4] = BAR; val[5] = OFF; val[6] = OFF; val[7] = OFF; val[8] = OFF;
                    cnt = 0; strike_cnt = 0;
                end
            endcase
            state = next_state;
        end
    end  
       
endmodule
