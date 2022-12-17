module branch_prediction (
    clk, reset,
    v_i, stall_i,
    branch_i, branch_id_i,
    pred_o, pred_id_o);

    `include "../include/params.v"

    input clk, reset;
    input v_i;
    input stall_i;
    input branch_i;
    input [W_BRID -1: 0] branch_id_i;
    output pred_o;
    output [W_BRID -1: 0] pred_id_o;

    reg [W_BRID -1: 0] pred_r;

    wire [W_BRID -1: 0] pred_next;
    wire [W_BRID -1: 0] pred_inc;
    wire [W_BRID -1: 0] pred_dec;

    wire miss;

    assign miss = branch_id_i[W_BRID -1] ^ branch_i;

    assign pred_inc = {|pred_r, 1'b1};
    assign pred_dec = {&pred_r, 1'b0};
    assign pred_next = v_i?(branch_i?pred_inc:pred_dec):pred_r;

    assign pred_o = pred_next[W_BRID -1] & ~stall_i;
    assign pred_id_o = pred_next;

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            pred_r <= 0;
        end else begin
            pred_r <= pred_next;
        end
    end
endmodule
