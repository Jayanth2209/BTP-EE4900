//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Tue May  9 22:24:32 IST 2023
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_inputs                 O     1
// mac_result                     O   132
// RDY_mac_result                 O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_inputs_multiplicand1       I    64
// get_inputs_multiplicand2       I    64
// get_inputs_addend              I    64
// get_inputs_mode                I     2 reg
// EN_get_inputs                  I     1
//
// No combinational paths from inputs to outputs
//
//

`ifdef BSV_ASSIGNMENT_DELAY
`else
  `define BSV_ASSIGNMENT_DELAY
`endif

`ifdef BSV_POSITIVE_RESET
  `define BSV_RESET_VALUE 1'b1
  `define BSV_RESET_EDGE posedge
`else
  `define BSV_RESET_VALUE 1'b0
  `define BSV_RESET_EDGE negedge
`endif

module mkMAC64(CLK,
	       RST_N,

	       get_inputs_multiplicand1,
	       get_inputs_multiplicand2,
	       get_inputs_addend,
	       get_inputs_mode,
	       EN_get_inputs,
	       RDY_get_inputs,

	       mac_result,
	       RDY_mac_result);
  input  CLK;
  input  RST_N;

  // action method get_inputs
  input  [63 : 0] get_inputs_multiplicand1;
  input  [63 : 0] get_inputs_multiplicand2;
  input  [63 : 0] get_inputs_addend;
  input  [1 : 0] get_inputs_mode;
  input  EN_get_inputs;
  output RDY_get_inputs;

  // value method mac_result
  output [131 : 0] mac_result;
  output RDY_mac_result;

  // signals for module outputs
  wire [131 : 0] mac_result;
  wire RDY_get_inputs, RDY_mac_result;

  // inlined wires
  reg [128 : 0] mac_output_rv$port1__write_1;
  wire [704 : 0] partial_sum_rv$port1__read,
		 partial_sum_rv$port1__write_1,
		 partial_sum_rv$port2__read;
  wire [576 : 0] partial_product_rv$port1__read,
		 partial_product_rv$port1__write_1,
		 partial_product_rv$port2__read;
  wire [192 : 0] mac_inputs_rv$port1__read,
		 mac_inputs_rv$port1__write_1,
		 mac_inputs_rv$port2__read;
  wire [128 : 0] mac_output_rv$port2__read;
  wire mac_inputs_rv$EN_port0__write,
       mac_output_rv$EN_port1__write,
       partial_product_rv$EN_port0__write;

  // register counter
  reg [3 : 0] counter;
  wire [3 : 0] counter$D_IN;
  wire counter$EN;

  // register mac_inputs_rv
  reg [192 : 0] mac_inputs_rv;
  wire [192 : 0] mac_inputs_rv$D_IN;
  wire mac_inputs_rv$EN;

  // register mac_output_rv
  reg [128 : 0] mac_output_rv;
  wire [128 : 0] mac_output_rv$D_IN;
  wire mac_output_rv$EN;

  // register mode_r
  reg [1 : 0] mode_r;
  wire [1 : 0] mode_r$D_IN;
  wire mode_r$EN;

  // register partial_product_rv
  reg [576 : 0] partial_product_rv;
  wire [576 : 0] partial_product_rv$D_IN;
  wire partial_product_rv$EN;

  // register partial_sum_rv
  reg [704 : 0] partial_sum_rv;
  wire [704 : 0] partial_sum_rv$D_IN;
  wire partial_sum_rv$EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_cycle_count,
       CAN_FIRE_RL_rl_generate_partials,
       CAN_FIRE_RL_rl_mac_16,
       CAN_FIRE_RL_rl_mac_32,
       CAN_FIRE_RL_rl_mac_64_1,
       CAN_FIRE_RL_rl_mac_64_2,
       CAN_FIRE_RL_rl_mac_8,
       CAN_FIRE_get_inputs,
       WILL_FIRE_RL_cycle_count,
       WILL_FIRE_RL_rl_generate_partials,
       WILL_FIRE_RL_rl_mac_16,
       WILL_FIRE_RL_rl_mac_32,
       WILL_FIRE_RL_rl_mac_64_1,
       WILL_FIRE_RL_rl_mac_64_2,
       WILL_FIRE_RL_rl_mac_8,
       WILL_FIRE_get_inputs;

  // inputs to muxes for submodule ports
  wire [128 : 0] MUX_mac_output_rv$port1__write_1__VAL_1,
		 MUX_mac_output_rv$port1__write_1__VAL_2,
		 MUX_mac_output_rv$port1__write_1__VAL_3,
		 MUX_mac_output_rv$port1__write_1__VAL_4;

  // remaining internal signals
  wire [127 : 0] x033_PLUS_y034__q5,
		 x397_PLUS_y398__q1,
		 x479_PLUS_y480__q2,
		 x498_PLUS_y499__q4,
		 x601_PLUS_y602__q3,
		 x__h3909,
		 x__h3935,
		 x__h3937,
		 x__h3939,
		 x__h4397,
		 x__h4479,
		 x__h4481,
		 x__h4601,
		 x__h4603,
		 x__h4605,
		 x__h6480,
		 x__h6481,
		 x__h6483,
		 x__h6485,
		 x__h6498,
		 x__h6500,
		 x__h7033,
		 y__h3936,
		 y__h3938,
		 y__h3940,
		 y__h4398,
		 y__h4480,
		 y__h4482,
		 y__h4602,
		 y__h4604,
		 y__h4606,
		 y__h6482,
		 y__h6484,
		 y__h6486,
		 y__h6499,
		 y__h6501,
		 y__h7034;
  wire [111 : 0] _0_CONCAT_mac_inputs_rv_port0__read_BITS_183_TO_ETC___d277;
  wire [79 : 0] _0_CONCAT_mac_inputs_rv_port0__read_BITS_167_TO_ETC___d276;
  wire [63 : 0] _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d51,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d59,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d64,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d66,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d37,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d47,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d56,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d61,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d26,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d33,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d44,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d54,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d17,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d21,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d30,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d42,
		mac_32_1__h7255,
		mac_32_2__h7256,
		x316_PLUS_y317__q6,
		x454_PLUS_y455__q7,
		x__h7276,
		x__h7278,
		x__h7280,
		x__h7316,
		x__h7414,
		x__h7416,
		x__h7418,
		x__h7454,
		y__h7277,
		y__h7279,
		y__h7281,
		y__h7317,
		y__h7415,
		y__h7417,
		y__h7419,
		y__h7455;
  wire [47 : 0] _0_CONCAT_mac_inputs_rv_port0__read_BITS_151_TO_ETC___d275;
  wire [31 : 0] _0_CONCAT_mac_inputs_rv_port0__read_BITS_135_TO_ETC___d270,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d261,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_151_TO_ETC___d252,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d243,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_167_TO_ETC___d234,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d225,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_183_TO_ETC___d216,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d207,
		mac_16_1__h7584,
		mac_16_2__h7585,
		mac_16_3__h7586,
		mac_16_4__h7587;
  wire [15 : 0] x__h8134,
		x__h8229,
		x__h8322,
		x__h8415,
		x__h8508,
		x__h8601,
		x__h8694,
		x__h8787,
		y__h8133,
		y__h8135,
		y__h8228,
		y__h8230,
		y__h8321,
		y__h8323,
		y__h8414,
		y__h8416,
		y__h8507,
		y__h8509,
		y__h8600,
		y__h8602,
		y__h8693,
		y__h8695,
		y__h8786,
		y__h8788;

  // action method get_inputs
  assign RDY_get_inputs = !mac_inputs_rv$port1__read[192] ;
  assign CAN_FIRE_get_inputs = !mac_inputs_rv$port1__read[192] ;
  assign WILL_FIRE_get_inputs = EN_get_inputs ;

  // value method mac_result
  assign mac_result = { counter, mac_output_rv[127:0] } ;
  assign RDY_mac_result = mac_output_rv[128] ;

  // rule RL_cycle_count
  assign CAN_FIRE_RL_cycle_count = 1'd1 ;
  assign WILL_FIRE_RL_cycle_count = 1'd1 ;

  // rule RL_rl_mac_64_2
  assign CAN_FIRE_RL_rl_mac_64_2 =
	     partial_sum_rv[704] && !mac_output_rv[128] && mode_r == 2'h3 ;
  assign WILL_FIRE_RL_rl_mac_64_2 = CAN_FIRE_RL_rl_mac_64_2 ;

  // rule RL_rl_mac_64_1
  assign CAN_FIRE_RL_rl_mac_64_1 =
	     partial_product_rv[576] && !partial_sum_rv$port1__read[704] &&
	     mode_r == 2'h3 ;
  assign WILL_FIRE_RL_rl_mac_64_1 = CAN_FIRE_RL_rl_mac_64_1 ;

  // rule RL_rl_mac_32
  assign CAN_FIRE_RL_rl_mac_32 =
	     partial_product_rv[576] && !mac_output_rv[128] &&
	     mode_r == 2'h2 ;
  assign WILL_FIRE_RL_rl_mac_32 = CAN_FIRE_RL_rl_mac_32 ;

  // rule RL_rl_mac_16
  assign CAN_FIRE_RL_rl_mac_16 =
	     partial_product_rv[576] && !mac_output_rv[128] &&
	     mode_r == 2'h1 ;
  assign WILL_FIRE_RL_rl_mac_16 = CAN_FIRE_RL_rl_mac_16 ;

  // rule RL_rl_generate_partials
  assign CAN_FIRE_RL_rl_generate_partials =
	     mac_inputs_rv[192] && !partial_product_rv$port1__read[576] &&
	     mode_r != 2'h0 ;
  assign WILL_FIRE_RL_rl_generate_partials =
	     CAN_FIRE_RL_rl_generate_partials ;

  // rule RL_rl_mac_8
  assign CAN_FIRE_RL_rl_mac_8 =
	     mac_inputs_rv[192] && !mac_output_rv[128] && mode_r == 2'h0 ;
  assign WILL_FIRE_RL_rl_mac_8 = CAN_FIRE_RL_rl_mac_8 ;

  // inputs to muxes for submodule ports
  assign MUX_mac_output_rv$port1__write_1__VAL_1 =
	     { 1'd1, x__h6480 + partial_sum_rv[703:576] } ;
  assign MUX_mac_output_rv$port1__write_1__VAL_2 =
	     { 1'd1, mac_32_2__h7256, mac_32_1__h7255 } ;
  assign MUX_mac_output_rv$port1__write_1__VAL_3 =
	     { 1'd1,
	       mac_16_4__h7587,
	       mac_16_3__h7586,
	       mac_16_2__h7585,
	       mac_16_1__h7584 } ;
  assign MUX_mac_output_rv$port1__write_1__VAL_4 =
	     { 1'd1,
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d207[15:0] +
	       y__h8133,
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_183_TO_ETC___d277 } ;

  // inlined wires
  assign mac_inputs_rv$EN_port0__write =
	     WILL_FIRE_RL_rl_mac_8 || WILL_FIRE_RL_rl_generate_partials ;
  assign mac_inputs_rv$port1__read =
	     mac_inputs_rv$EN_port0__write ?
	       193'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA :
	       mac_inputs_rv ;
  assign mac_inputs_rv$port1__write_1 =
	     { 1'd1,
	       get_inputs_multiplicand1,
	       get_inputs_multiplicand2,
	       get_inputs_addend } ;
  assign mac_inputs_rv$port2__read =
	     EN_get_inputs ?
	       mac_inputs_rv$port1__write_1 :
	       mac_inputs_rv$port1__read ;
  assign partial_product_rv$EN_port0__write =
	     WILL_FIRE_RL_rl_mac_16 || WILL_FIRE_RL_rl_mac_32 ||
	     WILL_FIRE_RL_rl_mac_64_1 ;
  assign partial_product_rv$port1__read =
	     partial_product_rv$EN_port0__write ?
	       577'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA :
	       partial_product_rv ;
  assign partial_product_rv$port1__write_1 =
	     { 1'd1,
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d17[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d21[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d26[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d30[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d33[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d37[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d42[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d44[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d47[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d51[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d54[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d56[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d59[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d61[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d64[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d66[31:0],
	       mac_inputs_rv[63:0] } ;
  assign partial_product_rv$port2__read =
	     CAN_FIRE_RL_rl_generate_partials ?
	       partial_product_rv$port1__write_1 :
	       partial_product_rv$port1__read ;
  assign partial_sum_rv$port1__read =
	     CAN_FIRE_RL_rl_mac_64_2 ?
	       705'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA :
	       partial_sum_rv ;
  assign partial_sum_rv$port1__write_1 =
	     { 1'd1, x__h3909, partial_product_rv[575:0] } ;
  assign partial_sum_rv$port2__read =
	     CAN_FIRE_RL_rl_mac_64_1 ?
	       partial_sum_rv$port1__write_1 :
	       partial_sum_rv$port1__read ;
  assign mac_output_rv$EN_port1__write =
	     WILL_FIRE_RL_rl_mac_64_2 || WILL_FIRE_RL_rl_mac_32 ||
	     WILL_FIRE_RL_rl_mac_16 ||
	     WILL_FIRE_RL_rl_mac_8 ;
  always@(WILL_FIRE_RL_rl_mac_64_2 or
	  MUX_mac_output_rv$port1__write_1__VAL_1 or
	  WILL_FIRE_RL_rl_mac_32 or
	  MUX_mac_output_rv$port1__write_1__VAL_2 or
	  WILL_FIRE_RL_rl_mac_16 or
	  MUX_mac_output_rv$port1__write_1__VAL_3 or
	  WILL_FIRE_RL_rl_mac_8 or MUX_mac_output_rv$port1__write_1__VAL_4)
  begin
    case (1'b1) // synopsys parallel_case
      WILL_FIRE_RL_rl_mac_64_2:
	  mac_output_rv$port1__write_1 =
	      MUX_mac_output_rv$port1__write_1__VAL_1;
      WILL_FIRE_RL_rl_mac_32:
	  mac_output_rv$port1__write_1 =
	      MUX_mac_output_rv$port1__write_1__VAL_2;
      WILL_FIRE_RL_rl_mac_16:
	  mac_output_rv$port1__write_1 =
	      MUX_mac_output_rv$port1__write_1__VAL_3;
      WILL_FIRE_RL_rl_mac_8:
	  mac_output_rv$port1__write_1 =
	      MUX_mac_output_rv$port1__write_1__VAL_4;
      default: mac_output_rv$port1__write_1 =
		   129'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA /* unspecified value */ ;
    endcase
  end
  assign mac_output_rv$port2__read =
	     mac_output_rv$EN_port1__write ?
	       mac_output_rv$port1__write_1 :
	       mac_output_rv ;

  // register counter
  assign counter$D_IN = counter + 4'd1 ;
  assign counter$EN = 1'd1 ;

  // register mac_inputs_rv
  assign mac_inputs_rv$D_IN = mac_inputs_rv$port2__read ;
  assign mac_inputs_rv$EN = 1'b1 ;

  // register mac_output_rv
  assign mac_output_rv$D_IN = mac_output_rv$port2__read ;
  assign mac_output_rv$EN = 1'b1 ;

  // register mode_r
  assign mode_r$D_IN = get_inputs_mode ;
  assign mode_r$EN = EN_get_inputs ;

  // register partial_product_rv
  assign partial_product_rv$D_IN = partial_product_rv$port2__read ;
  assign partial_product_rv$EN = 1'b1 ;

  // register partial_sum_rv
  assign partial_sum_rv$D_IN = partial_sum_rv$port2__read ;
  assign partial_sum_rv$EN = 1'b1 ;

  // remaining internal signals
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_135_TO_ETC___d270 =
	     x__h8787 * y__h8788 ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d261 =
	     x__h8694 * y__h8695 ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d51 =
	     { 16'd0, mac_inputs_rv[143:128] } *
	     { 16'd0, mac_inputs_rv[127:112] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d59 =
	     { 16'd0, mac_inputs_rv[143:128] } *
	     { 16'd0, mac_inputs_rv[111:96] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d64 =
	     { 16'd0, mac_inputs_rv[143:128] } *
	     { 16'd0, mac_inputs_rv[95:80] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d66 =
	     { 16'd0, mac_inputs_rv[143:128] } *
	     { 16'd0, mac_inputs_rv[79:64] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_151_TO_ETC___d252 =
	     x__h8601 * y__h8602 ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_151_TO_ETC___d275 =
	     { _0_CONCAT_mac_inputs_rv_port0__read_BITS_151_TO_ETC___d252[15:0] +
	       y__h8600,
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d261[15:0] +
	       y__h8693,
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_135_TO_ETC___d270[15:0] +
	       y__h8786 } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d243 =
	     x__h8508 * y__h8509 ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d37 =
	     { 16'd0, mac_inputs_rv[159:144] } *
	     { 16'd0, mac_inputs_rv[127:112] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d47 =
	     { 16'd0, mac_inputs_rv[159:144] } *
	     { 16'd0, mac_inputs_rv[111:96] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d56 =
	     { 16'd0, mac_inputs_rv[159:144] } *
	     { 16'd0, mac_inputs_rv[95:80] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d61 =
	     { 16'd0, mac_inputs_rv[159:144] } *
	     { 16'd0, mac_inputs_rv[79:64] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_167_TO_ETC___d234 =
	     x__h8415 * y__h8416 ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_167_TO_ETC___d276 =
	     { _0_CONCAT_mac_inputs_rv_port0__read_BITS_167_TO_ETC___d234[15:0] +
	       y__h8414,
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d243[15:0] +
	       y__h8507,
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_151_TO_ETC___d275 } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d225 =
	     x__h8322 * y__h8323 ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d26 =
	     { 16'd0, mac_inputs_rv[175:160] } *
	     { 16'd0, mac_inputs_rv[127:112] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d33 =
	     { 16'd0, mac_inputs_rv[175:160] } *
	     { 16'd0, mac_inputs_rv[111:96] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d44 =
	     { 16'd0, mac_inputs_rv[175:160] } *
	     { 16'd0, mac_inputs_rv[95:80] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d54 =
	     { 16'd0, mac_inputs_rv[175:160] } *
	     { 16'd0, mac_inputs_rv[79:64] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_183_TO_ETC___d216 =
	     x__h8229 * y__h8230 ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_183_TO_ETC___d277 =
	     { _0_CONCAT_mac_inputs_rv_port0__read_BITS_183_TO_ETC___d216[15:0] +
	       y__h8228,
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d225[15:0] +
	       y__h8321,
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_167_TO_ETC___d276 } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d17 =
	     { 16'd0, mac_inputs_rv[191:176] } *
	     { 16'd0, mac_inputs_rv[127:112] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d207 =
	     x__h8134 * y__h8135 ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d21 =
	     { 16'd0, mac_inputs_rv[191:176] } *
	     { 16'd0, mac_inputs_rv[111:96] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d30 =
	     { 16'd0, mac_inputs_rv[191:176] } *
	     { 16'd0, mac_inputs_rv[95:80] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d42 =
	     { 16'd0, mac_inputs_rv[191:176] } *
	     { 16'd0, mac_inputs_rv[79:64] } ;
  assign mac_16_1__h7584 =
	     partial_product_rv[95:64] + { 16'd0, partial_product_rv[15:0] } ;
  assign mac_16_2__h7585 =
	     partial_product_rv[223:192] +
	     { 16'd0, partial_product_rv[31:16] } ;
  assign mac_16_3__h7586 =
	     partial_product_rv[447:416] +
	     { 16'd0, partial_product_rv[47:32] } ;
  assign mac_16_4__h7587 =
	     partial_product_rv[575:544] +
	     { 16'd0, partial_product_rv[63:48] } ;
  assign mac_32_1__h7255 = x__h7414 + y__h7415 ;
  assign mac_32_2__h7256 = x__h7276 + y__h7277 ;
  assign x033_PLUS_y034__q5 = x__h7033 + y__h7034 ;
  assign x316_PLUS_y317__q6 = x__h7316 + y__h7317 ;
  assign x397_PLUS_y398__q1 = x__h4397 + y__h4398 ;
  assign x454_PLUS_y455__q7 = x__h7454 + y__h7455 ;
  assign x479_PLUS_y480__q2 = x__h4479 + y__h4480 ;
  assign x498_PLUS_y499__q4 = x__h6498 + y__h6499 ;
  assign x601_PLUS_y602__q3 = x__h4601 + y__h4602 ;
  assign x__h3909 = x__h3935 + y__h3936 ;
  assign x__h3935 = x__h3937 + y__h3938 ;
  assign x__h3937 = x__h3939 + y__h3940 ;
  assign x__h3939 = { 96'd0, partial_product_rv[95:64] } ;
  assign x__h4397 = { 96'd0, partial_product_rv[127:96] } ;
  assign x__h4479 = x__h4481 + y__h4482 ;
  assign x__h4481 = { 96'd0, partial_product_rv[191:160] } ;
  assign x__h4601 = x__h4603 + y__h4604 ;
  assign x__h4603 = x__h4605 + y__h4606 ;
  assign x__h4605 = { 96'd0, partial_product_rv[287:256] } ;
  assign x__h6480 = x__h6481 + y__h6482 ;
  assign x__h6481 = x__h6483 + y__h6484 ;
  assign x__h6483 = x__h6485 + y__h6486 ;
  assign x__h6485 = { x498_PLUS_y499__q4[63:0], 64'd0 } ;
  assign x__h6498 = x__h6500 + y__h6501 ;
  assign x__h6500 = { 96'd0, partial_sum_rv[415:384] } ;
  assign x__h7033 = { 96'd0, partial_sum_rv[511:480] } ;
  assign x__h7276 = x__h7278 + y__h7279 ;
  assign x__h7278 = x__h7280 + y__h7281 ;
  assign x__h7280 = { 32'd0, partial_product_rv[447:416] } ;
  assign x__h7316 = { 32'd0, partial_product_rv[511:480] } ;
  assign x__h7414 = x__h7416 + y__h7417 ;
  assign x__h7416 = x__h7418 + y__h7419 ;
  assign x__h7418 = { 32'd0, partial_product_rv[95:64] } ;
  assign x__h7454 = { 32'd0, partial_product_rv[127:96] } ;
  assign x__h8134 = { 8'd0, mac_inputs_rv[191:184] } ;
  assign x__h8229 = { 8'd0, mac_inputs_rv[183:176] } ;
  assign x__h8322 = { 8'd0, mac_inputs_rv[175:168] } ;
  assign x__h8415 = { 8'd0, mac_inputs_rv[167:160] } ;
  assign x__h8508 = { 8'd0, mac_inputs_rv[159:152] } ;
  assign x__h8601 = { 8'd0, mac_inputs_rv[151:144] } ;
  assign x__h8694 = { 8'd0, mac_inputs_rv[143:136] } ;
  assign x__h8787 = { 8'd0, mac_inputs_rv[135:128] } ;
  assign y__h3936 = { x601_PLUS_y602__q3[79:0], 48'd0 } ;
  assign y__h3938 = { x479_PLUS_y480__q2[95:0], 32'd0 } ;
  assign y__h3940 = { x397_PLUS_y398__q1[111:0], 16'd0 } ;
  assign y__h4398 = { 96'd0, partial_product_rv[159:128] } ;
  assign y__h4480 = { 96'd0, partial_product_rv[255:224] } ;
  assign y__h4482 = { 96'd0, partial_product_rv[223:192] } ;
  assign y__h4602 = { 96'd0, partial_product_rv[383:352] } ;
  assign y__h4604 = { 96'd0, partial_product_rv[351:320] } ;
  assign y__h4606 = { 96'd0, partial_product_rv[319:288] } ;
  assign y__h6482 = { 64'd0, partial_sum_rv[63:0] } ;
  assign y__h6484 = { partial_sum_rv[575:544], 96'd0 } ;
  assign y__h6486 = { x033_PLUS_y034__q5[47:0], 80'd0 } ;
  assign y__h6499 = { 96'd0, partial_sum_rv[479:448] } ;
  assign y__h6501 = { 96'd0, partial_sum_rv[447:416] } ;
  assign y__h7034 = { 96'd0, partial_sum_rv[543:512] } ;
  assign y__h7277 = { 32'd0, partial_product_rv[63:32] } ;
  assign y__h7279 = { partial_product_rv[575:544], 32'd0 } ;
  assign y__h7281 = { x316_PLUS_y317__q6[47:0], 16'd0 } ;
  assign y__h7317 = { 32'd0, partial_product_rv[543:512] } ;
  assign y__h7415 = { 32'd0, partial_product_rv[31:0] } ;
  assign y__h7417 = { partial_product_rv[223:192], 32'd0 } ;
  assign y__h7419 = { x454_PLUS_y455__q7[47:0], 16'd0 } ;
  assign y__h7455 = { 32'd0, partial_product_rv[159:128] } ;
  assign y__h8133 = { 8'd0, mac_inputs_rv[63:56] } ;
  assign y__h8135 = { 8'd0, mac_inputs_rv[127:120] } ;
  assign y__h8228 = { 8'd0, mac_inputs_rv[55:48] } ;
  assign y__h8230 = { 8'd0, mac_inputs_rv[119:112] } ;
  assign y__h8321 = { 8'd0, mac_inputs_rv[47:40] } ;
  assign y__h8323 = { 8'd0, mac_inputs_rv[111:104] } ;
  assign y__h8414 = { 8'd0, mac_inputs_rv[39:32] } ;
  assign y__h8416 = { 8'd0, mac_inputs_rv[103:96] } ;
  assign y__h8507 = { 8'd0, mac_inputs_rv[31:24] } ;
  assign y__h8509 = { 8'd0, mac_inputs_rv[95:88] } ;
  assign y__h8600 = { 8'd0, mac_inputs_rv[23:16] } ;
  assign y__h8602 = { 8'd0, mac_inputs_rv[87:80] } ;
  assign y__h8693 = { 8'd0, mac_inputs_rv[15:8] } ;
  assign y__h8695 = { 8'd0, mac_inputs_rv[79:72] } ;
  assign y__h8786 = { 8'd0, mac_inputs_rv[7:0] } ;
  assign y__h8788 = { 8'd0, mac_inputs_rv[71:64] } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        counter <= `BSV_ASSIGNMENT_DELAY 4'd0;
	mac_inputs_rv <= `BSV_ASSIGNMENT_DELAY
	    193'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
	mac_output_rv <= `BSV_ASSIGNMENT_DELAY
	    129'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
	mode_r <= `BSV_ASSIGNMENT_DELAY 2'd0;
	partial_product_rv <= `BSV_ASSIGNMENT_DELAY
	    577'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
	partial_sum_rv <= `BSV_ASSIGNMENT_DELAY
	    705'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
      end
    else
      begin
        if (counter$EN) counter <= `BSV_ASSIGNMENT_DELAY counter$D_IN;
	if (mac_inputs_rv$EN)
	  mac_inputs_rv <= `BSV_ASSIGNMENT_DELAY mac_inputs_rv$D_IN;
	if (mac_output_rv$EN)
	  mac_output_rv <= `BSV_ASSIGNMENT_DELAY mac_output_rv$D_IN;
	if (mode_r$EN) mode_r <= `BSV_ASSIGNMENT_DELAY mode_r$D_IN;
	if (partial_product_rv$EN)
	  partial_product_rv <= `BSV_ASSIGNMENT_DELAY partial_product_rv$D_IN;
	if (partial_sum_rv$EN)
	  partial_sum_rv <= `BSV_ASSIGNMENT_DELAY partial_sum_rv$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    counter = 4'hA;
    mac_inputs_rv = 193'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    mac_output_rv = 129'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    mode_r = 2'h2;
    partial_product_rv =
	577'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    partial_sum_rv =
	705'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMAC64

