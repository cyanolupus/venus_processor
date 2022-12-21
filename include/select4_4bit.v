function [3:0] select4_4bit;
      input [3:0] select;

      input [3:0] data0, data1, data2, data3;
      input [3:0] data4, data5, data6, data7;
      input [3:0] data8, data9, dataa, datab;
      input [3:0] datac, datad, datae, dataf;
      
      case (select)
        4'b0000: select4_4bit = data0;
        4'b0001: select4_4bit = data1;
        4'b0010: select4_4bit = data2;
        4'b0011: select4_4bit = data3;
        4'b0100: select4_4bit = data4;
        4'b0101: select4_4bit = data5;
        4'b0110: select4_4bit = data6;
        4'b0111: select4_4bit = data7;
        4'b1000: select4_4bit = data8;
        4'b1001: select4_4bit = data9;
        4'b1010: select4_4bit = dataa;
        4'b1011: select4_4bit = datab;
        4'b1100: select4_4bit = datac;
        4'b1101: select4_4bit = datad;
        4'b1110: select4_4bit = datae;
        4'b1111: select4_4bit = dataf;
      endcase
endfunction