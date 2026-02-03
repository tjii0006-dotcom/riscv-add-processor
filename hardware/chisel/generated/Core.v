module Control(
  input  [6:0] io_opcode,
  input  [2:0] io_funct3,
  input  [6:0] io_funct7,
  output       io_signals_regWrite,
  output       io_signals_memRead,
  output       io_signals_memWrite,
  output       io_signals_memToReg,
  output       io_signals_aluSrc,
  output       io_signals_branch,
  output       io_signals_jump,
  output [3:0] io_signals_aluOp
);
  wire  _io_signals_T = io_opcode == 7'h33; // @[Control.scala 30:16]
  wire  _io_signals_sig_aluOp_T = io_funct3 == 3'h0; // @[Control.scala 35:20]
  wire  _io_signals_sig_aluOp_T_2 = ~io_funct7[5]; // @[Control.scala 35:44]
  wire  _io_signals_sig_aluOp_T_3 = io_funct3 == 3'h0 & ~io_funct7[5]; // @[Control.scala 35:28]
  wire  _io_signals_sig_aluOp_T_7 = _io_signals_sig_aluOp_T & io_funct7[5]; // @[Control.scala 36:28]
  wire  _io_signals_sig_aluOp_T_8 = io_funct3 == 3'h1; // @[Control.scala 37:20]
  wire  _io_signals_sig_aluOp_T_9 = io_funct3 == 3'h2; // @[Control.scala 38:20]
  wire  _io_signals_sig_aluOp_T_10 = io_funct3 == 3'h3; // @[Control.scala 39:20]
  wire  _io_signals_sig_aluOp_T_11 = io_funct3 == 3'h4; // @[Control.scala 40:20]
  wire  _io_signals_sig_aluOp_T_12 = io_funct3 == 3'h5; // @[Control.scala 41:20]
  wire  _io_signals_sig_aluOp_T_15 = io_funct3 == 3'h5 & _io_signals_sig_aluOp_T_2; // @[Control.scala 41:28]
  wire  _io_signals_sig_aluOp_T_19 = _io_signals_sig_aluOp_T_12 & io_funct7[5]; // @[Control.scala 42:28]
  wire  _io_signals_sig_aluOp_T_20 = io_funct3 == 3'h6; // @[Control.scala 43:20]
  wire  _io_signals_sig_aluOp_T_21 = io_funct3 == 3'h7; // @[Control.scala 44:20]
  wire [3:0] _io_signals_sig_aluOp_T_22 = _io_signals_sig_aluOp_T_21 ? 4'h2 : 4'h0; // @[Mux.scala 101:16]
  wire [3:0] _io_signals_sig_aluOp_T_23 = _io_signals_sig_aluOp_T_20 ? 4'h3 : _io_signals_sig_aluOp_T_22; // @[Mux.scala 101:16]
  wire [3:0] _io_signals_sig_aluOp_T_24 = _io_signals_sig_aluOp_T_19 ? 4'h7 : _io_signals_sig_aluOp_T_23; // @[Mux.scala 101:16]
  wire [3:0] _io_signals_sig_aluOp_T_25 = _io_signals_sig_aluOp_T_15 ? 4'h6 : _io_signals_sig_aluOp_T_24; // @[Mux.scala 101:16]
  wire [3:0] _io_signals_sig_aluOp_T_26 = _io_signals_sig_aluOp_T_11 ? 4'h4 : _io_signals_sig_aluOp_T_25; // @[Mux.scala 101:16]
  wire [3:0] _io_signals_sig_aluOp_T_27 = _io_signals_sig_aluOp_T_10 ? 4'h9 : _io_signals_sig_aluOp_T_26; // @[Mux.scala 101:16]
  wire [3:0] _io_signals_sig_aluOp_T_28 = _io_signals_sig_aluOp_T_9 ? 4'h8 : _io_signals_sig_aluOp_T_27; // @[Mux.scala 101:16]
  wire [3:0] _io_signals_sig_aluOp_T_29 = _io_signals_sig_aluOp_T_8 ? 4'h5 : _io_signals_sig_aluOp_T_28; // @[Mux.scala 101:16]
  wire [3:0] _io_signals_sig_aluOp_T_30 = _io_signals_sig_aluOp_T_7 ? 4'h1 : _io_signals_sig_aluOp_T_29; // @[Mux.scala 101:16]
  wire [3:0] io_signals_sig_aluOp = _io_signals_sig_aluOp_T_3 ? 4'h0 : _io_signals_sig_aluOp_T_30; // @[Mux.scala 101:16]
  wire  _io_signals_T_1 = io_opcode == 7'h13; // @[Control.scala 50:16]
  wire [3:0] io_signals_sig_1_aluOp = _io_signals_sig_aluOp_T ? 4'h0 : _io_signals_sig_aluOp_T_29; // @[Mux.scala 101:16]
  wire  _io_signals_T_2 = io_opcode == 7'h37; // @[Control.scala 70:16]
  wire  _io_signals_T_3 = io_opcode == 7'h17; // @[Control.scala 79:16]
  wire  _io_signals_T_4 = io_opcode == 7'h6f; // @[Control.scala 88:16]
  wire  _io_signals_T_5 = io_opcode == 7'h67; // @[Control.scala 97:16]
  wire  _io_signals_T_6 = io_opcode == 7'h63; // @[Control.scala 107:16]
  wire  _io_signals_T_7 = io_opcode == 7'h3; // @[Control.scala 115:16]
  wire  _io_signals_T_8 = io_opcode == 7'h23; // @[Control.scala 126:16]
  wire  _io_signals_T_10_memWrite = _io_signals_T_7 ? 1'h0 : _io_signals_T_8; // @[Mux.scala 101:16]
  wire  _io_signals_T_11_regWrite = _io_signals_T_6 ? 1'h0 : _io_signals_T_7; // @[Mux.scala 101:16]
  wire  _io_signals_T_11_memWrite = _io_signals_T_6 ? 1'h0 : _io_signals_T_10_memWrite; // @[Mux.scala 101:16]
  wire  _io_signals_T_11_aluSrc = _io_signals_T_6 ? 1'h0 : _io_signals_T_7 | _io_signals_T_8; // @[Mux.scala 101:16]
  wire  _io_signals_T_12_memRead = _io_signals_T_5 ? 1'h0 : _io_signals_T_11_regWrite; // @[Mux.scala 101:16]
  wire  _io_signals_T_12_memWrite = _io_signals_T_5 ? 1'h0 : _io_signals_T_11_memWrite; // @[Mux.scala 101:16]
  wire  _io_signals_T_12_branch = _io_signals_T_5 ? 1'h0 : _io_signals_T_6; // @[Mux.scala 101:16]
  wire  _io_signals_T_13_memRead = _io_signals_T_4 ? 1'h0 : _io_signals_T_12_memRead; // @[Mux.scala 101:16]
  wire  _io_signals_T_13_memWrite = _io_signals_T_4 ? 1'h0 : _io_signals_T_12_memWrite; // @[Mux.scala 101:16]
  wire  _io_signals_T_13_aluSrc = _io_signals_T_4 ? 1'h0 : _io_signals_T_5 | _io_signals_T_11_aluSrc; // @[Mux.scala 101:16]
  wire  _io_signals_T_13_branch = _io_signals_T_4 ? 1'h0 : _io_signals_T_12_branch; // @[Mux.scala 101:16]
  wire  _io_signals_T_14_memRead = _io_signals_T_3 ? 1'h0 : _io_signals_T_13_memRead; // @[Mux.scala 101:16]
  wire  _io_signals_T_14_memWrite = _io_signals_T_3 ? 1'h0 : _io_signals_T_13_memWrite; // @[Mux.scala 101:16]
  wire  _io_signals_T_14_branch = _io_signals_T_3 ? 1'h0 : _io_signals_T_13_branch; // @[Mux.scala 101:16]
  wire  _io_signals_T_14_jump = _io_signals_T_3 ? 1'h0 : _io_signals_T_4 | _io_signals_T_5; // @[Mux.scala 101:16]
  wire  _io_signals_T_15_memRead = _io_signals_T_2 ? 1'h0 : _io_signals_T_14_memRead; // @[Mux.scala 101:16]
  wire  _io_signals_T_15_memWrite = _io_signals_T_2 ? 1'h0 : _io_signals_T_14_memWrite; // @[Mux.scala 101:16]
  wire  _io_signals_T_15_branch = _io_signals_T_2 ? 1'h0 : _io_signals_T_14_branch; // @[Mux.scala 101:16]
  wire  _io_signals_T_15_jump = _io_signals_T_2 ? 1'h0 : _io_signals_T_14_jump; // @[Mux.scala 101:16]
  wire  _io_signals_T_16_memRead = _io_signals_T_1 ? 1'h0 : _io_signals_T_15_memRead; // @[Mux.scala 101:16]
  wire  _io_signals_T_16_memWrite = _io_signals_T_1 ? 1'h0 : _io_signals_T_15_memWrite; // @[Mux.scala 101:16]
  wire  _io_signals_T_16_branch = _io_signals_T_1 ? 1'h0 : _io_signals_T_15_branch; // @[Mux.scala 101:16]
  wire  _io_signals_T_16_jump = _io_signals_T_1 ? 1'h0 : _io_signals_T_15_jump; // @[Mux.scala 101:16]
  wire [3:0] _io_signals_T_16_aluOp = _io_signals_T_1 ? io_signals_sig_1_aluOp : 4'h0; // @[Mux.scala 101:16]
  assign io_signals_regWrite = _io_signals_T | (_io_signals_T_1 | (_io_signals_T_2 | (_io_signals_T_3 | (_io_signals_T_4
     | (_io_signals_T_5 | _io_signals_T_11_regWrite))))); // @[Mux.scala 101:16]
  assign io_signals_memRead = _io_signals_T ? 1'h0 : _io_signals_T_16_memRead; // @[Mux.scala 101:16]
  assign io_signals_memWrite = _io_signals_T ? 1'h0 : _io_signals_T_16_memWrite; // @[Mux.scala 101:16]
  assign io_signals_memToReg = _io_signals_T ? 1'h0 : _io_signals_T_16_memRead; // @[Mux.scala 101:16]
  assign io_signals_aluSrc = _io_signals_T ? 1'h0 : _io_signals_T_1 | (_io_signals_T_2 | (_io_signals_T_3 |
    _io_signals_T_13_aluSrc)); // @[Mux.scala 101:16]
  assign io_signals_branch = _io_signals_T ? 1'h0 : _io_signals_T_16_branch; // @[Mux.scala 101:16]
  assign io_signals_jump = _io_signals_T ? 1'h0 : _io_signals_T_16_jump; // @[Mux.scala 101:16]
  assign io_signals_aluOp = _io_signals_T ? io_signals_sig_aluOp : _io_signals_T_16_aluOp; // @[Mux.scala 101:16]
