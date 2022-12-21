function [31:0] select5_32bit;
    input [4:0] select;
    input [31:0] result0, result1, result2, result3, result4, result5; // ADDx, SUBx, MULx, DIVx, (CMPx), ABSx
    input [31:0] result6, result7, result8, result9, result10, result11; // ADCx, SBCx, SHLx, SHRx, ASHx, none
    input [31:0] result12, result13, result14, result15, result16, result17; // ROLx, RORx, none, none, AND, OR
    input [31:0] result18, result19, result20, result21, result22, result23; // NOT, XOR, none, none, SETL, SETH
    input [31:0] result24, result25, result26, result27, result28, result29; // LD, ST, none, none, J, JA
    input [31:0] result30, result31; // NOP, HLT

    case (select)
        5'b0_0000: select5_32bit = result0;
        5'b0_0001: select5_32bit = result1;
        5'b0_0010: select5_32bit = result2;
        5'b0_0011: select5_32bit = result3;
        5'b0_0100: select5_32bit = result4;
        5'b0_0101: select5_32bit = result5;
        5'b0_0110: select5_32bit = result6;
        5'b0_0111: select5_32bit = result7;
        5'b0_1000: select5_32bit = result8;
        5'b0_1001: select5_32bit = result9;
        5'b0_1010: select5_32bit = result10;
        5'b0_1011: select5_32bit = result11;
        5'b0_1100: select5_32bit = result12;
        5'b0_1101: select5_32bit = result13;
        5'b0_1110: select5_32bit = result14;
        5'b0_1111: select5_32bit = result15;
        5'b1_0000: select5_32bit = result16;
        5'b1_0001: select5_32bit = result17;
        5'b1_0010: select5_32bit = result18;
        5'b1_0011: select5_32bit = result19;
        5'b1_0100: select5_32bit = result20;
        5'b1_0101: select5_32bit = result21;
        5'b1_0110: select5_32bit = result22;
        5'b1_0111: select5_32bit = result23;
        5'b1_1000: select5_32bit = result24;
        5'b1_1001: select5_32bit = result25;
        5'b1_1010: select5_32bit = result26;
        5'b1_1011: select5_32bit = result27;
        5'b1_1100: select5_32bit = result28;
        5'b1_1101: select5_32bit = result29;
        5'b1_1110: select5_32bit = result30;
        5'b1_1111: select5_32bit = result31;
    endcase
endfunction