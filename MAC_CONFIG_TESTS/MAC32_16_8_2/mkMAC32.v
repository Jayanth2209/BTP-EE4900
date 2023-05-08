//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Mon May  8 21:32:20 IST 2023
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_inputs                 O     1
// mac_result                     O    64
// RDY_mac_result                 O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_inputs_multiplicand1       I    32
// get_inputs_multiplicand2       I    32
// get_inputs_addend              I    32
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

module mkMAC32(CLK,
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
  input  [31 : 0] get_inputs_multiplicand1;
  input  [31 : 0] get_inputs_multiplicand2;
  input  [31 : 0] get_inputs_addend;
  input  [1 : 0] get_inputs_mode;
  input  EN_get_inputs;
  output RDY_get_inputs;

  // value method mac_result
  output [63 : 0] mac_result;
  output RDY_mac_result;

  // signals for module outputs
  wire [63 : 0] mac_result;
  wire RDY_get_inputs, RDY_mac_result;

  // inlined wires
  reg [64 : 0] mac_output_rv$port1__write_1;
  wire [160 : 0] partial_product_rv$port1__read,
		 partial_product_rv$port1__write_1,
		 partial_product_rv$port2__read;
  wire [96 : 0] mac_inputs_rv$port1__read,
		mac_inputs_rv$port1__write_1,
		mac_inputs_rv$port2__read;
  wire [64 : 0] mac_output_rv$port2__read;
  wire mac_inputs_rv$EN_port0__write,
       mac_output_rv$EN_port1__write,
       partial_product_rv$EN_port0__write;

  // register mac8_0
  reg [15 : 0] mac8_0;
  wire [15 : 0] mac8_0$D_IN;
  wire mac8_0$EN;

  // register mac8_1
  reg [15 : 0] mac8_1;
  wire [15 : 0] mac8_1$D_IN;
  wire mac8_1$EN;

  // register mac8_2
  reg [15 : 0] mac8_2;
  wire [15 : 0] mac8_2$D_IN;
  wire mac8_2$EN;

  // register mac8_3
  reg [15 : 0] mac8_3;
  wire [15 : 0] mac8_3$D_IN;
  wire mac8_3$EN;

  // register mac_inputs_rv
  reg [96 : 0] mac_inputs_rv;
  wire [96 : 0] mac_inputs_rv$D_IN;
  wire mac_inputs_rv$EN;

  // register mac_output_rv
  reg [64 : 0] mac_output_rv;
  wire [64 : 0] mac_output_rv$D_IN;
  wire mac_output_rv$EN;

  // register mode_r
  reg [1 : 0] mode_r;
  wire [1 : 0] mode_r$D_IN;
  wire mode_r$EN;

  // register partial_product_rv
  reg [160 : 0] partial_product_rv;
  wire [160 : 0] partial_product_rv$D_IN;
  wire partial_product_rv$EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_generate_partials,
       CAN_FIRE_RL_rl_mac_16,
       CAN_FIRE_RL_rl_mac_32,
       CAN_FIRE_RL_rl_mac_8,
       CAN_FIRE_get_inputs,
       WILL_FIRE_RL_rl_generate_partials,
       WILL_FIRE_RL_rl_mac_16,
       WILL_FIRE_RL_rl_mac_32,
       WILL_FIRE_RL_rl_mac_8,
       WILL_FIRE_get_inputs;

  // inputs to muxes for submodule ports
  wire [64 : 0] MUX_mac_output_rv$port1__write_1__VAL_1,
		MUX_mac_output_rv$port1__write_1__VAL_2,
		MUX_mac_output_rv$port1__write_1__VAL_3;

  // remaining internal signals
  wire [63 : 0] _0_CONCAT_mac_inputs_rv_port0__read_BITS_79_TO__ETC___d15,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_79_TO__ETC___d19,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_95_TO__ETC___d23,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_95_TO__ETC___d25,
		x__h1616,
		x__h1618,
		x__h1620,
		y__h1617,
		y__h1619,
		y__h1621;
  wire [31 : 0] _0_CONCAT_mac_inputs_rv_port0__read_BITS_71_TO__ETC___d97,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_79_TO__ETC___d88,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_87_TO__ETC___d79,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_95_TO__ETC___d70,
		x__h1691,
		y__h1842,
		y__h1878;
  wire [15 : 0] mac_8_0__h2248,
		mac_8_1__h2150,
		mac_8_2__h2053,
		mac_8_3__h1957,
		x__h1978,
		x__h2076,
		x__h2175,
		x__h2274,
		y__h1977,
		y__h1979,
		y__h2075,
		y__h2077,
		y__h2174,
		y__h2176,
		y__h2273,
		y__h2275;

  // action method get_inputs
  assign RDY_get_inputs = !mac_inputs_rv$port1__read[96] ;
  assign CAN_FIRE_get_inputs = !mac_inputs_rv$port1__read[96] ;
  assign WILL_FIRE_get_inputs = EN_get_inputs ;

  // value method mac_result
  assign mac_result = mac_output_rv[63:0] ;
  assign RDY_mac_result = mac_output_rv[64] ;

  // rule RL_rl_mac_32
  assign CAN_FIRE_RL_rl_mac_32 =
	     partial_product_rv[160] && !mac_output_rv[64] && mode_r == 2'h2 ;
  assign WILL_FIRE_RL_rl_mac_32 = CAN_FIRE_RL_rl_mac_32 ;

  // rule RL_rl_mac_16
  assign CAN_FIRE_RL_rl_mac_16 =
	     partial_product_rv[160] && !mac_output_rv[64] && mode_r == 2'h1 ;
  assign WILL_FIRE_RL_rl_mac_16 = CAN_FIRE_RL_rl_mac_16 ;

  // rule RL_rl_generate_partials
  assign CAN_FIRE_RL_rl_generate_partials =
	     mac_inputs_rv[96] && !partial_product_rv$port1__read[160] &&
	     mode_r != 2'h0 ;
  assign WILL_FIRE_RL_rl_generate_partials =
	     CAN_FIRE_RL_rl_generate_partials ;

  // rule RL_rl_mac_8
  assign CAN_FIRE_RL_rl_mac_8 =
	     mac_inputs_rv[96] && !mac_output_rv[64] && mode_r == 2'h0 ;
  assign WILL_FIRE_RL_rl_mac_8 = CAN_FIRE_RL_rl_mac_8 ;

  // inputs to muxes for submodule ports
  assign MUX_mac_output_rv$port1__write_1__VAL_1 =
	     { 1'd1, x__h1616 + y__h1617 } ;
  assign MUX_mac_output_rv$port1__write_1__VAL_2 =
	     { 1'd1,
	       partial_product_rv[63:32] + y__h1842,
	       partial_product_rv[159:128] + y__h1878 } ;
  assign MUX_mac_output_rv$port1__write_1__VAL_3 =
	     { 1'd1,
	       mac_8_3__h1957,
	       mac_8_2__h2053,
	       mac_8_1__h2150,
	       mac_8_0__h2248 } ;

  // inlined wires
  assign mac_inputs_rv$EN_port0__write =
	     WILL_FIRE_RL_rl_mac_8 || WILL_FIRE_RL_rl_generate_partials ;
  assign mac_inputs_rv$port1__read =
	     mac_inputs_rv$EN_port0__write ?
	       97'h0AAAAAAAAAAAAAAAAAAAAAAAA :
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
	     WILL_FIRE_RL_rl_mac_16 || WILL_FIRE_RL_rl_mac_32 ;
  assign partial_product_rv$port1__read =
	     partial_product_rv$EN_port0__write ?
	       161'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA :
	       partial_product_rv ;
  assign partial_product_rv$port1__write_1 =
	     { 1'd1,
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_79_TO__ETC___d15[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_79_TO__ETC___d19[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_95_TO__ETC___d23[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_95_TO__ETC___d25[31:0],
	       mac_inputs_rv[31:0] } ;
  assign partial_product_rv$port2__read =
	     CAN_FIRE_RL_rl_generate_partials ?
	       partial_product_rv$port1__write_1 :
	       partial_product_rv$port1__read ;
  assign mac_output_rv$EN_port1__write =
	     WILL_FIRE_RL_rl_mac_32 || WILL_FIRE_RL_rl_mac_16 ||
	     WILL_FIRE_RL_rl_mac_8 ;
  always@(WILL_FIRE_RL_rl_mac_32 or
	  MUX_mac_output_rv$port1__write_1__VAL_1 or
	  WILL_FIRE_RL_rl_mac_16 or
	  MUX_mac_output_rv$port1__write_1__VAL_2 or
	  WILL_FIRE_RL_rl_mac_8 or MUX_mac_output_rv$port1__write_1__VAL_3)
  begin
    case (1'b1) // synopsys parallel_case
      WILL_FIRE_RL_rl_mac_32:
	  mac_output_rv$port1__write_1 =
	      MUX_mac_output_rv$port1__write_1__VAL_1;
      WILL_FIRE_RL_rl_mac_16:
	  mac_output_rv$port1__write_1 =
	      MUX_mac_output_rv$port1__write_1__VAL_2;
      WILL_FIRE_RL_rl_mac_8:
	  mac_output_rv$port1__write_1 =
	      MUX_mac_output_rv$port1__write_1__VAL_3;
      default: mac_output_rv$port1__write_1 =
		   65'h0AAAAAAAAAAAAAAAA /* unspecified value */ ;
    endcase
  end
  assign mac_output_rv$port2__read =
	     mac_output_rv$EN_port1__write ?
	       mac_output_rv$port1__write_1 :
	       mac_output_rv ;

  // register mac8_0
  assign mac8_0$D_IN = 16'h0 ;
  assign mac8_0$EN = 1'b0 ;

  // register mac8_1
  assign mac8_1$D_IN = 16'h0 ;
  assign mac8_1$EN = 1'b0 ;

  // register mac8_2
  assign mac8_2$D_IN = 16'h0 ;
  assign mac8_2$EN = 1'b0 ;

  // register mac8_3
  assign mac8_3$D_IN = 16'h0 ;
  assign mac8_3$EN = 1'b0 ;

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

  // remaining internal signals
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_71_TO__ETC___d97 =
	     x__h2274 * y__h2275 ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_79_TO__ETC___d15 =
	     { 16'd0, mac_inputs_rv[79:64] } *
	     { 16'd0, mac_inputs_rv[47:32] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_79_TO__ETC___d19 =
	     { 16'd0, mac_inputs_rv[79:64] } *
	     { 16'd0, mac_inputs_rv[63:48] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_79_TO__ETC___d88 =
	     x__h2175 * y__h2176 ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_87_TO__ETC___d79 =
	     x__h2076 * y__h2077 ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_95_TO__ETC___d23 =
	     { 16'd0, mac_inputs_rv[95:80] } *
	     { 16'd0, mac_inputs_rv[47:32] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_95_TO__ETC___d25 =
	     { 16'd0, mac_inputs_rv[95:80] } *
	     { 16'd0, mac_inputs_rv[63:48] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_95_TO__ETC___d70 =
	     x__h1978 * y__h1979 ;
  assign mac_8_0__h2248 =
	     _0_CONCAT_mac_inputs_rv_port0__read_BITS_71_TO__ETC___d97[15:0] +
	     y__h2273 ;
  assign mac_8_1__h2150 =
	     _0_CONCAT_mac_inputs_rv_port0__read_BITS_79_TO__ETC___d88[15:0] +
	     y__h2174 ;
  assign mac_8_2__h2053 =
	     _0_CONCAT_mac_inputs_rv_port0__read_BITS_87_TO__ETC___d79[15:0] +
	     y__h2075 ;
  assign mac_8_3__h1957 =
	     _0_CONCAT_mac_inputs_rv_port0__read_BITS_95_TO__ETC___d70[15:0] +
	     y__h1977 ;
  assign x__h1616 = x__h1618 + y__h1619 ;
  assign x__h1618 = x__h1620 + y__h1621 ;
  assign x__h1620 = { 32'd0, partial_product_rv[159:128] } ;
  assign x__h1691 = partial_product_rv[127:96] + partial_product_rv[95:64] ;
  assign x__h1978 = { 8'd0, mac_inputs_rv[95:88] } ;
  assign x__h2076 = { 8'd0, mac_inputs_rv[87:80] } ;
  assign x__h2175 = { 8'd0, mac_inputs_rv[79:72] } ;
  assign x__h2274 = { 8'd0, mac_inputs_rv[71:64] } ;
  assign y__h1617 = { 32'd0, partial_product_rv[31:0] } ;
  assign y__h1619 = { partial_product_rv[63:32], 32'd0 } ;
  assign y__h1621 = { 16'd0, x__h1691, 16'd0 } ;
  assign y__h1842 = { 16'd0, partial_product_rv[31:16] } ;
  assign y__h1878 = { 16'd0, partial_product_rv[15:0] } ;
  assign y__h1977 = { 8'd0, mac_inputs_rv[31:24] } ;
  assign y__h1979 = { 8'd0, mac_inputs_rv[63:56] } ;
  assign y__h2075 = { 8'd0, mac_inputs_rv[23:16] } ;
  assign y__h2077 = { 8'd0, mac_inputs_rv[55:48] } ;
  assign y__h2174 = { 8'd0, mac_inputs_rv[15:8] } ;
  assign y__h2176 = { 8'd0, mac_inputs_rv[47:40] } ;
  assign y__h2273 = { 8'd0, mac_inputs_rv[7:0] } ;
  assign y__h2275 = { 8'd0, mac_inputs_rv[39:32] } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        mac8_0 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	mac8_1 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	mac8_2 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	mac8_3 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	mac_inputs_rv <= `BSV_ASSIGNMENT_DELAY 97'h0AAAAAAAAAAAAAAAAAAAAAAAA;
	mac_output_rv <= `BSV_ASSIGNMENT_DELAY 65'h0AAAAAAAAAAAAAAAA;
	mode_r <= `BSV_ASSIGNMENT_DELAY 2'd0;
	partial_product_rv <= `BSV_ASSIGNMENT_DELAY
	    161'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
      end
    else
      begin
        if (mac8_0$EN) mac8_0 <= `BSV_ASSIGNMENT_DELAY mac8_0$D_IN;
	if (mac8_1$EN) mac8_1 <= `BSV_ASSIGNMENT_DELAY mac8_1$D_IN;
	if (mac8_2$EN) mac8_2 <= `BSV_ASSIGNMENT_DELAY mac8_2$D_IN;
	if (mac8_3$EN) mac8_3 <= `BSV_ASSIGNMENT_DELAY mac8_3$D_IN;
	if (mac_inputs_rv$EN)
	  mac_inputs_rv <= `BSV_ASSIGNMENT_DELAY mac_inputs_rv$D_IN;
	if (mac_output_rv$EN)
	  mac_output_rv <= `BSV_ASSIGNMENT_DELAY mac_output_rv$D_IN;
	if (mode_r$EN) mode_r <= `BSV_ASSIGNMENT_DELAY mode_r$D_IN;
	if (partial_product_rv$EN)
	  partial_product_rv <= `BSV_ASSIGNMENT_DELAY partial_product_rv$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    mac8_0 = 16'hAAAA;
    mac8_1 = 16'hAAAA;
    mac8_2 = 16'hAAAA;
    mac8_3 = 16'hAAAA;
    mac_inputs_rv = 97'h0AAAAAAAAAAAAAAAAAAAAAAAA;
    mac_output_rv = 65'h0AAAAAAAAAAAAAAAA;
    mode_r = 2'h2;
    partial_product_rv = 161'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMAC32
