`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2019 01:00:45 PM
// Design Name: 
// Module Name: clk_divider
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Takes a 100MHz clk and divides and outputs into a 1hz clk and 500Hz clk
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module clk_divider(
    input clk,
    output reg fiveHundredHzClk,
    output reg oneHzClk
    );
    wire fiveMHzClk;
    clk_wiz clkWiz(
        .clk_out1   (fiveMHzClk),
        .clk_in1    (clk)
    );
    integer fiveHundredHz_count;
    integer oneHz_count;
    always @(posedge fiveMHzClk) begin
        if(fiveHundredHz_count == 10000) begin
            fiveHundredHz_count = 0;
            fiveHundredHzClk = !fiveHundredHzClk;
        end
        if(oneHz_count == 2500000) begin
            oneHz_count = 0;
            oneHzClk = !oneHzClk;
        end
        oneHz_count = oneHz_count + 1;
        fiveHundredHz_count = fiveHundredHz_count + 1;
    end
    
    
endmodule
