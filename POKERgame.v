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
// Create Date: 2023/12/01 15:34:39
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

module test(clk, reseta, upa, downa, seta, allina, ANODE, SEG, LED1, LED2, RGB1, RGB2);

    parameter INITIAL = 7'd0;
    parameter INITIAL0 = 7'd1;
    
    parameter ANTE = 7'd2;
    parameter ANTE1 = 7'd3;
    
    parameter F1B1 = 7'd4;
    parameter F1CHECK = 7'd5;
    parameter F1B2 = 7'd6;
    
    parameter F2B2 = 7'd7;
    parameter F2CHECK = 7'd8;
    parameter F2B1 = 7'd9;
    
    parameter CALL = 7'd10;
    parameter FOLD = 7'd11;
        
    parameter ANTE1b1 = 7'd12;   
    parameter ANTE1b2 = 7'd13;
    parameter F1B1b = 7'd14;
    parameter F1B2b = 7'd15;
    parameter F2B2b = 7'd16;
    parameter F2B1b = 7'd17;
    
    parameter ANTE1c1 = 7'd55;   
    parameter ANTE1c2 = 7'd56;
    parameter ANTEDc1 = 7'd57;
    parameter ANTEDc2 = 7'd58;
    
    parameter F1B1c = 7'd18;  
    parameter F1B2c= 7'd19;
    parameter F2B2c = 7'd20;
    parameter F2B1c = 7'd21;
    
    parameter ANTE1d1 = 7'd22; 
    parameter ANTE1d2 = 7'd23;
    parameter F1B1d1 = 7'd24;
    parameter F1B1d2 = 7'd25;
    parameter F1B1d3 = 7'd26;
    parameter F1B2d1 = 7'd27;
    parameter F1B2d2 = 7'd28;
    parameter F1B2d3 = 7'd29;
    parameter F2B2d1 = 7'd30;
    parameter F2B2d2 = 7'd31;
    parameter F2B2d3 = 7'd32;
    parameter F2B1d1 = 7'd33;
    parameter F2B1d2 = 7'd34;
    parameter F2B1d3 = 7'd35;
    
    parameter ANTED = 7'd36;
    
    parameter ANTEDf = 7'd60;
    parameter ANTEDfd = 7'd61;
    
    parameter ANTEDb1 = 7'd37;  
    parameter ANTEDb2 = 7'd38;
    parameter ANTEDd1 = 7'd39;   
    parameter ANTEDd2 = 7'd40;
    
    parameter CALLd1 = 7'd41;
    parameter CALLd2 = 7'd42;
    parameter CALLd3 = 7'd43;
    
    parameter SWEEP = 7'd44;
    parameter SWEEPa = 7'd45;
    
    parameter F1CHECKb = 7'd46;
    parameter F1CHECKd = 7'd47;
    
    parameter F2CHECKb = 7'd50;
    parameter F2CHECKd = 7'd51;
    
    parameter FOLDd1 = 7'd52;
    parameter FOLDd2 = 7'd53;
    parameter FOLDd3 = 7'd54;
    
    parameter ANTE1in = 7'd62;
    parameter ANTEDin = 7'd63;
    parameter F1B1in = 7'd64;
    parameter F2CHECKin = 7'd65;
    parameter F2B1in = 7'd66;
    parameter F1B2in = 7'd67;
    parameter F1CHECKin = 7'd68;
    parameter F2B2in = 7'd70;
    
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
    parameter OFF = 8'b11111111;
    parameter W = 8'b10000011;
    parameter P = 8'b00110001;
    
    input clk;
    input reseta, upa, downa, seta, allina;
    output reg [7:0] ANODE;
    output reg [7:0] SEG;
    output reg [7:0] LED1, LED2;
    output reg [2:0] RGB1, RGB2;
    
    wire reset, up, down, set, allin;
    
    oneshot u1(.in(reseta), .clk(clk), .tick(reset));
    oneshot u2(.in(upa), .clk(clk), .tick(up));
    oneshot u3(.in(downa), .clk(clk), .tick(down));
    oneshot u4(.in(seta), .clk(clk), .tick(set));
    oneshot u5(.in(allina), .clk(clk), .tick(allin));
    
    reg [7:0] val[8:1];
    reg [6:0] state, next_state;
    reg [4:0] data, next_data, datar = 5'b00001;
    reg [6:0] double = 1;           
    reg [4:0] card [1:100], cpy_data[1:100];
    reg [4:0] p1, p2;
    reg [3:0] p1card, p2card;
    reg [5:0] chips1, chips2;   
    reg [5:0] life1, life2;   
    reg [5:0] ante = 6'd1;     
    reg firstplayerflag;    
    reg [5:0] prevchips1, prevchips2, winnerchips;  
    reg winnerflag;
    reg [1:0] playerflag;
    reg [2:0] rgbflag1, rgbflag2;  
    
    reg [2:0] chips_ten1, chips_ten2, life_ten1, life_ten2, prevchips_ten1, prevchips_ten2;
    reg [3:0] chips_one1, chips_one2, life_one1, life_one2, prevchips_one1, prevchips_one2;
    reg [2:0] threesec;
    reg [3:0] fivesec1, fivesec2;
    
    integer i, j, k, l;
    
    reg [26:0] countLED1, countLED2, count;

    //////////////////////////////////////////////////////////////////
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
    
    //////////////////////////////////////////////////////////////////
    always @(posedge clk) begin
        if(datar == 5'b11111) datar = 5'b00001;
        else datar = datar + 1;
    end

    always @(posedge clk or posedge reset) begin
        if(reset) begin
            for(k = 1; k < 101; k = k + 1) begin
                card[k] = cpy_data[k];
            end
            i = 0;
        end
        else begin
            if(!i) begin
                data = datar;
                i = 1;
            end
            else begin
                data = next_data;
                if(data < 21 && i < 101) begin
                    cpy_data[i] = data;
                    i = i + 1;
                end
            end
        end
    end
    //////////////////////////////////////////////////////////////////
    always @(posedge clk) begin
        case(state)
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            INITIAL: begin
                playerflag = 3;
                val[1] = OFF; val[2] = OFF; val[3] = THREE; val[4] = ZERO; val[5] = THREE; val[6] = ZERO; val[7] = OFF; val[8] = OFF;
                chips1 = ante; chips2 = ante;
                prevchips1 = ante; prevchips2 = ante;
                life1 = 6'd30; life2 = 6'd30;
                firstplayerflag = 0;
                j = 1;
                threesec = 0;
                count = 0;
                winnerchips = 0;
                rgbflag1 = 2; rgbflag2 = 2;
                if(reset) begin
                    p1 = card[j]; p2 = card[j+1];
                    state = ANTE;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////        
            INITIAL0: begin
                playerflag = 3;
                val[1] = OFF; val[2] = OFF; val[3] = THREE; val[4] = ZERO; val[5] = THREE; val[6] = ZERO; val[7] = OFF; val[8] = OFF;
                chips1 = ante; chips2 = ante;
                prevchips1 = ante; prevchips2 = ante;
                life1 = 6'd30; life2 = 6'd30;
                firstplayerflag = 0;
                j = 1;
                threesec = 0;
                count = 0;
                winnerchips = 0;
                rgbflag1 = 2; rgbflag2 = 2;
                if(!reset) begin
                    p1 = card[j]; p2 = card[j+1];
                    state = ANTE;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////                
            ANTE: begin
                if(!reset) begin
                    val[3] = ZERO; val[4] = ONE; val[5] = ZERO; val[6] = ONE;
                    
                    case(p1)
                        5'd1: begin p1card = 4'd1; val[8] = ONE; end
                        5'd2: begin p1card = 4'd2; val[8] = TWO; end
                        5'd3: begin p1card = 4'd3; val[8] = THREE; end
                        5'd4: begin p1card = 4'd4; val[8] = FOUR; end
                        5'd5: begin p1card = 4'd5; val[8] = FIVE; end
                        5'd6: begin p1card = 4'd6; val[8] = SIX; end
                        5'd7: begin p1card = 4'd7; val[8] = SEVEN; end
                        5'd8: begin p1card = 4'd8; val[8] = EIGHT; end
                        5'd9: begin p1card = 4'd9; val[8] = NINE; end
                        5'd10: begin p1card = 4'd10; val[8] = ZERO; end
                        5'd11: begin p1card = 4'd1; val[8] = ONE; end
                        5'd12: begin p1card = 4'd2; val[8] = TWO; end
                        5'd13: begin p1card = 4'd3; val[8] = THREE; end
                        5'd14: begin p1card = 4'd4; val[8] = FOUR; end
                        5'd15: begin p1card = 4'd5; val[8] = FIVE; end
                        5'd16: begin p1card = 4'd6; val[8] = SIX; end
                        5'd17: begin p1card = 4'd7; val[8] = SEVEN; end
                        5'd18: begin p1card = 4'd8; val[8] = EIGHT; end
                        5'd19: begin p1card = 4'd9; val[8] = NINE; end
                        5'd20: begin p1card = 4'd10; val[8] = ZERO; end
                    endcase
                    case(p2)
                        5'd1: begin p2card = 4'd1; val[1] = ONE; end
                        5'd2: begin p2card = 4'd2; val[1] = TWO; end
                        5'd3: begin p2card = 4'd3; val[1] = THREE; end
                        5'd4: begin p2card = 4'd4; val[1] = FOUR; end
                        5'd5: begin p2card = 4'd5; val[1] = FIVE; end
                        5'd6: begin p2card = 4'd6; val[1] = SIX; end
                        5'd7: begin p2card = 4'd7; val[1] = SEVEN; end
                        5'd8: begin p2card = 4'd8; val[1] = EIGHT; end
                        5'd9: begin p2card = 4'd9; val[1] = NINE; end
                        5'd10: begin p2card = 4'd10; val[1] = ZERO; end
                        5'd11: begin p2card = 4'd1; val[1] = ONE; end
                        5'd12: begin p2card = 4'd2; val[1] = TWO; end
                        5'd13: begin p2card = 4'd3; val[1] = THREE; end
                        5'd14: begin p2card = 4'd4; val[1] = FOUR; end
                        5'd15: begin p2card = 4'd5; val[1] = FIVE; end
                        5'd16: begin p2card = 4'd6; val[1] = SIX; end
                        5'd17: begin p2card = 4'd7; val[1] = SEVEN; end
                        5'd18: begin p2card = 4'd8; val[1] = EIGHT; end
                        5'd19: begin p2card = 4'd9; val[1] = NINE; end
                        5'd20: begin p2card = 4'd10; val[1] = ZERO; end
                    endcase
                    state = ANTE1;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ANTE1: begin

                case(p1)
                    5'd1: begin p1card = 4'd1; val[8] = ONE; end
                    5'd2: begin p1card = 4'd2; val[8] = TWO; end
                    5'd3: begin p1card = 4'd3; val[8] = THREE; end
                    5'd4: begin p1card = 4'd4; val[8] = FOUR; end
                    5'd5: begin p1card = 4'd5; val[8] = FIVE; end
                    5'd6: begin p1card = 4'd6; val[8] = SIX; end
                    5'd7: begin p1card = 4'd7; val[8] = SEVEN; end
                    5'd8: begin p1card = 4'd8; val[8] = EIGHT; end
                    5'd9: begin p1card = 4'd9; val[8] = NINE; end
                    5'd10: begin p1card = 4'd10; val[8] = ZERO; end
                    5'd11: begin p1card = 4'd1; val[8] = ONE; end
                    5'd12: begin p1card = 4'd2; val[8] = TWO; end
                    5'd13: begin p1card = 4'd3; val[8] = THREE; end
                    5'd14: begin p1card = 4'd4; val[8] = FOUR; end
                    5'd15: begin p1card = 4'd5; val[8] = FIVE; end
                    5'd16: begin p1card = 4'd6; val[8] = SIX; end
                    5'd17: begin p1card = 4'd7; val[8] = SEVEN; end
                    5'd18: begin p1card = 4'd8; val[8] = EIGHT; end
                    5'd19: begin p1card = 4'd9; val[8] = NINE; end
                    5'd20: begin p1card = 4'd10; val[8] = ZERO; end
                endcase
                case(p2)
                    5'd1: begin p2card = 4'd1; val[1] = ONE; end
                    5'd2: begin p2card = 4'd2; val[1] = TWO; end
                    5'd3: begin p2card = 4'd3; val[1] = THREE; end
                    5'd4: begin p2card = 4'd4; val[1] = FOUR; end
                    5'd5: begin p2card = 4'd5; val[1] = FIVE; end
                    5'd6: begin p2card = 4'd6; val[1] = SIX; end
                    5'd7: begin p2card = 4'd7; val[1] = SEVEN; end
                    5'd8: begin p2card = 4'd8; val[1] = EIGHT; end
                    5'd9: begin p2card = 4'd9; val[1] = NINE; end
                    5'd10: begin p2card = 4'd10; val[1] = ZERO; end
                    5'd11: begin p2card = 4'd1; val[1] = ONE; end
                    5'd12: begin p2card = 4'd2; val[1] = TWO; end
                    5'd13: begin p2card = 4'd3; val[1] = THREE; end
                    5'd14: begin p2card = 4'd4; val[1] = FOUR; end
                    5'd15: begin p2card = 4'd5; val[1] = FIVE; end
                    5'd16: begin p2card = 4'd6; val[1] = SIX; end
                    5'd17: begin p2card = 4'd7; val[1] = SEVEN; end
                    5'd18: begin p2card = 4'd8; val[1] = EIGHT; end
                    5'd19: begin p2card = 4'd9; val[1] = NINE; end
                    5'd20: begin p2card = 4'd10; val[1] = ZERO; end
                endcase
                
                if(!firstplayerflag) begin
                    playerflag = 0;
                    if(up) begin
                        if(chips1 < life1 && chips1 < life2) begin
                            chips1 = chips1 + 1;
                            chips_ten1 = chips1 / 10;
                            chips_one1 = chips1 % 10;
                            case(chips_ten1)
                                3'd0: val[3] = ZERO;
                                3'd1: val[3] = ONE;
                                3'd2: val[3] = TWO;
                                3'd3: val[3] = THREE;
                                3'd4: val[3] = FOUR;
                                3'd5: val[3] = FIVE;
                                3'd6: val[3] = SIX;
                            endcase
                            case(chips_one1)
                                4'd0: val[4] = ZERO;
                                4'd1: val[4] = ONE;
                                4'd2: val[4] = TWO;
                                4'd3: val[4] = THREE;
                                4'd4: val[4] = FOUR;
                                4'd5: val[4] = FIVE;
                                4'd6: val[4] = SIX;
                                4'd7: val[4] = SEVEN;
                                4'd8: val[4] = EIGHT;
                                4'd9: val[4] = NINE;
                            endcase
                        end
                        state = ANTE1b1;
                    end
                    else if(down) begin
                        if(chips1 > prevchips1) begin
                            chips1 = chips1 - 1;
                            chips_ten1 = chips1 / 10;
                            chips_one1 = chips1 % 10;
                            case(chips_ten1)
                                3'd0: val[3] = ZERO;
                                3'd1: val[3] = ONE;
                                3'd2: val[3] = TWO;
                                3'd3: val[3] = THREE;
                                3'd4: val[3] = FOUR;
                                3'd5: val[3] = FIVE;
                                3'd6: val[3] = SIX;
                            endcase
                            case(chips_one1)
                                4'd0: val[4] = ZERO;
                                4'd1: val[4] = ONE;
                                4'd2: val[4] = TWO;
                                4'd3: val[4] = THREE;
                                4'd4: val[4] = FOUR;
                                4'd5: val[4] = FIVE;
                                4'd6: val[4] = SIX;
                                4'd7: val[4] = SEVEN;
                                4'd8: val[4] = EIGHT;
                                4'd9: val[4] = NINE;
                            endcase
                        end
                        state = ANTE1c1;
                    end
                    else if(set) begin
                        if(chips1 == ante) state = ANTE1d1;
                        else begin
                            prevchips1 = chips1;
                            state = F1B1d1;
                        end
                    end
                    else if(allin) begin
                        if(life1 < life2) chips1 = life1;
                        else chips1 = life2;
                        chips_ten1 = chips1 / 10;
                        chips_one1 = chips1 % 10;
                        case(chips_ten1)
                            3'd0: val[3] = ZERO;
                            3'd1: val[3] = ONE;
                            3'd2: val[3] = TWO;
                            3'd3: val[3] = THREE;
                            3'd4: val[3] = FOUR;
                            3'd5: val[3] = FIVE;
                            3'd6: val[3] = SIX;
                        endcase
                        case(chips_one1)
                            4'd0: val[4] = ZERO;
                            4'd1: val[4] = ONE;
                            4'd2: val[4] = TWO;
                            4'd3: val[4] = THREE;
                            4'd4: val[4] = FOUR;
                            4'd5: val[4] = FIVE;
                            4'd6: val[4] = SIX;
                            4'd7: val[4] = SEVEN;
                            4'd8: val[4] = EIGHT;
                            4'd9: val[4] = NINE;
                        endcase
                        state = ANTE1in;
                    end
                end
                
                else if(firstplayerflag) begin
                    playerflag = 1;
                    if(up) begin
                        if(chips2 < life1 && chips2 < life2) begin 
                            chips2 = chips2 + 1;
                            chips_ten2 = chips2 / 10;
                            chips_one2 = chips2 % 10;
                            case(chips_ten2)
                                3'd0: val[5] = ZERO;
                                3'd1: val[5] = ONE;
                                3'd2: val[5] = TWO;
                                3'd3: val[5] = THREE;
                                3'd4: val[5] = FOUR;
                                3'd5: val[5] = FIVE;
                                3'd6: val[5] = SIX;
                            endcase
                            case(chips_one2)
                                4'd0: val[6] = ZERO;
                                4'd1: val[6] = ONE;
                                4'd2: val[6] = TWO;
                                4'd3: val[6] = THREE;
                                4'd4: val[6] = FOUR;
                                4'd5: val[6] = FIVE;
                                4'd6: val[6] = SIX;
                                4'd7: val[6] = SEVEN;
                                4'd8: val[6] = EIGHT;
                                4'd9: val[6] = NINE;
                            endcase
                        end
                        state = ANTE1b2;
                    end
                    else if(down) begin
                        if(chips2 > prevchips2) begin
                            chips2 = chips2 - 1;
                            chips_ten2 = chips2 / 10;
                            chips_one2 = chips2 % 10;
                            case(chips_ten2)
                                3'd0: val[5] = ZERO;
                                3'd1: val[5] = ONE;
                                3'd2: val[5] = TWO;
                                3'd3: val[5] = THREE;
                                3'd4: val[5] = FOUR;
                                3'd5: val[5] = FIVE;
                                3'd6: val[5] = SIX;
                            endcase
                            case(chips_one2)
                                4'd0: val[6] = ZERO;
                                4'd1: val[6] = ONE;
                                4'd2: val[6] = TWO;
                                4'd3: val[6] = THREE;
                                4'd4: val[6] = FOUR;
                                4'd5: val[6] = FIVE;
                                4'd6: val[6] = SIX;
                                4'd7: val[6] = SEVEN;
                                4'd8: val[6] = EIGHT;
                                4'd9: val[6] = NINE;
                            endcase
                        end
                        state = ANTE1c2;
                    end
                    else if(set) begin
                        if(chips2 == ante) state = ANTE1d2;
                        else begin 
                            prevchips2 = chips2;
                            state = F2B2d1;
                        end
                    end
                    else if(allin) begin
                        if(life1 < life2) chips2 = life1;
                        else chips2 = life2;
                        chips_ten2 = chips2 / 10;
                        chips_one2 = chips2 % 10;
                        case(chips_ten2)
                            3'd0: val[5] = ZERO;
                            3'd1: val[5] = ONE;
                            3'd2: val[5] = TWO;
                            3'd3: val[5] = THREE;
                            3'd4: val[5] = FOUR;
                            3'd5: val[5] = FIVE;
                            3'd6: val[5] = SIX;
                        endcase
                        case(chips_one2)
                            4'd0: val[6] = ZERO;
                            4'd1: val[6] = ONE;
                            4'd2: val[6] = TWO;
                            4'd3: val[6] = THREE;
                            4'd4: val[6] = FOUR;
                            4'd5: val[6] = FIVE;
                            4'd6: val[6] = SIX;
                            4'd7: val[6] = SEVEN;
                            4'd8: val[6] = EIGHT;
                            4'd9: val[6] = NINE;
                        endcase
                        state = ANTE1in;
                    end
                end
                
                if(reset) begin
                    state = INITIAL0;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ANTE1b1: begin
                if(!up) state = ANTE1;
            end
            ANTE1b2: begin
                if(!up) state = ANTE1;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ANTE1c1: begin
                if(!down) state = ANTE1;
            end
            ANTE1c2: begin
                if(!down) state = ANTE1;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ANTE1d1: begin
                if(!set) state = F1CHECK;
            end
            ANTE1d2: begin
                if(!set) state = F2CHECK;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ANTE1in: begin
                if(!allin) state = ANTE1;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ANTED: begin

                case(p1)
                    5'd1: begin p1card = 4'd1; val[8] = ONE; end
                    5'd2: begin p1card = 4'd2; val[8] = TWO; end
                    5'd3: begin p1card = 4'd3; val[8] = THREE; end
                    5'd4: begin p1card = 4'd4; val[8] = FOUR; end
                    5'd5: begin p1card = 4'd5; val[8] = FIVE; end
                    5'd6: begin p1card = 4'd6; val[8] = SIX; end
                    5'd7: begin p1card = 4'd7; val[8] = SEVEN; end
                    5'd8: begin p1card = 4'd8; val[8] = EIGHT; end
                    5'd9: begin p1card = 4'd9; val[8] = NINE; end
                    5'd10: begin p1card = 4'd10; val[8] = ZERO; end
                    5'd11: begin p1card = 4'd1; val[8] = ONE; end
                    5'd12: begin p1card = 4'd2; val[8] = TWO; end
                    5'd13: begin p1card = 4'd3; val[8] = THREE; end
                    5'd14: begin p1card = 4'd4; val[8] = FOUR; end
                    5'd15: begin p1card = 4'd5; val[8] = FIVE; end
                    5'd16: begin p1card = 4'd6; val[8] = SIX; end
                    5'd17: begin p1card = 4'd7; val[8] = SEVEN; end
                    5'd18: begin p1card = 4'd8; val[8] = EIGHT; end
                    5'd19: begin p1card = 4'd9; val[8] = NINE; end
                    5'd20: begin p1card = 4'd10; val[8] = ZERO; end
                endcase
                case(p2)
                    5'd1: begin p2card = 4'd1; val[1] = ONE; end
                    5'd2: begin p2card = 4'd2; val[1] = TWO; end
                    5'd3: begin p2card = 4'd3; val[1] = THREE; end
                    5'd4: begin p2card = 4'd4; val[1] = FOUR; end
                    5'd5: begin p2card = 4'd5; val[1] = FIVE; end
                    5'd6: begin p2card = 4'd6; val[1] = SIX; end
                    5'd7: begin p2card = 4'd7; val[1] = SEVEN; end
                    5'd8: begin p2card = 4'd8; val[1] = EIGHT; end
                    5'd9: begin p2card = 4'd9; val[1] = NINE; end
                    5'd10: begin p2card = 4'd10; val[1] = ZERO; end
                    5'd11: begin p2card = 4'd1; val[1] = ONE; end
                    5'd12: begin p2card = 4'd2; val[1] = TWO; end
                    5'd13: begin p2card = 4'd3; val[1] = THREE; end
                    5'd14: begin p2card = 4'd4; val[1] = FOUR; end
                    5'd15: begin p2card = 4'd5; val[1] = FIVE; end
                    5'd16: begin p2card = 4'd6; val[1] = SIX; end
                    5'd17: begin p2card = 4'd7; val[1] = SEVEN; end
                    5'd18: begin p2card = 4'd8; val[1] = EIGHT; end
                    5'd19: begin p2card = 4'd9; val[1] = NINE; end
                    5'd20: begin p2card = 4'd10; val[1] = ZERO; end
                endcase
                
                chips_ten1 = chips1 / 10;
                chips_one1 = chips1 % 10;
                case(chips_ten1)
                    3'd0: val[3] = ZERO;
                    3'd1: val[3] = ONE;
                    3'd2: val[3] = TWO;
                    3'd3: val[3] = THREE;
                    3'd4: val[3] = FOUR;
                    3'd5: val[3] = FIVE;
                    3'd6: val[3] = SIX;
                endcase
                case(chips_one1)
                    4'd0: val[4] = ZERO;
                    4'd1: val[4] = ONE;
                    4'd2: val[4] = TWO;
                    4'd3: val[4] = THREE;
                    4'd4: val[4] = FOUR;
                    4'd5: val[4] = FIVE;
                    4'd6: val[4] = SIX;
                    4'd7: val[4] = SEVEN;
                    4'd8: val[4] = EIGHT;
                    4'd9: val[4] = NINE;
                endcase
                
                chips_ten2 = chips2 / 10;
                chips_one2 = chips2 % 10;
                case(chips_ten2)
                    3'd0: val[5] = ZERO;
                    3'd1: val[5] = ONE;
                    3'd2: val[5] = TWO;
                    3'd3: val[5] = THREE;
                    3'd4: val[5] = FOUR;
                    3'd5: val[5] = FIVE;
                    3'd6: val[5] = SIX;
                endcase
                case(chips_one2)
                    4'd0: val[6] = ZERO;
                    4'd1: val[6] = ONE;
                    4'd2: val[6] = TWO;
                    4'd3: val[6] = THREE;
                    4'd4: val[6] = FOUR;
                    4'd5: val[6] = FIVE;
                    4'd6: val[6] = SIX;
                    4'd7: val[6] = SEVEN;
                    4'd8: val[6] = EIGHT;
                    4'd9: val[6] = NINE;
                endcase
               
                if(!firstplayerflag) begin
                    playerflag = 0;
                    if(up) begin
                        if(chips1 < life1 && chips1 < life2) begin
                            chips1 = chips1 + 1;
                            chips_ten1 = chips1 / 10;
                            chips_one1 = chips1 % 10;
                            case(chips_ten1)
                                3'd0: val[3] = ZERO;
                                3'd1: val[3] = ONE;
                                3'd2: val[3] = TWO;
                                3'd3: val[3] = THREE;
                                3'd4: val[3] = FOUR;
                                3'd5: val[3] = FIVE;
                                3'd6: val[3] = SIX;
                            endcase
                            case(chips_one1)
                                4'd0: val[4] = ZERO;
                                4'd1: val[4] = ONE;
                                4'd2: val[4] = TWO;
                                4'd3: val[4] = THREE;
                                4'd4: val[4] = FOUR;
                                4'd5: val[4] = FIVE;
                                4'd6: val[4] = SIX;
                                4'd7: val[4] = SEVEN;
                                4'd8: val[4] = EIGHT;
                                4'd9: val[4] = NINE;
                            endcase
                        end
                        state = ANTEDb1;
                    end
                    else if(down) begin
                        if(chips1 > prevchips1) begin
                            chips1 = chips1 - 1;
                            chips_ten1 = chips1 / 10;
                            chips_one1 = chips1 % 10;
                            case(chips_ten1)
                                3'd0: val[3] = ZERO;
                                3'd1: val[3] = ONE;
                                3'd2: val[3] = TWO;
                                3'd3: val[3] = THREE;
                                3'd4: val[3] = FOUR;
                                3'd5: val[3] = FIVE;
                                3'd6: val[3] = SIX;
                            endcase
                            case(chips_one1)
                                4'd0: val[4] = ZERO;
                                4'd1: val[4] = ONE;
                                4'd2: val[4] = TWO;
                                4'd3: val[4] = THREE;
                                4'd4: val[4] = FOUR;
                                4'd5: val[4] = FIVE;
                                4'd6: val[4] = SIX;
                                4'd7: val[4] = SEVEN;
                                4'd8: val[4] = EIGHT;
                                4'd9: val[4] = NINE;
                            endcase
                        end
                        state = ANTEDc1;
                    end
                    else if(set) begin
                        if(chips1 == prevchips1) state = ANTEDd1;
                        else begin
                            prevchips1 = chips1;
                            state = F1B1d1;
                        end
                    end
                    else if(allin) begin
                        if(life1 < life2) chips1 = life1;
                        else chips1 = life2;
                        chips_ten1 = chips1 / 10;
                        chips_one1 = chips1 % 10;
                        case(chips_ten1)
                            3'd0: val[3] = ZERO;
                            3'd1: val[3] = ONE;
                            3'd2: val[3] = TWO;
                            3'd3: val[3] = THREE;
                            3'd4: val[3] = FOUR;
                            3'd5: val[3] = FIVE;
                            3'd6: val[3] = SIX;
                        endcase
                        case(chips_one1)
                            4'd0: val[4] = ZERO;
                            4'd1: val[4] = ONE;
                            4'd2: val[4] = TWO;
                            4'd3: val[4] = THREE;
                            4'd4: val[4] = FOUR;
                            4'd5: val[4] = FIVE;
                            4'd6: val[4] = SIX;
                            4'd7: val[4] = SEVEN;
                            4'd8: val[4] = EIGHT;
                            4'd9: val[4] = NINE;
                        endcase
                        state = ANTEDin;
                    end
                end
                
                else if(firstplayerflag) begin
                    playerflag = 1;
                    if(up) begin
                        if(chips2 < life1 && chips2 < life2) begin 
                            chips2 = chips2 + 1;
                            chips_ten2 = chips2 / 10;
                            chips_one2 = chips2 % 10;
                            case(chips_ten2)
                                3'd0: val[5] = ZERO;
                                3'd1: val[5] = ONE;
                                3'd2: val[5] = TWO;
                                3'd3: val[5] = THREE;
                                3'd4: val[5] = FOUR;
                                3'd5: val[5] = FIVE;
                                3'd6: val[5] = SIX;
                            endcase
                            case(chips_one2)
                                4'd0: val[6] = ZERO;
                                4'd1: val[6] = ONE;
                                4'd2: val[6] = TWO;
                                4'd3: val[6] = THREE;
                                4'd4: val[6] = FOUR;
                                4'd5: val[6] = FIVE;
                                4'd6: val[6] = SIX;
                                4'd7: val[6] = SEVEN;
                                4'd8: val[6] = EIGHT;
                                4'd9: val[6] = NINE;
                            endcase
                        end
                        state = ANTEDb2;
                    end
                    else if(down) begin
                        if(chips2 > prevchips2) begin
                            chips2 = chips2 - 1;
                            chips_ten2 = chips2 / 10;
                            chips_one2 = chips2 % 10;
                            case(chips_ten2)
                                3'd0: val[5] = ZERO;
                                3'd1: val[5] = ONE;
                                3'd2: val[5] = TWO;
                                3'd3: val[5] = THREE;
                                3'd4: val[5] = FOUR;
                                3'd5: val[5] = FIVE;
                                3'd6: val[5] = SIX;
                            endcase
                            case(chips_one2)
                                4'd0: val[6] = ZERO;
                                4'd1: val[6] = ONE;
                                4'd2: val[6] = TWO;
                                4'd3: val[6] = THREE;
                                4'd4: val[6] = FOUR;
                                4'd5: val[6] = FIVE;
                                4'd6: val[6] = SIX;
                                4'd7: val[6] = SEVEN;
                                4'd8: val[6] = EIGHT;
                                4'd9: val[6] = NINE;
                            endcase
                        end
                        state = ANTEDc2;
                    end
                    else if(set) begin
                        if(chips2 == prevchips2) state = ANTEDd2;
                        else begin 
                            prevchips2 = chips2;
                            state = F2B2d1;
                        end
                    end
                    else if(allin) begin
                        if(life1 < life2) chips2 = life1;
                        else chips2 = life2;
                        chips_ten2 = chips2 / 10;
                        chips_one2 = chips2 % 10;
                        case(chips_ten2)
                            3'd0: val[5] = ZERO;
                            3'd1: val[5] = ONE;
                            3'd2: val[5] = TWO;
                            3'd3: val[5] = THREE;
                            3'd4: val[5] = FOUR;
                            3'd5: val[5] = FIVE;
                            3'd6: val[5] = SIX;
                        endcase
                        case(chips_one2)
                            4'd0: val[6] = ZERO;
                            4'd1: val[6] = ONE;
                            4'd2: val[6] = TWO;
                            4'd3: val[6] = THREE;
                            4'd4: val[6] = FOUR;
                            4'd5: val[6] = FIVE;
                            4'd6: val[6] = SIX;
                            4'd7: val[6] = SEVEN;
                            4'd8: val[6] = EIGHT;
                            4'd9: val[6] = NINE;
                        endcase
                        state = ANTEDin;
                    end
                end
                if(reset) begin
                    state = INITIAL0;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ANTEDf: begin
                playerflag = 3;
        
                case(p1)
                    5'd1: begin p1card = 4'd1; end
                    5'd2: begin p1card = 4'd2; end
                    5'd3: begin p1card = 4'd3; end
                    5'd4: begin p1card = 4'd4; end
                    5'd5: begin p1card = 4'd5; end
                    5'd6: begin p1card = 4'd6; end
                    5'd7: begin p1card = 4'd7; end
                    5'd8: begin p1card = 4'd8; end
                    5'd9: begin p1card = 4'd9; end
                    5'd10: begin p1card = 4'd10; end
                    5'd11: begin p1card = 4'd1; end
                    5'd12: begin p1card = 4'd2; end
                    5'd13: begin p1card = 4'd3; end
                    5'd14: begin p1card = 4'd4; end
                    5'd15: begin p1card = 4'd5; end
                    5'd16: begin p1card = 4'd6; end
                    5'd17: begin p1card = 4'd7; end
                    5'd18: begin p1card = 4'd8; end
                    5'd19: begin p1card = 4'd9; end
                    5'd20: begin p1card = 4'd10; end
                endcase
                case(p2)
                    5'd1: begin p2card = 4'd1; end
                    5'd2: begin p2card = 4'd2; end
                    5'd3: begin p2card = 4'd3; end
                    5'd4: begin p2card = 4'd4; end
                    5'd5: begin p2card = 4'd5; end
                    5'd6: begin p2card = 4'd6; end
                    5'd7: begin p2card = 4'd7; end
                    5'd8: begin p2card = 4'd8; end
                    5'd9: begin p2card = 4'd9; end
                    5'd10: begin p2card = 4'd10; end
                    5'd11: begin p2card = 4'd1; end
                    5'd12: begin p2card = 4'd2; end
                    5'd13: begin p2card = 4'd3; end
                    5'd14: begin p2card = 4'd4; end
                    5'd15: begin p2card = 4'd5; end
                    5'd16: begin p2card = 4'd6; end
                    5'd17: begin p2card = 4'd7; end
                    5'd18: begin p2card = 4'd8; end
                    5'd19: begin p2card = 4'd9; end
                    5'd20: begin p2card = 4'd10; end
                endcase
                
                prevchips_ten1 = prevchips1 / 10;
                prevchips_one1 = prevchips1 % 10;
                case(prevchips_ten1)
                    3'd0: val[3] = ZERO;
                    3'd1: val[3] = ONE;
                    3'd2: val[3] = TWO;
                    3'd3: val[3] = THREE;
                    3'd4: val[3] = FOUR;
                    3'd5: val[3] = FIVE;
                    3'd6: val[3] = SIX;
                endcase
                case(prevchips_one1)
                    4'd0: val[4] = ZERO;
                    4'd1: val[4] = ONE;
                    4'd2: val[4] = TWO;
                    4'd3: val[4] = THREE;
                    4'd4: val[4] = FOUR;
                    4'd5: val[4] = FIVE;
                    4'd6: val[4] = SIX;
                    4'd7: val[4] = SEVEN;
                    4'd8: val[4] = EIGHT;
                    4'd9: val[4] = NINE;
                endcase
                
                prevchips_ten2 = prevchips2 / 10;
                prevchips_one2 = prevchips2 % 10;
                case(prevchips_ten2)
                    3'd0: val[5] = ZERO;
                    3'd1: val[5] = ONE;
                    3'd2: val[5] = TWO;
                    3'd3: val[5] = THREE;
                    3'd4: val[5] = FOUR;
                    3'd5: val[5] = FIVE;
                    3'd6: val[5] = SIX;
                endcase
                case(prevchips_one2)
                    4'd0: val[6] = ZERO;
                    4'd1: val[6] = ONE;
                    4'd2: val[6] = TWO;
                    4'd3: val[6] = THREE;
                    4'd4: val[6] = FOUR;
                    4'd5: val[6] = FIVE;
                    4'd6: val[6] = SIX;
                    4'd7: val[6] = SEVEN;
                    4'd8: val[6] = EIGHT;
                    4'd9: val[6] = NINE;
                endcase
               
                if(set) begin
                    winnerchips = chips1;
                    state = ANTEDfd;
                end
                
                if(reset) begin
                    state = INITIAL0;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ANTEDb1: begin
                if(!up) state = ANTED;
            end
            ANTEDb2: begin
                if(!up) state = ANTED;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ANTEDc1: begin
                if(!down) state = ANTED;
            end
            ANTEDc2: begin
                if(!down) state = ANTED;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ANTEDd1: begin
                if(!set) state = F1CHECK;
            end
            ANTEDd2: begin
                if(!set) state = F2CHECK;
            end
            ANTEDfd: begin
                if(!set) begin
                    threesec = 0;
                    j = j + 2;
                    if(j == 101) j = ((datar * 2) % 10) * 10 + 1;
                    state = CALL;
                end
            end
            
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            ANTEDin: begin
                if(!allin) state = ANTED;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F1B1: begin
                playerflag = 0;
                if(up) begin
                    if(chips1 < life1 && chips1 < life2) begin
                        chips1 = chips1 + 1;
                        chips_ten1 = chips1 / 10;
                        chips_one1 = chips1 % 10;
                        case(chips_ten1)
                            3'd0: val[3] = ZERO;
                            3'd1: val[3] = ONE;
                            3'd2: val[3] = TWO;
                            3'd3: val[3] = THREE;
                            3'd4: val[3] = FOUR;
                            3'd5: val[3] = FIVE;
                            3'd6: val[3] = SIX;
                        endcase
                        case(chips_one1)
                            4'd0: val[4] = ZERO;
                            4'd1: val[4] = ONE;
                            4'd2: val[4] = TWO;
                            4'd3: val[4] = THREE;
                            4'd4: val[4] = FOUR;
                            4'd5: val[4] = FIVE;
                            4'd6: val[4] = SIX;
                            4'd7: val[4] = SEVEN;
                            4'd8: val[4] = EIGHT;
                            4'd9: val[4] = NINE;
                        endcase
                    end
                    state = F1B1b;
                end
                else if(down) begin
                    if(chips1 > prevchips1) begin
                        chips1 = chips1 - 1;
                        chips_ten1 = chips1 / 10;
                        chips_one1 = chips1 % 10;
                        case(chips_ten1)
                            3'd0: val[3] = ZERO;
                            3'd1: val[3] = ONE;
                            3'd2: val[3] = TWO;
                            3'd3: val[3] = THREE;
                            3'd4: val[3] = FOUR;
                            3'd5: val[3] = FIVE;
                            3'd6: val[3] = SIX;
                        endcase
                        case(chips_one1)
                            4'd0: val[4] = ZERO;
                            4'd1: val[4] = ONE;
                            4'd2: val[4] = TWO;
                            4'd3: val[4] = THREE;
                            4'd4: val[4] = FOUR;
                            4'd5: val[4] = FIVE;
                            4'd6: val[4] = SIX;
                            4'd7: val[4] = SEVEN;
                            4'd8: val[4] = EIGHT;
                            4'd9: val[4] = NINE;
                        endcase
                    end
                    state = F1B1c;
                end
                else if(set) begin
                    if(chips1 > chips2) begin 
                        prevchips1 = chips1;
                        state = F1B1d1;
                    end
                    else if(chips1 == chips2) begin
                        prevchips1 = chips1;
                        prevchips2 = chips2;
                        firstplayerflag = 1;
                        winnerchips = chips1;
                        state = F1B1d2;
                    end
                    else if(chips1 < chips2) begin
                        firstplayerflag = 1;
                        state = F1B1d3;
                    end
                end
                else if(allin) begin
                    if(life1 < life2) chips1 = life1;
                    else chips1 = life2;
                    chips_ten1 = chips1 / 10;
                    chips_one1 = chips1 % 10;
                    case(chips_ten1)
                        3'd0: val[3] = ZERO;
                        3'd1: val[3] = ONE;
                        3'd2: val[3] = TWO;
                        3'd3: val[3] = THREE;
                        3'd4: val[3] = FOUR;
                        3'd5: val[3] = FIVE;
                        3'd6: val[3] = SIX;
                    endcase
                    case(chips_one1)
                        4'd0: val[4] = ZERO;
                        4'd1: val[4] = ONE;
                        4'd2: val[4] = TWO;
                        4'd3: val[4] = THREE;
                        4'd4: val[4] = FOUR;
                        4'd5: val[4] = FIVE;
                        4'd6: val[4] = SIX;
                        4'd7: val[4] = SEVEN;
                        4'd8: val[4] = EIGHT;
                        4'd9: val[4] = NINE;
                    endcase
                    state = F1B1in;
                end
                if(reset) begin
                    state = INITIAL0;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F1B1b: begin
                if(!up) state = F1B1;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F1B1c: begin
                if(!down) state = F1B1;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F1B1d1: begin
                if(!set) state = F1B2;
            end
            F1B1d2: begin
                if(!set) begin
                    threesec = 0;
                    j = j + 2;
                    if(j == 101) j = ((datar * 2) % 10) * 10 + 1;
                    state = CALL;
                end
            end
            F1B1d3: begin
                if(!set) begin 
                    threesec = 0;
                    j = j + 2;
                    if(j == 101) j = ((datar * 2) % 10) * 10 + 1;
                    state = FOLD;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F1B1in: begin
                if(!allin) state = F1B1;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F1CHECK: begin//P2              
                playerflag = 1;
                if(up) begin
                    chips2 = chips2 + 1;
                    chips_ten2 = chips2 / 10;
                    chips_one2 = chips2 % 10;
                    case(chips_ten2)
                        3'd0: val[5] = ZERO;
                        3'd1: val[5] = ONE;
                        3'd2: val[5] = TWO;
                        3'd3: val[5] = THREE;
                        3'd4: val[5] = FOUR;
                        3'd5: val[5] = FIVE;
                        3'd6: val[5] = SIX;
                    endcase
                    case(chips_one2)
                        4'd0: val[6] = ZERO;
                        4'd1: val[6] = ONE;
                        4'd2: val[6] = TWO;
                        4'd3: val[6] = THREE;
                        4'd4: val[6] = FOUR;
                        4'd5: val[6] = FIVE;
                        4'd6: val[6] = SIX;
                        4'd7: val[6] = SEVEN;
                        4'd8: val[6] = EIGHT;
                        4'd9: val[6] = NINE;
                    endcase
                    state = F1CHECKb;
                end
                else if(set) begin
                    prevchips1 = chips1;
                    prevchips2 = chips2;
                    firstplayerflag = 0;
                    winnerchips = chips1;
                    state = F1CHECKd;
                end
                else if(allin) begin
                    if(life1 < life2) chips2 = life1;
                    else chips2 = life2;
                    chips_ten2 = chips2 / 10;
                    chips_one2 = chips2 % 10;
                    case(chips_ten2)
                        3'd0: val[5] = ZERO;
                        3'd1: val[5] = ONE;
                        3'd2: val[5] = TWO;
                        3'd3: val[5] = THREE;
                        3'd4: val[5] = FOUR;
                        3'd5: val[5] = FIVE;
                        3'd6: val[5] = SIX;
                    endcase
                    case(chips_one2)
                        4'd0: val[6] = ZERO;
                        4'd1: val[6] = ONE;
                        4'd2: val[6] = TWO;
                        4'd3: val[6] = THREE;
                        4'd4: val[6] = FOUR;
                        4'd5: val[6] = FIVE;
                        4'd6: val[6] = SIX;
                        4'd7: val[6] = SEVEN;
                        4'd8: val[6] = EIGHT;
                        4'd9: val[6] = NINE;
                    endcase
                    state = F1CHECKin;
                end
                if(reset) begin
                    state = INITIAL0;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F1CHECKb: begin
                if(!up) state = F1B2;
            end
            F1CHECKd: begin
                if(!set) begin
                    threesec = 0;
                    j = j + 2;
                    if(j == 101) j = ((datar * 2) % 10) * 10 + 1;
                    state = CALL;
                end
            end
            F1CHECKin: begin
                if(!allin) state = F1CHECK;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F1B2: begin
                playerflag = 1;
                if(up) begin
                    if(chips2 < life1 && chips2 < life2) begin 
                        chips2 = chips2 + 1;
                        chips_ten2 = chips2 / 10;
                        chips_one2 = chips2 % 10;
                        case(chips_ten2)
                            3'd0: val[5] = ZERO;
                            3'd1: val[5] = ONE;
                            3'd2: val[5] = TWO;
                            3'd3: val[5] = THREE;
                            3'd4: val[5] = FOUR;
                            3'd5: val[5] = FIVE;
                            3'd6: val[5] = SIX;
                        endcase
                        case(chips_one2)
                            4'd0: val[6] = ZERO;
                            4'd1: val[6] = ONE;
                            4'd2: val[6] = TWO;
                            4'd3: val[6] = THREE;
                            4'd4: val[6] = FOUR;
                            4'd5: val[6] = FIVE;
                            4'd6: val[6] = SIX;
                            4'd7: val[6] = SEVEN;
                            4'd8: val[6] = EIGHT;
                            4'd9: val[6] = NINE;
                        endcase
                    end
                    state = F1B2b;
                end
                else if(down) begin
                    if(chips2 > prevchips2) begin
                        chips2 = chips2 - 1;
                        chips_ten2 = chips2 / 10;
                        chips_one2 = chips2 % 10;
                        case(chips_ten2)
                            3'd0: val[5] = ZERO;
                            3'd1: val[5] = ONE;
                            3'd2: val[5] = TWO;
                            3'd3: val[5] = THREE;
                            3'd4: val[5] = FOUR;
                            3'd5: val[5] = FIVE;
                            3'd6: val[5] = SIX;
                        endcase
                        case(chips_one2)
                            4'd0: val[6] = ZERO;
                            4'd1: val[6] = ONE;
                            4'd2: val[6] = TWO;
                            4'd3: val[6] = THREE;
                            4'd4: val[6] = FOUR;
                            4'd5: val[6] = FIVE;
                            4'd6: val[6] = SIX;
                            4'd7: val[6] = SEVEN;
                            4'd8: val[6] = EIGHT;
                            4'd9: val[6] = NINE;
                        endcase
                    end
                    state = F1B2c;
                end
                else if(set) begin
                    if(chips2 > chips1) begin
                        prevchips2 = chips2;
                        state = F1B2d1;
                    end
                    else if(chips1 == chips2) begin
                        prevchips1 = chips1;
                        prevchips2 = chips2;
                        firstplayerflag = 0;
                        winnerchips = chips1;
                        state = F1B2d2;
                    end
                    else if(chips2 < chips1) begin 
                        firstplayerflag = 0;
                        state = F1B2d3;
                    end
                end
                else if(allin) begin
                    if(life1 < life2) chips2 = life1;
                    else chips2 = life2;
                    chips_ten2 = chips2 / 10;
                    chips_one2 = chips2 % 10;
                    case(chips_ten2)
                        3'd0: val[5] = ZERO;
                        3'd1: val[5] = ONE;
                        3'd2: val[5] = TWO;
                        3'd3: val[5] = THREE;
                        3'd4: val[5] = FOUR;
                        3'd5: val[5] = FIVE;
                        3'd6: val[5] = SIX;
                    endcase
                    case(chips_one2)
                        4'd0: val[6] = ZERO;
                        4'd1: val[6] = ONE;
                        4'd2: val[6] = TWO;
                        4'd3: val[6] = THREE;
                        4'd4: val[6] = FOUR;
                        4'd5: val[6] = FIVE;
                        4'd6: val[6] = SIX;
                        4'd7: val[6] = SEVEN;
                        4'd8: val[6] = EIGHT;
                        4'd9: val[6] = NINE;
                    endcase
                    state = F1B2in;
                end
                if(reset) begin
                    state = INITIAL0;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F1B2b: begin
                if(!up) state = F1B2;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F1B2c: begin
                if(!down) state = F1B2;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F1B2d1: begin
                if(!set) state = F1B1;
            end
            F1B2d2: begin
                if(!set) begin
                    threesec = 0;
                    j = j + 2;
                    if(j == 101) j = ((datar * 2) % 10) * 10 + 1;
                    state = CALL;
                end
            end
            F1B2d3: begin
                if(!set) begin 
                    threesec = 0;
                    j = j + 2;
                    if(j == 101) j = ((datar * 2) % 10) * 10 + 1;
                    state = FOLD;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F1B2in: begin
                if(!allin) state = F1B2;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F2B2: begin
                playerflag = 1;
                if(up) begin
                    if(chips2 < life1 && chips2 < life2) begin 
                        chips2 = chips2 + 1;
                        chips_ten2 = chips2 / 10;
                        chips_one2 = chips2 % 10;
                        case(chips_ten2)
                            3'd0: val[5] = ZERO;
                            3'd1: val[5] = ONE;
                            3'd2: val[5] = TWO;
                            3'd3: val[5] = THREE;
                            3'd4: val[5] = FOUR;
                            3'd5: val[5] = FIVE;
                            3'd6: val[5] = SIX;
                        endcase
                        case(chips_one2)
                            4'd0: val[6] = ZERO;
                            4'd1: val[6] = ONE;
                            4'd2: val[6] = TWO;
                            4'd3: val[6] = THREE;
                            4'd4: val[6] = FOUR;
                            4'd5: val[6] = FIVE;
                            4'd6: val[6] = SIX;
                            4'd7: val[6] = SEVEN;
                            4'd8: val[6] = EIGHT;
                            4'd9: val[6] = NINE;
                        endcase
                    end
                    state = F2B2b;
                end
                else if(down) begin
                    if(chips2 > prevchips2) begin
                        chips2 = chips2 - 1;
                        chips_ten2 = chips2 / 10;
                        chips_one2 = chips2 % 10;
                        case(chips_ten2)
                            3'd0: val[5] = ZERO;
                            3'd1: val[5] = ONE;
                            3'd2: val[5] = TWO;
                            3'd3: val[5] = THREE;
                            3'd4: val[5] = FOUR;
                            3'd5: val[5] = FIVE;
                            3'd6: val[5] = SIX;
                        endcase
                        case(chips_one2)
                            4'd0: val[6] = ZERO;
                            4'd1: val[6] = ONE;
                            4'd2: val[6] = TWO;
                            4'd3: val[6] = THREE;
                            4'd4: val[6] = FOUR;
                            4'd5: val[6] = FIVE;
                            4'd6: val[6] = SIX;
                            4'd7: val[6] = SEVEN;
                            4'd8: val[6] = EIGHT;
                            4'd9: val[6] = NINE;
                        endcase
                    end
                    state = F2B2c;
                end
                else if(set) begin
                    if(chips2 > chips1) begin 
                        prevchips2 = chips2;
                        state = F2B2d1;
                    end
                    else if(chips1 == chips2) begin
                        prevchips1 = chips1;
                        prevchips2 = chips2;
                        firstplayerflag = 0;
                        winnerchips = chips1;
                        state = F2B2d2;
                    end
                    else if(chips2 < chips1) begin 
                        firstplayerflag = 0;
                        state = F2B2d3;
                    end
                end
                else if(allin) begin
                    if(life1 < life2) chips2 = life1;
                    else chips2 = life2;
                    chips_ten2 = chips2 / 10;
                    chips_one2 = chips2 % 10;
                    case(chips_ten2)
                        3'd0: val[5] = ZERO;
                        3'd1: val[5] = ONE;
                        3'd2: val[5] = TWO;
                        3'd3: val[5] = THREE;
                        3'd4: val[5] = FOUR;
                        3'd5: val[5] = FIVE;
                        3'd6: val[5] = SIX;
                    endcase
                    case(chips_one2)
                        4'd0: val[6] = ZERO;
                        4'd1: val[6] = ONE;
                        4'd2: val[6] = TWO;
                        4'd3: val[6] = THREE;
                        4'd4: val[6] = FOUR;
                        4'd5: val[6] = FIVE;
                        4'd6: val[6] = SIX;
                        4'd7: val[6] = SEVEN;
                        4'd8: val[6] = EIGHT;
                        4'd9: val[6] = NINE;
                    endcase
                    state = F2B2in;
                end
                if(reset) begin
                    state = INITIAL0;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F2B2b: begin
                if(!up) state = F2B2;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F2B2c: begin
                if(!down) state = F2B2;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F2B2d1: begin
                if(!set) state = F2B1;
            end
            F2B2d2: begin
                if(!set) begin
                    threesec = 0;
                    j = j + 2;
                    if(j == 101) j = ((datar * 2) % 10) * 10 + 1;
                    state = CALL;
                end
            end
            F2B2d3: begin
                if(!set) begin 
                    threesec = 0;
                    j = j + 2;
                    if(j == 101) j = ((datar * 2) % 10) * 10 + 1;
                    state = FOLD;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F2B2in: begin
                if(!allin) state = F2B2;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F2CHECK: begin
                playerflag = 0;
                if(up) begin
                    chips1 = chips1 + 1;
                    chips_ten1 = chips1 / 10;
                    chips_one1 = chips1 % 10;
                    case(chips_ten1)
                        3'd0: val[3] = ZERO;
                        3'd1: val[3] = ONE;
                        3'd2: val[3] = TWO;
                        3'd3: val[3] = THREE;
                        3'd4: val[3] = FOUR;
                        3'd5: val[3] = FIVE;
                        3'd6: val[3] = SIX;
                    endcase
                    case(chips_one1)
                        4'd0: val[4] = ZERO;
                        4'd1: val[4] = ONE;
                        4'd2: val[4] = TWO;
                        4'd3: val[4] = THREE;
                        4'd4: val[4] = FOUR;
                        4'd5: val[4] = FIVE;
                        4'd6: val[4] = SIX;
                        4'd7: val[4] = SEVEN;
                        4'd8: val[4] = EIGHT;
                        4'd9: val[4] = NINE;
                    endcase
                    state = F2CHECKb;
                end
                else if(set) begin
                    prevchips1 = chips1;
                    prevchips2 = chips2;
                    firstplayerflag = 1;
                    winnerchips = chips1;
                    state = F2CHECKd;
                end
                else if(allin) begin
                    if(life1 < life2) chips1 = life1;
                    else chips1 = life2;
                    chips_ten1 = chips1 / 10;
                    chips_one1 = chips1 % 10;
                    case(chips_ten1)
                        3'd0: val[3] = ZERO;
                        3'd1: val[3] = ONE;
                        3'd2: val[3] = TWO;
                        3'd3: val[3] = THREE;
                        3'd4: val[3] = FOUR;
                        3'd5: val[3] = FIVE;
                        3'd6: val[3] = SIX;
                    endcase
                    case(chips_one1)
                        4'd0: val[4] = ZERO;
                        4'd1: val[4] = ONE;
                        4'd2: val[4] = TWO;
                        4'd3: val[4] = THREE;
                        4'd4: val[4] = FOUR;
                        4'd5: val[4] = FIVE;
                        4'd6: val[4] = SIX;
                        4'd7: val[4] = SEVEN;
                        4'd8: val[4] = EIGHT;
                        4'd9: val[4] = NINE;
                    endcase
                    state = F2CHECKin;
                end
                if(reset) begin
                    state = INITIAL0;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F2CHECKb: begin
                if(!up) state = F2B1;
            end
            F2CHECKd: begin
                if(!set) begin
                    threesec = 0;
                    j = j + 2;
                    if(j == 101) j = ((datar * 2) % 10) * 10 + 1;
                    state = CALL;
                end
            end
            F2CHECKin: begin
                if(!allin) state = F2CHECK;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F2B1: begin
                playerflag = 0;
                if(up) begin
                    if(chips1 < life1 && chips1 < life2) begin
                        chips1 = chips1 + 1;
                        chips_ten1 = chips1 / 10;
                        chips_one1 = chips1 % 10;
                        case(chips_ten1)
                            3'd0: val[3] = ZERO;
                            3'd1: val[3] = ONE;
                            3'd2: val[3] = TWO;
                            3'd3: val[3] = THREE;
                            3'd4: val[3] = FOUR;
                            3'd5: val[3] = FIVE;
                            3'd6: val[3] = SIX;
                        endcase
                        case(chips_one1)
                            4'd0: val[4] = ZERO;
                            4'd1: val[4] = ONE;
                            4'd2: val[4] = TWO;
                            4'd3: val[4] = THREE;
                            4'd4: val[4] = FOUR;
                            4'd5: val[4] = FIVE;
                            4'd6: val[4] = SIX;
                            4'd7: val[4] = SEVEN;
                            4'd8: val[4] = EIGHT;
                            4'd9: val[4] = NINE;
                        endcase
                    end
                    state = F2B1b;
                end
                else if(down) begin
                    if(chips1 > prevchips1) begin
                        chips1 = chips1 - 1;
                        chips_ten1 = chips1 / 10;
                        chips_one1 = chips1 % 10;
                        case(chips_ten1)
                            3'd0: val[3] = ZERO;
                            3'd1: val[3] = ONE;
                            3'd2: val[3] = TWO;
                            3'd3: val[3] = THREE;
                            3'd4: val[3] = FOUR;
                            3'd5: val[3] = FIVE;
                            3'd6: val[3] = SIX;
                        endcase
                        case(chips_one1)
                            4'd0: val[4] = ZERO;
                            4'd1: val[4] = ONE;
                            4'd2: val[4] = TWO;
                            4'd3: val[4] = THREE;
                            4'd4: val[4] = FOUR;
                            4'd5: val[4] = FIVE;
                            4'd6: val[4] = SIX;
                            4'd7: val[4] = SEVEN;
                            4'd8: val[4] = EIGHT;
                            4'd9: val[4] = NINE;
                        endcase
                    end
                    state = F2B1c;
                end
                else if(set) begin
                    if(chips1 > chips2) begin 
                        prevchips1 = chips1;
                        state = F2B1d1;
                    end
                    else if(chips1 == chips2) begin
                        prevchips1 = chips1;
                        prevchips2 = chips2;
                        firstplayerflag = 1;
                        winnerchips = chips1;
                        state = F2B1d2;
                    end
                    else if(chips1 < chips2) begin 
                        firstplayerflag = 1;
                        state = F2B1d3;
                    end
                end
                else if(allin) begin
                    if(life1 < life2) chips1 = life1;
                    else chips1 = life2;
                    chips_ten1 = chips1 / 10;
                    chips_one1 = chips1 % 10;
                    case(chips_ten1)
                        3'd0: val[3] = ZERO;
                        3'd1: val[3] = ONE;
                        3'd2: val[3] = TWO;
                        3'd3: val[3] = THREE;
                        3'd4: val[3] = FOUR;
                        3'd5: val[3] = FIVE;
                        3'd6: val[3] = SIX;
                    endcase
                    case(chips_one1)
                        4'd0: val[4] = ZERO;
                        4'd1: val[4] = ONE;
                        4'd2: val[4] = TWO;
                        4'd3: val[4] = THREE;
                        4'd4: val[4] = FOUR;
                        4'd5: val[4] = FIVE;
                        4'd6: val[4] = SIX;
                        4'd7: val[4] = SEVEN;
                        4'd8: val[4] = EIGHT;
                        4'd9: val[4] = NINE;
                    endcase
                    state = F2B1in;
                end
                if(reset) begin
                    state = INITIAL0;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F2B1b: begin
                if(!up) state = F2B1;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F2B1c: begin
                if(!down) state = F2B1;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F2B1d1: begin
                if(!set) state = F2B2;
            end
            F2B1d2: begin
                if(!set) begin
                    threesec = 0;
                    j = j + 2;
                    if(j == 21) j = 1;
                    state = CALL;
                end
            end
            F2B1d3: begin
                if(!set) begin 
                    threesec = 0;
                    j = j + 2;
                    if(j == 101) j = ((datar * 2) % 10) * 10 + 1;
                    state = FOLD;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            F2B1in: begin
                if(!allin) state = F2B1;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            CALL: begin
                playerflag = 3;
                val[1] = OFF; val[8] = OFF;

                if(threesec < 3) begin
                    case(p1card)
                        4'd1: begin val[3] = ZERO; val[4] = ONE; end
                        4'd2: begin val[3] = ZERO; val[4] = TWO; end
                        4'd3: begin val[3] = ZERO; val[4] = THREE; end
                        4'd4: begin val[3] = ZERO; val[4] = FOUR; end
                        4'd5: begin val[3] = ZERO; val[4] = FIVE; end
                        4'd6: begin val[3] = ZERO; val[4] = SIX; end
                        4'd7: begin val[3] = ZERO; val[4] = SEVEN; end
                        4'd8: begin val[3] = ZERO; val[4] = EIGHT; end
                        4'd9: begin val[3] = ZERO; val[4] = NINE; end
                        4'd10: begin val[3] = ONE; val[4] = ZERO; end
                    endcase
                    case(p2card)
                        4'd1: begin val[5] = ZERO; val[6] = ONE; end
                        4'd2: begin val[5] = ZERO; val[6] = TWO; end
                        4'd3: begin val[5] = ZERO; val[6] = THREE; end
                        4'd4: begin val[5] = ZERO; val[6] = FOUR; end
                        4'd5: begin val[5] = ZERO; val[6] = FIVE; end
                        4'd6: begin val[5] = ZERO; val[6] = SIX; end
                        4'd7: begin val[5] = ZERO; val[6] = SEVEN; end
                        4'd8: begin val[5] = ZERO; val[6] = EIGHT; end
                        4'd9: begin val[5] = ZERO; val[6] = NINE; end
                        4'd10: begin val[5] = ONE; val[6] = ZERO; end
                    endcase
                    if(count == 50000000) begin
                        threesec = threesec + 1;
                        count = 0;
                    end
                    else begin
                        count = count + 1;
                    end
                end
                
                else begin
                    if(threesec == 3) begin
                        threesec = threesec + 1;
                        if(p1card > p2card) begin
                            winnerflag = 0;
                            firstplayerflag = 0;
                            life1 = life1 + winnerchips;
                            life2 = life2 - winnerchips;
                        end
                        /*else if(p1card == p2card) begin
                        end*/
                        else if(p1card < p2card) begin
                            winnerflag = 1;
                            firstplayerflag = 1;
                            life1 = life1 - winnerchips;
                            life2 = life2 + winnerchips;
                        end
                    end
                    
                    life_ten1 = life1 / 10;
                    life_one1 = life1 % 10;
                    case(life_ten1)
                        3'd0: val[3] = ZERO;
                        3'd1: val[3] = ONE;
                        3'd2: val[3] = TWO;
                        3'd3: val[3] = THREE;
                        3'd4: val[3] = FOUR;
                        3'd5: val[3] = FIVE;
                        3'd6: val[3] = SIX;
                    endcase
                    case(life_one1)
                        4'd0: val[4] = ZERO;
                        4'd1: val[4] = ONE;
                        4'd2: val[4] = TWO;
                        4'd3: val[4] = THREE;
                        4'd4: val[4] = FOUR;
                        4'd5: val[4] = FIVE;
                        4'd6: val[4] = SIX;
                        4'd7: val[4] = SEVEN;
                        4'd8: val[4] = EIGHT;
                        4'd9: val[4] = NINE;
                    endcase
                    
                    life_ten2 = life2 / 10;
                    life_one2 = life2 % 10;
                    case(life_ten2)
                        3'd0: val[5] = ZERO;
                        3'd1: val[5] = ONE;
                        3'd2: val[5] = TWO;
                        3'd3: val[5] = THREE;
                        3'd4: val[5] = FOUR;
                        3'd5: val[5] = FIVE;
                        3'd6: val[5] = SIX;
                    endcase
                    case(life_one2)
                        4'd0: val[6] = ZERO;
                        4'd1: val[6] = ONE;
                        4'd2: val[6] = TWO;
                        4'd3: val[6] = THREE;
                        4'd4: val[6] = FOUR;
                        4'd5: val[6] = FIVE;
                        4'd6: val[6] = SIX;
                        4'd7: val[6] = SEVEN;
                        4'd8: val[6] = EIGHT;
                        4'd9: val[6] = NINE;
                    endcase
                    
                    if(life1 > 0 && life1 < 16) rgbflag1 = 1;
                    else if(life1 > 15 && life1 < 31) rgbflag1 = 2;
                    else if(life1 > 30 && life1 < 61) rgbflag1 = 3;
                    else if(life1 == 0) rgbflag1 = 0;
                    
                    if(life2 > 0 && life2 < 16) rgbflag2 = 1;
                    else if(life2 > 15 && life2 < 31) rgbflag2 = 2;
                    else if(life2 > 30 && life2 < 61) rgbflag2 = 3;
                    else if(life2 == 0) rgbflag2 = 0;
                    
                    if(set) begin
                        if((life1 == 60) || (life2 == 60)) begin
                            if(!winnerflag) begin
                                val[3] = ONE; val[4] = P; val[5] = W; val[6] = W;
                                rgbflag1 = 4; rgbflag2 = 4;
                            end
                            else if(winnerflag) begin
                                val[3] = TWO; val[4] = P; val[5] = W; val[6] = W;
                                rgbflag1 = 4; rgbflag2 = 4;
                            end
                            state = SWEEP;
                        end
                        else begin
                            if(p1card == p2card) begin     
                                chips1 = prevchips1; chips2 = prevchips2;
                                p1 = card[j]; p2 = card[j+1];
                                if(chips1 == life1 || chips2 == life2) state = CALLd3;      
                                else state = CALLd1;
                            end
                            else begin
                                p1 = card[j]; p2 = card[j+1];
                                state = CALLd2;
                            end
                        end
                    end
                        
                end
                
                if(reset) begin
                    state = INITIAL0;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            CALLd1: begin
                if(!set) state = ANTED;
            end
            CALLd2: begin
                if(!set) begin 
                    val[3] = ZERO; val[4] = ONE; val[5] = ZERO; val[6] = ONE;
                    prevchips1 = ante; prevchips2 = ante;
                    chips1 = ante; chips2 = ante;
                    state = ANTE1;
                end
            end
            CALLd3: begin
                if(!set) begin
                    state = ANTEDf;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            SWEEP: begin
                if(!set) state = SWEEPa;
            end
            SWEEPa: begin
                if(reset) state = INITIAL0;
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            FOLD: begin
                playerflag = 3;
                val[1] = OFF; val[8] = OFF;

                if(threesec < 3) begin
                    case(p1card)
                        4'd1: begin val[3] = ZERO; val[4] = ONE; end
                        4'd2: begin val[3] = ZERO; val[4] = TWO; end
                        4'd3: begin val[3] = ZERO; val[4] = THREE; end
                        4'd4: begin val[3] = ZERO; val[4] = FOUR; end
                        4'd5: begin val[3] = ZERO; val[4] = FIVE; end
                        4'd6: begin val[3] = ZERO; val[4] = SIX; end
                        4'd7: begin val[3] = ZERO; val[4] = SEVEN; end
                        4'd8: begin val[3] = ZERO; val[4] = EIGHT; end
                        4'd9: begin val[3] = ZERO; val[4] = NINE; end
                        4'd10: begin val[3] = ONE; val[4] = ZERO; end
                    endcase
                    case(p2card)
                        4'd1: begin val[5] = ZERO; val[6] = ONE; end
                        4'd2: begin val[5] = ZERO; val[6] = TWO; end
                        4'd3: begin val[5] = ZERO; val[6] = THREE; end
                        4'd4: begin val[5] = ZERO; val[6] = FOUR; end
                        4'd5: begin val[5] = ZERO; val[6] = FIVE; end
                        4'd6: begin val[5] = ZERO; val[6] = SIX; end
                        4'd7: begin val[5] = ZERO; val[6] = SEVEN; end
                        4'd8: begin val[5] = ZERO; val[6] = EIGHT; end
                        4'd9: begin val[5] = ZERO; val[6] = NINE; end
                        4'd10: begin val[5] = ONE; val[6] = ZERO; end
                    endcase
                    if(count == 50000000) begin
                        threesec = threesec + 1;
                        count = 0;
                    end
                    else begin
                        count = count + 1;
                    end
                end
                
                else begin
                    if(threesec == 3) begin
                        threesec = threesec + 1;
                        if(chips1 > chips2) begin//p2       
                            winnerflag = 0;
                            life1 = life1 + prevchips2;
                            if(p2card == 10) begin
                                if(life1 > 50) begin life1 = 60; life2 = 0; end
                                else life1 = life1 + 10; life2 = 60 - life1;
                            end
                            else begin
                                life2 = 60 - life1;
                            end
                        end
                        else if(chips1 < chips2) begin//p1       
                            winnerflag = 1;
                            if(p1card == 10) begin
                                life2 = life2 + prevchips1 + 10;
                                if(life2 > 60) life2 = 60;
                                life1 = 60 - life2;
                            end
                            else begin
                                life2 = life2 + prevchips1;
                                life1 = 60 - life2;
                            end
                        end
                    end
                    
                    life_ten1 = life1 / 10;
                    life_one1 = life1 % 10;
                    case(life_ten1)
                        3'd0: val[3] = ZERO;
                        3'd1: val[3] = ONE;
                        3'd2: val[3] = TWO;
                        3'd3: val[3] = THREE;
                        3'd4: val[3] = FOUR;
                        3'd5: val[3] = FIVE;
                        3'd6: val[3] = SIX;
                    endcase
                    case(life_one1)
                        4'd0: val[4] = ZERO;
                        4'd1: val[4] = ONE;
                        4'd2: val[4] = TWO;
                        4'd3: val[4] = THREE;
                        4'd4: val[4] = FOUR;
                        4'd5: val[4] = FIVE;
                        4'd6: val[4] = SIX;
                        4'd7: val[4] = SEVEN;
                        4'd8: val[4] = EIGHT;
                        4'd9: val[4] = NINE;
                    endcase
                    
                    life_ten2 = life2 / 10;
                    life_one2 = life2 % 10;
                    case(life_ten2)
                        3'd0: val[5] = ZERO;
                        3'd1: val[5] = ONE;
                        3'd2: val[5] = TWO;
                        3'd3: val[5] = THREE;
                        3'd4: val[5] = FOUR;
                        3'd5: val[5] = FIVE;
                        3'd6: val[5] = SIX;
                    endcase
                    case(life_one2)
                        4'd0: val[6] = ZERO;
                        4'd1: val[6] = ONE;
                        4'd2: val[6] = TWO;
                        4'd3: val[6] = THREE;
                        4'd4: val[6] = FOUR;
                        4'd5: val[6] = FIVE;
                        4'd6: val[6] = SIX;
                        4'd7: val[6] = SEVEN;
                        4'd8: val[6] = EIGHT;
                        4'd9: val[6] = NINE;
                    endcase
                    
                    if(life1 > 0 && life1 < 16) rgbflag1 = 1;
                    else if(life1 > 15 && life1 < 31) rgbflag1 = 2;
                    else if(life1 > 30 && life1 < 61) rgbflag1 = 3;
                    else if(life1 == 0) rgbflag1 = 0;
                    
                    if(life2 > 0 && life2 < 16) rgbflag2 = 1;
                    else if(life2 > 15 && life2 < 31) rgbflag2 = 2;
                    else if(life2 > 30 && life2 < 61) rgbflag2 = 3;
                    else if(life2 == 0) rgbflag2 = 0;
                    
                    if(set) begin
                        if((life1 == 60) || (life2 == 60)) begin
                            if(!winnerflag) begin
                                val[3] = ONE; val[4] = P; val[5] = W; val[6] = W;
                                rgbflag1 = 4; rgbflag2 = 4;
                            end
                            else if(winnerflag) begin
                                val[3] = TWO; val[4] = P; val[5] = W; val[6] = W;
                                rgbflag1 = 4; rgbflag2 = 4;
                            end
                            state = SWEEP;
                        end
                        else begin
                            p1 = card[j]; p2 = card[j+1];
                            state = FOLDd1;
                        end
                    end
                        
                end
                if(reset) begin
                    state = INITIAL0;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
            FOLDd1: begin
                if(!set) begin 
                    val[3] = ZERO; val[4] = ONE; val[5] = ZERO; val[6] = ONE;
                    prevchips1 = ante; prevchips2 = ante;
                    chips1 = ante; chips2 = ante;
                    state = ANTE1;
                end
            end
            ////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
        endcase
    end
    
    always @(posedge clk) begin
        case(rgbflag1)
            0: RGB1 = 3'b000;
            1: RGB1 = 3'b100;
            2: RGB1 = 3'b010;
            3: RGB1 = 3'b001;
            4: RGB1 = 3'b111;
        endcase
        
        case(rgbflag2)
            0: RGB2 = 3'b000;
            1: RGB2 = 3'b100;
            2: RGB2 = 3'b010;
            3: RGB2 = 3'b001;
            4: RGB2 = 3'b111;
        endcase
    end
    
    always @(posedge clk) begin
        case(playerflag)
            0: begin
                fivesec2 = 0; countLED2 = 0; LED2 = 0;
                
                if(fivesec1 < 10) begin       
                    if(countLED1 == 50000000) begin
                        LED1 = ~LED1;
                        fivesec1 = fivesec1 + 1;
                        countLED1 = 0;
                    end
                    else countLED1 = countLED1 + 1;
                end
                else begin 
                    if(countLED1 == 25000000) begin
                        LED1 = ~LED1;
                        countLED1 = 0;
                    end
                    else countLED1 = countLED1 + 1;
                end
            end
            
            1: begin
                fivesec1 = 0; countLED1 = 0; LED1 = 0;
                
                if(fivesec2 < 10) begin     
                    if(countLED2 == 50000000) begin
                        LED2 = ~LED2;
                        fivesec2 = fivesec2 + 1;
                        countLED2 = 0;
                    end
                    else countLED2 = countLED2 + 1;
                end
                else begin
                    if(countLED2 == 25000000) begin
                        LED2 = ~LED2;
                        countLED2 = 0;
                    end
                    else countLED2 = countLED2 + 1;
                end
            end
            
            3: begin
                fivesec1 = 0; fivesec2 = 0;
                countLED1 = 0; countLED2 = 0;
                LED1 = 0;
                LED2 = 0;
            end
        endcase
    end
    
    always @(data) begin
        if(i < 21) next_data = {data[3], data[2], data[1], data[0], data[4]^data[1]};
        else if(i > 20 && i < 41) next_data = {data[3], data[2], data[1], data[0], data[4]^data[2]};
        else if(i > 40 && i < 61) next_data = {data[0]^data[3], data[4], data[3], data[2], data[1]};
        else if(i > 60 && i < 81) next_data = {data[3], data[2], data[1], data[0], data[4]^data[2]^data[1]^data[0]};
        else if(i > 80 && i < 101) next_data = {data[3], data[2], data[1], data[0], data[4]^data[3]^data[1]^data[0]};
    end
    
endmodule   
