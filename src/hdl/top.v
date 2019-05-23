`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2019 11:46:08 AM
// Design Name: Stopwatch Lite
// Module Name: top
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Stopwatch top module, counts up to 99 or down to 00
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top(
    input clk,
    input start,
    input stop,
    input countUp,
    input reset,
    output reg [6:0] seg,
    output reg an,
    output [2:0] modeLED,
    output reg countFinished
    );
    
    wire [6:0] seg0, seg1;
    reg digit;
    reg enable;

    reg state, nextstate;
    parameter stopstate=0, startstate=1;
    
    assign modeLED[0] = countUp & enable;
    assign modeLED[1] = !countUp & enable;
    assign modeLED[2] = !enable;
    
    wire fiveHundredHzClk;
    wire oneHzClk;
    clk_divider clkDiv(
        .clk                (clk),
        .fiveHundredHzClk   (fiveHundredHzClk),
        .oneHzClk           (oneHzClk)
        );
    
    always @(posedge fiveHundredHzClk or posedge reset) begin
        if(reset) state <= stopstate;
        else state <= nextstate;
    end
    
    always @(state or start or stop or countFinished) begin
        case(state)
            stopstate: begin
                if(start) nextstate = startstate;
                else nextstate = state;
            end
            startstate: begin
                if(stop | countFinished) nextstate = stopstate;
                else nextstate = state;
            end
            default begin
                nextstate = stopstate;
            end
        endcase
    end
    
    always @(state) begin
        case(state)
            stopstate: enable = 0;
            startstate: enable = 1;
        endcase
    end
    
    reg [4:0] v0;    
    reg [4:0] v1;
    always @(posedge oneHzClk or posedge reset) begin
        if(reset) begin
            v0 = 0;
            v1 = 0;
            countFinished = 0;
        end
        else begin
            if(enable) begin
                if(countUp) begin
                    if(v1 == 9 & v0 == 9) begin
                        countFinished = 1;
                    end
                    else countFinished = 0;
                    if(v0 == 9 & !countFinished) begin
                        v0 = 0;
                        v1 = v1 + 1;
                    end
                    else if(!countFinished) v0 = v0 + 1;
                end
                else begin
                    if(v1 == 0 & v0 == 0) begin
                        countFinished = 1;
                    end
                    else countFinished = 0;
                    if(v0 == 0 & !countFinished) begin
                        v0 = 9;
                        v1 = v1 - 1;
                    end
                    else if(!countFinished) v0 = v0 - 1;
                end
            end
        end
    end

    BCD_Decoder v0_bcd(
        .v      (v0),
        .seg    (seg0)
    );
    BCD_Decoder v1_bcd(
        .v      (v1),
        .seg    (seg1)
    );
    
    always @(posedge fiveHundredHzClk) begin
        if(digit) begin 
            seg <= seg0;
            an <= 0;
        end
        else begin 
            seg <= seg1;
            an <= 1;
        end
        digit = !digit;
    end
endmodule
