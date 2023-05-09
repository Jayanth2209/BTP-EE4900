module mkMAC64(CLK,
	       RST,

	       get_inputs_multiplicand1,
	       get_inputs_multiplicand2,
	       get_inputs_addend,
	       get_inputs_mode,
	       EN_get_inputs,
	       RDY_get_inputs,

	       mac_result,
	       RDY_mac_result);
  input  CLK;
  input  RST;

  // action method get_inputs
  input  [63 : 0] get_inputs_multiplicand1;
  input  [63 : 0] get_inputs_multiplicand2;
  input  [63 : 0] get_inputs_addend;
  input  get_inputs_mode;
  input  EN_get_inputs;
  output RDY_get_inputs;

  // value method mac_result
  output [127 : 0] mac_result;
  output RDY_mac_result;

  // signals for module outputs
  wire [127 : 0] mac_result;
  wire RDY_get_inputs, RDY_mac_result;

  // inlined wires
  wire [704 : 0] partial_sum_rv$port1__read,
		 partial_sum_rv$port1__write_1,
		 partial_sum_rv$port2__read;
  wire [576 : 0] partial_product_rv$port1__read,
		 partial_product_rv$port1__write_1,
		 partial_product_rv$port2__read;
  wire [192 : 0] mac_inputs_rv$port1__read,
		 mac_inputs_rv$port1__write_1,
		 mac_inputs_rv$port2__read;
  wire [128 : 0] mac_output_rv$port1__write_1, mac_output_rv$port2__read;
  wire mac_output_rv$EN_port1__write, partial_product_rv$EN_port0__write;

  // register mac_inputs_rv
  reg [192 : 0] mac_inputs_rv;
  wire [192 : 0] mac_inputs_rv$D_IN;
  wire mac_inputs_rv$EN;

  // register mac_output_rv
  reg [128 : 0] mac_output_rv;
  wire [128 : 0] mac_output_rv$D_IN;
  wire mac_output_rv$EN;

  // register mode_r
  reg mode_r;
  wire mode_r$D_IN, mode_r$EN;

  // register partial_product_rv
  reg [576 : 0] partial_product_rv;
  wire [576 : 0] partial_product_rv$D_IN;
  wire partial_product_rv$EN;

  // register partial_sum_rv
  reg [704 : 0] partial_sum_rv;
  wire [704 : 0] partial_sum_rv$D_IN;
  wire partial_sum_rv$EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_generate_partials,
       CAN_FIRE_RL_rl_mac_32,
       CAN_FIRE_RL_rl_mac_64_1,
       CAN_FIRE_RL_rl_mac_64_2,
       CAN_FIRE_get_inputs,
       WILL_FIRE_RL_rl_generate_partials,
       WILL_FIRE_RL_rl_mac_32,
       WILL_FIRE_RL_rl_mac_64_1,
       WILL_FIRE_RL_rl_mac_64_2,
       WILL_FIRE_get_inputs;

  // inputs to muxes for submodule ports
  wire [128 : 0] MUX_mac_output_rv$port1__write_1__VAL_1,
		 MUX_mac_output_rv$port1__write_1__VAL_2;

  // remaining internal signals
  wire [127 : 0] x338_PLUS_y339__q1,
		 x420_PLUS_y421__q2,
		 x439_PLUS_y440__q4,
		 x542_PLUS_y543__q3,
		 x974_PLUS_y975__q5,
		 x__h3850,
		 x__h3876,
		 x__h3878,
		 x__h3880,
		 x__h4338,
		 x__h4420,
		 x__h4422,
		 x__h4542,
		 x__h4544,
		 x__h4546,
		 x__h6421,
		 x__h6422,
		 x__h6424,
		 x__h6426,
		 x__h6439,
		 x__h6441,
		 x__h6974,
		 y__h3877,
		 y__h3879,
		 y__h3881,
		 y__h4339,
		 y__h4421,
		 y__h4423,
		 y__h4543,
		 y__h4545,
		 y__h4547,
		 y__h6423,
		 y__h6425,
		 y__h6427,
		 y__h6440,
		 y__h6442,
		 y__h6975;
  wire [63 : 0] _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d45,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d53,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d58,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d60,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d31,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d41,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d50,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d55,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d20,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d27,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d38,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d48,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d11,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d15,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d24,
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d36,
		mac_32_1__h7195,
		mac_32_2__h7196,
		x256_PLUS_y257__q6,
		x394_PLUS_y395__q7,
		x__h7216,
		x__h7218,
		x__h7220,
		x__h7256,
		x__h7354,
		x__h7356,
		x__h7358,
		x__h7394,
		y__h7217,
		y__h7219,
		y__h7221,
		y__h7257,
		y__h7355,
		y__h7357,
		y__h7359,
		y__h7395;

  // action method get_inputs
  assign RDY_get_inputs = !mac_inputs_rv$port1__read[192] ;
  assign CAN_FIRE_get_inputs = !mac_inputs_rv$port1__read[192] ;
  assign WILL_FIRE_get_inputs = EN_get_inputs ;

  // value method mac_result
  assign mac_result = mac_output_rv[127:0] ;
  assign RDY_mac_result = mac_output_rv[128] ;

  // rule RL_rl_mac_64_2
  assign CAN_FIRE_RL_rl_mac_64_2 = WILL_FIRE_RL_rl_mac_64_2 ;
  assign WILL_FIRE_RL_rl_mac_64_2 =
	     partial_sum_rv[704] && !mac_output_rv[128] && mode_r ;

  // rule RL_rl_mac_64_1
  assign CAN_FIRE_RL_rl_mac_64_1 =
	     partial_product_rv[576] && !partial_sum_rv$port1__read[704] &&
	     mode_r ;
  assign WILL_FIRE_RL_rl_mac_64_1 = CAN_FIRE_RL_rl_mac_64_1 ;

  // rule RL_rl_mac_32
  assign CAN_FIRE_RL_rl_mac_32 =
	     partial_product_rv[576] && !mac_output_rv[128] && !mode_r ;
  assign WILL_FIRE_RL_rl_mac_32 = CAN_FIRE_RL_rl_mac_32 ;

  // rule RL_rl_generate_partials
  assign CAN_FIRE_RL_rl_generate_partials =
	     mac_inputs_rv[192] && !partial_product_rv$port1__read[576] ;
  assign WILL_FIRE_RL_rl_generate_partials =
	     CAN_FIRE_RL_rl_generate_partials ;

  // inputs to muxes for submodule ports
  assign MUX_mac_output_rv$port1__write_1__VAL_1 =
	     { 1'd1, x__h6421 + partial_sum_rv[703:576] } ;
  assign MUX_mac_output_rv$port1__write_1__VAL_2 =
	     { 1'd1, mac_32_2__h7196, mac_32_1__h7195 } ;

  // inlined wires
  assign mac_inputs_rv$port1__read =
	     CAN_FIRE_RL_rl_generate_partials ?
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
	     WILL_FIRE_RL_rl_mac_32 || WILL_FIRE_RL_rl_mac_64_1 ;
  assign partial_product_rv$port1__read =
	     partial_product_rv$EN_port0__write ?
	       577'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA :
	       partial_product_rv ;
  assign partial_product_rv$port1__write_1 =
	     { 1'd1,
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d11[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d15[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d20[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d24[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d27[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d31[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d36[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d38[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d41[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d45[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d48[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d50[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d53[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d55[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d58[31:0],
	       _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d60[31:0],
	       mac_inputs_rv[63:0] } ;
  assign partial_product_rv$port2__read =
	     CAN_FIRE_RL_rl_generate_partials ?
	       partial_product_rv$port1__write_1 :
	       partial_product_rv$port1__read ;
  assign partial_sum_rv$port1__read =
	     WILL_FIRE_RL_rl_mac_64_2 ?
	       705'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA :
	       partial_sum_rv ;
  assign partial_sum_rv$port1__write_1 =
	     { 1'd1, x__h3850, partial_product_rv[575:0] } ;
  assign partial_sum_rv$port2__read =
	     CAN_FIRE_RL_rl_mac_64_1 ?
	       partial_sum_rv$port1__write_1 :
	       partial_sum_rv$port1__read ;
  assign mac_output_rv$EN_port1__write =
	     WILL_FIRE_RL_rl_mac_64_2 || WILL_FIRE_RL_rl_mac_32 ;
  assign mac_output_rv$port1__write_1 =
	     WILL_FIRE_RL_rl_mac_64_2 ?
	       MUX_mac_output_rv$port1__write_1__VAL_1 :
	       MUX_mac_output_rv$port1__write_1__VAL_2 ;
  assign mac_output_rv$port2__read =
	     mac_output_rv$EN_port1__write ?
	       mac_output_rv$port1__write_1 :
	       mac_output_rv ;

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
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d45 =
	     { 16'd0, mac_inputs_rv[143:128] } *
	     { 16'd0, mac_inputs_rv[127:112] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d53 =
	     { 16'd0, mac_inputs_rv[143:128] } *
	     { 16'd0, mac_inputs_rv[111:96] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d58 =
	     { 16'd0, mac_inputs_rv[143:128] } *
	     { 16'd0, mac_inputs_rv[95:80] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_143_TO_ETC___d60 =
	     { 16'd0, mac_inputs_rv[143:128] } *
	     { 16'd0, mac_inputs_rv[79:64] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d31 =
	     { 16'd0, mac_inputs_rv[159:144] } *
	     { 16'd0, mac_inputs_rv[127:112] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d41 =
	     { 16'd0, mac_inputs_rv[159:144] } *
	     { 16'd0, mac_inputs_rv[111:96] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d50 =
	     { 16'd0, mac_inputs_rv[159:144] } *
	     { 16'd0, mac_inputs_rv[95:80] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_159_TO_ETC___d55 =
	     { 16'd0, mac_inputs_rv[159:144] } *
	     { 16'd0, mac_inputs_rv[79:64] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d20 =
	     { 16'd0, mac_inputs_rv[175:160] } *
	     { 16'd0, mac_inputs_rv[127:112] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d27 =
	     { 16'd0, mac_inputs_rv[175:160] } *
	     { 16'd0, mac_inputs_rv[111:96] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d38 =
	     { 16'd0, mac_inputs_rv[175:160] } *
	     { 16'd0, mac_inputs_rv[95:80] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_175_TO_ETC___d48 =
	     { 16'd0, mac_inputs_rv[175:160] } *
	     { 16'd0, mac_inputs_rv[79:64] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d11 =
	     { 16'd0, mac_inputs_rv[191:176] } *
	     { 16'd0, mac_inputs_rv[127:112] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d15 =
	     { 16'd0, mac_inputs_rv[191:176] } *
	     { 16'd0, mac_inputs_rv[111:96] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d24 =
	     { 16'd0, mac_inputs_rv[191:176] } *
	     { 16'd0, mac_inputs_rv[95:80] } ;
  assign _0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d36 =
	     { 16'd0, mac_inputs_rv[191:176] } *
	     { 16'd0, mac_inputs_rv[79:64] } ;
  assign mac_32_1__h7195 = x__h7354 + y__h7355 ;
  assign mac_32_2__h7196 = x__h7216 + y__h7217 ;
  assign x256_PLUS_y257__q6 = x__h7256 + y__h7257 ;
  assign x338_PLUS_y339__q1 = x__h4338 + y__h4339 ;
  assign x394_PLUS_y395__q7 = x__h7394 + y__h7395 ;
  assign x420_PLUS_y421__q2 = x__h4420 + y__h4421 ;
  assign x439_PLUS_y440__q4 = x__h6439 + y__h6440 ;
  assign x542_PLUS_y543__q3 = x__h4542 + y__h4543 ;
  assign x974_PLUS_y975__q5 = x__h6974 + y__h6975 ;
  assign x__h3850 = x__h3876 + y__h3877 ;
  assign x__h3876 = x__h3878 + y__h3879 ;
  assign x__h3878 = x__h3880 + y__h3881 ;
  assign x__h3880 = { 96'd0, partial_product_rv[95:64] } ;
  assign x__h4338 = { 96'd0, partial_product_rv[127:96] } ;
  assign x__h4420 = x__h4422 + y__h4423 ;
  assign x__h4422 = { 96'd0, partial_product_rv[191:160] } ;
  assign x__h4542 = x__h4544 + y__h4545 ;
  assign x__h4544 = x__h4546 + y__h4547 ;
  assign x__h4546 = { 96'd0, partial_product_rv[287:256] } ;
  assign x__h6421 = x__h6422 + y__h6423 ;
  assign x__h6422 = x__h6424 + y__h6425 ;
  assign x__h6424 = x__h6426 + y__h6427 ;
  assign x__h6426 = { x439_PLUS_y440__q4[63:0], 64'd0 } ;
  assign x__h6439 = x__h6441 + y__h6442 ;
  assign x__h6441 = { 96'd0, partial_sum_rv[415:384] } ;
  assign x__h6974 = { 96'd0, partial_sum_rv[511:480] } ;
  assign x__h7216 = x__h7218 + y__h7219 ;
  assign x__h7218 = x__h7220 + y__h7221 ;
  assign x__h7220 = { 32'd0, partial_product_rv[447:416] } ;
  assign x__h7256 = { 32'd0, partial_product_rv[511:480] } ;
  assign x__h7354 = x__h7356 + y__h7357 ;
  assign x__h7356 = x__h7358 + y__h7359 ;
  assign x__h7358 = { 32'd0, partial_product_rv[95:64] } ;
  assign x__h7394 = { 32'd0, partial_product_rv[127:96] } ;
  assign y__h3877 = { x542_PLUS_y543__q3[79:0], 48'd0 } ;
  assign y__h3879 = { x420_PLUS_y421__q2[95:0], 32'd0 } ;
  assign y__h3881 = { x338_PLUS_y339__q1[111:0], 16'd0 } ;
  assign y__h4339 = { 96'd0, partial_product_rv[159:128] } ;
  assign y__h4421 = { 96'd0, partial_product_rv[255:224] } ;
  assign y__h4423 = { 96'd0, partial_product_rv[223:192] } ;
  assign y__h4543 = { 96'd0, partial_product_rv[383:352] } ;
  assign y__h4545 = { 96'd0, partial_product_rv[351:320] } ;
  assign y__h4547 = { 96'd0, partial_product_rv[319:288] } ;
  assign y__h6423 = { 64'd0, partial_sum_rv[63:0] } ;
  assign y__h6425 = { partial_sum_rv[575:544], 96'd0 } ;
  assign y__h6427 = { x974_PLUS_y975__q5[47:0], 80'd0 } ;
  assign y__h6440 = { 96'd0, partial_sum_rv[479:448] } ;
  assign y__h6442 = { 96'd0, partial_sum_rv[447:416] } ;
  assign y__h6975 = { 96'd0, partial_sum_rv[543:512] } ;
  assign y__h7217 = { 32'd0, partial_product_rv[63:32] } ;
  assign y__h7219 = { partial_product_rv[575:544], 32'd0 } ;
  assign y__h7221 = { x256_PLUS_y257__q6[47:0], 16'd0 } ;
  assign y__h7257 = { 32'd0, partial_product_rv[543:512] } ;
  assign y__h7355 = { 32'd0, partial_product_rv[31:0] } ;
  assign y__h7357 = { partial_product_rv[223:192], 32'd0 } ;
  assign y__h7359 = { x394_PLUS_y395__q7[47:0], 16'd0 } ;
  assign y__h7395 = { 32'd0, partial_product_rv[159:128] } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST == 1'b1)
      begin
        mac_inputs_rv <=
	    193'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
	mac_output_rv <=
	    129'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
	mode_r <= 1'd0;
	partial_product_rv <=
	    577'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
	partial_sum_rv <=
	    705'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
      end
    else
      begin
        if (mac_inputs_rv$EN)
	  mac_inputs_rv <= mac_inputs_rv$D_IN;
	if (mac_output_rv$EN)
	  mac_output_rv <= mac_output_rv$D_IN;
	if (mode_r$EN) mode_r <= mode_r$D_IN;
	if (partial_product_rv$EN)
	  partial_product_rv <= partial_product_rv$D_IN;
	if (partial_sum_rv$EN)
	  partial_sum_rv <= partial_sum_rv$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    mac_inputs_rv = 193'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    mac_output_rv = 129'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    mode_r = 1'h0;
    partial_product_rv =
	577'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    partial_sum_rv =
	705'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMAC64

