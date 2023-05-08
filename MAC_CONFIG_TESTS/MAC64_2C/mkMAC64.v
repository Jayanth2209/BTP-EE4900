//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Mon May  8 23:46:10 IST 2023
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
  wire [576 : 0] partial_product_rv$port1__read,
		 partial_product_rv$port1__write_1,
		 partial_product_rv$port2__read;
  wire [192 : 0] mac_inputs_rv$port1__read,
		 mac_inputs_rv$port1__write_1,
		 mac_inputs_rv$port2__read;
  wire [128 : 0] mac_output_rv$port1__write_1, mac_output_rv$port2__read;

  // register mac_inputs_rv
  reg [192 : 0] mac_inputs_rv;
  wire [192 : 0] mac_inputs_rv$D_IN;
  wire mac_inputs_rv$EN;

  // register mac_output_rv
  reg [128 : 0] mac_output_rv;
  wire [128 : 0] mac_output_rv$D_IN;
  wire mac_output_rv$EN;

  // register partial_product_rv
  reg [576 : 0] partial_product_rv;
  wire [576 : 0] partial_product_rv$D_IN;
  wire partial_product_rv$EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_rl_generate_partials,
       CAN_FIRE_RL_rl_mac_64,
       CAN_FIRE_get_inputs,
       WILL_FIRE_RL_rl_generate_partials,
       WILL_FIRE_RL_rl_mac_64,
       WILL_FIRE_get_inputs;

  // remaining internal signals
  wire [127 : 0] x090_PLUS_y091__q1,
		 x172_PLUS_y173__q2,
		 x294_PLUS_y295__q3,
		 x456_PLUS_y457__q4,
		 x578_PLUS_y579__q5,
		 x__h3621,
		 x__h3623,
		 x__h3625,
		 x__h3627,
		 x__h3629,
		 x__h3631,
		 x__h3633,
		 x__h4090,
		 x__h4172,
		 x__h4174,
		 x__h4294,
		 x__h4296,
		 x__h4298,
		 x__h4456,
		 x__h4458,
		 x__h4578,
		 y__h3622,
		 y__h3624,
		 y__h3626,
		 y__h3628,
		 y__h3630,
		 y__h3632,
		 y__h3634,
		 y__h4091,
		 y__h4173,
		 y__h4175,
		 y__h4295,
		 y__h4297,
		 y__h4299,
		 y__h4457,
		 y__h4459,
		 y__h4579;
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
		_0_CONCAT_mac_inputs_rv_port0__read_BITS_191_TO_ETC___d36;

  // action method get_inputs
  assign RDY_get_inputs = !mac_inputs_rv$port1__read[192] ;
  assign CAN_FIRE_get_inputs = !mac_inputs_rv$port1__read[192] ;
  assign WILL_FIRE_get_inputs = EN_get_inputs ;

  // value method mac_result
  assign mac_result = mac_output_rv[127:0] ;
  assign RDY_mac_result = mac_output_rv[128] ;

  // rule RL_rl_mac_64
  assign CAN_FIRE_RL_rl_mac_64 =
	     partial_product_rv[576] && !mac_output_rv[128] ;
  assign WILL_FIRE_RL_rl_mac_64 = CAN_FIRE_RL_rl_mac_64 ;

  // rule RL_rl_generate_partials
  assign CAN_FIRE_RL_rl_generate_partials =
	     mac_inputs_rv[192] && !partial_product_rv$port1__read[576] ;
  assign WILL_FIRE_RL_rl_generate_partials =
	     CAN_FIRE_RL_rl_generate_partials ;

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
  assign partial_product_rv$port1__read =
	     CAN_FIRE_RL_rl_mac_64 ?
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
  assign mac_output_rv$port1__write_1 = { 1'd1, x__h3621 + y__h3622 } ;
  assign mac_output_rv$port2__read =
	     CAN_FIRE_RL_rl_mac_64 ?
	       mac_output_rv$port1__write_1 :
	       mac_output_rv ;

  // register mac_inputs_rv
  assign mac_inputs_rv$D_IN = mac_inputs_rv$port2__read ;
  assign mac_inputs_rv$EN = 1'b1 ;

  // register mac_output_rv
  assign mac_output_rv$D_IN = mac_output_rv$port2__read ;
  assign mac_output_rv$EN = 1'b1 ;

  // register partial_product_rv
  assign partial_product_rv$D_IN = partial_product_rv$port2__read ;
  assign partial_product_rv$EN = 1'b1 ;

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
  assign x090_PLUS_y091__q1 = x__h4090 + y__h4091 ;
  assign x172_PLUS_y173__q2 = x__h4172 + y__h4173 ;
  assign x294_PLUS_y295__q3 = x__h4294 + y__h4295 ;
  assign x456_PLUS_y457__q4 = x__h4456 + y__h4457 ;
  assign x578_PLUS_y579__q5 = x__h4578 + y__h4579 ;
  assign x__h3621 = x__h3623 + y__h3624 ;
  assign x__h3623 = x__h3625 + y__h3626 ;
  assign x__h3625 = x__h3627 + y__h3628 ;
  assign x__h3627 = x__h3629 + y__h3630 ;
  assign x__h3629 = x__h3631 + y__h3632 ;
  assign x__h3631 = x__h3633 + y__h3634 ;
  assign x__h3633 = { 96'd0, partial_product_rv[95:64] } ;
  assign x__h4090 = { 96'd0, partial_product_rv[127:96] } ;
  assign x__h4172 = x__h4174 + y__h4175 ;
  assign x__h4174 = { 96'd0, partial_product_rv[191:160] } ;
  assign x__h4294 = x__h4296 + y__h4297 ;
  assign x__h4296 = x__h4298 + y__h4299 ;
  assign x__h4298 = { 96'd0, partial_product_rv[287:256] } ;
  assign x__h4456 = x__h4458 + y__h4459 ;
  assign x__h4458 = { 96'd0, partial_product_rv[415:384] } ;
  assign x__h4578 = { 96'd0, partial_product_rv[511:480] } ;
  assign y__h3622 = { 64'd0, partial_product_rv[63:0] } ;
  assign y__h3624 = { partial_product_rv[575:544], 96'd0 } ;
  assign y__h3626 = { x578_PLUS_y579__q5[47:0], 80'd0 } ;
  assign y__h3628 = { x456_PLUS_y457__q4[63:0], 64'd0 } ;
  assign y__h3630 = { x294_PLUS_y295__q3[79:0], 48'd0 } ;
  assign y__h3632 = { x172_PLUS_y173__q2[95:0], 32'd0 } ;
  assign y__h3634 = { x090_PLUS_y091__q1[111:0], 16'd0 } ;
  assign y__h4091 = { 96'd0, partial_product_rv[159:128] } ;
  assign y__h4173 = { 96'd0, partial_product_rv[255:224] } ;
  assign y__h4175 = { 96'd0, partial_product_rv[223:192] } ;
  assign y__h4295 = { 96'd0, partial_product_rv[383:352] } ;
  assign y__h4297 = { 96'd0, partial_product_rv[351:320] } ;
  assign y__h4299 = { 96'd0, partial_product_rv[319:288] } ;
  assign y__h4457 = { 96'd0, partial_product_rv[479:448] } ;
  assign y__h4459 = { 96'd0, partial_product_rv[447:416] } ;
  assign y__h4579 = { 96'd0, partial_product_rv[543:512] } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        mac_inputs_rv <= `BSV_ASSIGNMENT_DELAY
	    193'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
	mac_output_rv <= `BSV_ASSIGNMENT_DELAY
	    129'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
	partial_product_rv <= `BSV_ASSIGNMENT_DELAY
	    577'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
      end
    else
      begin
        if (mac_inputs_rv$EN)
	  mac_inputs_rv <= `BSV_ASSIGNMENT_DELAY mac_inputs_rv$D_IN;
	if (mac_output_rv$EN)
	  mac_output_rv <= `BSV_ASSIGNMENT_DELAY mac_output_rv$D_IN;
	if (partial_product_rv$EN)
	  partial_product_rv <= `BSV_ASSIGNMENT_DELAY partial_product_rv$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    mac_inputs_rv = 193'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    mac_output_rv = 129'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    partial_product_rv =
	577'h0AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMAC64

