//
// Generated by Bluespec Compiler, version 2021.12.1 (build fd501401)
//
// On Mon Mar  6 22:25:01 IST 2023
//
//
// Ports:
// Name                         I/O  size props
// oP                             O    32
// CLK                            I     1 clock
// RST_N                          I     1 reset
// iA_a                           I    32 reg
// iB_b                           I    32 reg
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

module mkadder(CLK,
	       RST_N,

	       iA_a,

	       iB_b,

	       oP);
  input  CLK;
  input  RST_N;

  // action method iA
  input  [31 : 0] iA_a;

  // action method iB
  input  [31 : 0] iB_b;

  // value method oP
  output [31 : 0] oP;

  // signals for module outputs
  wire [31 : 0] oP;

  // register reg_a
  reg [31 : 0] reg_a;
  wire [31 : 0] reg_a$D_IN;
  wire reg_a$EN;

  // register reg_b
  reg [31 : 0] reg_b;
  wire [31 : 0] reg_b$D_IN;
  wire reg_b$EN;

  // value method oP
  assign oP = reg_a + reg_b ;

  // register reg_a
  assign reg_a$D_IN = iA_a ;
  assign reg_a$EN = 1'd1 ;

  // register reg_b
  assign reg_b$D_IN = iB_b ;
  assign reg_b$EN = 1'd1 ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST_N == `BSV_RESET_VALUE)
      begin
        reg_a <= `BSV_ASSIGNMENT_DELAY 32'd0;
	reg_b <= `BSV_ASSIGNMENT_DELAY 32'd0;
      end
    else
      begin
        if (reg_a$EN) reg_a <= `BSV_ASSIGNMENT_DELAY reg_a$D_IN;
	if (reg_b$EN) reg_b <= `BSV_ASSIGNMENT_DELAY reg_b$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    reg_a = 32'hAAAAAAAA;
    reg_b = 32'hAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkadder

