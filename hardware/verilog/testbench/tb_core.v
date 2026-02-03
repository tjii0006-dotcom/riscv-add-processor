`timescale 1ns / 1ps

module tb_core;
    reg clk;
    reg rst_n;
    
    wire [31:0] instr_addr;
    reg [31:0] instr_data;
    wire [31:0] data_addr;
    wire [31:0] data_wdata;
    reg [31:0] data_rdata;
    wire data_we;
    wire data_re;
    wire [31:0] pc_debug;
    
    riscv_core uut (
        .clk(clk),
        .rst_n(rst_n),
        .instr_addr(instr_addr),
        .instr_data(instr_data),
        .data_addr(data_addr),
        .data_wdata(data_wdata),
        .data_rdata(data_rdata),
        .data_we(data_we),
        .data_re(data_re),
        .pc_debug(pc_debug)
    );
    
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    
    initial begin
        rst_n = 0;
        #20 rst_n = 1;
        
        // Test: addi x1, x0, 5
        @(posedge clk);
        instr_data = 32'h00500093;
        
        // Test: addi x2, x1, 3
        @(posedge clk);
        instr_data = 32'h00308113;
        
        // Test: add x3, x1, x2
        @(posedge clk);
        instr_data = 32'h002081b3;
        
        #100;
        $display("Simulation completed");
        $display("PC = 0x%h", pc_debug);
        $finish;
    end
    
    initial begin
        $dumpfile("waveform.vcd");
        $dumpvars(0, tb_core);
    end
endmodule
