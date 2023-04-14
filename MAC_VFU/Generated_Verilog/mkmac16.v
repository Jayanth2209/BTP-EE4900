//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Mon Mar 27 02:40:36 IST 2023
//
//
// Ports:
// Name                         I/O  size props
// RDY_get_values                 O     1
// mac_result                     O    32 reg
// RDY_mac_result                 O     1
// CLK                            I     1 clock
// RST_N                          I     1 reset
// get_values_multiplicand1       I    16 reg
// get_values_multiplicand2       I    16 reg
// get_values_addend              I    16 reg
// EN_get_values                  I     1
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

module mkmac16(CLK,
	       RST_N,

	       get_values_multiplicand1,
	       get_values_multiplicand2,
	       get_values_addend,
	       EN_get_values,
	       RDY_get_values,

	       mac_result,
	       RDY_mac_result);
  input  CLK;
  input  RST_N;

  // action method get_values
  input  [15 : 0] get_values_multiplicand1;
  input  [15 : 0] get_values_multiplicand2;
  input  [15 : 0] get_values_addend;
  input  EN_get_values;
  output RDY_get_values;

  // value method mac_result
  output [31 : 0] mac_result;
  output RDY_mac_result;

  // signals for module outputs
  wire [31 : 0] mac_result;
  wire RDY_get_values, RDY_mac_result;

  // register a
  reg [15 : 0] a;
  wire [15 : 0] a$D_IN;
  wire a$EN;

  // register isReady
  reg [1 : 0] isReady;
  wire [1 : 0] isReady$D_IN;
  wire isReady$EN;

  // register m1
  reg [15 : 0] m1;
  wire [15 : 0] m1$D_IN;
  wire m1$EN;

  // register m2
  reg [15 : 0] m2;
  wire [15 : 0] m2$D_IN;
  wire m2$EN;

  // register resmac
  reg [31 : 0] resmac;
  wire [31 : 0] resmac$D_IN;
  wire resmac$EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_compute_mac16,
       CAN_FIRE_get_values,
       WILL_FIRE_RL_compute_mac16,
       WILL_FIRE_get_values;

  // remaining internal signals
  wire [63 : 0] _0_CONCAT_m1_MUL_0_CONCAT_m2___d7;
  wire [31 : 0] x__h250, y__h249, y__h251;

  // action method get_values
  assign RDY_get_values = isReady == 2'd0 ;
  assign CAN_FIRE_get_values = isReady == 2'd0 ;
  assign WILL_FIRE_get_values = EN_get_values ;

  // value method mac_result
  assign mac_result = resmac ;
  assign RDY_mac_result = isReady == 2'd2 ;

  // rule RL_compute_mac16
  assign CAN_FIRE_RL_compute_mac16 = isReady == 2'd1 ;
  assign WILL_FIRE_RL_compute_mac16 = CAN_FIRE_RL_compute_mac16 ;

  // register a
  assign a$D_IN = get_values_addend ;
  assign a$EN = EN_get_values ;

  // register isReady
  assign isReady$D_IN = EN_get_values ? 2'd1 : 2'd2 ;
  assign isReady$EN = EN_get_values || WILL_FIRE_RL_compute_mac16 ;

  // register m1
  assign m1$D_IN = get_values_multiplicand1 ;
  assign m1$EN = EN_get_values ;

  // register m2
  assign m2$D_IN = get_values_multiplicand2 ;
  assign m2$EN = EN_get_values ;

  // register resmac
  assign resmac$D_IN = _0_CONCAT_m1_MUL_0_CONCAT_m2___d7[31:0] + y__h249 ;
  assign resmac$EN = CAN_FIRE_RL_compute_mac16 ;

  // remaining internal signals
  assign _0_CONCAT_m1_MUL_0_CONCAT_m2___d7 = x__h250 * y__h251 ;
  assign x__h250 = { 16'd0, m1 } ;
  assign y__h249 = { 16'd0, a } ;
  assign y__h251 = { 16'd0, m2 } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        a <= `BSV_ASSIGNMENT_DELAY 16'd0;
	m1 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	m2 <= `BSV_ASSIGNMENT_DELAY 16'd0;
	resmac <= `BSV_ASSIGNMENT_DELAY 32'd0;
      end
    else
      begin
        if (a$EN) a <= `BSV_ASSIGNMENT_DELAY a$D_IN;
	if (m1$EN) m1 <= `BSV_ASSIGNMENT_DELAY m1$D_IN;
	if (m2$EN) m2 <= `BSV_ASSIGNMENT_DELAY m2$D_IN;
	if (resmac$EN) resmac <= `BSV_ASSIGNMENT_DELAY resmac$D_IN;
      end
  end

  always@(posedge CLK or `BSV_RESET_EDGE RST_N)
  if (RST_N == `BSV_RESET_VALUE)
    begin
      isReady <= `BSV_ASSIGNMENT_DELAY 2'd0;
    end
  else
    begin
      if (isReady$EN) isReady <= `BSV_ASSIGNMENT_DELAY isReady$D_IN;
    end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    a = 16'hAAAA;
    isReady = 2'h2;
    m1 = 16'hAAAA;
    m2 = 16'hAAAA;
    resmac = 32'hAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkmac16

