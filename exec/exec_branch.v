module exec_branch (cc_i, opr1_i,
                pc_i, brf_i,
                select_i, flags_i,
                branch_o, branch_addr_o);

    `include "../include/params.v"
    `include "../include/select3_1bit.v"

    input [W_CC -1: 0] cc_i;
    input [ADDR -1: 0] opr1_i;
    input [ADDR -1: 0] pc_i;
    input brf_i;
    input [2:0] select_i;
    input [W_FLAGS -1: 0] flags_i;
    output branch_o;
    output [ADDR -1: 0] branch_addr_o;

    wire cond_en = select_i[2] & select_i[1];
    wire c_cc = select3_1bit(cc_i,
            1'b1, flags_i[F_ZERO], ~flags_i[F_SIGN], flags_i[F_SIGN], 
            flags_i[F_CRRY], flags_i[F_OVRF], 1'b0, 1'b0) & cond_en;
    wire c_select = select3_1bit(select_i,
            1'b1, flags_i[F_ZERO], ~flags_i[F_ZERO], ~(flags_i[F_CRRY]|flags_i[F_ZERO]),
            flags_i[F_CRRY], 1'b0, 1'b0, 1'b0) & ~cond_en;
    wire relative = &select_i;

    assign branch_o = brf_i & (c_cc | c_select);
    assign branch_addr_o = (relative) ? (pc_i + opr1_i) : opr1_i;
endmodule