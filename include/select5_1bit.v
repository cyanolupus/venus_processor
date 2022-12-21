function select5_1bit;
    input [4:0] select;
    input result0, result1, result2, result3, result4, result5; // ADDx, SUBx, MULx, DIVx, (CMPx), ABSx
    input result6, result7, result8, result9, result10, result11; // ADCx, SBCx, SHLx, SHRx, ASHx, none
    input result12, result13, result14, result15, result16, result17; // ROLx, RORx, none, none, AND, OR
    input result18, result19, result20, result21, result22, result23; // NOT, XOR, none, none, SETL, SETH
    input result24, result25, result26, result27, result28, result29; // LD, ST, none, none, J, JA
    input result30, result31; // NOP, HLT

    case (select)
        5'b0_0000: select5_1bit = result0;
        5'b0_0001: select5_1bit = result1;
        5'b0_0010: select5_1bit = result2;
        5'b0_0011: select5_1bit = result3;
        5'b0_0100: select5_1bit = result4;
        5'b0_0101: select5_1bit = result5;
        5'b0_0110: select5_1bit = result6;
        5'b0_0111: select5_1bit = result7;
        5'b0_1000: select5_1bit = result8;
        5'b0_1001: select5_1bit = result9;
        5'b0_1010: select5_1bit = result10;
        5'b0_1011: select5_1bit = result11;
        5'b0_1100: select5_1bit = result12;
        5'b0_1101: select5_1bit = result13;
        5'b0_1110: select5_1bit = result14;
        5'b0_1111: select5_1bit = result15;
        5'b1_0000: select5_1bit = result16;
        5'b1_0001: select5_1bit = result17;
        5'b1_0010: select5_1bit = result18;
        5'b1_0011: select5_1bit = result19;
        5'b1_0100: select5_1bit = result20;
        5'b1_0101: select5_1bit = result21;
        5'b1_0110: select5_1bit = result22;
        5'b1_0111: select5_1bit = result23;
        5'b1_1000: select5_1bit = result24;
        5'b1_1001: select5_1bit = result25;
        5'b1_1010: select5_1bit = result26;
        5'b1_1011: select5_1bit = result27;
        5'b1_1100: select5_1bit = result28;
        5'b1_1101: select5_1bit = result29;
        5'b1_1110: select5_1bit = result30;
        5'b1_1111: select5_1bit = result31;
    endcase
endfunction