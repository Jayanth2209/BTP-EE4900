module mkMAC(CLK,
	     RST,

	     get_values_multiplicand1,
	     get_values_multiplicand2,
	     get_values_addend,
	     get_values_mode,
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
  input  [1 : 0] get_values_mode;
  input  EN_get_values;
  output RDY_get_values;

  // actionvalue method mac_result
  input  EN_mac_result;
  output [127 : 0] mac_result;
  output RDY_mac_result;

  // signals for module outputs
  reg [127 : 0] mac_result;
  wire RDY_get_values, RDY_mac_result;

  // register a
  reg [63 : 0] a;
  wire [63 : 0] a$D_IN;
  wire a$EN;

  // register isReady
  reg [1 : 0] isReady;
  wire [1 : 0] isReady$D_IN;
  wire isReady$EN;

  // register m1
  reg [63 : 0] m1;
  wire [63 : 0] m1$D_IN;
  wire m1$EN;

  // register m2
  reg [63 : 0] m2;
  wire [63 : 0] m2$D_IN;
  wire m2$EN;

  // register reg_mode
  reg [1 : 0] reg_mode;
  wire [1 : 0] reg_mode$D_IN;
  wire reg_mode$EN;

  // register resmac
  reg [127 : 0] resmac;
  wire [127 : 0] resmac$D_IN;
  wire resmac$EN;

  // ports of submodule mac_16b_1
  wire [31 : 0] mac_16b_1$mac_result;
  wire [15 : 0] mac_16b_1$get_values_addend,
		mac_16b_1$get_values_multiplicand1,
		mac_16b_1$get_values_multiplicand2;
  wire mac_16b_1$EN_get_values, mac_16b_1$RDY_mac_result;

  // ports of submodule mac_16b_2
  wire [31 : 0] mac_16b_2$mac_result;
  wire [15 : 0] mac_16b_2$get_values_addend,
		mac_16b_2$get_values_multiplicand1,
		mac_16b_2$get_values_multiplicand2;
  wire mac_16b_2$EN_get_values, mac_16b_2$RDY_mac_result;

  // ports of submodule mac_32b
  reg [31 : 0] mac_32b$get_values_addend,
	       mac_32b$get_values_multiplicand1,
	       mac_32b$get_values_multiplicand2;
  wire [63 : 0] mac_32b$mac_result;
  wire mac_32b$EN_get_values, mac_32b$RDY_mac_result;

  // ports of submodule mac_64b
  reg [63 : 0] mac_64b$get_values_addend,
	       mac_64b$get_values_multiplicand1,
	       mac_64b$get_values_multiplicand2;
  wire [127 : 0] mac_64b$mac_result;
  wire mac_64b$EN_get_values, mac_64b$RDY_mac_result;

  // ports of submodule mac_8b_1
  wire [15 : 0] mac_8b_1$mac_result;
  wire [7 : 0] mac_8b_1$get_values_addend,
	       mac_8b_1$get_values_multiplicand1,
	       mac_8b_1$get_values_multiplicand2;
  wire mac_8b_1$EN_get_values, mac_8b_1$RDY_mac_result;

  // ports of submodule mac_8b_2
  wire [15 : 0] mac_8b_2$mac_result;
  wire [7 : 0] mac_8b_2$get_values_addend,
	       mac_8b_2$get_values_multiplicand1,
	       mac_8b_2$get_values_multiplicand2;
  wire mac_8b_2$EN_get_values, mac_8b_2$RDY_mac_result;

  // ports of submodule mac_8b_3
  wire [15 : 0] mac_8b_3$mac_result;
  wire [7 : 0] mac_8b_3$get_values_addend,
	       mac_8b_3$get_values_multiplicand1,
	       mac_8b_3$get_values_multiplicand2;
  wire mac_8b_3$EN_get_values, mac_8b_3$RDY_mac_result;

  // ports of submodule mac_8b_4
  wire [15 : 0] mac_8b_4$mac_result;
  wire [7 : 0] mac_8b_4$get_values_addend,
	       mac_8b_4$get_values_multiplicand1,
	       mac_8b_4$get_values_multiplicand2;
  wire mac_8b_4$EN_get_values, mac_8b_4$RDY_mac_result;

  // rule scheduling signals
  wire CAN_FIRE_RL_compute_MAC,
       CAN_FIRE_get_values,
       CAN_FIRE_mac_result,
       WILL_FIRE_RL_compute_MAC,
       WILL_FIRE_get_values,
       WILL_FIRE_mac_result;

  // remaining internal signals
  reg IF_reg_mode_EQ_1_THEN_mac_32b_RDY_mac_result___ETC___d148;
  wire [127 : 0] final_mac_result__h2238,
		 final_mac_result__h2271,
		 final_mac_result__h2333;
  wire [63 : 0] addend__h743,
		addend__h843,
		addend__h929,
		multiplicand1__h741,
		multiplicand1__h841,
		multiplicand1__h927,
		multiplicand2__h742,
		multiplicand2__h842,
		multiplicand2__h928;
  wire [31 : 0] addend__h1139,
		addend__h1414,
		multiplicand1__h1137,
		multiplicand1__h1412,
		multiplicand2__h1138,
		multiplicand2__h1413;
  wire [15 : 0] addend__h1507,
		addend__h1600,
		multiplicand1__h1505,
		multiplicand1__h1598,
		multiplicand2__h1506,
		multiplicand2__h1599;
  wire mac_8b_1_RDY_mac_result__38_AND_mac_8b_2_RDY_m_ETC___d145;

  // action method get_values
  assign RDY_get_values = isReady == 2'd0 ;
  assign CAN_FIRE_get_values = isReady == 2'd0 ;
  assign WILL_FIRE_get_values = EN_get_values ;

  // actionvalue method mac_result
  always@(reg_mode or
	  mac_64b$mac_result or
	  final_mac_result__h2238 or
	  final_mac_result__h2271 or final_mac_result__h2333)
  begin
    case (reg_mode)
      2'd0: mac_result = mac_64b$mac_result;
      2'd1: mac_result = final_mac_result__h2238;
      2'd2: mac_result = final_mac_result__h2271;
      2'd3: mac_result = final_mac_result__h2333;
    endcase
  end
  assign RDY_mac_result =
	     isReady == 2'd2 && mac_64b$RDY_mac_result &&
	     (reg_mode == 2'd0 ||
	      IF_reg_mode_EQ_1_THEN_mac_32b_RDY_mac_result___ETC___d148) ;
  assign CAN_FIRE_mac_result =
	     isReady == 2'd2 && mac_64b$RDY_mac_result &&
	     (reg_mode == 2'd0 ||
	      IF_reg_mode_EQ_1_THEN_mac_32b_RDY_mac_result___ETC___d148) ;
  assign WILL_FIRE_mac_result = EN_mac_result ;

  // submodule mac_16b_1
  mkmac16 mac_16b_1(.CLK(CLK),
		    .RST(RST),
		    .get_values_addend(mac_16b_1$get_values_addend),
		    .get_values_multiplicand1(mac_16b_1$get_values_multiplicand1),
		    .get_values_multiplicand2(mac_16b_1$get_values_multiplicand2),
		    .EN_get_values(mac_16b_1$EN_get_values),
		    .RDY_get_values(),
		    .mac_result(mac_16b_1$mac_result),
		    .RDY_mac_result(mac_16b_1$RDY_mac_result));

  // submodule mac_16b_2
  mkmac16 mac_16b_2(.CLK(CLK),
		    .RST(RST),
		    .get_values_addend(mac_16b_2$get_values_addend),
		    .get_values_multiplicand1(mac_16b_2$get_values_multiplicand1),
		    .get_values_multiplicand2(mac_16b_2$get_values_multiplicand2),
		    .EN_get_values(mac_16b_2$EN_get_values),
		    .RDY_get_values(),
		    .mac_result(mac_16b_2$mac_result),
		    .RDY_mac_result(mac_16b_2$RDY_mac_result));

  // submodule mac_32b
  mkmac322p mac_32b(.CLK(CLK),
		    .RST(RST),
		    .get_values_addend(mac_32b$get_values_addend),
		    .get_values_multiplicand1(mac_32b$get_values_multiplicand1),
		    .get_values_multiplicand2(mac_32b$get_values_multiplicand2),
		    .EN_get_values(mac_32b$EN_get_values),
		    .RDY_get_values(),
		    .mac_result(mac_32b$mac_result),
		    .RDY_mac_result(mac_32b$RDY_mac_result));

  // submodule mac_64b
  mkmac642p mac_64b(.CLK(CLK),
		    .RST(RST),
		    .get_values_addend(mac_64b$get_values_addend),
		    .get_values_multiplicand1(mac_64b$get_values_multiplicand1),
		    .get_values_multiplicand2(mac_64b$get_values_multiplicand2),
		    .EN_get_values(mac_64b$EN_get_values),
		    .RDY_get_values(),
		    .mac_result(mac_64b$mac_result),
		    .RDY_mac_result(mac_64b$RDY_mac_result));

  // submodule mac_8b_1
  mkmac8 mac_8b_1(.CLK(CLK),
		  .RST(RST),
		  .get_values_addend(mac_8b_1$get_values_addend),
		  .get_values_multiplicand1(mac_8b_1$get_values_multiplicand1),
		  .get_values_multiplicand2(mac_8b_1$get_values_multiplicand2),
		  .EN_get_values(mac_8b_1$EN_get_values),
		  .RDY_get_values(),
		  .mac_result(mac_8b_1$mac_result),
		  .RDY_mac_result(mac_8b_1$RDY_mac_result));

  // submodule mac_8b_2
  mkmac8 mac_8b_2(.CLK(CLK),
		  .RST(RST),
		  .get_values_addend(mac_8b_2$get_values_addend),
		  .get_values_multiplicand1(mac_8b_2$get_values_multiplicand1),
		  .get_values_multiplicand2(mac_8b_2$get_values_multiplicand2),
		  .EN_get_values(mac_8b_2$EN_get_values),
		  .RDY_get_values(),
		  .mac_result(mac_8b_2$mac_result),
		  .RDY_mac_result(mac_8b_2$RDY_mac_result));

  // submodule mac_8b_3
  mkmac8 mac_8b_3(.CLK(CLK),
		  .RST(RST),
		  .get_values_addend(mac_8b_3$get_values_addend),
		  .get_values_multiplicand1(mac_8b_3$get_values_multiplicand1),
		  .get_values_multiplicand2(mac_8b_3$get_values_multiplicand2),
		  .EN_get_values(mac_8b_3$EN_get_values),
		  .RDY_get_values(),
		  .mac_result(mac_8b_3$mac_result),
		  .RDY_mac_result(mac_8b_3$RDY_mac_result));

  // submodule mac_8b_4
  mkmac8 mac_8b_4(.CLK(CLK),
		  .RST(RST),
		  .get_values_addend(mac_8b_4$get_values_addend),
		  .get_values_multiplicand1(mac_8b_4$get_values_multiplicand1),
		  .get_values_multiplicand2(mac_8b_4$get_values_multiplicand2),
		  .EN_get_values(mac_8b_4$EN_get_values),
		  .RDY_get_values(),
		  .mac_result(mac_8b_4$mac_result),
		  .RDY_mac_result(mac_8b_4$RDY_mac_result));

  // rule RL_compute_MAC
  assign CAN_FIRE_RL_compute_MAC = isReady == 2'd1 ;
  assign WILL_FIRE_RL_compute_MAC = CAN_FIRE_RL_compute_MAC ;

  // register a
  assign a$D_IN = get_values_addend ;
  assign a$EN = EN_get_values ;

  // register isReady
  assign isReady$D_IN = EN_get_values ? 2'd1 : 2'd2 ;
  assign isReady$EN = EN_get_values || WILL_FIRE_RL_compute_MAC ;

  // register m1
  assign m1$D_IN = get_values_multiplicand1 ;
  assign m1$EN = EN_get_values ;

  // register m2
  assign m2$D_IN = get_values_multiplicand2 ;
  assign m2$EN = EN_get_values ;

  // register reg_mode
  assign reg_mode$D_IN = get_values_mode ;
  assign reg_mode$EN = EN_get_values ;

  // register resmac
  assign resmac$D_IN = 128'h0 ;
  assign resmac$EN = 1'b0 ;

  // submodule mac_16b_1
  assign mac_16b_1$get_values_addend =
	     (reg_mode == 2'd2) ? a[47:32] : addend__h1507 ;
  assign mac_16b_1$get_values_multiplicand1 =
	     (reg_mode == 2'd2) ? m1[47:32] : multiplicand1__h1505 ;
  assign mac_16b_1$get_values_multiplicand2 =
	     (reg_mode == 2'd2) ? m2[47:32] : multiplicand2__h1506 ;
  assign mac_16b_1$EN_get_values =
	     WILL_FIRE_RL_compute_MAC &&
	     (reg_mode == 2'd2 || reg_mode == 2'd3) ;

  // submodule mac_16b_2
  assign mac_16b_2$get_values_addend =
	     (reg_mode == 2'd2) ? a[63:48] : addend__h1600 ;
  assign mac_16b_2$get_values_multiplicand1 =
	     (reg_mode == 2'd2) ? m1[63:48] : multiplicand1__h1598 ;
  assign mac_16b_2$get_values_multiplicand2 =
	     (reg_mode == 2'd2) ? m2[63:48] : multiplicand2__h1599 ;
  assign mac_16b_2$EN_get_values =
	     WILL_FIRE_RL_compute_MAC &&
	     (reg_mode == 2'd2 || reg_mode == 2'd3) ;

  // submodule mac_32b
  always@(reg_mode or addend__h1414 or a or addend__h1139)
  begin
    case (reg_mode)
      2'd1: mac_32b$get_values_addend = a[63:32];
      2'd2: mac_32b$get_values_addend = addend__h1139;
      default: mac_32b$get_values_addend = addend__h1414;
    endcase
  end
  always@(reg_mode or multiplicand1__h1412 or m1 or multiplicand1__h1137)
  begin
    case (reg_mode)
      2'd1: mac_32b$get_values_multiplicand1 = m1[63:32];
      2'd2: mac_32b$get_values_multiplicand1 = multiplicand1__h1137;
      default: mac_32b$get_values_multiplicand1 = multiplicand1__h1412;
    endcase
  end
  always@(reg_mode or multiplicand2__h1413 or m2 or multiplicand2__h1138)
  begin
    case (reg_mode)
      2'd1: mac_32b$get_values_multiplicand2 = m2[63:32];
      2'd2: mac_32b$get_values_multiplicand2 = multiplicand2__h1138;
      default: mac_32b$get_values_multiplicand2 = multiplicand2__h1413;
    endcase
  end
  assign mac_32b$EN_get_values =
	     WILL_FIRE_RL_compute_MAC &&
	     (reg_mode == 2'd1 || reg_mode == 2'd2 || reg_mode == 2'd3) ;

  // submodule mac_64b
  always@(reg_mode or a or addend__h743 or addend__h843 or addend__h929)
  begin
    case (reg_mode)
      2'd0: mac_64b$get_values_addend = a;
      2'd1: mac_64b$get_values_addend = addend__h743;
      2'd2: mac_64b$get_values_addend = addend__h843;
      2'd3: mac_64b$get_values_addend = addend__h929;
    endcase
  end
  always@(reg_mode or
	  m1 or
	  multiplicand1__h741 or multiplicand1__h841 or multiplicand1__h927)
  begin
    case (reg_mode)
      2'd0: mac_64b$get_values_multiplicand1 = m1;
      2'd1: mac_64b$get_values_multiplicand1 = multiplicand1__h741;
      2'd2: mac_64b$get_values_multiplicand1 = multiplicand1__h841;
      2'd3: mac_64b$get_values_multiplicand1 = multiplicand1__h927;
    endcase
  end
  always@(reg_mode or
	  m2 or
	  multiplicand2__h742 or multiplicand2__h842 or multiplicand2__h928)
  begin
    case (reg_mode)
      2'd0: mac_64b$get_values_multiplicand2 = m2;
      2'd1: mac_64b$get_values_multiplicand2 = multiplicand2__h742;
      2'd2: mac_64b$get_values_multiplicand2 = multiplicand2__h842;
      2'd3: mac_64b$get_values_multiplicand2 = multiplicand2__h928;
    endcase
  end
  assign mac_64b$EN_get_values = CAN_FIRE_RL_compute_MAC ;

  // submodule mac_8b_1
  assign mac_8b_1$get_values_addend = a[39:32] ;
  assign mac_8b_1$get_values_multiplicand1 = m1[39:32] ;
  assign mac_8b_1$get_values_multiplicand2 = m2[39:32] ;
  assign mac_8b_1$EN_get_values =
	     WILL_FIRE_RL_compute_MAC && reg_mode == 2'd3 ;

  // submodule mac_8b_2
  assign mac_8b_2$get_values_addend = a[47:40] ;
  assign mac_8b_2$get_values_multiplicand1 = m1[47:40] ;
  assign mac_8b_2$get_values_multiplicand2 = m2[47:40] ;
  assign mac_8b_2$EN_get_values =
	     WILL_FIRE_RL_compute_MAC && reg_mode == 2'd3 ;

  // submodule mac_8b_3
  assign mac_8b_3$get_values_addend = a[55:48] ;
  assign mac_8b_3$get_values_multiplicand1 = m1[55:48] ;
  assign mac_8b_3$get_values_multiplicand2 = m2[55:48] ;
  assign mac_8b_3$EN_get_values =
	     WILL_FIRE_RL_compute_MAC && reg_mode == 2'd3 ;

  // submodule mac_8b_4
  assign mac_8b_4$get_values_addend = a[63:56] ;
  assign mac_8b_4$get_values_multiplicand1 = m1[63:56] ;
  assign mac_8b_4$get_values_multiplicand2 = m2[63:56] ;
  assign mac_8b_4$EN_get_values =
	     WILL_FIRE_RL_compute_MAC && reg_mode == 2'd3 ;

  // remaining internal signals
  assign addend__h1139 = { 16'd0, a[31:16] } ;
  assign addend__h1414 = { 24'd0, a[15:8] } ;
  assign addend__h1507 = { 8'd0, a[23:16] } ;
  assign addend__h1600 = { 8'd0, a[31:24] } ;
  assign addend__h743 = { 32'd0, a[31:0] } ;
  assign addend__h843 = { 48'd0, a[15:0] } ;
  assign addend__h929 = { 56'd0, a[7:0] } ;
  assign final_mac_result__h2238 =
	     { mac_32b$mac_result, mac_64b$mac_result[63:0] } ;
  assign final_mac_result__h2271 =
	     { mac_16b_2$mac_result,
	       mac_16b_1$mac_result,
	       mac_32b$mac_result[31:0],
	       mac_64b$mac_result[31:0] } ;
  assign final_mac_result__h2333 =
	     { mac_8b_4$mac_result,
	       mac_8b_3$mac_result,
	       mac_8b_2$mac_result,
	       mac_8b_1$mac_result,
	       mac_16b_2$mac_result[15:0],
	       mac_16b_1$mac_result[15:0],
	       mac_32b$mac_result[15:0],
	       mac_64b$mac_result[15:0] } ;
  assign mac_8b_1_RDY_mac_result__38_AND_mac_8b_2_RDY_m_ETC___d145 =
	     mac_8b_1$RDY_mac_result && mac_8b_2$RDY_mac_result &&
	     mac_8b_3$RDY_mac_result &&
	     mac_8b_4$RDY_mac_result &&
	     mac_16b_1$RDY_mac_result &&
	     mac_16b_2$RDY_mac_result &&
	     mac_32b$RDY_mac_result ;
  assign multiplicand1__h1137 = { 16'd0, m1[31:16] } ;
  assign multiplicand1__h1412 = { 24'd0, m1[15:8] } ;
  assign multiplicand1__h1505 = { 8'd0, m1[23:16] } ;
  assign multiplicand1__h1598 = { 8'd0, m1[31:24] } ;
  assign multiplicand1__h741 = { 32'd0, m1[31:0] } ;
  assign multiplicand1__h841 = { 48'd0, m1[15:0] } ;
  assign multiplicand1__h927 = { 56'd0, m1[7:0] } ;
  assign multiplicand2__h1138 = { 16'd0, m2[31:16] } ;
  assign multiplicand2__h1413 = { 24'd0, m2[15:8] } ;
  assign multiplicand2__h1506 = { 8'd0, m2[23:16] } ;
  assign multiplicand2__h1599 = { 8'd0, m2[31:24] } ;
  assign multiplicand2__h742 = { 32'd0, m2[31:0] } ;
  assign multiplicand2__h842 = { 48'd0, m2[15:0] } ;
  assign multiplicand2__h928 = { 56'd0, m2[7:0] } ;
  always@(reg_mode or
	  mac_8b_1_RDY_mac_result__38_AND_mac_8b_2_RDY_m_ETC___d145 or
	  mac_32b$RDY_mac_result or
	  mac_16b_1$RDY_mac_result or mac_16b_2$RDY_mac_result)
  begin
    case (reg_mode)
      2'd1:
	  IF_reg_mode_EQ_1_THEN_mac_32b_RDY_mac_result___ETC___d148 =
	      mac_32b$RDY_mac_result;
      2'd2:
	  IF_reg_mode_EQ_1_THEN_mac_32b_RDY_mac_result___ETC___d148 =
	      mac_16b_1$RDY_mac_result && mac_16b_2$RDY_mac_result &&
	      mac_32b$RDY_mac_result;
      default: IF_reg_mode_EQ_1_THEN_mac_32b_RDY_mac_result___ETC___d148 =
		   reg_mode != 2'd3 ||
		   mac_8b_1_RDY_mac_result__38_AND_mac_8b_2_RDY_m_ETC___d145;
    endcase
  end

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST == 1)
      begin
        a <= 64'd0;
	m1 <= 64'd0;
	m2 <= 64'd0;
	reg_mode <= 2'd0;
	resmac <= 128'd0;
      end
    else
      begin
        if (a$EN) a <= a$D_IN;
	if (m1$EN) m1 <= m1$D_IN;
	if (m2$EN) m2 <= m2$D_IN;
	if (reg_mode$EN) reg_mode <= reg_mode$D_IN;
	if (resmac$EN) resmac <= resmac$D_IN;
      end
  end

  always@(posedge CLK or posedge RST)
  if (RST == 1)
    begin
      isReady <= 2'd0;
    end
  else
    begin
      if (isReady$EN) isReady <= isReady$D_IN;
    end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    a = 64'hAAAAAAAAAAAAAAAA;
    isReady = 2'h2;
    m1 = 64'hAAAAAAAAAAAAAAAA;
    m2 = 64'hAAAAAAAAAAAAAAAA;
    reg_mode = 2'h2;
    resmac = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMAC
