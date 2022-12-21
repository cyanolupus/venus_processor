function [31:0] select4_32bit;
      input [3:0] select;

      input [31:0] data0, data1, data2, data3;
      input [31:0] data4, data5, data6, data7;
      input [31:0] data8, data9, dataa, datab;
      input [31:0] datac, datad, datae, dataf;
      
      case (select)
        4'b0000: select4_32bit = data0;
        4'b0001: select4_32bit = data1;
        4'b0010: select4_32bit = data2;
        4'b0011: select4_32bit = data3;
        4'b0100: select4_32bit = data4;
        4'b0101: select4_32bit = data5;
        4'b0110: select4_32bit = data6;
        4'b0111: select4_32bit = data7;
        4'b1000: select4_32bit = data8;
        4'b1001: select4_32bit = data9;
        4'b1010: select4_32bit = dataa;
        4'b1011: select4_32bit = datab;
        4'b1100: select4_32bit = datac;
        4'b1101: select4_32bit = datad;
        4'b1110: select4_32bit = datae;
        4'b1111: select4_32bit = dataf;
      endcase
endfunction