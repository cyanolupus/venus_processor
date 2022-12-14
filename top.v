module top(clk, reset, stall_i,
            inst_i, inst_addr_o,
            ldst_data_i, ldst_data_o,
            ldst_addr_o, ldst_write_o,
            hlt_o);
    `include "../include/params.v"

    input clk;
    input reset;
    input stall_i;
    input [WORD -1:0] inst_i;
    output [ADDR -1:0] inst_addr_o;

    input [W_OPR -1:0] ldst_data_i;
    output [W_OPR -1:0] ldst_data_o;
    output [ADDR -1:0] ldst_addr_o;
    output ldst_write_o;
    output hlt_o;

    // general
    wire stall_o;
    wire v_o;
    wire branch_wire;
    wire [ADDR -1: 0] branch_addr_wire;

    // pc - fetch
    wire [ADDR -1: 0] pc_pf;
    wire stall_fp;

    // fetch - queue
    wire v_fq;
    wire stall_qf;
    wire [WORD -1: 0] inst_fq;
    wire [ADDR -1:0] pc_fq;

    // queue - decode
    wire v_qd;
    wire stall_dq;
    wire [WORD -1: 0] inst_qd;
    wire [ADDR -1:0] pc_qd;

    // decode - register
    wire w_reserve_dr;
    wire [W_RD -1: 0] r0_dr, r1_dr;
    wire [W_OPR -1: 0] r_opr0_rd, r_opr1_rd;
    wire reserved_rd;

    // decode - execute
    wire v_de;
    wire stall_ed;
    wire [W_OPR -1: 0] opr0_de, opr1_de;
    wire [W_RD -1: 0] wb_r_de;
    wire [ADDR -1:0] pc_de;
    wire [W_IMM -1:0] imm_de;
    wire [D_INFO -1:0] d_info_de;

    // execute - register
    wire v_er;
    wire stall_re;
    wire wb_er;
    wire [W_RD -1: 0] wb_r_er;
    wire [W_OPR -1: 0] result_er;

    assign inst_addr_o = pc_pf;

    execute_instruction exec(
        .clk(clk), .reset(reset),
        .v_i(v_de), .v_o(v_er),
        .stall_i(stall_i), .stall_o(stall_ed),
        .pc_i(pc_de), .imm_i(imm_de),
        .opr0_i(opr0_de), .opr1_i(opr1_de),
        .d_info_i(d_info_de), .wb_r_i(wb_r_de),
        .ldst_addr_o(ldst_addr_o), .ldst_write_o(ldst_write_o),
        .ldst_data_i(ldst_data_i), .ldst_data_o(ldst_data_o),
        .result_o(result_er), .wb_r_o(wb_r_er), .wb_o(wb_er),
        .branch_o(branch_wire), .branch_addr_o(branch_addr_wire),
        .hlt_o(hlt_o)
    );

    decode_instruction decode(
        .clk(clk), .reset(reset),
        .v_i(v_qd), .v_o(v_de),
        .stall_i(stall_ed), .stall_o(stall_dq),
        .inst_i(inst_qd),
        .pc_i(pc_qd), .pc_o(pc_de),
        .w_reserve_o(w_reserve_dr),
        .r0_o(r0_dr), .r1_o(r1_dr),
        .r_opr0_i(r_opr0_rd), .r_opr1_i(r_opr1_rd),
        .imm_o(imm_de),
        .reserved_i(reserved_rd),
        .opr0_o(opr0_de), .opr1_o(opr1_de),
        .d_info_o(d_info_de),
        .wb_r_o(wb_r_de), .branch_i(branch_wire)
    );

    g_reg_x16 register(
        .clk(clk), .reset(reset),
        .w_reserve_i(w_reserve_dr),
        .r0_i(r0_dr), .r1_i(r1_dr),
        .r_opr0_o(r_opr0_rd), .r_opr1_o(r_opr1_rd),
        .reserved_o(reserved_rd),
        .wb_i(wb_er), .wb_r_i(wb_r_er),
        .result_i(result_er)
    );

    queue_instruction queue(
        .clk(clk), .reset(reset),
        .v_i(v_fq), .v_o(v_qd),
        .stall_i(stall_dq), .stall_o(stall_qf),
        .inst_i(inst_fq), .inst_o(inst_qd),
        .pc_i(pc_fq), .pc_o(pc_qd),
        .branch_i(branch_wire)
    );

    fetch_instruction fetch(
        .clk(clk), .reset(reset),
        .v_o(v_fq),
        .stall_i(stall_qf), .stall_o(stall_fp),
        .inst_i(inst_i), .inst_o(inst_fq),
        .pc_i(pc_pf), .pc_o(pc_fq),
        .branch_i(branch_wire)
    );

    pc pc(
        .clk(clk), .reset(reset),
        .stall_i(stall_fp), .stall_o(stall_o),
        .pc_o(pc_pf),
        .branch_i(branch_wire), .branch_addr_i(branch_addr_wire)
    );
endmodule