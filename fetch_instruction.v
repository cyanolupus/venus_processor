module fetch_instruction(clk, reset,
                v_o,
                stall_i, stall_o,
                inst_i, inst_o, pc_o,
                branch, branch_addr);

    `include "./include/params.v"

    input  clk, reset;
    output v_o;
    input stall_i;
    output stall_o;

    input [WORD -1: 0] inst_i;
    output [WORD -1: 0] inst_o;

    output [ADDR -1: 0] pc_o;

    input branch;
    input [ADDR -1: 0] branch_addr;

    reg v_r;
    reg [WORD -1: 0] inst_r;
    reg [ADDR -1: 0] pc_r;
    reg stall_prev;

    wire [ADDR -1: 0] pc_next;
    wire [ADDR -1: 0] pc_prev;

    assign inst_o = (stall_i)? inst_r: inst_i;
    assign pc_o = (stall_i)? pc_prev: pc_r;
    assign pc_next = pc_r + 1;
    assign pc_prev = pc_r - 1;
    assign v_o = v_r;
    assign stall_o = stall_i;

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            pc_r <= 0;
            v_r <= 0;
            inst_r <= 0;
            stall_prev <= 0;
        end else begin
            if (~stall_i) begin
                if (branch) begin
                    inst_r <= inst_i;
                    pc_r <= branch_addr;
                    v_r <= 0;
                end else begin
                    inst_r <= inst_i;
                    pc_r <= pc_next;
                    v_r <= 1;
                end
            end
        end
    end
endmodule