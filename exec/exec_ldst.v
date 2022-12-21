module exec_ldst (opr0_i, opr1_i, immf_i, imm_i, stf_i, addr_o, write_o, data_o);
    `include "../include/params.v"
    input [W_OPR -1: 0] opr0_i, opr1_i;
    input immf_i;
    input [W_IMM -1: 0] imm_i;
    input stf_i;
    output [ADDR -1: 0] addr_o;
    output write_o;
    output [W_OPR -1: 0] data_o;

    wire [ADDR -1: 0] load_addr;
    wire [ADDR -1: 0] store_addr;

    wire [ADDR -1: 0] opr0_addr;
    wire [ADDR -1: 0] opr1_addr;

    assign opr0_addr = opr0_i[ADDR -1: 0];
    assign opr1_addr = opr1_i[ADDR -1: 0];

    assign load_addr = immf_i?(opr1_addr + imm_i):opr1_addr;
    assign store_addr = immf_i?(opr0_addr + imm_i):opr0_addr;
    assign addr_o = (stf_i) ? store_addr[ADDR -1: 0] : load_addr[ADDR -1: 0];
    assign data_o = opr1_i;
    assign write_o = stf_i;
endmodule