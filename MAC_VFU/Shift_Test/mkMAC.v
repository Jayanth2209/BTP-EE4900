module mkMAC(CLK,
	     RST,

	     get_values_multiplicand1,
	     get_values_multiplicand2,
	     get_values_addend,
	     get_values_mode,
	     EN_get_values,
	     RDY_get_values,

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

  // value method mac_result
  output [127 : 0] mac_result;
  output RDY_mac_result;

  // signals for module outputs
  wire [127 : 0] mac_result;
  wire RDY_get_values, RDY_mac_result;

  // register a
  reg [63 : 0] a;
  wire [63 : 0] a$D_IN;
  wire a$EN;

  // register counter
  reg [3 : 0] counter;
  wire [3 : 0] counter$D_IN;
  wire counter$EN;

  // register flag_0
  reg flag_0;
  wire flag_0$D_IN, flag_0$EN;

  // register flag_1
  reg flag_1;
  wire flag_1$D_IN, flag_1$EN;

  // register flag_2
  reg flag_2;
  wire flag_2$D_IN, flag_2$EN;

  // register flag_3
  reg flag_3;
  wire flag_3$D_IN, flag_3$EN;

  // register flag_4
  reg flag_4;
  wire flag_4$D_IN, flag_4$EN;

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

  // register mac_output
  reg [127 : 0] mac_output;
  reg [127 : 0] mac_output$D_IN;
  wire mac_output$EN;

  // register mac_ready
  reg mac_ready;
  wire mac_ready$D_IN, mac_ready$EN;

  // register partial_product_0
  reg [31 : 0] partial_product_0;
  wire [31 : 0] partial_product_0$D_IN;
  wire partial_product_0$EN;

  // register partial_product_1
  reg [31 : 0] partial_product_1;
  wire [31 : 0] partial_product_1$D_IN;
  wire partial_product_1$EN;

  // register partial_product_10
  reg [31 : 0] partial_product_10;
  wire [31 : 0] partial_product_10$D_IN;
  wire partial_product_10$EN;

  // register partial_product_11
  reg [31 : 0] partial_product_11;
  wire [31 : 0] partial_product_11$D_IN;
  wire partial_product_11$EN;

  // register partial_product_12
  reg [31 : 0] partial_product_12;
  wire [31 : 0] partial_product_12$D_IN;
  wire partial_product_12$EN;

  // register partial_product_13
  reg [31 : 0] partial_product_13;
  wire [31 : 0] partial_product_13$D_IN;
  wire partial_product_13$EN;

  // register partial_product_14
  reg [31 : 0] partial_product_14;
  wire [31 : 0] partial_product_14$D_IN;
  wire partial_product_14$EN;

  // register partial_product_15
  reg [31 : 0] partial_product_15;
  wire [31 : 0] partial_product_15$D_IN;
  wire partial_product_15$EN;

  // register partial_product_2
  reg [31 : 0] partial_product_2;
  wire [31 : 0] partial_product_2$D_IN;
  wire partial_product_2$EN;

  // register partial_product_3
  reg [31 : 0] partial_product_3;
  wire [31 : 0] partial_product_3$D_IN;
  wire partial_product_3$EN;

  // register partial_product_4
  reg [31 : 0] partial_product_4;
  wire [31 : 0] partial_product_4$D_IN;
  wire partial_product_4$EN;

  // register partial_product_5
  reg [31 : 0] partial_product_5;
  wire [31 : 0] partial_product_5$D_IN;
  wire partial_product_5$EN;

  // register partial_product_6
  reg [31 : 0] partial_product_6;
  wire [31 : 0] partial_product_6$D_IN;
  wire partial_product_6$EN;

  // register partial_product_7
  reg [31 : 0] partial_product_7;
  wire [31 : 0] partial_product_7$D_IN;
  wire partial_product_7$EN;

  // register partial_product_8
  reg [31 : 0] partial_product_8;
  wire [31 : 0] partial_product_8$D_IN;
  wire partial_product_8$EN;

  // register partial_product_9
  reg [31 : 0] partial_product_9;
  wire [31 : 0] partial_product_9$D_IN;
  wire partial_product_9$EN;

  // register partial_sum_0
  reg [127 : 0] partial_sum_0;
  wire [127 : 0] partial_sum_0$D_IN;
  wire partial_sum_0$EN;

  // register partial_sum_1
  reg [127 : 0] partial_sum_1;
  wire [127 : 0] partial_sum_1$D_IN;
  wire partial_sum_1$EN;

  // register partial_sum_2
  reg [127 : 0] partial_sum_2;
  wire [127 : 0] partial_sum_2$D_IN;
  wire partial_sum_2$EN;

  // register partial_sum_3
  reg [127 : 0] partial_sum_3;
  wire [127 : 0] partial_sum_3$D_IN;
  wire partial_sum_3$EN;

  // register partial_sum_4
  reg [127 : 0] partial_sum_4;
  wire [127 : 0] partial_sum_4$D_IN;
  wire partial_sum_4$EN;

  // register partial_sum_5
  reg [127 : 0] partial_sum_5;
  wire [127 : 0] partial_sum_5$D_IN;
  wire partial_sum_5$EN;

  // register partial_sum_6
  reg [127 : 0] partial_sum_6;
  wire [127 : 0] partial_sum_6$D_IN;
  wire partial_sum_6$EN;

  // register reg_mode
  reg [1 : 0] reg_mode;
  wire [1 : 0] reg_mode$D_IN;
  wire reg_mode$EN;

  // register x_0
  reg [15 : 0] x_0;
  wire [15 : 0] x_0$D_IN;
  wire x_0$EN;

  // register x_1
  reg [15 : 0] x_1;
  reg [15 : 0] x_1$D_IN;
  wire x_1$EN;

  // register x_10
  reg [15 : 0] x_10;
  reg [15 : 0] x_10$D_IN;
  wire x_10$EN;

  // register x_11
  reg [15 : 0] x_11;
  reg [15 : 0] x_11$D_IN;
  wire x_11$EN;

  // register x_12
  reg [15 : 0] x_12;
  reg [15 : 0] x_12$D_IN;
  wire x_12$EN;

  // register x_13
  reg [15 : 0] x_13;
  reg [15 : 0] x_13$D_IN;
  wire x_13$EN;

  // register x_14
  reg [15 : 0] x_14;
  reg [15 : 0] x_14$D_IN;
  wire x_14$EN;

  // register x_15
  reg [15 : 0] x_15;
  wire [15 : 0] x_15$D_IN;
  wire x_15$EN;

  // register x_2
  reg [15 : 0] x_2;
  reg [15 : 0] x_2$D_IN;
  wire x_2$EN;

  // register x_3
  reg [15 : 0] x_3;
  reg [15 : 0] x_3$D_IN;
  wire x_3$EN;

  // register x_4
  reg [15 : 0] x_4;
  reg [15 : 0] x_4$D_IN;
  wire x_4$EN;

  // register x_5
  reg [15 : 0] x_5;
  reg [15 : 0] x_5$D_IN;
  wire x_5$EN;

  // register x_6
  reg [15 : 0] x_6;
  reg [15 : 0] x_6$D_IN;
  wire x_6$EN;

  // register x_7
  reg [15 : 0] x_7;
  reg [15 : 0] x_7$D_IN;
  wire x_7$EN;

  // register x_8
  reg [15 : 0] x_8;
  reg [15 : 0] x_8$D_IN;
  wire x_8$EN;

  // register x_9
  reg [15 : 0] x_9;
  reg [15 : 0] x_9$D_IN;
  wire x_9$EN;

  // register y_0
  reg [15 : 0] y_0;
  wire [15 : 0] y_0$D_IN;
  wire y_0$EN;

  // register y_1
  reg [15 : 0] y_1;
  wire [15 : 0] y_1$D_IN;
  wire y_1$EN;

  // register y_10
  reg [15 : 0] y_10;
  reg [15 : 0] y_10$D_IN;
  wire y_10$EN;

  // register y_11
  reg [15 : 0] y_11;
  reg [15 : 0] y_11$D_IN;
  wire y_11$EN;

  // register y_12
  reg [15 : 0] y_12;
  reg [15 : 0] y_12$D_IN;
  wire y_12$EN;

  // register y_13
  reg [15 : 0] y_13;
  reg [15 : 0] y_13$D_IN;
  wire y_13$EN;

  // register y_14
  reg [15 : 0] y_14;
  wire [15 : 0] y_14$D_IN;
  wire y_14$EN;

  // register y_15
  reg [15 : 0] y_15;
  wire [15 : 0] y_15$D_IN;
  wire y_15$EN;

  // register y_2
  reg [15 : 0] y_2;
  reg [15 : 0] y_2$D_IN;
  wire y_2$EN;

  // register y_3
  reg [15 : 0] y_3;
  reg [15 : 0] y_3$D_IN;
  wire y_3$EN;

  // register y_4
  reg [15 : 0] y_4;
  reg [15 : 0] y_4$D_IN;
  wire y_4$EN;

  // register y_5
  reg [15 : 0] y_5;
  reg [15 : 0] y_5$D_IN;
  wire y_5$EN;

  // register y_6
  reg [15 : 0] y_6;
  reg [15 : 0] y_6$D_IN;
  wire y_6$EN;

  // register y_7
  reg [15 : 0] y_7;
  reg [15 : 0] y_7$D_IN;
  wire y_7$EN;

  // register y_8
  reg [15 : 0] y_8;
  reg [15 : 0] y_8$D_IN;
  wire y_8$EN;

  // register y_9
  reg [15 : 0] y_9;
  reg [15 : 0] y_9$D_IN;
  wire y_9$EN;

  // rule scheduling signals
  wire CAN_FIRE_RL_compute_MAC,
       CAN_FIRE_get_values,
       WILL_FIRE_RL_compute_MAC,
       WILL_FIRE_get_values;

  // remaining internal signals
  wire [127 : 0] x7294_PLUS_y7295__q1,
		 x7384_PLUS_y7385__q2,
		 x7564_PLUS_y7565__q3,
		 x7633_PLUS_y7634__q5,
		 x7700_PLUS_y7701__q4,
		 x__h17294,
		 x__h17384,
		 x__h17564,
		 x__h17633,
		 x__h17700,
		 x__h17702,
		 x__h17704,
		 x__h17920,
		 x__h18412,
		 x__h18601,
		 x__h18855,
		 x__h19064,
		 x__h19066,
		 x__h19068,
		 x__h19070,
		 x__h19072,
		 x__h19074,
		 x__h19076,
		 x__h19078,
		 x__h19080,
		 y__h17295,
		 y__h17385,
		 y__h17565,
		 y__h17634,
		 y__h17701,
		 y__h17703,
		 y__h17705,
		 y__h18890,
		 y__h19067,
		 y__h19069,
		 y__h19071,
		 y__h19073,
		 y__h19077;
  wire [95 : 0] partial_product_5_34_BITS_15_TO_0_71_PLUS_0_CO_ETC___d298;
  wire [63 : 0] _0_CONCAT_x_0_15_16_MUL_0_CONCAT_y_0_17_18___d119,
		_0_CONCAT_x_10_75_76_MUL_0_CONCAT_y_10_77_78___d179,
		_0_CONCAT_x_11_81_82_MUL_0_CONCAT_y_11_83_84___d185,
		_0_CONCAT_x_12_87_88_MUL_0_CONCAT_y_12_89_90___d191,
		_0_CONCAT_x_13_93_94_MUL_0_CONCAT_y_13_95_96___d197,
		_0_CONCAT_x_14_99_00_MUL_0_CONCAT_y_14_01_02___d203,
		_0_CONCAT_x_15_05_06_MUL_0_CONCAT_y_15_07_08___d209,
		_0_CONCAT_x_1_21_22_MUL_0_CONCAT_y_1_23_24___d125,
		_0_CONCAT_x_2_27_28_MUL_0_CONCAT_y_2_29_30___d131,
		_0_CONCAT_x_3_33_34_MUL_0_CONCAT_y_3_35_36___d137,
		_0_CONCAT_x_4_39_40_MUL_0_CONCAT_y_4_41_42___d143,
		_0_CONCAT_x_5_45_46_MUL_0_CONCAT_y_5_47_48___d149,
		_0_CONCAT_x_6_51_52_MUL_0_CONCAT_y_6_53_54___d155,
		_0_CONCAT_x_7_57_58_MUL_0_CONCAT_y_7_59_60___d161,
		_0_CONCAT_x_8_63_64_MUL_0_CONCAT_y_8_65_66___d167,
		_0_CONCAT_x_9_69_70_MUL_0_CONCAT_y_9_71_72___d173,
		partial_product_3_32_BITS_15_TO_0_79_PLUS_0_CO_ETC___d297,
		x__h18635,
		x__h18637,
		x__h18639,
		x__h18738,
		x__h18740,
		x__h18742,
		y__h18636,
		y__h18739;
  wire [31 : 0] x__h15829,
		x__h15916,
		x__h15981,
		x__h16046,
		x__h16111,
		x__h16176,
		x__h16241,
		x__h16306,
		x__h16371,
		x__h16436,
		x__h16501,
		x__h16566,
		x__h16631,
		x__h16696,
		x__h16761,
		x__h16826,
		y__h15830,
		y__h15917,
		y__h15982,
		y__h16047,
		y__h16112,
		y__h16177,
		y__h16242,
		y__h16307,
		y__h16372,
		y__h16437,
		y__h16502,
		y__h16567,
		y__h16632,
		y__h16697,
		y__h16762,
		y__h16827,
		y__h18447,
		y__h18484,
		y__h18516,
		y__h18548;
  wire [15 : 0] x__h5399,
		x__h5463,
		x__h5527,
		x__h5591,
		x__h5655,
		x__h5719,
		x__h5783,
		x__h5847,
		x__h6872,
		x__h6936,
		x__h7000,
		x__h7064,
		x__h7128,
		x__h7192,
		x__h7256,
		x__h7320,
		y__h17955,
		y__h18015,
		y__h18068,
		y__h18121,
		y__h18174,
		y__h18227,
		y__h18280,
		y__h18333;
  wire NOT_get_values_multiplicand1_EQ_m1_60_61_OR_NO_ETC___d367;

  // action method get_values
  assign RDY_get_values = 1'd1 ;
  assign CAN_FIRE_get_values = 1'd1 ;
  assign WILL_FIRE_get_values = EN_get_values ;

  // value method mac_result
  assign mac_result = mac_output ;
  assign RDY_mac_result = mac_ready ;

  // rule RL_compute_MAC
  assign CAN_FIRE_RL_compute_MAC = 1'd1 ;
  assign WILL_FIRE_RL_compute_MAC = 1'd1 ;

  // register a
  assign a$D_IN = get_values_addend ;
  assign a$EN =
	     EN_get_values &&
	     (NOT_get_values_multiplicand1_EQ_m1_60_61_OR_NO_ETC___d367 ||
	      get_values_mode != reg_mode) ;

  // register counter
  assign counter$D_IN = 4'h0 ;
  assign counter$EN = 1'b0 ;

  // register flag_0
  assign flag_0$D_IN = inp_ready ;
  assign flag_0$EN = 1'd1 ;

  // register flag_1
  assign flag_1$D_IN = flag_0 ;
  assign flag_1$EN = reg_mode != 2'd0 && reg_mode != 2'd1 || !flag_0 ;

  // register flag_2
  assign flag_2$D_IN = flag_1 ;
  assign flag_2$EN = 1'd1 ;

  // register flag_3
  assign flag_3$D_IN = flag_2 || flag_4 ;
  assign flag_3$EN = 1'd1 ;

  // register flag_4
  assign flag_4$D_IN = 1'd1 ;
  assign flag_4$EN = flag_0 && (reg_mode == 2'd0 || reg_mode == 2'd1) ;

  // register inp_ready
  assign inp_ready$D_IN =
	     NOT_get_values_multiplicand1_EQ_m1_60_61_OR_NO_ETC___d367 ||
	     get_values_mode != reg_mode ;
  assign inp_ready$EN = EN_get_values ;

  // register m1
  assign m1$D_IN = get_values_multiplicand1 ;
  assign m1$EN =
	     EN_get_values &&
	     (NOT_get_values_multiplicand1_EQ_m1_60_61_OR_NO_ETC___d367 ||
	      get_values_mode != reg_mode) ;

  // register m2
  assign m2$D_IN = get_values_multiplicand2 ;
  assign m2$EN =
	     EN_get_values &&
	     (NOT_get_values_multiplicand1_EQ_m1_60_61_OR_NO_ETC___d367 ||
	      get_values_mode != reg_mode) ;

  // register mac_output
  always@(reg_mode or x__h18855 or x__h17920 or x__h18412 or x__h18601)
  begin
    case (reg_mode)
      2'd0: mac_output$D_IN = x__h17920;
      2'd1: mac_output$D_IN = x__h18412;
      2'd2: mac_output$D_IN = x__h18601;
      2'd3: mac_output$D_IN = x__h18855;
    endcase
  end
  assign mac_output$EN = flag_3$D_IN ;

  // register mac_ready
  assign mac_ready$D_IN = 1'd1 ;
  assign mac_ready$EN = flag_3$D_IN ;

  // register partial_product_0
  assign partial_product_0$D_IN =
	     _0_CONCAT_x_0_15_16_MUL_0_CONCAT_y_0_17_18___d119[31:0] ;
  assign partial_product_0$EN = flag_0 ;

  // register partial_product_1
  assign partial_product_1$D_IN =
	     _0_CONCAT_x_1_21_22_MUL_0_CONCAT_y_1_23_24___d125[31:0] ;
  assign partial_product_1$EN = flag_0 ;

  // register partial_product_10
  assign partial_product_10$D_IN =
	     _0_CONCAT_x_10_75_76_MUL_0_CONCAT_y_10_77_78___d179[31:0] ;
  assign partial_product_10$EN = flag_0 ;

  // register partial_product_11
  assign partial_product_11$D_IN =
	     _0_CONCAT_x_11_81_82_MUL_0_CONCAT_y_11_83_84___d185[31:0] ;
  assign partial_product_11$EN = flag_0 ;

  // register partial_product_12
  assign partial_product_12$D_IN =
	     _0_CONCAT_x_12_87_88_MUL_0_CONCAT_y_12_89_90___d191[31:0] ;
  assign partial_product_12$EN = flag_0 ;

  // register partial_product_13
  assign partial_product_13$D_IN =
	     _0_CONCAT_x_13_93_94_MUL_0_CONCAT_y_13_95_96___d197[31:0] ;
  assign partial_product_13$EN = flag_0 ;

  // register partial_product_14
  assign partial_product_14$D_IN =
	     _0_CONCAT_x_14_99_00_MUL_0_CONCAT_y_14_01_02___d203[31:0] ;
  assign partial_product_14$EN = flag_0 ;

  // register partial_product_15
  assign partial_product_15$D_IN =
	     _0_CONCAT_x_15_05_06_MUL_0_CONCAT_y_15_07_08___d209[31:0] ;
  assign partial_product_15$EN = flag_0 ;

  // register partial_product_2
  assign partial_product_2$D_IN =
	     _0_CONCAT_x_2_27_28_MUL_0_CONCAT_y_2_29_30___d131[31:0] ;
  assign partial_product_2$EN = flag_0 ;

  // register partial_product_3
  assign partial_product_3$D_IN =
	     _0_CONCAT_x_3_33_34_MUL_0_CONCAT_y_3_35_36___d137[31:0] ;
  assign partial_product_3$EN = flag_0 ;

  // register partial_product_4
  assign partial_product_4$D_IN =
	     _0_CONCAT_x_4_39_40_MUL_0_CONCAT_y_4_41_42___d143[31:0] ;
  assign partial_product_4$EN = flag_0 ;

  // register partial_product_5
  assign partial_product_5$D_IN =
	     _0_CONCAT_x_5_45_46_MUL_0_CONCAT_y_5_47_48___d149[31:0] ;
  assign partial_product_5$EN = flag_0 ;

  // register partial_product_6
  assign partial_product_6$D_IN =
	     _0_CONCAT_x_6_51_52_MUL_0_CONCAT_y_6_53_54___d155[31:0] ;
  assign partial_product_6$EN = flag_0 ;

  // register partial_product_7
  assign partial_product_7$D_IN =
	     _0_CONCAT_x_7_57_58_MUL_0_CONCAT_y_7_59_60___d161[31:0] ;
  assign partial_product_7$EN = flag_0 ;

  // register partial_product_8
  assign partial_product_8$D_IN =
	     _0_CONCAT_x_8_63_64_MUL_0_CONCAT_y_8_65_66___d167[31:0] ;
  assign partial_product_8$EN = flag_0 ;

  // register partial_product_9
  assign partial_product_9$D_IN =
	     _0_CONCAT_x_9_69_70_MUL_0_CONCAT_y_9_71_72___d173[31:0] ;
  assign partial_product_9$EN = flag_0 ;

  // register partial_sum_0
  assign partial_sum_0$D_IN = { x7294_PLUS_y7295__q1[111:0], 16'd0 } ;
  assign partial_sum_0$EN = flag_1 ;

  // register partial_sum_1
  assign partial_sum_1$D_IN = { x7384_PLUS_y7385__q2[111:0], 16'd0 } ;
  assign partial_sum_1$EN = flag_1 ;

  // register partial_sum_2
  assign partial_sum_2$D_IN = { 64'd0, partial_product_4, 32'd0 } ;
  assign partial_sum_2$EN = flag_1 ;

  // register partial_sum_3
  assign partial_sum_3$D_IN = { 64'd0, partial_product_15, 32'd0 } ;
  assign partial_sum_3$EN = flag_1 ;

  // register partial_sum_4
  assign partial_sum_4$D_IN = { x7564_PLUS_y7565__q3[111:0], 16'd0 } ;
  assign partial_sum_4$EN = flag_1 ;

  // register partial_sum_5
  assign partial_sum_5$D_IN = { x7700_PLUS_y7701__q4[79:0], 48'd0 } ;
  assign partial_sum_5$EN = flag_1 ;

  // register partial_sum_6
  assign partial_sum_6$D_IN = { x7633_PLUS_y7634__q5[111:0], 16'd0 } ;
  assign partial_sum_6$EN = flag_1 ;

  // register reg_mode
  assign reg_mode$D_IN = get_values_mode ;
  assign reg_mode$EN =
	     EN_get_values &&
	     (NOT_get_values_multiplicand1_EQ_m1_60_61_OR_NO_ETC___d367 ||
	      get_values_mode != reg_mode) ;

  // register x_0
  assign x_0$D_IN = (reg_mode == 2'd0) ? x__h5399 : m1[15:0] ;
  assign x_0$EN = inp_ready ;

  // register x_1
  always@(reg_mode or m1 or x__h5463)
  begin
    case (reg_mode)
      2'd0: x_1$D_IN = x__h5463;
      2'd1: x_1$D_IN = m1[31:16];
      default: x_1$D_IN = m1[15:0];
    endcase
  end
  assign x_1$EN = inp_ready ;

  // register x_10
  always@(reg_mode or m1 or x__h5527)
  begin
    case (reg_mode)
      2'd0: x_10$D_IN = x__h5527;
      2'd1, 2'd2: x_10$D_IN = m1[47:32];
      2'd3: x_10$D_IN = m1[31:16];
    endcase
  end
  assign x_10$EN = inp_ready ;

  // register x_11
  always@(reg_mode or m1 or x__h5591)
  begin
    case (reg_mode)
      2'd0: x_11$D_IN = x__h5591;
      2'd1: x_11$D_IN = m1[63:48];
      default: x_11$D_IN = m1[47:32];
    endcase
  end
  assign x_11$EN = inp_ready ;

  // register x_12
  always@(reg_mode or m1 or x__h5655)
  begin
    case (reg_mode)
      2'd0: x_12$D_IN = x__h5655;
      2'd1: x_12$D_IN = m1[15:0];
      default: x_12$D_IN = m1[63:48];
    endcase
  end
  assign x_12$EN = inp_ready ;

  // register x_13
  always@(reg_mode or m1 or x__h5719)
  begin
    case (reg_mode)
      2'd0: x_13$D_IN = x__h5719;
      2'd1: x_13$D_IN = m1[31:16];
      default: x_13$D_IN = m1[47:32];
    endcase
  end
  assign x_13$EN = inp_ready ;

  // register x_14
  always@(reg_mode or m1 or x__h5783)
  begin
    case (reg_mode)
      2'd0: x_14$D_IN = x__h5783;
      2'd1: x_14$D_IN = m1[47:32];
      default: x_14$D_IN = m1[63:48];
    endcase
  end
  assign x_14$EN = inp_ready ;

  // register x_15
  assign x_15$D_IN = (reg_mode == 2'd0) ? x__h5847 : m1[63:48] ;
  assign x_15$EN = inp_ready ;

  // register x_2
  always@(reg_mode or m1 or x__h5527)
  begin
    case (reg_mode)
      2'd0: x_2$D_IN = x__h5527;
      2'd1: x_2$D_IN = m1[47:32];
      default: x_2$D_IN = m1[31:16];
    endcase
  end
  assign x_2$EN = inp_ready ;

  // register x_3
  always@(reg_mode or m1 or x__h5591)
  begin
    case (reg_mode)
      2'd0: x_3$D_IN = x__h5591;
      2'd1: x_3$D_IN = m1[63:48];
      default: x_3$D_IN = m1[15:0];
    endcase
  end
  assign x_3$EN = inp_ready ;

  // register x_4
  always@(reg_mode or m1 or x__h5655)
  begin
    case (reg_mode)
      2'd0: x_4$D_IN = x__h5655;
      2'd1: x_4$D_IN = m1[15:0];
      default: x_4$D_IN = m1[31:16];
    endcase
  end
  assign x_4$EN = inp_ready ;

  // register x_5
  always@(reg_mode or m1 or x__h5719)
  begin
    case (reg_mode)
      2'd0: x_5$D_IN = x__h5719;
      2'd1, 2'd2: x_5$D_IN = m1[31:16];
      2'd3: x_5$D_IN = m1[47:32];
    endcase
  end
  assign x_5$EN = inp_ready ;

  // register x_6
  always@(reg_mode or m1 or x__h5783)
  begin
    case (reg_mode)
      2'd0: x_6$D_IN = x__h5783;
      2'd1: x_6$D_IN = m1[47:32];
      default: x_6$D_IN = m1[15:0];
    endcase
  end
  assign x_6$EN = inp_ready ;

  // register x_7
  always@(reg_mode or m1 or x__h5847)
  begin
    case (reg_mode)
      2'd0: x_7$D_IN = x__h5847;
      2'd1: x_7$D_IN = m1[63:48];
      default: x_7$D_IN = m1[31:16];
    endcase
  end
  assign x_7$EN = inp_ready ;

  // register x_8
  always@(reg_mode or m1 or x__h5399)
  begin
    case (reg_mode)
      2'd0: x_8$D_IN = x__h5399;
      2'd1: x_8$D_IN = m1[15:0];
      default: x_8$D_IN = m1[47:32];
    endcase
  end
  assign x_8$EN = inp_ready ;

  // register x_9
  always@(reg_mode or m1 or x__h5463)
  begin
    case (reg_mode)
      2'd0: x_9$D_IN = x__h5463;
      2'd1: x_9$D_IN = m1[31:16];
      default: x_9$D_IN = m1[63:48];
    endcase
  end
  assign x_9$EN = inp_ready ;

  // register y_0
  assign y_0$D_IN = (reg_mode == 2'd0) ? x__h6872 : m2[15:0] ;
  assign y_0$EN = inp_ready ;

  // register y_1
  assign y_1$D_IN = (reg_mode == 2'd0) ? x__h6936 : m2[31:16] ;
  assign y_1$EN = inp_ready ;

  // register y_10
  always@(reg_mode or m2 or x__h7000)
  begin
    case (reg_mode)
      2'd0: y_10$D_IN = x__h7000;
      2'd1: y_10$D_IN = m2[47:32];
      default: y_10$D_IN = m2[63:48];
    endcase
  end
  assign y_10$EN = inp_ready ;

  // register y_11
  always@(reg_mode or m2 or x__h7064)
  begin
    case (reg_mode)
      2'd0: y_11$D_IN = x__h7064;
      2'd1: y_11$D_IN = m2[63:48];
      default: y_11$D_IN = m2[47:32];
    endcase
  end
  assign y_11$EN = inp_ready ;

  // register y_12
  always@(reg_mode or m2 or x__h7128)
  begin
    case (reg_mode)
      2'd0: y_12$D_IN = x__h7128;
      2'd1: y_12$D_IN = m2[15:0];
      2'd2: y_12$D_IN = m2[47:32];
      2'd3: y_12$D_IN = m2[31:16];
    endcase
  end
  assign y_12$EN = inp_ready ;

  // register y_13
  always@(reg_mode or m2 or x__h7192)
  begin
    case (reg_mode)
      2'd0: y_13$D_IN = x__h7192;
      2'd1: y_13$D_IN = m2[31:16];
      default: y_13$D_IN = m2[63:48];
    endcase
  end
  assign y_13$EN = inp_ready ;

  // register y_14
  assign y_14$D_IN = (reg_mode == 2'd0) ? x__h7256 : m2[47:32] ;
  assign y_14$EN = inp_ready ;

  // register y_15
  assign y_15$D_IN = (reg_mode == 2'd0) ? x__h7320 : m2[63:48] ;
  assign y_15$EN = inp_ready ;

  // register y_2
  always@(reg_mode or m2 or x__h7000)
  begin
    case (reg_mode)
      2'd0: y_2$D_IN = x__h7000;
      2'd1: y_2$D_IN = m2[47:32];
      default: y_2$D_IN = m2[15:0];
    endcase
  end
  assign y_2$EN = inp_ready ;

  // register y_3
  always@(reg_mode or m2 or x__h7064)
  begin
    case (reg_mode)
      2'd0: y_3$D_IN = x__h7064;
      2'd1: y_3$D_IN = m2[63:48];
      2'd2: y_3$D_IN = m2[31:16];
      2'd3: y_3$D_IN = m2[47:32];
    endcase
  end
  assign y_3$EN = inp_ready ;

  // register y_4
  always@(reg_mode or m2 or x__h7128)
  begin
    case (reg_mode)
      2'd0: y_4$D_IN = x__h7128;
      2'd1: y_4$D_IN = m2[15:0];
      default: y_4$D_IN = m2[31:16];
    endcase
  end
  assign y_4$EN = inp_ready ;

  // register y_5
  always@(reg_mode or m2 or x__h7192)
  begin
    case (reg_mode)
      2'd0: y_5$D_IN = x__h7192;
      2'd1: y_5$D_IN = m2[31:16];
      default: y_5$D_IN = m2[15:0];
    endcase
  end
  assign y_5$EN = inp_ready ;

  // register y_6
  always@(reg_mode or m2 or x__h7256)
  begin
    case (reg_mode)
      2'd0: y_6$D_IN = x__h7256;
      2'd1: y_6$D_IN = m2[47:32];
      2'd2: y_6$D_IN = m2[15:0];
      2'd3: y_6$D_IN = m2[63:48];
    endcase
  end
  assign y_6$EN = inp_ready ;

  // register y_7
  always@(reg_mode or m2 or x__h7320)
  begin
    case (reg_mode)
      2'd0: y_7$D_IN = x__h7320;
      2'd1: y_7$D_IN = m2[63:48];
      2'd2: y_7$D_IN = m2[31:16];
      2'd3: y_7$D_IN = m2[47:32];
    endcase
  end
  assign y_7$EN = inp_ready ;

  // register y_8
  always@(reg_mode or m2 or x__h6872)
  begin
    case (reg_mode)
      2'd0: y_8$D_IN = x__h6872;
      2'd1: y_8$D_IN = m2[15:0];
      2'd2: y_8$D_IN = m2[47:32];
      2'd3: y_8$D_IN = m2[31:16];
    endcase
  end
  assign y_8$EN = inp_ready ;

  // register y_9
  always@(reg_mode or m2 or x__h6936)
  begin
    case (reg_mode)
      2'd0: y_9$D_IN = x__h6936;
      2'd1: y_9$D_IN = m2[31:16];
      2'd2: y_9$D_IN = m2[63:48];
      2'd3: y_9$D_IN = m2[15:0];
    endcase
  end
  assign y_9$EN = inp_ready ;

  // remaining internal signals
  assign NOT_get_values_multiplicand1_EQ_m1_60_61_OR_NO_ETC___d367 =
	     get_values_multiplicand1 != m1 ||
	     get_values_multiplicand2 != m2 ||
	     get_values_addend != a ;
  assign _0_CONCAT_x_0_15_16_MUL_0_CONCAT_y_0_17_18___d119 =
	     x__h15829 * y__h15830 ;
  assign _0_CONCAT_x_10_75_76_MUL_0_CONCAT_y_10_77_78___d179 =
	     x__h16501 * y__h16502 ;
  assign _0_CONCAT_x_11_81_82_MUL_0_CONCAT_y_11_83_84___d185 =
	     x__h16566 * y__h16567 ;
  assign _0_CONCAT_x_12_87_88_MUL_0_CONCAT_y_12_89_90___d191 =
	     x__h16631 * y__h16632 ;
  assign _0_CONCAT_x_13_93_94_MUL_0_CONCAT_y_13_95_96___d197 =
	     x__h16696 * y__h16697 ;
  assign _0_CONCAT_x_14_99_00_MUL_0_CONCAT_y_14_01_02___d203 =
	     x__h16761 * y__h16762 ;
  assign _0_CONCAT_x_15_05_06_MUL_0_CONCAT_y_15_07_08___d209 =
	     x__h16826 * y__h16827 ;
  assign _0_CONCAT_x_1_21_22_MUL_0_CONCAT_y_1_23_24___d125 =
	     x__h15916 * y__h15917 ;
  assign _0_CONCAT_x_2_27_28_MUL_0_CONCAT_y_2_29_30___d131 =
	     x__h15981 * y__h15982 ;
  assign _0_CONCAT_x_3_33_34_MUL_0_CONCAT_y_3_35_36___d137 =
	     x__h16046 * y__h16047 ;
  assign _0_CONCAT_x_4_39_40_MUL_0_CONCAT_y_4_41_42___d143 =
	     x__h16111 * y__h16112 ;
  assign _0_CONCAT_x_5_45_46_MUL_0_CONCAT_y_5_47_48___d149 =
	     x__h16176 * y__h16177 ;
  assign _0_CONCAT_x_6_51_52_MUL_0_CONCAT_y_6_53_54___d155 =
	     x__h16241 * y__h16242 ;
  assign _0_CONCAT_x_7_57_58_MUL_0_CONCAT_y_7_59_60___d161 =
	     x__h16306 * y__h16307 ;
  assign _0_CONCAT_x_8_63_64_MUL_0_CONCAT_y_8_65_66___d167 =
	     x__h16371 * y__h16372 ;
  assign _0_CONCAT_x_9_69_70_MUL_0_CONCAT_y_9_71_72___d173 =
	     x__h16436 * y__h16437 ;
  assign partial_product_3_32_BITS_15_TO_0_79_PLUS_0_CO_ETC___d297 =
	     { partial_product_3[15:0] + y__h18174,
	       partial_product_2[15:0] + y__h18227,
	       partial_product_1[15:0] + y__h18280,
	       partial_product_0[15:0] + y__h18333 } ;
  assign partial_product_5_34_BITS_15_TO_0_71_PLUS_0_CO_ETC___d298 =
	     { partial_product_5[15:0] + y__h18068,
	       partial_product_4[15:0] + y__h18121,
	       partial_product_3_32_BITS_15_TO_0_79_PLUS_0_CO_ETC___d297 } ;
  assign x7294_PLUS_y7295__q1 = x__h17294 + y__h17295 ;
  assign x7384_PLUS_y7385__q2 = x__h17384 + y__h17385 ;
  assign x7564_PLUS_y7565__q3 = x__h17564 + y__h17565 ;
  assign x7633_PLUS_y7634__q5 = x__h17633 + y__h17634 ;
  assign x7700_PLUS_y7701__q4 = x__h17700 + y__h17701 ;
  assign x__h15829 = { 16'd0, x_0 } ;
  assign x__h15916 = { 16'd0, x_1 } ;
  assign x__h15981 = { 16'd0, x_2 } ;
  assign x__h16046 = { 16'd0, x_3 } ;
  assign x__h16111 = { 16'd0, x_4 } ;
  assign x__h16176 = { 16'd0, x_5 } ;
  assign x__h16241 = { 16'd0, x_6 } ;
  assign x__h16306 = { 16'd0, x_7 } ;
  assign x__h16371 = { 16'd0, x_8 } ;
  assign x__h16436 = { 16'd0, x_9 } ;
  assign x__h16501 = { 16'd0, x_10 } ;
  assign x__h16566 = { 16'd0, x_11 } ;
  assign x__h16631 = { 16'd0, x_12 } ;
  assign x__h16696 = { 16'd0, x_13 } ;
  assign x__h16761 = { 16'd0, x_14 } ;
  assign x__h16826 = { 16'd0, x_15 } ;
  assign x__h17294 = { 96'd0, partial_product_1 } ;
  assign x__h17384 = { 96'd0, partial_product_13 } ;
  assign x__h17564 = { 96'd0, partial_product_3 } ;
  assign x__h17633 = { 96'd0, partial_product_10 } ;
  assign x__h17700 = x__h17702 + y__h17703 ;
  assign x__h17702 = x__h17704 + y__h17705 ;
  assign x__h17704 = { 96'd0, partial_product_6 } ;
  assign x__h17920 =
	     { partial_product_7[15:0] + y__h17955,
	       partial_product_6[15:0] + y__h18015,
	       partial_product_5_34_BITS_15_TO_0_71_PLUS_0_CO_ETC___d298 } ;
  assign x__h18412 =
	     { partial_product_3 + y__h18447,
	       partial_product_2 + y__h18484,
	       partial_product_1 + y__h18516,
	       partial_product_0 + y__h18548 } ;
  assign x__h18601 = { x__h18635 + y__h18636, x__h18738 + y__h18739 } ;
  assign x__h18635 = x__h18637 + partial_sum_3[63:0] ;
  assign x__h18637 = x__h18639 + partial_sum_1[63:0] ;
  assign x__h18639 = { 32'd0, partial_product_8 } ;
  assign x__h18738 = x__h18740 + partial_sum_2[63:0] ;
  assign x__h18740 = x__h18742 + partial_sum_0[63:0] ;
  assign x__h18742 = { 32'd0, partial_product_0 } ;
  assign x__h18855 = x__h19064 + y__h18890 ;
  assign x__h19064 = x__h19066 + y__h19067 ;
  assign x__h19066 = x__h19068 + y__h19069 ;
  assign x__h19068 = x__h19070 + y__h19071 ;
  assign x__h19070 = x__h19072 + y__h19073 ;
  assign x__h19072 = x__h19074 + partial_sum_5 ;
  assign x__h19074 = x__h19076 + y__h19077 ;
  assign x__h19076 = x__h19078 + partial_sum_2 ;
  assign x__h19078 = x__h19080 + partial_sum_0 ;
  assign x__h19080 = { 96'd0, partial_product_0 } ;
  assign x__h5399 = { 8'd0, m1[7:0] } ;
  assign x__h5463 = { 8'd0, m1[15:8] } ;
  assign x__h5527 = { 8'd0, m1[23:16] } ;
  assign x__h5591 = { 8'd0, m1[31:24] } ;
  assign x__h5655 = { 8'd0, m1[39:32] } ;
  assign x__h5719 = { 8'd0, m1[47:40] } ;
  assign x__h5783 = { 8'd0, m1[55:48] } ;
  assign x__h5847 = { 8'd0, m1[63:56] } ;
  assign x__h6872 = { 8'd0, m2[7:0] } ;
  assign x__h6936 = { 8'd0, m2[15:8] } ;
  assign x__h7000 = { 8'd0, m2[23:16] } ;
  assign x__h7064 = { 8'd0, m2[31:24] } ;
  assign x__h7128 = { 8'd0, m2[39:32] } ;
  assign x__h7192 = { 8'd0, m2[47:40] } ;
  assign x__h7256 = { 8'd0, m2[55:48] } ;
  assign x__h7320 = { 8'd0, m2[63:56] } ;
  assign y__h15830 = { 16'd0, y_0 } ;
  assign y__h15917 = { 16'd0, y_1 } ;
  assign y__h15982 = { 16'd0, y_2 } ;
  assign y__h16047 = { 16'd0, y_3 } ;
  assign y__h16112 = { 16'd0, y_4 } ;
  assign y__h16177 = { 16'd0, y_5 } ;
  assign y__h16242 = { 16'd0, y_6 } ;
  assign y__h16307 = { 16'd0, y_7 } ;
  assign y__h16372 = { 16'd0, y_8 } ;
  assign y__h16437 = { 16'd0, y_9 } ;
  assign y__h16502 = { 16'd0, y_10 } ;
  assign y__h16567 = { 16'd0, y_11 } ;
  assign y__h16632 = { 16'd0, y_12 } ;
  assign y__h16697 = { 16'd0, y_13 } ;
  assign y__h16762 = { 16'd0, y_14 } ;
  assign y__h16827 = { 16'd0, y_15 } ;
  assign y__h17295 = { 96'd0, partial_product_2 } ;
  assign y__h17385 = { 96'd0, partial_product_14 } ;
  assign y__h17565 = { 96'd0, partial_product_5 } ;
  assign y__h17634 = { 96'd0, partial_product_12 } ;
  assign y__h17701 = { 96'd0, partial_product_9 } ;
  assign y__h17703 = { 96'd0, partial_product_8 } ;
  assign y__h17705 = { 96'd0, partial_product_7 } ;
  assign y__h17955 = { 8'd0, a[63:56] } ;
  assign y__h18015 = { 8'd0, a[55:48] } ;
  assign y__h18068 = { 8'd0, a[47:40] } ;
  assign y__h18121 = { 8'd0, a[39:32] } ;
  assign y__h18174 = { 8'd0, a[31:24] } ;
  assign y__h18227 = { 8'd0, a[23:16] } ;
  assign y__h18280 = { 8'd0, a[15:8] } ;
  assign y__h18333 = { 8'd0, a[7:0] } ;
  assign y__h18447 = { 16'd0, a[63:48] } ;
  assign y__h18484 = { 16'd0, a[47:32] } ;
  assign y__h18516 = { 16'd0, a[31:16] } ;
  assign y__h18548 = { 16'd0, a[15:0] } ;
  assign y__h18636 = { 32'd0, a[63:32] } ;
  assign y__h18739 = { 32'd0, a[31:0] } ;
  assign y__h18890 = { 64'd0, a } ;
  assign y__h19067 = { partial_sum_3[63:0], 64'd0 } ;
  assign y__h19069 = { partial_sum_1[63:0], 64'd0 } ;
  assign y__h19071 = { partial_sum_6[79:0], 48'd0 } ;
  assign y__h19073 = { 32'd0, partial_product_11, 64'd0 } ;
  assign y__h19077 = { partial_sum_4[111:0], 16'd0 } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST == 1)
      begin
        a <= 64'd0;
	counter <= 4'd0;
	flag_0 <= 1'd0;
	flag_1 <= 1'd0;
	flag_2 <= 1'd0;
	flag_3 <= 1'd0;
	flag_4 <= 1'd0;
	inp_ready <= 1'd0;
	m1 <= 64'd0;
	m2 <= 64'd0;
	mac_output <= 128'd0;
	mac_ready <= 1'd0;
	partial_product_0 <= 32'd0;
	partial_product_1 <= 32'd0;
	partial_product_10 <= 32'd0;
	partial_product_11 <= 32'd0;
	partial_product_12 <= 32'd0;
	partial_product_13 <= 32'd0;
	partial_product_14 <= 32'd0;
	partial_product_15 <= 32'd0;
	partial_product_2 <= 32'd0;
	partial_product_3 <= 32'd0;
	partial_product_4 <= 32'd0;
	partial_product_5 <= 32'd0;
	partial_product_6 <= 32'd0;
	partial_product_7 <= 32'd0;
	partial_product_8 <= 32'd0;
	partial_product_9 <= 32'd0;
	partial_sum_0 <= 128'd0;
	partial_sum_1 <= 128'd0;
	partial_sum_2 <= 128'd0;
	partial_sum_3 <= 128'd0;
	partial_sum_4 <= 128'd0;
	partial_sum_5 <= 128'd0;
	partial_sum_6 <= 128'd0;
	reg_mode <= 2'd0;
	x_0 <= 16'd0;
	x_1 <= 16'd0;
	x_10 <= 16'd0;
	x_11 <= 16'd0;
	x_12 <= 16'd0;
	x_13 <= 16'd0;
	x_14 <= 16'd0;
	x_15 <= 16'd0;
	x_2 <= 16'd0;
	x_3 <= 16'd0;
	x_4 <= 16'd0;
	x_5 <= 16'd0;
	x_6 <= 16'd0;
	x_7 <= 16'd0;
	x_8 <= 16'd0;
	x_9 <= 16'd0;
	y_0 <= 16'd0;
	y_1 <= 16'd0;
	y_10 <= 16'd0;
	y_11 <= 16'd0;
	y_12 <= 16'd0;
	y_13 <= 16'd0;
	y_14 <= 16'd0;
	y_15 <= 16'd0;
	y_2 <= 16'd0;
	y_3 <= 16'd0;
	y_4 <= 16'd0;
	y_5 <= 16'd0;
	y_6 <= 16'd0;
	y_7 <= 16'd0;
	y_8 <= 16'd0;
	y_9 <= 16'd0;
      end
    else
      begin
        if (a$EN) a <= a$D_IN;
	if (counter$EN) counter <= counter$D_IN;
	if (flag_0$EN) flag_0 <= flag_0$D_IN;
	if (flag_1$EN) flag_1 <= flag_1$D_IN;
	if (flag_2$EN) flag_2 <= flag_2$D_IN;
	if (flag_3$EN) flag_3 <= flag_3$D_IN;
	if (flag_4$EN) flag_4 <= flag_4$D_IN;
	if (inp_ready$EN) inp_ready <= inp_ready$D_IN;
	if (m1$EN) m1 <= m1$D_IN;
	if (m2$EN) m2 <= m2$D_IN;
	if (mac_output$EN)
	  mac_output <= mac_output$D_IN;
	if (mac_ready$EN) mac_ready <= mac_ready$D_IN;
	if (partial_product_0$EN)
	  partial_product_0 <= partial_product_0$D_IN;
	if (partial_product_1$EN)
	  partial_product_1 <= partial_product_1$D_IN;
	if (partial_product_10$EN)
	  partial_product_10 <= partial_product_10$D_IN;
	if (partial_product_11$EN)
	  partial_product_11 <= partial_product_11$D_IN;
	if (partial_product_12$EN)
	  partial_product_12 <= partial_product_12$D_IN;
	if (partial_product_13$EN)
	  partial_product_13 <= partial_product_13$D_IN;
	if (partial_product_14$EN)
	  partial_product_14 <= partial_product_14$D_IN;
	if (partial_product_15$EN)
	  partial_product_15 <= partial_product_15$D_IN;
	if (partial_product_2$EN)
	  partial_product_2 <= partial_product_2$D_IN;
	if (partial_product_3$EN)
	  partial_product_3 <= partial_product_3$D_IN;
	if (partial_product_4$EN)
	  partial_product_4 <= partial_product_4$D_IN;
	if (partial_product_5$EN)
	  partial_product_5 <= partial_product_5$D_IN;
	if (partial_product_6$EN)
	  partial_product_6 <= partial_product_6$D_IN;
	if (partial_product_7$EN)
	  partial_product_7 <= partial_product_7$D_IN;
	if (partial_product_8$EN)
	  partial_product_8 <= partial_product_8$D_IN;
	if (partial_product_9$EN)
	  partial_product_9 <= partial_product_9$D_IN;
	if (partial_sum_0$EN)
	  partial_sum_0 <= partial_sum_0$D_IN;
	if (partial_sum_1$EN)
	  partial_sum_1 <= partial_sum_1$D_IN;
	if (partial_sum_2$EN)
	  partial_sum_2 <= partial_sum_2$D_IN;
	if (partial_sum_3$EN)
	  partial_sum_3 <= partial_sum_3$D_IN;
	if (partial_sum_4$EN)
	  partial_sum_4 <= partial_sum_4$D_IN;
	if (partial_sum_5$EN)
	  partial_sum_5 <= partial_sum_5$D_IN;
	if (partial_sum_6$EN)
	  partial_sum_6 <= partial_sum_6$D_IN;
	if (reg_mode$EN) reg_mode <= reg_mode$D_IN;
	if (x_0$EN) x_0 <= x_0$D_IN;
	if (x_1$EN) x_1 <= x_1$D_IN;
	if (x_10$EN) x_10 <= x_10$D_IN;
	if (x_11$EN) x_11 <= x_11$D_IN;
	if (x_12$EN) x_12 <= x_12$D_IN;
	if (x_13$EN) x_13 <= x_13$D_IN;
	if (x_14$EN) x_14 <= x_14$D_IN;
	if (x_15$EN) x_15 <= x_15$D_IN;
	if (x_2$EN) x_2 <= x_2$D_IN;
	if (x_3$EN) x_3 <= x_3$D_IN;
	if (x_4$EN) x_4 <= x_4$D_IN;
	if (x_5$EN) x_5 <= x_5$D_IN;
	if (x_6$EN) x_6 <= x_6$D_IN;
	if (x_7$EN) x_7 <= x_7$D_IN;
	if (x_8$EN) x_8 <= x_8$D_IN;
	if (x_9$EN) x_9 <= x_9$D_IN;
	if (y_0$EN) y_0 <= y_0$D_IN;
	if (y_1$EN) y_1 <= y_1$D_IN;
	if (y_10$EN) y_10 <= y_10$D_IN;
	if (y_11$EN) y_11 <= y_11$D_IN;
	if (y_12$EN) y_12 <= y_12$D_IN;
	if (y_13$EN) y_13 <= y_13$D_IN;
	if (y_14$EN) y_14 <= y_14$D_IN;
	if (y_15$EN) y_15 <= y_15$D_IN;
	if (y_2$EN) y_2 <= y_2$D_IN;
	if (y_3$EN) y_3 <= y_3$D_IN;
	if (y_4$EN) y_4 <= y_4$D_IN;
	if (y_5$EN) y_5 <= y_5$D_IN;
	if (y_6$EN) y_6 <= y_6$D_IN;
	if (y_7$EN) y_7 <= y_7$D_IN;
	if (y_8$EN) y_8 <= y_8$D_IN;
	if (y_9$EN) y_9 <= y_9$D_IN;
      end
  end

  // synopsys translate_off
  `ifdef BSV_NO_INITIAL_BLOCKS
  `else // not BSV_NO_INITIAL_BLOCKS
  initial
  begin
    a = 64'hAAAAAAAAAAAAAAAA;
    counter = 4'hA;
    flag_0 = 1'h0;
    flag_1 = 1'h0;
    flag_2 = 1'h0;
    flag_3 = 1'h0;
    flag_4 = 1'h0;
    inp_ready = 1'h0;
    m1 = 64'hAAAAAAAAAAAAAAAA;
    m2 = 64'hAAAAAAAAAAAAAAAA;
    mac_output = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    mac_ready = 1'h0;
    partial_product_0 = 32'hAAAAAAAA;
    partial_product_1 = 32'hAAAAAAAA;
    partial_product_10 = 32'hAAAAAAAA;
    partial_product_11 = 32'hAAAAAAAA;
    partial_product_12 = 32'hAAAAAAAA;
    partial_product_13 = 32'hAAAAAAAA;
    partial_product_14 = 32'hAAAAAAAA;
    partial_product_15 = 32'hAAAAAAAA;
    partial_product_2 = 32'hAAAAAAAA;
    partial_product_3 = 32'hAAAAAAAA;
    partial_product_4 = 32'hAAAAAAAA;
    partial_product_5 = 32'hAAAAAAAA;
    partial_product_6 = 32'hAAAAAAAA;
    partial_product_7 = 32'hAAAAAAAA;
    partial_product_8 = 32'hAAAAAAAA;
    partial_product_9 = 32'hAAAAAAAA;
    partial_sum_0 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    partial_sum_1 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    partial_sum_2 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    partial_sum_3 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    partial_sum_4 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    partial_sum_5 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    partial_sum_6 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    reg_mode = 2'h2;
    x_0 = 16'hAAAA;
    x_1 = 16'hAAAA;
    x_10 = 16'hAAAA;
    x_11 = 16'hAAAA;
    x_12 = 16'hAAAA;
    x_13 = 16'hAAAA;
    x_14 = 16'hAAAA;
    x_15 = 16'hAAAA;
    x_2 = 16'hAAAA;
    x_3 = 16'hAAAA;
    x_4 = 16'hAAAA;
    x_5 = 16'hAAAA;
    x_6 = 16'hAAAA;
    x_7 = 16'hAAAA;
    x_8 = 16'hAAAA;
    x_9 = 16'hAAAA;
    y_0 = 16'hAAAA;
    y_1 = 16'hAAAA;
    y_10 = 16'hAAAA;
    y_11 = 16'hAAAA;
    y_12 = 16'hAAAA;
    y_13 = 16'hAAAA;
    y_14 = 16'hAAAA;
    y_15 = 16'hAAAA;
    y_2 = 16'hAAAA;
    y_3 = 16'hAAAA;
    y_4 = 16'hAAAA;
    y_5 = 16'hAAAA;
    y_6 = 16'hAAAA;
    y_7 = 16'hAAAA;
    y_8 = 16'hAAAA;
    y_9 = 16'hAAAA;
  end
  `endif // BSV_NO_INITIAL_BLOCKS
  // synopsys translate_on
endmodule  // mkMAC