endmodule
module RegFile(
  input         clock,
  input         reset,
  input  [4:0]  io_readAddr1,
  input  [4:0]  io_readAddr2,
  output [31:0] io_readData1,
  output [31:0] io_readData2,
  input  [4:0]  io_writeAddr,
  input  [31:0] io_writeData,
  input         io_writeEn
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
  reg [31:0] _RAND_1;
  reg [31:0] _RAND_2;
  reg [31:0] _RAND_3;
  reg [31:0] _RAND_4;
  reg [31:0] _RAND_5;
  reg [31:0] _RAND_6;
  reg [31:0] _RAND_7;
  reg [31:0] _RAND_8;
  reg [31:0] _RAND_9;
  reg [31:0] _RAND_10;
  reg [31:0] _RAND_11;
  reg [31:0] _RAND_12;
  reg [31:0] _RAND_13;
  reg [31:0] _RAND_14;
  reg [31:0] _RAND_15;
  reg [31:0] _RAND_16;
  reg [31:0] _RAND_17;
  reg [31:0] _RAND_18;
  reg [31:0] _RAND_19;
  reg [31:0] _RAND_20;
  reg [31:0] _RAND_21;
  reg [31:0] _RAND_22;
  reg [31:0] _RAND_23;
  reg [31:0] _RAND_24;
  reg [31:0] _RAND_25;
  reg [31:0] _RAND_26;
  reg [31:0] _RAND_27;
  reg [31:0] _RAND_28;
  reg [31:0] _RAND_29;
  reg [31:0] _RAND_30;
  reg [31:0] _RAND_31;
`endif // RANDOMIZE_REG_INIT
  reg [31:0] regs_0; // @[RegFile.scala 22:21]
  reg [31:0] regs_1; // @[RegFile.scala 22:21]
  reg [31:0] regs_2; // @[RegFile.scala 22:21]
  reg [31:0] regs_3; // @[RegFile.scala 22:21]
  reg [31:0] regs_4; // @[RegFile.scala 22:21]
  reg [31:0] regs_5; // @[RegFile.scala 22:21]
  reg [31:0] regs_6; // @[RegFile.scala 22:21]
  reg [31:0] regs_7; // @[RegFile.scala 22:21]
  reg [31:0] regs_8; // @[RegFile.scala 22:21]
  reg [31:0] regs_9; // @[RegFile.scala 22:21]
  reg [31:0] regs_10; // @[RegFile.scala 22:21]
  reg [31:0] regs_11; // @[RegFile.scala 22:21]
  reg [31:0] regs_12; // @[RegFile.scala 22:21]
  reg [31:0] regs_13; // @[RegFile.scala 22:21]
  reg [31:0] regs_14; // @[RegFile.scala 22:21]
  reg [31:0] regs_15; // @[RegFile.scala 22:21]
  reg [31:0] regs_16; // @[RegFile.scala 22:21]
  reg [31:0] regs_17; // @[RegFile.scala 22:21]
  reg [31:0] regs_18; // @[RegFile.scala 22:21]
  reg [31:0] regs_19; // @[RegFile.scala 22:21]
  reg [31:0] regs_20; // @[RegFile.scala 22:21]
  reg [31:0] regs_21; // @[RegFile.scala 22:21]
  reg [31:0] regs_22; // @[RegFile.scala 22:21]
  reg [31:0] regs_23; // @[RegFile.scala 22:21]
  reg [31:0] regs_24; // @[RegFile.scala 22:21]
  reg [31:0] regs_25; // @[RegFile.scala 22:21]
  reg [31:0] regs_26; // @[RegFile.scala 22:21]
  reg [31:0] regs_27; // @[RegFile.scala 22:21]
  reg [31:0] regs_28; // @[RegFile.scala 22:21]
  reg [31:0] regs_29; // @[RegFile.scala 22:21]
  reg [31:0] regs_30; // @[RegFile.scala 22:21]
  reg [31:0] regs_31; // @[RegFile.scala 22:21]
  wire [31:0] _GEN_1 = 5'h1 == io_readAddr1 ? regs_1 : regs_0; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_2 = 5'h2 == io_readAddr1 ? regs_2 : _GEN_1; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_3 = 5'h3 == io_readAddr1 ? regs_3 : _GEN_2; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_4 = 5'h4 == io_readAddr1 ? regs_4 : _GEN_3; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_5 = 5'h5 == io_readAddr1 ? regs_5 : _GEN_4; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_6 = 5'h6 == io_readAddr1 ? regs_6 : _GEN_5; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_7 = 5'h7 == io_readAddr1 ? regs_7 : _GEN_6; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_8 = 5'h8 == io_readAddr1 ? regs_8 : _GEN_7; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_9 = 5'h9 == io_readAddr1 ? regs_9 : _GEN_8; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_10 = 5'ha == io_readAddr1 ? regs_10 : _GEN_9; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_11 = 5'hb == io_readAddr1 ? regs_11 : _GEN_10; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_12 = 5'hc == io_readAddr1 ? regs_12 : _GEN_11; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_13 = 5'hd == io_readAddr1 ? regs_13 : _GEN_12; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_14 = 5'he == io_readAddr1 ? regs_14 : _GEN_13; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_15 = 5'hf == io_readAddr1 ? regs_15 : _GEN_14; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_16 = 5'h10 == io_readAddr1 ? regs_16 : _GEN_15; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_17 = 5'h11 == io_readAddr1 ? regs_17 : _GEN_16; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_18 = 5'h12 == io_readAddr1 ? regs_18 : _GEN_17; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_19 = 5'h13 == io_readAddr1 ? regs_19 : _GEN_18; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_20 = 5'h14 == io_readAddr1 ? regs_20 : _GEN_19; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_21 = 5'h15 == io_readAddr1 ? regs_21 : _GEN_20; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_22 = 5'h16 == io_readAddr1 ? regs_22 : _GEN_21; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_23 = 5'h17 == io_readAddr1 ? regs_23 : _GEN_22; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_24 = 5'h18 == io_readAddr1 ? regs_24 : _GEN_23; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_25 = 5'h19 == io_readAddr1 ? regs_25 : _GEN_24; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_26 = 5'h1a == io_readAddr1 ? regs_26 : _GEN_25; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_27 = 5'h1b == io_readAddr1 ? regs_27 : _GEN_26; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_28 = 5'h1c == io_readAddr1 ? regs_28 : _GEN_27; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_29 = 5'h1d == io_readAddr1 ? regs_29 : _GEN_28; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_30 = 5'h1e == io_readAddr1 ? regs_30 : _GEN_29; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_31 = 5'h1f == io_readAddr1 ? regs_31 : _GEN_30; // @[RegFile.scala 25:{22,22}]
  wire [31:0] _GEN_33 = 5'h1 == io_readAddr2 ? regs_1 : regs_0; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_34 = 5'h2 == io_readAddr2 ? regs_2 : _GEN_33; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_35 = 5'h3 == io_readAddr2 ? regs_3 : _GEN_34; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_36 = 5'h4 == io_readAddr2 ? regs_4 : _GEN_35; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_37 = 5'h5 == io_readAddr2 ? regs_5 : _GEN_36; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_38 = 5'h6 == io_readAddr2 ? regs_6 : _GEN_37; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_39 = 5'h7 == io_readAddr2 ? regs_7 : _GEN_38; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_40 = 5'h8 == io_readAddr2 ? regs_8 : _GEN_39; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_41 = 5'h9 == io_readAddr2 ? regs_9 : _GEN_40; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_42 = 5'ha == io_readAddr2 ? regs_10 : _GEN_41; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_43 = 5'hb == io_readAddr2 ? regs_11 : _GEN_42; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_44 = 5'hc == io_readAddr2 ? regs_12 : _GEN_43; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_45 = 5'hd == io_readAddr2 ? regs_13 : _GEN_44; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_46 = 5'he == io_readAddr2 ? regs_14 : _GEN_45; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_47 = 5'hf == io_readAddr2 ? regs_15 : _GEN_46; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_48 = 5'h10 == io_readAddr2 ? regs_16 : _GEN_47; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_49 = 5'h11 == io_readAddr2 ? regs_17 : _GEN_48; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_50 = 5'h12 == io_readAddr2 ? regs_18 : _GEN_49; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_51 = 5'h13 == io_readAddr2 ? regs_19 : _GEN_50; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_52 = 5'h14 == io_readAddr2 ? regs_20 : _GEN_51; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_53 = 5'h15 == io_readAddr2 ? regs_21 : _GEN_52; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_54 = 5'h16 == io_readAddr2 ? regs_22 : _GEN_53; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_55 = 5'h17 == io_readAddr2 ? regs_23 : _GEN_54; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_56 = 5'h18 == io_readAddr2 ? regs_24 : _GEN_55; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_57 = 5'h19 == io_readAddr2 ? regs_25 : _GEN_56; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_58 = 5'h1a == io_readAddr2 ? regs_26 : _GEN_57; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_59 = 5'h1b == io_readAddr2 ? regs_27 : _GEN_58; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_60 = 5'h1c == io_readAddr2 ? regs_28 : _GEN_59; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_61 = 5'h1d == io_readAddr2 ? regs_29 : _GEN_60; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_62 = 5'h1e == io_readAddr2 ? regs_30 : _GEN_61; // @[RegFile.scala 26:{22,22}]
  wire [31:0] _GEN_63 = 5'h1f == io_readAddr2 ? regs_31 : _GEN_62; // @[RegFile.scala 26:{22,22}]
  assign io_readData1 = io_readAddr1 == 5'h0 ? 32'h0 : _GEN_31; // @[RegFile.scala 25:22]
  assign io_readData2 = io_readAddr2 == 5'h0 ? 32'h0 : _GEN_63; // @[RegFile.scala 26:22]
  always @(posedge clock) begin
    if (reset) begin // @[RegFile.scala 22:21]
      regs_0 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h0 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_0 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_1 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h1 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_1 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_2 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h2 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_2 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_3 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h3 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_3 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_4 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h4 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_4 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_5 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h5 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_5 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_6 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h6 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_6 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_7 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h7 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_7 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_8 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h8 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_8 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_9 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h9 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_9 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_10 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'ha == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_10 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_11 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'hb == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_11 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_12 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'hc == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_12 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_13 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'hd == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_13 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_14 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'he == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_14 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_15 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'hf == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_15 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_16 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h10 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_16 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_17 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h11 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_17 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_18 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h12 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_18 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_19 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h13 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_19 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_20 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h14 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_20 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_21 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h15 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_21 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_22 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h16 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_22 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_23 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h17 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_23 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_24 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h18 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_24 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_25 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h19 == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_25 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_26 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h1a == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_26 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_27 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h1b == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_27 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_28 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h1c == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_28 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_29 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h1d == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_29 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_30 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h1e == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_30 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
    if (reset) begin // @[RegFile.scala 22:21]
      regs_31 <= 32'h0; // @[RegFile.scala 22:21]
    end else if (io_writeEn & io_writeAddr != 5'h0) begin // @[RegFile.scala 29:44]
      if (5'h1f == io_writeAddr) begin // @[RegFile.scala 30:24]
        regs_31 <= io_writeData; // @[RegFile.scala 30:24]
      end
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  regs_0 = _RAND_0[31:0];
  _RAND_1 = {1{`RANDOM}};
  regs_1 = _RAND_1[31:0];
  _RAND_2 = {1{`RANDOM}};
  regs_2 = _RAND_2[31:0];
  _RAND_3 = {1{`RANDOM}};
  regs_3 = _RAND_3[31:0];
  _RAND_4 = {1{`RANDOM}};
  regs_4 = _RAND_4[31:0];
  _RAND_5 = {1{`RANDOM}};
  regs_5 = _RAND_5[31:0];
  _RAND_6 = {1{`RANDOM}};
  regs_6 = _RAND_6[31:0];
  _RAND_7 = {1{`RANDOM}};
  regs_7 = _RAND_7[31:0];
  _RAND_8 = {1{`RANDOM}};
  regs_8 = _RAND_8[31:0];
  _RAND_9 = {1{`RANDOM}};
  regs_9 = _RAND_9[31:0];
  _RAND_10 = {1{`RANDOM}};
  regs_10 = _RAND_10[31:0];
  _RAND_11 = {1{`RANDOM}};
  regs_11 = _RAND_11[31:0];
  _RAND_12 = {1{`RANDOM}};
  regs_12 = _RAND_12[31:0];
  _RAND_13 = {1{`RANDOM}};
  regs_13 = _RAND_13[31:0];
  _RAND_14 = {1{`RANDOM}};
  regs_14 = _RAND_14[31:0];
  _RAND_15 = {1{`RANDOM}};
  regs_15 = _RAND_15[31:0];
  _RAND_16 = {1{`RANDOM}};
  regs_16 = _RAND_16[31:0];
  _RAND_17 = {1{`RANDOM}};
  regs_17 = _RAND_17[31:0];
  _RAND_18 = {1{`RANDOM}};
  regs_18 = _RAND_18[31:0];
  _RAND_19 = {1{`RANDOM}};
  regs_19 = _RAND_19[31:0];
  _RAND_20 = {1{`RANDOM}};
  regs_20 = _RAND_20[31:0];
  _RAND_21 = {1{`RANDOM}};
  regs_21 = _RAND_21[31:0];
  _RAND_22 = {1{`RANDOM}};
  regs_22 = _RAND_22[31:0];
  _RAND_23 = {1{`RANDOM}};
  regs_23 = _RAND_23[31:0];
  _RAND_24 = {1{`RANDOM}};
  regs_24 = _RAND_24[31:0];
  _RAND_25 = {1{`RANDOM}};
  regs_25 = _RAND_25[31:0];
  _RAND_26 = {1{`RANDOM}};
  regs_26 = _RAND_26[31:0];
  _RAND_27 = {1{`RANDOM}};
  regs_27 = _RAND_27[31:0];
  _RAND_28 = {1{`RANDOM}};
  regs_28 = _RAND_28[31:0];
  _RAND_29 = {1{`RANDOM}};
  regs_29 = _RAND_29[31:0];
  _RAND_30 = {1{`RANDOM}};
  regs_30 = _RAND_30[31:0];
  _RAND_31 = {1{`RANDOM}};
  regs_31 = _RAND_31[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
module Alu(
  input  [3:0]  io_op,
  input  [31:0] io_in1,
  input  [31:0] io_in2,
  output [31:0] io_out,
  output        io_zero
);
  wire [4:0] shamt = io_in2[4:0]; // @[Alu.scala 17:21]
  wire  _io_out_T = io_op == 4'h0; // @[Alu.scala 21:12]
  wire [31:0] _io_out_T_2 = io_in1 + io_in2; // @[Alu.scala 21:39]
  wire  _io_out_T_3 = io_op == 4'h1; // @[Alu.scala 22:12]
  wire [31:0] _io_out_T_5 = io_in1 - io_in2; // @[Alu.scala 22:39]
  wire  _io_out_T_6 = io_op == 4'h2; // @[Alu.scala 23:12]
  wire [31:0] _io_out_T_7 = io_in1 & io_in2; // @[Alu.scala 23:39]
  wire  _io_out_T_8 = io_op == 4'h3; // @[Alu.scala 24:12]
  wire [31:0] _io_out_T_9 = io_in1 | io_in2; // @[Alu.scala 24:39]
  wire  _io_out_T_10 = io_op == 4'h4; // @[Alu.scala 25:12]
  wire [31:0] _io_out_T_11 = io_in1 ^ io_in2; // @[Alu.scala 25:39]
  wire  _io_out_T_12 = io_op == 4'h5; // @[Alu.scala 26:12]
  wire [62:0] _GEN_0 = {{31'd0}, io_in1}; // @[Alu.scala 26:39]
  wire [62:0] _io_out_T_13 = _GEN_0 << shamt; // @[Alu.scala 26:39]
  wire  _io_out_T_14 = io_op == 4'h6; // @[Alu.scala 27:12]
  wire [31:0] _io_out_T_15 = io_in1 >> shamt; // @[Alu.scala 27:39]
  wire  _io_out_T_16 = io_op == 4'h7; // @[Alu.scala 28:12]
  wire [31:0] _io_out_T_19 = $signed(io_in1) >>> shamt; // @[Alu.scala 28:56]
  wire  _io_out_T_20 = io_op == 4'h8; // @[Alu.scala 29:12]
  wire  _io_out_T_23 = $signed(io_in1) < $signed(io_in2); // @[Alu.scala 29:46]
  wire  _io_out_T_24 = io_op == 4'h9; // @[Alu.scala 30:12]
  wire  _io_out_T_25 = io_in1 < io_in2; // @[Alu.scala 30:39]
  wire  _io_out_T_27 = _io_out_T_20 ? _io_out_T_23 : _io_out_T_24 & _io_out_T_25; // @[Mux.scala 101:16]
  wire [31:0] _io_out_T_28 = _io_out_T_16 ? _io_out_T_19 : {{31'd0}, _io_out_T_27}; // @[Mux.scala 101:16]
  wire [31:0] _io_out_T_29 = _io_out_T_14 ? _io_out_T_15 : _io_out_T_28; // @[Mux.scala 101:16]
  wire [62:0] _io_out_T_30 = _io_out_T_12 ? _io_out_T_13 : {{31'd0}, _io_out_T_29}; // @[Mux.scala 101:16]
  wire [62:0] _io_out_T_31 = _io_out_T_10 ? {{31'd0}, _io_out_T_11} : _io_out_T_30; // @[Mux.scala 101:16]
  wire [62:0] _io_out_T_32 = _io_out_T_8 ? {{31'd0}, _io_out_T_9} : _io_out_T_31; // @[Mux.scala 101:16]
  wire [62:0] _io_out_T_33 = _io_out_T_6 ? {{31'd0}, _io_out_T_7} : _io_out_T_32; // @[Mux.scala 101:16]
  wire [62:0] _io_out_T_34 = _io_out_T_3 ? {{31'd0}, _io_out_T_5} : _io_out_T_33; // @[Mux.scala 101:16]
  wire [62:0] _io_out_T_35 = _io_out_T ? {{31'd0}, _io_out_T_2} : _io_out_T_34; // @[Mux.scala 101:16]
  assign io_out = _io_out_T_35[31:0]; // @[Alu.scala 20:10]
  assign io_zero = io_out == 32'h0; // @[Alu.scala 34:22]
endmodule
module Core(
  input         clock,
  input         reset,
  output [31:0] io_instrAddr,
  input  [31:0] io_instrData,
  output [31:0] io_dataAddr,
  output [31:0] io_dataWrite,
  input  [31:0] io_dataRead,
  output        io_dataWen,
  output        io_dataRen,
  output [3:0]  io_dataMask,
  output [31:0] io_pcDebug
);
`ifdef RANDOMIZE_REG_INIT
  reg [31:0] _RAND_0;
`endif // RANDOMIZE_REG_INIT
  wire [6:0] control_io_opcode; // @[Core.scala 31:23]
  wire [2:0] control_io_funct3; // @[Core.scala 31:23]
  wire [6:0] control_io_funct7; // @[Core.scala 31:23]
  wire  control_io_signals_regWrite; // @[Core.scala 31:23]
  wire  control_io_signals_memRead; // @[Core.scala 31:23]
  wire  control_io_signals_memWrite; // @[Core.scala 31:23]
  wire  control_io_signals_memToReg; // @[Core.scala 31:23]
  wire  control_io_signals_aluSrc; // @[Core.scala 31:23]
  wire  control_io_signals_branch; // @[Core.scala 31:23]
  wire  control_io_signals_jump; // @[Core.scala 31:23]
  wire [3:0] control_io_signals_aluOp; // @[Core.scala 31:23]
  wire  regFile_clock; // @[Core.scala 36:23]
  wire  regFile_reset; // @[Core.scala 36:23]
  wire [4:0] regFile_io_readAddr1; // @[Core.scala 36:23]
  wire [4:0] regFile_io_readAddr2; // @[Core.scala 36:23]
  wire [31:0] regFile_io_readData1; // @[Core.scala 36:23]
  wire [31:0] regFile_io_readData2; // @[Core.scala 36:23]
  wire [4:0] regFile_io_writeAddr; // @[Core.scala 36:23]
  wire [31:0] regFile_io_writeData; // @[Core.scala 36:23]
  wire  regFile_io_writeEn; // @[Core.scala 36:23]
  wire [3:0] alu_io_op; // @[Core.scala 42:19]
  wire [31:0] alu_io_in1; // @[Core.scala 42:19]
  wire [31:0] alu_io_in2; // @[Core.scala 42:19]
  wire [31:0] alu_io_out; // @[Core.scala 42:19]
  wire  alu_io_zero; // @[Core.scala 42:19]
  reg [31:0] pcReg; // @[Core.scala 25:22]
  wire  _aluIn1_T_1 = io_instrData[6:0] == 7'h17; // @[Core.scala 46:28]
  wire [31:0] datapath_regRead1 = regFile_io_readData1; // @[Core.scala 23:22 39:21]
  wire [19:0] _aluIn2_T_2 = io_instrData[31] ? 20'hfffff : 20'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _aluIn2_T_6 = {_aluIn2_T_2,io_instrData[31:20]}; // @[Core.scala 50:26]
  wire [31:0] datapath_regRead2 = regFile_io_readData2; // @[Core.scala 23:22 40:21]
  wire [31:0] aluIn2 = control_io_signals_aluSrc ? _aluIn2_T_6 : datapath_regRead2; // @[Core.scala 49:19]
  wire [31:0] _finalAluIn2_T_6 = {io_instrData[31:12],12'h0}; // @[Core.scala 55:26]
  wire [31:0] _datapath_regWriteData_T_1 = pcReg + 32'h4; // @[Core.scala 74:20]
  wire [31:0] datapath_aluResult = alu_io_out; // @[Core.scala 23:22 61:22]
  wire [31:0] _datapath_regWriteData_T_2 = control_io_signals_jump ? _datapath_regWriteData_T_1 : datapath_aluResult; // @[Core.scala 73:8]
  wire [18:0] _branchTarget_T_2 = io_instrData[31] ? 19'h7ffff : 19'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _branchTarget_T_9 = {_branchTarget_T_2,io_instrData[31],io_instrData[7],io_instrData[30:25],io_instrData[
    11:8],1'h0}; // @[Core.scala 84:57]
  wire [31:0] branchTarget = pcReg + _branchTarget_T_9; // @[Core.scala 84:34]
  wire  _jumpTarget_T_1 = io_instrData[6:0] == 7'h67; // @[Core.scala 86:27]
  wire [31:0] _jumpTarget_T_10 = datapath_regRead1 + _aluIn2_T_6; // @[Core.scala 87:24]
  wire [31:0] _jumpTarget_T_12 = _jumpTarget_T_10 & 32'hfffffffe; // @[Core.scala 87:55]
  wire [10:0] _jumpTarget_T_15 = io_instrData[31] ? 11'h7ff : 11'h0; // @[Bitwise.scala 77:12]
  wire [31:0] _jumpTarget_T_22 = {_jumpTarget_T_15,io_instrData[31],io_instrData[19:12],io_instrData[20],io_instrData[30
    :21],1'h0}; // @[Core.scala 88:40]
  wire [31:0] _jumpTarget_T_24 = pcReg + _jumpTarget_T_22; // @[Core.scala 88:17]
  wire  _nextPc_T_2 = control_io_signals_branch & alu_io_zero; // @[Core.scala 93:32]
  Control control ( // @[Core.scala 31:23]
    .io_opcode(control_io_opcode),
    .io_funct3(control_io_funct3),
    .io_funct7(control_io_funct7),
    .io_signals_regWrite(control_io_signals_regWrite),
    .io_signals_memRead(control_io_signals_memRead),
    .io_signals_memWrite(control_io_signals_memWrite),
    .io_signals_memToReg(control_io_signals_memToReg),
    .io_signals_aluSrc(control_io_signals_aluSrc),
    .io_signals_branch(control_io_signals_branch),
    .io_signals_jump(control_io_signals_jump),
    .io_signals_aluOp(control_io_signals_aluOp)
  );
  RegFile regFile ( // @[Core.scala 36:23]
    .clock(regFile_clock),
    .reset(regFile_reset),
    .io_readAddr1(regFile_io_readAddr1),
    .io_readAddr2(regFile_io_readAddr2),
    .io_readData1(regFile_io_readData1),
    .io_readData2(regFile_io_readData2),
    .io_writeAddr(regFile_io_writeAddr),
    .io_writeData(regFile_io_writeData),
    .io_writeEn(regFile_io_writeEn)
  );
  Alu alu ( // @[Core.scala 42:19]
    .io_op(alu_io_op),
    .io_in1(alu_io_in1),
    .io_in2(alu_io_in2),
    .io_out(alu_io_out),
    .io_zero(alu_io_zero)
  );
  assign io_instrAddr = pcReg; // @[Core.scala 23:22 26:15]
  assign io_dataAddr = alu_io_out; // @[Core.scala 23:22 61:22]
  assign io_dataWrite = regFile_io_readData2; // @[Core.scala 23:22 40:21]
  assign io_dataWen = control_io_signals_memWrite; // @[Core.scala 65:16]
  assign io_dataRen = control_io_signals_memRead; // @[Core.scala 66:16]
  assign io_dataMask = 4'hf; // @[Core.scala 67:16]
  assign io_pcDebug = pcReg; // @[Core.scala 23:22 26:15]
  assign control_io_opcode = io_instrData[6:0]; // @[Bundle.scala 9:20]
  assign control_io_funct3 = io_instrData[14:12]; // @[Bundle.scala 13:20]
  assign control_io_funct7 = io_instrData[31:25]; // @[Bundle.scala 14:20]
  assign regFile_clock = clock;
  assign regFile_reset = reset;
  assign regFile_io_readAddr1 = io_instrData[19:15]; // @[Bundle.scala 11:20]
  assign regFile_io_readAddr2 = io_instrData[24:20]; // @[Bundle.scala 12:20]
  assign regFile_io_writeAddr = io_instrData[11:7]; // @[Bundle.scala 10:20]
  assign regFile_io_writeData = control_io_signals_memToReg ? io_dataRead : _datapath_regWriteData_T_2; // @[Core.scala 71:31]
  assign regFile_io_writeEn = control_io_signals_regWrite; // @[Core.scala 82:24]
  assign alu_io_op = control_io_signals_aluOp; // @[Core.scala 43:13]
  assign alu_io_in1 = _aluIn1_T_1 ? pcReg : datapath_regRead1; // @[Mux.scala 101:16]
  assign alu_io_in2 = io_instrData[6:0] == 7'h37 ? _finalAluIn2_T_6 : aluIn2; // @[Core.scala 54:24]
  always @(posedge clock) begin
    if (reset) begin // @[Core.scala 25:22]
      pcReg <= 32'h80000000; // @[Core.scala 25:22]
    end else if (control_io_signals_jump) begin // @[Mux.scala 101:16]
      if (_jumpTarget_T_1) begin // @[Core.scala 85:23]
        pcReg <= _jumpTarget_T_12;
      end else begin
        pcReg <= _jumpTarget_T_24;
      end
    end else if (_nextPc_T_2) begin // @[Mux.scala 101:16]
      pcReg <= branchTarget;
    end else begin
      pcReg <= _datapath_regWriteData_T_1;
    end
  end
// Register and memory initialization
`ifdef RANDOMIZE_GARBAGE_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_INVALID_ASSIGN
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_REG_INIT
`define RANDOMIZE
`endif
`ifdef RANDOMIZE_MEM_INIT
`define RANDOMIZE
`endif
`ifndef RANDOM
`define RANDOM $random
`endif
`ifdef RANDOMIZE_MEM_INIT
  integer initvar;
`endif
`ifndef SYNTHESIS
`ifdef FIRRTL_BEFORE_INITIAL
`FIRRTL_BEFORE_INITIAL
`endif
initial begin
  `ifdef RANDOMIZE
    `ifdef INIT_RANDOM
      `INIT_RANDOM
    `endif
    `ifndef VERILATOR
      `ifdef RANDOMIZE_DELAY
        #`RANDOMIZE_DELAY begin end
      `else
        #0.002 begin end
      `endif
    `endif
`ifdef RANDOMIZE_REG_INIT
  _RAND_0 = {1{`RANDOM}};
  pcReg = _RAND_0[31:0];
`endif // RANDOMIZE_REG_INIT
  `endif // RANDOMIZE
end // initial
`ifdef FIRRTL_AFTER_INITIAL
`FIRRTL_AFTER_INITIAL
`endif
`endif // SYNTHESIS
endmodule
