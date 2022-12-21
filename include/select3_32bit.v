function [31:0] select3_32bit;
    input [2:0] select;

    input [31:0] data0, data1, data2, data3;
    input [31:0] data4, data5, data6, data7;
      
    case (select)
        3'b000: select3_32bit = data0;
        3'b001: select3_32bit = data1;
        3'b010: select3_32bit = data2;
        3'b011: select3_32bit = data3;
        3'b100: select3_32bit = data4;
        3'b101: select3_32bit = data5;
        3'b110: select3_32bit = data6;
        3'b111: select3_32bit = data7;
    endcase
endfunction