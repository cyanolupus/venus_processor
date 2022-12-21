module decode_instruction(clk, reset,
                v_i, v_o,
                stall_i, stall_o,
                inst_i,
                pc_i, pc_o,
                w_reserve_o, 
                r0_o, r1_o,
                r_opr0_i, r_opr1_i,
                imm_o,
                reserved0_i, reserved1_i,
                opr0_o, opr1_o,
                d_info_o,
                wb_r_o,
                brid_i, brid_o,
                branch_i,
                ex_i, ex_r_i, ex_opr_i);

    `include "../include/params.v"
    `include "../include/decode_inst.v"

    input  clk, reset;
    input  v_i;
    output v_o;
    input stall_i;
    output stall_o;
    input [WORD -1: 0] inst_i;
    input [ADDR -1: 0] pc_i;
    output [ADDR -1: 0] pc_o;
    output w_reserve_o;
    output [W_RD -1: 0] r0_o, r1_o;
    input [W_OPR -1: 0] r_opr0_i, r_opr1_i;
    output [W_IMM -1: 0] imm_o;
    input reserved0_i;
    input reserved1_i;
    output [W_OPR -1: 0] opr0_o, opr1_o;
    output [D_INFO -1: 0] d_info_o;
    output [W_RD -1: 0] wb_r_o;

    input [W_BRID -1: 0] brid_i;
    output [W_BRID -1: 0] brid_o;

    input branch_i;

    input ex_i;
    input [W_RD -1: 0] ex_r_i;
    input [W_OPR -1: 0] ex_opr_i;

    reg v_r;
    reg [W_IMM -1: 0] imm_r;
    reg [ADDR -1: 0] pc_r;
    reg [W_RD -1: 0] r0_r, r1_r;
    reg [D_INFO -1: 0] d_info_r;
    reg [W_BRID -1: 0] brid_r;

    wire [W_IMM -1: 0] imm;
    wire [D_INFO -1: 0] d_info;

    wire ex_0;
    wire ex_1;

    wire rsv_no_ex0;
    wire rsv_no_ex1;

    assign d_info = decode_inst(inst_i[WORD -1: W_RD + W_RD + W_IMM]);
    assign r0_o = r0_r;
    assign r1_o = r1_r;
    assign imm = inst_i[W_IMM - 1: 0];
    
    assign ex_0 = ex_i & (ex_r_i == r0_r);
    assign ex_1 = ex_i & (ex_r_i == r1_r);

    assign rsv_no_ex0 = reserved0_i & ~ex_0;
    assign rsv_no_ex1 = reserved1_i & ~ex_1;

    assign w_reserve_o = v_r & d_info_r[WRSV] & ~(rsv_no_ex0 | rsv_no_ex1);
    assign opr0_o = ex_0?ex_opr_i:r_opr0_i;
    assign opr1_o = ex_1?ex_opr_i:r_opr1_i;
    assign wb_r_o = r0_r;
    assign imm_o = imm_r;
    assign pc_o = pc_r;
    assign d_info_o = d_info_r;

    assign stall_o = stall_i & v_r | (rsv_no_ex0 | rsv_no_ex1);
    assign v_o = v_r & (~stall_o | stall_i);

    assign brid_o = brid_r;

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            v_r <= 0;
            imm_r <= 0;
            r0_r <= 0;
            r1_r <= 0;
            pc_r <= 0;
            d_info_r <= 0;
            brid_r <= 0;
        end else begin
            if ((~stall_i | ~v_r) & ~(rsv_no_ex0 | rsv_no_ex1)) begin
                v_r <= v_i & ~branch_i;
                r0_r <= inst_i[W_RD + W_RD + W_IMM - 1: W_RD + W_IMM];
                r1_r <= inst_i[W_RD + W_IMM - 1: + W_IMM];
                d_info_r <= d_info;
                imm_r <= imm;
                pc_r <= pc_i;
                brid_r <= brid_i;
            end
        end
    end
endmodule