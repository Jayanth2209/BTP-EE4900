module mkmac643p(CLK,
		 RST,

		 get_values_multiplicand1,
		 get_values_multiplicand2,
		 get_values_addend,
		 EN_get_values,
		 RDY_get_values,

		 EN_mac_result,
		 mac_result,
		 RDY_mac_result);
  input  CLK;
  input  RST;

  // action method get_values
  input  [63 : 0] get_values_multiplicand1;
  input  [63 : 0] get_values_multiplicand2;
  input  [63 : 0] get_values_addend;
  input  EN_get_values;
  output RDY_get_values;

  // actionvalue method mac_result
  input  EN_mac_result;
  output [127 : 0] mac_result;
  output RDY_mac_result;

  // signals for module outputs
  wire [127 : 0] mac_result;
  wire RDY_get_values, RDY_mac_result;

  // register a
  reg [63 : 0] a;
  wire [63 : 0] a$D_IN;
  wire a$EN;

  // register flag_0
  reg flag_0;
  wire flag_0$D_IN, flag_0$EN;

  // register flag_1
  reg flag_1;
  wire flag_1$D_IN, flag_1$EN;

  // register flag_2
  reg flag_2;
  wire flag_2$D_IN, flag_2$EN;

  // register inp_ready
  reg inp_ready;
  wire inp_ready$D_IN, inp_ready$EN;

  // register m1
  reg [63 : 0] m1;
  wire [63 : 0] m1$D_IN;
  wire m1$EN;

  // register m2
  reg [63 : 0] m2;
  wire [63 : 0] m2$D_IN;
  wire m2$EN;

  // register mac_ready
  reg mac_ready;
  wire mac_ready$D_IN, mac_ready$EN;

  // register p1
  reg [127 : 0] p1;
  wire [127 : 0] p1$D_IN;
  wire p1$EN;

  // register p2
  reg [127 : 0] p2;
  wire [127 : 0] p2$D_IN;
  wire p2$EN;

  // register resmac
  reg [127 : 0] resmac;
  wire [127 : 0] resmac$D_IN;
  wire resmac$EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_mac,
       CAN_FIRE_get_values,
       CAN_FIRE_mac_result,
       WILL_FIRE_RL_mac,
       WILL_FIRE_get_values,
       WILL_FIRE_mac_result;

  // remaining internal signals
  wire [255 : 0] _0_CONCAT_m1_MUL_0_CONCAT_m2_BITS_31_TO_0___d7,
		 _0_CONCAT_m1_MUL_0_CONCAT_m2_BITS_63_TO_32_0_1___d12;
  wire [127 : 0] x__h1022, y__h1023;
  wire NOT_get_values_multiplicand1_EQ_m1_1_2_OR_NOT__ETC___d28;

  // action method get_values
  assign RDY_get_values = 1'd1 ;
  assign CAN_FIRE_get_values = 1'd1 ;
  assign WILL_FIRE_get_values = EN_get_values ;

  // actionvalue method mac_result
  assign mac_result = resmac ;
  assign RDY_mac_result = mac_ready ;
  assign CAN_FIRE_mac_result = mac_ready ;
  assign WILL_FIRE_mac_result = EN_mac_result ;

  // rule RL_mac
  assign CAN_FIRE_RL_mac = 1'd1 ;
  assign WILL_FIRE_RL_mac = 1'd1 ;

  // register a
  assign a$D_IN = get_values_addend ;
  assign a$EN =
	     EN_get_values &&
	     NOT_get_values_multiplicand1_EQ_m1_1_2_OR_NOT__ETC___d28 ;

  // register flag_0
  assign flag_0$D_IN = inp_ready ;
  assign flag_0$EN = 1'd1 ;

  // register flag_1
  assign flag_1$D_IN = flag_0 ;
  assign flag_1$EN = 1'd1 ;

  // register flag_2
  assign flag_2$D_IN = flag_1 ;
  assign flag_2$EN = 1'd1 ;

  // register inp_ready
  assign inp_ready$D_IN =
	     NOT_get_values_multiplicand1_EQ_m1_1_2_OR_NOT__ETC___d28 ;
  assign inp_ready$EN = EN_get_values ;

  // register m1
  assign m1$D_IN = get_values_multiplicand1 ;
  assign m1$EN =
	     EN_get_values &&
	     NOT_get_values_multiplicand1_EQ_m1_1_2_OR_NOT__ETC___d28 ;

  // register m2
  assign m2$D_IN = get_values_multiplicand2 ;
  assign m2$EN =
	     EN_get_values &&
	     NOT_get_values_multiplicand1_EQ_m1_1_2_OR_NOT__ETC___d28 ;

  // register mac_ready
  assign mac_ready$D_IN = flag_1 ;
  assign mac_ready$EN = flag_1 || EN_mac_result ;

  // register p1
  assign p1$D_IN = _0_CONCAT_m1_MUL_0_CONCAT_m2_BITS_31_TO_0___d7[127:0] ;
  assign p1$EN = inp_ready ;

  // register p2
  assign p2$D_IN =
	     _0_CONCAT_m1_MUL_0_CONCAT_m2_BITS_63_TO_32_0_1___d12[127:0] ;
  assign p2$EN = flag_0 ;

  // register resmac
  assign resmac$D_IN = x__h1022 + y__h1023 ;
  assign resmac$EN = flag_1 ;

  // remaining internal signals
  assign NOT_get_values_multiplicand1_EQ_m1_1_2_OR_NOT__ETC___d28 =
	     get_values_multiplicand1 != m1 ||
	     get_values_multiplicand2 != m2 ||
	     get_values_addend != a ;
  assign _0_CONCAT_m1_MUL_0_CONCAT_m2_BITS_31_TO_0___d7 =
	     { 64'd0, m1 } * { 96'd0, m2[31:0] } ;
  assign _0_CONCAT_m1_MUL_0_CONCAT_m2_BITS_63_TO_32_0_1___d12 =
	     { 64'd0, m1 } * { 96'd0, m2[63:32] } ;
  assign x__h1022 = p1 + p2 ;
  assign y__h1023 = { 64'd0, a } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST == 1)
      begin
        a <= 64'd0;
	flag_0 <= 1'd0;
	flag_1 <= 1'd0;
	flag_2 <= 1'd0;
	inp_ready <= 1'd0;
	m1 <= 64'd0;
	m2 <= 64'd0;
	mac_ready <= 1'd0;
	p1 <= 128'd0;
	p2 <= 128'd0;
	resmac <= 128'd0;
      end
    else
      begin
        if (a$EN) a <= a$D_IN;
	if (flag_0$EN) flag_0 <= flag_0$D_IN;
	if (flag_1$EN) flag_1 <= flag_1$D_IN;
	if (flag_2$EN) flag_2 <= flag_2$D_IN;
	if (inp_ready$EN) inp_ready <= inp_ready$D_IN;
	if (m1$EN) m1 <= m1$D_IN;
	if (m2$EN) m2 <= m2$D_IN;
	if (mac_ready$EN) mac_ready <= mac_ready$D_IN;
	if (p1$EN) p1 <= p1$D_IN;
	if (p2$EN) p2 <= p2$D_IN;
	if (resmac$EN) resmac <= resmac$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    a = 64'hAAAAAAAAAAAAAAAA;
    flag_0 = 1'h0;
    flag_1 = 1'h0;
    flag_2 = 1'h0;
    inp_ready = 1'h0;
    m1 = 64'hAAAAAAAAAAAAAAAA;
    m2 = 64'hAAAAAAAAAAAAAAAA;
    mac_ready = 1'h0;
    p1 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    p2 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    resmac = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkmac643p

