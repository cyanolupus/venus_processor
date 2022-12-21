function select3_1bit;
    input [2:0] select;

    input data0, data1, data2, data3;
    input data4, data5, data6, data7;
      
    case (select)
        3'b000: select3_1bit = data0;
        3'b001: select3_1bit = data1;
        3'b010: select3_1bit = data2;
        3'b011: select3_1bit = data3;
        3'b100: select3_1bit = data4;
        3'b101: select3_1bit = data5;
        3'b110: select3_1bit = data6;
        3'b111: select3_1bit = data7;
    endcase
endfunction