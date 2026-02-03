`timescale 1ns / 1ps

module riscv_core (
    input wire clk,
    input wire rst_n,
    output reg [31:0] instr_addr,
    input wire [31:0] instr_data,
    output reg [31:0] data_addr,
    output reg [31:0] data_wdata,
    input wire [31:0] data_rdata,
    output reg data_we,
    output reg data_re,
    output wire [31:0] pc_debug
);
    reg [31:0] pc;
    assign pc_debug = pc;
    
    wire [6:0] opcode = instr_data[6:0];
    wire [4:0] rd = instr_data[11:7];
    wire [2:0] funct3 = instr_data[14:12];
    wire [4:0] rs1 = instr_data[19:15];
    wire [4:0] rs2 = instr_data[24:20];
    wire [6:0] funct7 = instr_data[31:25];
    
    wire [31:0] imm_i = {{20{instr_data[31]}}, instr_data[31:20]};
    wire [31:0] imm_u = {instr_data[31:12], 12'b0};
    
    reg [31:0] regs [0:31];
    wire [31:0] rs1_data = (rs1 == 0) ? 32'd0 : regs[rs1];
    wire [31:0] rs2_data = (rs2 == 0) ? 32'd0 : regs[rs2];
    
    reg [31:0] alu_a, alu_b;
    reg [3:0] alu_op;
    wire [31:0] alu_result;
    
    localparam ALU_ADD = 4'd0;
    localparam ALU_SUB = 4'd1;
    localparam ALU_AND = 4'd2;
    localparam ALU_OR = 4'd3;
    localparam ALU_XOR = 4'd4;
    
    assign alu_result = (alu_op == ALU_ADD) ? (alu_a + alu_b) :
                        (alu_op == ALU_SUB) ? (alu_a - alu_b) :
                        (alu_op == ALU_AND) ? (alu_a & alu_b) :
                        (alu_op == ALU_OR) ? (alu_a | alu_b) :
                        (alu_op == ALU_XOR) ? (alu_a ^ alu_b) : 32'd0;
    
    wire is_op_imm = (opcode == 7'b0010011);
    wire is_op = (opcode == 7'b0110011);
    wire is_lui = (opcode == 7'b0110111);
    
    wire reg_write = is_op_imm || is_op || is_lui;
    wire use_imm = is_op_imm || is_lui;
    
    always @(*) begin
        if (is_op_imm || is_op) begin
            case (funct3)
                3'b000: alu_op = (is_op && funct7[5]) ? ALU_SUB : ALU_ADD;
                3'b111: alu_op = ALU_AND;
                3'b110: alu_op = ALU_OR;
                3'b100: alu_op = ALU_XOR;
                default: alu_op = ALU_ADD;
            endcase
        end else begin
            alu_op = ALU_ADD;
        end
    end
    
    always @(*) begin
        if (is_lui) begin
            alu_a = 32'd0;
            alu_b = imm_u;
        end else if (is_op_imm) begin
            alu_a = rs1_data;
            alu_b = imm_i;
        end else begin
            alu_a = rs1_data;
            alu_b = rs2_data;
        end
    end
    
    always @(*) begin
        data_addr = alu_result;
        data_wdata = rs2_data;
        data_we = 1'b0;
        data_re = 1'b0;
    end
    
    wire [31:0] write_data = is_lui ? imm_u : alu_result;
    
    integer i;
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            pc <= 32'h80000000;
            for (i = 0; i < 32; i = i + 1)
                regs[i] <= 32'd0;
        end else begin
            pc <= pc + 4;
            if (reg_write && rd != 0) begin
                regs[rd] <= write_data;
            end
        end
    end
    
    always @(*) begin
        instr_addr = pc;
    end
endmodule
