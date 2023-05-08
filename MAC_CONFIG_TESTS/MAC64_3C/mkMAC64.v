//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Tue May  9 01:17:07 IST 2023
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_inputs                 O     1
// mac_result                     O   128
// RDY_mac_result                 O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_inputs_multiplicand1       I    64
// get_inputs_multiplicand2       I    64
// get_inputs_addend              I    64
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
  input  EN_get_inputs;
  output RDY_get_inputs;

  // value method mac_result
  output [127 : 0] mac_result;
  output RDY_mac_result;

  // signals for module outputs
  wire [127 : 0] mac_result;
  wire RDY_get_inputs, RDY_mac_result;

  // inlined wires
  wire [320 : 0] partial_product_2_rv$port1__read,
		 partial_product_2_rv$port1__write_1,
		 partial_product_2_rv$port2__read;
  wire [256 : 0] partial_product_1_rv$port1__read,
		 partial_product_1_rv$port1__write_1,
		 partial_product_1_rv$port2__read;
  wire [192 : 0] mac_inputs_1_rv$port1__read,
		 mac_inputs_1_rv$port1__write_1,
		 mac_inputs_1_rv$port2__read,
		 mac_inputs_2_rv$port1__read,
		 mac_inputs_2_rv$port1__write_1,
		 mac_inputs_2_rv$port2__read;
  wire [128 : 0] mac_output_rv$port1__write_1, mac_output_rv$port2__read;

  // register flag
  reg flag;
  wire flag$D_IN, flag$EN;

  // register mac_inputs_1_rv
  reg [192 : 0] mac_inputs_1_rv;
  wire [192 : 0] mac_inputs_1_rv$D_IN;
  wire mac_inputs_1_rv$EN;

  // register mac_inputs_2_rv
  reg [192 : 0] mac_inputs_2_rv;
  wire [192 : 0] mac_inputs_2_rv$D_IN;
  wire mac_inputs_2_rv$EN;

  // register mac_output_rv
  reg [128 : 0] mac_output_rv;
  wire [128 : 0] mac_output_rv$D_IN;
  wire mac_output_rv$EN;

  // register partial_product_1_rv
  reg [256 : 0] partial_product_1_rv;
  wire [256 : 0] partial_product_1_rv$D_IN;
  wire partial_product_1_rv$EN;

  // register partial_product_2_rv
  reg [320 : 0] partial_product_2_rv;
  wire [320 : 0] partial_product_2_rv$D_IN;
  wire partial_product_2_rv$EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_generate_partials_1,
       CAN_FIRE_RL_rl_generate_partials_2,
       CAN_FIRE_RL_rl_mac_64,
       CAN_FIRE_get_inputs,
       WILL_FIRE_RL_rl_generate_partials_1,
       WILL_FIRE_RL_rl_generate_partials_2,
       WILL_FIRE_RL_rl_mac_64,
       WILL_FIRE_get_inputs;

  // remaining internal signals
  wire [127 : 0] x179_PLUS_y180__q2,
		 x187_PLUS_y188__q5,
		 x718_PLUS_y719__q3,
		 x727_PLUS_y728__q1,
		 x880_PLUS_y881__q4,
		 x__h4427,
		 x__h4429,
		 x__h4431,
		 x__h4433,
		 x__h4435,
		 x__h4437,
		 x__h4439,
		 x__h4727,
		 x__h5179,
		 x__h5181,
		 x__h5718,
		 x__h5720,
		 x__h5722,
		 x__h5880,
		 x__h5882,
		 x__h6187,
		 y__h4428,
		 y__h4430,
		 y__h4432,
		 y__h4434,
		 y__h4436,
		 y__h4438,
		 y__h4440,
		 y__h4728,
		 y__h5180,
		 y__h5182,
		 y__h5719,
		 y__h5721,
		 y__h5723,
		 y__h5881,
		 y__h5883,
		 y__h6188;
  wire [63 : 0] _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_143__ETC___d41,
		_0_CONCAT_mac_inputs_1_rv_port0__read_BITS_143__ETC___d44,
		_0_CONCAT_mac_inputs_1_rv_port0__read_BITS_159__ETC___d32,
		_0_CONCAT_mac_inputs_1_rv_port0__read_BITS_159__ETC___d37,
		_0_CONCAT_mac_inputs_1_rv_port0__read_BITS_175__ETC___d23,
		_0_CONCAT_mac_inputs_1_rv_port0__read_BITS_175__ETC___d26,
		_0_CONCAT_mac_inputs_1_rv_port0__read_BITS_191__ETC___d15,
		_0_CONCAT_mac_inputs_1_rv_port0__read_BITS_191__ETC___d19,
		_0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d62,
		_0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d68,
		_0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d73,
		_0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d77,
		_0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d82,
		_0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d86,
		_0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d89,
		_0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d91;

  // action method get_inputs
  assign RDY_get_inputs = !mac_inputs_1_rv$port1__read[192] ;
  assign CAN_FIRE_get_inputs = !mac_inputs_1_rv$port1__read[192] ;
  assign WILL_FIRE_get_inputs = EN_get_inputs ;

  // value method mac_result
  assign mac_result = mac_output_rv[127:0] ;
  assign RDY_mac_result = mac_output_rv[128] ;

  // rule RL_rl_mac_64
  assign CAN_FIRE_RL_rl_mac_64 =
	     partial_product_1_rv[256] && partial_product_2_rv[320] &&
	     !mac_output_rv[128] ;
  assign WILL_FIRE_RL_rl_mac_64 = CAN_FIRE_RL_rl_mac_64 ;

  // rule RL_rl_generate_partials_2
  assign CAN_FIRE_RL_rl_generate_partials_2 =
	     mac_inputs_2_rv[192] && !partial_product_2_rv$port1__read[320] &&
	     flag ;
  assign WILL_FIRE_RL_rl_generate_partials_2 =
	     CAN_FIRE_RL_rl_generate_partials_2 ;

  // rule RL_rl_generate_partials_1
  assign CAN_FIRE_RL_rl_generate_partials_1 =
	     mac_inputs_1_rv[192] && !partial_product_1_rv$port1__read[256] &&
	     !mac_inputs_2_rv$port1__read[192] ;
  assign WILL_FIRE_RL_rl_generate_partials_1 =
	     CAN_FIRE_RL_rl_generate_partials_1 ;

  // inlined wires
  assign mac_inputs_1_rv$port1__read =
	     CAN_FIRE_RL_rl_generate_partials_1 ?
	       193'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA :
	       mac_inputs_1_rv ;
  assign mac_inputs_1_rv$port1__write_1 =
	     { 1'd1,
	       get_inputs_multiplicand1,
	       get_inputs_multiplicand2,
	       get_inputs_addend } ;
  assign mac_inputs_1_rv$port2__read =
	     EN_get_inputs ?
	       mac_inputs_1_rv$port1__write_1 :
	       mac_inputs_1_rv$port1__read ;
  assign partial_product_1_rv$port1__read =
	     CAN_FIRE_RL_rl_mac_64 ?
	       257'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA :
	       partial_product_1_rv ;
  assign partial_product_1_rv$port1__write_1 =
	     { 1'd1,
	       _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_191__ETC___d15[31:0],
	       _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_191__ETC___d19[31:0],
	       _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_175__ETC___d23[31:0],
	       _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_175__ETC___d26[31:0],
	       _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_159__ETC___d32[31:0],
	       _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_159__ETC___d37[31:0],
	       _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_143__ETC___d41[31:0],
	       _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_143__ETC___d44[31:0] } ;
  assign partial_product_1_rv$port2__read =
	     CAN_FIRE_RL_rl_generate_partials_1 ?
	       partial_product_1_rv$port1__write_1 :
	       partial_product_1_rv$port1__read ;
  assign mac_inputs_2_rv$port1__read =
	     CAN_FIRE_RL_rl_generate_partials_2 ?
	       193'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA :
	       mac_inputs_2_rv ;
  assign mac_inputs_2_rv$port1__write_1 = { 1'd1, mac_inputs_1_rv[191:0] } ;
  assign mac_inputs_2_rv$port2__read =
	     CAN_FIRE_RL_rl_generate_partials_1 ?
	       mac_inputs_2_rv$port1__write_1 :
	       mac_inputs_2_rv$port1__read ;
  assign partial_product_2_rv$port1__read =
	     CAN_FIRE_RL_rl_mac_64 ?
	       321'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA :
	       partial_product_2_rv ;
  assign partial_product_2_rv$port1__write_1 =
	     { 1'd1,
	       _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d62[31:0],
	       _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d68[31:0],
	       _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d73[31:0],
	       _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d77[31:0],
	       _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d82[31:0],
	       _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d86[31:0],
	       _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d89[31:0],
	       _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d91[31:0],
	       mac_inputs_2_rv[63:0] } ;
  assign partial_product_2_rv$port2__read =
	     CAN_FIRE_RL_rl_generate_partials_2 ?
	       partial_product_2_rv$port1__write_1 :
	       partial_product_2_rv$port1__read ;
  assign mac_output_rv$port1__write_1 = { 1'd1, x__h4427 + y__h4428 } ;
  assign mac_output_rv$port2__read =
	     CAN_FIRE_RL_rl_mac_64 ?
	       mac_output_rv$port1__write_1 :
	       mac_output_rv ;

  // register flag
  assign flag$D_IN = 1'd1 ;
  assign flag$EN = CAN_FIRE_RL_rl_generate_partials_1 ;

  // register mac_inputs_1_rv
  assign mac_inputs_1_rv$D_IN = mac_inputs_1_rv$port2__read ;
  assign mac_inputs_1_rv$EN = 1'b1 ;

  // register mac_inputs_2_rv
  assign mac_inputs_2_rv$D_IN = mac_inputs_2_rv$port2__read ;
  assign mac_inputs_2_rv$EN = 1'b1 ;

  // register mac_output_rv
  assign mac_output_rv$D_IN = mac_output_rv$port2__read ;
  assign mac_output_rv$EN = 1'b1 ;

  // register partial_product_1_rv
  assign partial_product_1_rv$D_IN = partial_product_1_rv$port2__read ;
  assign partial_product_1_rv$EN = 1'b1 ;

  // register partial_product_2_rv
  assign partial_product_2_rv$D_IN = partial_product_2_rv$port2__read ;
  assign partial_product_2_rv$EN = 1'b1 ;

  // remaining internal signals
  assign _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_143__ETC___d41 =
	     { 16'd0, mac_inputs_1_rv[143:128] } *
	     { 16'd0, mac_inputs_1_rv[95:80] } ;
  assign _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_143__ETC___d44 =
	     { 16'd0, mac_inputs_1_rv[143:128] } *
	     { 16'd0, mac_inputs_1_rv[79:64] } ;
  assign _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_159__ETC___d32 =
	     { 16'd0, mac_inputs_1_rv[159:144] } *
	     { 16'd0, mac_inputs_1_rv[95:80] } ;
  assign _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_159__ETC___d37 =
	     { 16'd0, mac_inputs_1_rv[159:144] } *
	     { 16'd0, mac_inputs_1_rv[79:64] } ;
  assign _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_175__ETC___d23 =
	     { 16'd0, mac_inputs_1_rv[175:160] } *
	     { 16'd0, mac_inputs_1_rv[127:112] } ;
  assign _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_175__ETC___d26 =
	     { 16'd0, mac_inputs_1_rv[175:160] } *
	     { 16'd0, mac_inputs_1_rv[111:96] } ;
  assign _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_191__ETC___d15 =
	     { 16'd0, mac_inputs_1_rv[191:176] } *
	     { 16'd0, mac_inputs_1_rv[127:112] } ;
  assign _0_CONCAT_mac_inputs_1_rv_port0__read_BITS_191__ETC___d19 =
	     { 16'd0, mac_inputs_1_rv[191:176] } *
	     { 16'd0, mac_inputs_1_rv[111:96] } ;
  assign _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d62 =
	     { 16'd0, mac_inputs_2_rv[191:176] } *
	     { 16'd0, mac_inputs_2_rv[95:80] } ;
  assign _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d68 =
	     { 16'd0, mac_inputs_2_rv[159:144] } *
	     { 16'd0, mac_inputs_2_rv[127:112] } ;
  assign _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d73 =
	     { 16'd0, mac_inputs_2_rv[191:176] } *
	     { 16'd0, mac_inputs_2_rv[79:64] } ;
  assign _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d77 =
	     { 16'd0, mac_inputs_2_rv[175:160] } *
	     { 16'd0, mac_inputs_2_rv[95:80] } ;
  assign _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d82 =
	     { 16'd0, mac_inputs_2_rv[159:144] } *
	     { 16'd0, mac_inputs_2_rv[111:96] } ;
  assign _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d86 =
	     { 16'd0, mac_inputs_2_rv[143:128] } *
	     { 16'd0, mac_inputs_2_rv[127:112] } ;
  assign _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d89 =
	     { 16'd0, mac_inputs_2_rv[175:160] } *
	     { 16'd0, mac_inputs_2_rv[79:64] } ;
  assign _0_CONCAT_mac_inputs_2_rv_port0__read__0_BITS_1_ETC___d91 =
	     { 16'd0, mac_inputs_2_rv[143:128] } *
	     { 16'd0, mac_inputs_2_rv[111:96] } ;
  assign x179_PLUS_y180__q2 = x__h5179 + y__h5180 ;
  assign x187_PLUS_y188__q5 = x__h6187 + y__h6188 ;
  assign x718_PLUS_y719__q3 = x__h5718 + y__h5719 ;
  assign x727_PLUS_y728__q1 = x__h4727 + y__h4728 ;
  assign x880_PLUS_y881__q4 = x__h5880 + y__h5881 ;
  assign x__h4427 = x__h4429 + y__h4430 ;
  assign x__h4429 = x__h4431 + y__h4432 ;
  assign x__h4431 = x__h4433 + y__h4434 ;
  assign x__h4433 = x__h4435 + y__h4436 ;
  assign x__h4435 = x__h4437 + y__h4438 ;
  assign x__h4437 = x__h4439 + y__h4440 ;
  assign x__h4439 = { 96'd0, partial_product_1_rv[31:0] } ;
  assign x__h4727 = { 96'd0, partial_product_1_rv[63:32] } ;
  assign x__h5179 = x__h5181 + y__h5182 ;
  assign x__h5181 = { 96'd0, partial_product_2_rv[95:64] } ;
  assign x__h5718 = x__h5720 + y__h5721 ;
  assign x__h5720 = x__h5722 + y__h5723 ;
  assign x__h5722 = { 96'd0, partial_product_2_rv[159:128] } ;
  assign x__h5880 = x__h5882 + y__h5883 ;
  assign x__h5882 = { 96'd0, partial_product_2_rv[287:256] } ;
  assign x__h6187 = { 96'd0, partial_product_1_rv[191:160] } ;
  assign y__h4428 = { 64'd0, partial_product_2_rv[63:0] } ;
  assign y__h4430 = { partial_product_1_rv[255:224], 96'd0 } ;
  assign y__h4432 = { x187_PLUS_y188__q5[47:0], 80'd0 } ;
  assign y__h4434 = { x880_PLUS_y881__q4[63:0], 64'd0 } ;
  assign y__h4436 = { x718_PLUS_y719__q3[79:0], 48'd0 } ;
  assign y__h4438 = { x179_PLUS_y180__q2[95:0], 32'd0 } ;
  assign y__h4440 = { x727_PLUS_y728__q1[111:0], 16'd0 } ;
  assign y__h4728 = { 96'd0, partial_product_1_rv[95:64] } ;
  assign y__h5180 = { 96'd0, partial_product_2_rv[127:96] } ;
  assign y__h5182 = { 96'd0, partial_product_1_rv[127:96] } ;
  assign y__h5719 = { 96'd0, partial_product_2_rv[255:224] } ;
  assign y__h5721 = { 96'd0, partial_product_2_rv[223:192] } ;
  assign y__h5723 = { 96'd0, partial_product_2_rv[191:160] } ;
  assign y__h5881 = { 96'd0, partial_product_2_rv[319:288] } ;
  assign y__h5883 = { 96'd0, partial_product_1_rv[159:128] } ;
  assign y__h6188 = { 96'd0, partial_product_1_rv[223:192] } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        flag <= `BSV_ASSIGNMENT_DELAY 1'd0;
	mac_inputs_1_rv <= `BSV_ASSIGNMENT_DELAY
	    193'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
	mac_inputs_2_rv <= `BSV_ASSIGNMENT_DELAY
	    193'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
	mac_output_rv <= `BSV_ASSIGNMENT_DELAY
	    129'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
	partial_product_1_rv <= `BSV_ASSIGNMENT_DELAY
	    257'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
	partial_product_2_rv <= `BSV_ASSIGNMENT_DELAY
	    321'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
      end
    else
      begin
        if (flag$EN) flag <= `BSV_ASSIGNMENT_DELAY flag$D_IN;
	if (mac_inputs_1_rv$EN)
	  mac_inputs_1_rv <= `BSV_ASSIGNMENT_DELAY mac_inputs_1_rv$D_IN;
	if (mac_inputs_2_rv$EN)
	  mac_inputs_2_rv <= `BSV_ASSIGNMENT_DELAY mac_inputs_2_rv$D_IN;
	if (mac_output_rv$EN)
	  mac_output_rv <= `BSV_ASSIGNMENT_DELAY mac_output_rv$D_IN;
	if (partial_product_1_rv$EN)
	  partial_product_1_rv <= `BSV_ASSIGNMENT_DELAY
	      partial_product_1_rv$D_IN;
	if (partial_product_2_rv$EN)
	  partial_product_2_rv <= `BSV_ASSIGNMENT_DELAY
	      partial_product_2_rv$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    flag = 1'h0;
    mac_inputs_1_rv = 193'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    mac_inputs_2_rv = 193'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    mac_output_rv = 129'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    partial_product_1_rv =
	257'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    partial_product_2_rv =
	321'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMAC64

