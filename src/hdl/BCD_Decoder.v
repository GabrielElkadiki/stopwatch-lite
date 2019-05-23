`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/17/2019 04:01:11 PM
// Design Name: 
// Module Name: BCD_Decoder
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: Takes a 4-bit input and outputs the segment combination for an seven segment display
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module BCD_Decoder(
    input [4:0] v,
    output reg [6:0] seg
);

always @(v) begin
    case(v)
        0: seg = 7'b0111111;
        1: seg = 7'b0000110;
        2: seg = 7'b1011011;
        3: seg = 7'b1001111;
        4: seg = 7'b1100110;
        5: seg = 7'b1101101;
        6: seg = 7'b1111101;
        7: seg = 7'b0000111;
        8: seg = 7'b1111111;
        9: seg = 7'b1101111;
        default: seg = 7'b0000000;
    endcase
end

endmodule