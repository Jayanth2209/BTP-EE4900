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
  reg [127 : 0] mac_result;
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

  // register flag_3
  reg flag_3;
  wire flag_3$D_IN, flag_3$EN;

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

  // register mac_output_0
  reg [127 : 0] mac_output_0;
  wire [127 : 0] mac_output_0$D_IN;
  wire mac_output_0$EN;

  // register mac_output_1
  reg [127 : 0] mac_output_1;
  wire [127 : 0] mac_output_1$D_IN;
  wire mac_output_1$EN;

  // register mac_output_2
  reg [127 : 0] mac_output_2;
  wire [127 : 0] mac_output_2$D_IN;
  wire mac_output_2$EN;

  // register mac_output_3
  reg [127 : 0] mac_output_3;
  wire [127 : 0] mac_output_3$D_IN;
  wire mac_output_3$EN;

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
  wire [127 : 0] x7334_PLUS_y7335__q1,
		 x7424_PLUS_y7425__q2,
		 x7604_PLUS_y7605__q3,
		 x7673_PLUS_y7674__q5,
		 x7740_PLUS_y7741__q4,
		 x__h17334,
		 x__h17424,
		 x__h17604,
		 x__h17673,
		 x__h17740,
		 x__h17742,
		 x__h17744,
		 x__h18994,
		 x__h18996,
		 x__h18998,
		 x__h19000,
		 x__h19002,
		 x__h19004,
		 x__h19006,
		 x__h19008,
		 x__h19010,
		 y__h17335,
		 y__h17425,
		 y__h17605,
		 y__h17674,
		 y__h17741,
		 y__h17743,
		 y__h17745,
		 y__h18995,
		 y__h18997,
		 y__h18999,
		 y__h19001,
		 y__h19003,
		 y__h19007;
  wire [95 : 0] partial_product_5_27_BITS_15_TO_0_62_PLUS_0_CO_ETC___d289;
  wire [63 : 0] _0_CONCAT_x_0_10_11_MUL_0_CONCAT_y_0_12_13___d114,
		_0_CONCAT_x_10_70_71_MUL_0_CONCAT_y_10_72_73___d174,
		_0_CONCAT_x_11_76_77_MUL_0_CONCAT_y_11_78_79___d180,
		_0_CONCAT_x_12_82_83_MUL_0_CONCAT_y_12_84_85___d186,
		_0_CONCAT_x_13_88_89_MUL_0_CONCAT_y_13_90_91___d192,
		_0_CONCAT_x_14_94_95_MUL_0_CONCAT_y_14_96_97___d198,
		_0_CONCAT_x_15_00_01_MUL_0_CONCAT_y_15_02_03___d204,
		_0_CONCAT_x_1_16_17_MUL_0_CONCAT_y_1_18_19___d120,
		_0_CONCAT_x_2_22_23_MUL_0_CONCAT_y_2_24_25___d126,
		_0_CONCAT_x_3_28_29_MUL_0_CONCAT_y_3_30_31___d132,
		_0_CONCAT_x_4_34_35_MUL_0_CONCAT_y_4_36_37___d138,
		_0_CONCAT_x_5_40_41_MUL_0_CONCAT_y_5_42_43___d144,
		_0_CONCAT_x_6_46_47_MUL_0_CONCAT_y_6_48_49___d150,
		_0_CONCAT_x_7_52_53_MUL_0_CONCAT_y_7_54_55___d156,
		_0_CONCAT_x_8_58_59_MUL_0_CONCAT_y_8_60_61___d162,
		_0_CONCAT_x_9_64_65_MUL_0_CONCAT_y_9_66_67___d168,
		partial_product_3_25_BITS_15_TO_0_70_PLUS_0_CO_ETC___d288,
		x__h18737,
		x__h18739,
		x__h18741,
		x__h18840,
		x__h18842,
		x__h18844,
		y__h18738,
		y__h18841;
  wire [31 : 0] x__h15960,
		x__h16047,
		x__h16112,
		x__h16177,
		x__h16242,
		x__h16307,
		x__h16372,
		x__h16437,
		x__h16502,
		x__h16567,
		x__h16632,
		x__h16697,
		x__h16762,
		x__h16827,
		x__h16892,
		x__h16957,
		y__h15961,
		y__h16048,
		y__h16113,
		y__h16178,
		y__h16243,
		y__h16308,
		y__h16373,
		y__h16438,
		y__h16503,
		y__h16568,
		y__h16633,
		y__h16698,
		y__h16763,
		y__h16828,
		y__h16893,
		y__h16958,
		y__h18546,
		y__h18583,
		y__h18615,
		y__h18647;
  wire [15 : 0] x__h5533,
		x__h5597,
		x__h5661,
		x__h5725,
		x__h5789,
		x__h5853,
		x__h5917,
		x__h5981,
		x__h7006,
		x__h7070,
		x__h7134,
		x__h7198,
		x__h7262,
		x__h7326,
		x__h7390,
		x__h7454,
		y__h18050,
		y__h18110,
		y__h18163,
		y__h18216,
		y__h18269,
		y__h18322,
		y__h18375,
		y__h18428;
  wire NOT_get_values_multiplicand1_EQ_m1_48_49_OR_NO_ETC___d355;

  // action method get_values
  assign RDY_get_values = 1'd1 ;
  assign CAN_FIRE_get_values = 1'd1 ;
  assign WILL_FIRE_get_values = EN_get_values ;

  // value method mac_result
  always@(reg_mode or
	  mac_output_0 or mac_output_1 or mac_output_2 or mac_output_3)
  begin
    case (reg_mode)
      2'd0: mac_result = mac_output_0;
      2'd1: mac_result = mac_output_1;
      2'd2: mac_result = mac_output_2;
      2'd3: mac_result = mac_output_3;
    endcase
  end
  assign RDY_mac_result = mac_ready ;

  // rule RL_compute_MAC
  assign CAN_FIRE_RL_compute_MAC = 1'd1 ;
  assign WILL_FIRE_RL_compute_MAC = 1'd1 ;

  // register a
  assign a$D_IN = get_values_addend ;
  assign a$EN =
	     EN_get_values &&
	     (NOT_get_values_multiplicand1_EQ_m1_48_49_OR_NO_ETC___d355 ||
	      get_values_mode != reg_mode) ;

  // register flag_0
  assign flag_0$D_IN = inp_ready ;
  assign flag_0$EN = 1'd1 ;

  // register flag_1
  assign flag_1$D_IN = flag_0 ;
  assign flag_1$EN = 1'd1 ;

  // register flag_2
  assign flag_2$D_IN = flag_1 ;
  assign flag_2$EN = 1'd1 ;

  // register flag_3
  assign flag_3$D_IN = flag_2 ;
  assign flag_3$EN = 1'd1 ;

  // register inp_ready
  assign inp_ready$D_IN =
	     NOT_get_values_multiplicand1_EQ_m1_48_49_OR_NO_ETC___d355 ||
	     get_values_mode != reg_mode ;
  assign inp_ready$EN = EN_get_values ;

  // register m1
  assign m1$D_IN = get_values_multiplicand1 ;
  assign m1$EN =
	     EN_get_values &&
	     (NOT_get_values_multiplicand1_EQ_m1_48_49_OR_NO_ETC___d355 ||
	      get_values_mode != reg_mode) ;

  // register m2
  assign m2$D_IN = get_values_multiplicand2 ;
  assign m2$EN =
	     EN_get_values &&
	     (NOT_get_values_multiplicand1_EQ_m1_48_49_OR_NO_ETC___d355 ||
	      get_values_mode != reg_mode) ;

  // register mac_output_0
  assign mac_output_0$D_IN =
	     { partial_product_7[15:0] + y__h18050,
	       partial_product_6[15:0] + y__h18110,
	       partial_product_5_27_BITS_15_TO_0_62_PLUS_0_CO_ETC___d289 } ;
  assign mac_output_0$EN = flag_2 ;

  // register mac_output_1
  assign mac_output_1$D_IN =
	     { partial_product_3 + y__h18546,
	       partial_product_2 + y__h18583,
	       partial_product_1 + y__h18615,
	       partial_product_0 + y__h18647 } ;
  assign mac_output_1$EN = flag_2 ;

  // register mac_output_2
  assign mac_output_2$D_IN =
	     { x__h18737 + y__h18738, x__h18840 + y__h18841 } ;
  assign mac_output_2$EN = flag_2 ;

  // register mac_output_3
  assign mac_output_3$D_IN = x__h18994 + y__h18995 ;
  assign mac_output_3$EN = flag_2 ;

  // register mac_ready
  assign mac_ready$D_IN = 1'd1 ;
  assign mac_ready$EN = flag_2 ;

  // register partial_product_0
  assign partial_product_0$D_IN =
	     _0_CONCAT_x_0_10_11_MUL_0_CONCAT_y_0_12_13___d114[31:0] ;
  assign partial_product_0$EN = flag_0 ;

  // register partial_product_1
  assign partial_product_1$D_IN =
	     _0_CONCAT_x_1_16_17_MUL_0_CONCAT_y_1_18_19___d120[31:0] ;
  assign partial_product_1$EN = flag_0 ;

  // register partial_product_10
  assign partial_product_10$D_IN =
	     _0_CONCAT_x_10_70_71_MUL_0_CONCAT_y_10_72_73___d174[31:0] ;
  assign partial_product_10$EN = flag_0 ;

  // register partial_product_11
  assign partial_product_11$D_IN =
	     _0_CONCAT_x_11_76_77_MUL_0_CONCAT_y_11_78_79___d180[31:0] ;
  assign partial_product_11$EN = flag_0 ;

  // register partial_product_12
  assign partial_product_12$D_IN =
	     _0_CONCAT_x_12_82_83_MUL_0_CONCAT_y_12_84_85___d186[31:0] ;
  assign partial_product_12$EN = flag_0 ;

  // register partial_product_13
  assign partial_product_13$D_IN =
	     _0_CONCAT_x_13_88_89_MUL_0_CONCAT_y_13_90_91___d192[31:0] ;
  assign partial_product_13$EN = flag_0 ;

  // register partial_product_14
  assign partial_product_14$D_IN =
	     _0_CONCAT_x_14_94_95_MUL_0_CONCAT_y_14_96_97___d198[31:0] ;
  assign partial_product_14$EN = flag_0 ;

  // register partial_product_15
  assign partial_product_15$D_IN =
	     _0_CONCAT_x_15_00_01_MUL_0_CONCAT_y_15_02_03___d204[31:0] ;
  assign partial_product_15$EN = flag_0 ;

  // register partial_product_2
  assign partial_product_2$D_IN =
	     _0_CONCAT_x_2_22_23_MUL_0_CONCAT_y_2_24_25___d126[31:0] ;
  assign partial_product_2$EN = flag_0 ;

  // register partial_product_3
  assign partial_product_3$D_IN =
	     _0_CONCAT_x_3_28_29_MUL_0_CONCAT_y_3_30_31___d132[31:0] ;
  assign partial_product_3$EN = flag_0 ;

  // register partial_product_4
  assign partial_product_4$D_IN =
	     _0_CONCAT_x_4_34_35_MUL_0_CONCAT_y_4_36_37___d138[31:0] ;
  assign partial_product_4$EN = flag_0 ;

  // register partial_product_5
  assign partial_product_5$D_IN =
	     _0_CONCAT_x_5_40_41_MUL_0_CONCAT_y_5_42_43___d144[31:0] ;
  assign partial_product_5$EN = flag_0 ;

  // register partial_product_6
  assign partial_product_6$D_IN =
	     _0_CONCAT_x_6_46_47_MUL_0_CONCAT_y_6_48_49___d150[31:0] ;
  assign partial_product_6$EN = flag_0 ;

  // register partial_product_7
  assign partial_product_7$D_IN =
	     _0_CONCAT_x_7_52_53_MUL_0_CONCAT_y_7_54_55___d156[31:0] ;
  assign partial_product_7$EN = flag_0 ;

  // register partial_product_8
  assign partial_product_8$D_IN =
	     _0_CONCAT_x_8_58_59_MUL_0_CONCAT_y_8_60_61___d162[31:0] ;
  assign partial_product_8$EN = flag_0 ;

  // register partial_product_9
  assign partial_product_9$D_IN =
	     _0_CONCAT_x_9_64_65_MUL_0_CONCAT_y_9_66_67___d168[31:0] ;
  assign partial_product_9$EN = flag_0 ;

  // register partial_sum_0
  assign partial_sum_0$D_IN = { x7334_PLUS_y7335__q1[111:0], 16'd0 } ;
  assign partial_sum_0$EN = flag_1 ;

  // register partial_sum_1
  assign partial_sum_1$D_IN = { x7424_PLUS_y7425__q2[111:0], 16'd0 } ;
  assign partial_sum_1$EN = flag_1 ;

  // register partial_sum_2
  assign partial_sum_2$D_IN = { 64'd0, partial_product_4, 32'd0 } ;
  assign partial_sum_2$EN = flag_1 ;

  // register partial_sum_3
  assign partial_sum_3$D_IN = { 64'd0, partial_product_15, 32'd0 } ;
  assign partial_sum_3$EN = flag_1 ;

  // register partial_sum_4
  assign partial_sum_4$D_IN = { x7604_PLUS_y7605__q3[111:0], 16'd0 } ;
  assign partial_sum_4$EN = flag_1 ;

  // register partial_sum_5
  assign partial_sum_5$D_IN = { x7740_PLUS_y7741__q4[79:0], 48'd0 } ;
  assign partial_sum_5$EN = flag_1 ;

  // register partial_sum_6
  assign partial_sum_6$D_IN = { x7673_PLUS_y7674__q5[111:0], 16'd0 } ;
  assign partial_sum_6$EN = flag_1 ;

  // register reg_mode
  assign reg_mode$D_IN = get_values_mode ;
  assign reg_mode$EN =
	     EN_get_values &&
	     (NOT_get_values_multiplicand1_EQ_m1_48_49_OR_NO_ETC___d355 ||
	      get_values_mode != reg_mode) ;

  // register x_0
  assign x_0$D_IN = (reg_mode == 2'd0) ? x__h5533 : m1[15:0] ;
  assign x_0$EN = inp_ready ;

  // register x_1
  always@(reg_mode or m1 or x__h5597)
  begin
    case (reg_mode)
      2'd0: x_1$D_IN = x__h5597;
      2'd1: x_1$D_IN = m1[31:16];
      default: x_1$D_IN = m1[15:0];
    endcase
  end
  assign x_1$EN = inp_ready ;

  // register x_10
  always@(reg_mode or m1 or x__h5661)
  begin
    case (reg_mode)
      2'd0: x_10$D_IN = x__h5661;
      2'd1, 2'd2: x_10$D_IN = m1[47:32];
      2'd3: x_10$D_IN = m1[31:16];
    endcase
  end
  assign x_10$EN = inp_ready ;

  // register x_11
  always@(reg_mode or m1 or x__h5725)
  begin
    case (reg_mode)
      2'd0: x_11$D_IN = x__h5725;
      2'd1: x_11$D_IN = m1[63:48];
      default: x_11$D_IN = m1[47:32];
    endcase
  end
  assign x_11$EN = inp_ready ;

  // register x_12
  always@(reg_mode or m1 or x__h5789)
  begin
    case (reg_mode)
      2'd0: x_12$D_IN = x__h5789;
      2'd1: x_12$D_IN = m1[15:0];
      default: x_12$D_IN = m1[63:48];
    endcase
  end
  assign x_12$EN = inp_ready ;

  // register x_13
  always@(reg_mode or m1 or x__h5853)
  begin
    case (reg_mode)
      2'd0: x_13$D_IN = x__h5853;
      2'd1: x_13$D_IN = m1[31:16];
      default: x_13$D_IN = m1[47:32];
    endcase
  end
  assign x_13$EN = inp_ready ;

  // register x_14
  always@(reg_mode or m1 or x__h5917)
  begin
    case (reg_mode)
      2'd0: x_14$D_IN = x__h5917;
      2'd1: x_14$D_IN = m1[47:32];
      default: x_14$D_IN = m1[63:48];
    endcase
  end
  assign x_14$EN = inp_ready ;

  // register x_15
  assign x_15$D_IN = (reg_mode == 2'd0) ? x__h5981 : m1[63:48] ;
  assign x_15$EN = inp_ready ;

  // register x_2
  always@(reg_mode or m1 or x__h5661)
  begin
    case (reg_mode)
      2'd0: x_2$D_IN = x__h5661;
      2'd1: x_2$D_IN = m1[47:32];
      default: x_2$D_IN = m1[31:16];
    endcase
  end
  assign x_2$EN = inp_ready ;

  // register x_3
  always@(reg_mode or m1 or x__h5725)
  begin
    case (reg_mode)
      2'd0: x_3$D_IN = x__h5725;
      2'd1: x_3$D_IN = m1[63:48];
      default: x_3$D_IN = m1[15:0];
    endcase
  end
  assign x_3$EN = inp_ready ;

  // register x_4
  always@(reg_mode or m1 or x__h5789)
  begin
    case (reg_mode)
      2'd0: x_4$D_IN = x__h5789;
      2'd1: x_4$D_IN = m1[15:0];
      default: x_4$D_IN = m1[31:16];
    endcase
  end
  assign x_4$EN = inp_ready ;

  // register x_5
  always@(reg_mode or m1 or x__h5853)
  begin
    case (reg_mode)
      2'd0: x_5$D_IN = x__h5853;
      2'd1, 2'd2: x_5$D_IN = m1[31:16];
      2'd3: x_5$D_IN = m1[47:32];
    endcase
  end
  assign x_5$EN = inp_ready ;

  // register x_6
  always@(reg_mode or m1 or x__h5917)
  begin
    case (reg_mode)
      2'd0: x_6$D_IN = x__h5917;
      2'd1: x_6$D_IN = m1[47:32];
      default: x_6$D_IN = m1[15:0];
    endcase
  end
  assign x_6$EN = inp_ready ;

  // register x_7
  always@(reg_mode or m1 or x__h5981)
  begin
    case (reg_mode)
      2'd0: x_7$D_IN = x__h5981;
      2'd1: x_7$D_IN = m1[63:48];
      default: x_7$D_IN = m1[31:16];
    endcase
  end
  assign x_7$EN = inp_ready ;

  // register x_8
  always@(reg_mode or m1 or x__h5533)
  begin
    case (reg_mode)
      2'd0: x_8$D_IN = x__h5533;
      2'd1: x_8$D_IN = m1[15:0];
      default: x_8$D_IN = m1[47:32];
    endcase
  end
  assign x_8$EN = inp_ready ;

  // register x_9
  always@(reg_mode or m1 or x__h5597)
  begin
    case (reg_mode)
      2'd0: x_9$D_IN = x__h5597;
      2'd1: x_9$D_IN = m1[31:16];
      default: x_9$D_IN = m1[63:48];
    endcase
  end
  assign x_9$EN = inp_ready ;

  // register y_0
  assign y_0$D_IN = (reg_mode == 2'd0) ? x__h7006 : m2[15:0] ;
  assign y_0$EN = inp_ready ;

  // register y_1
  assign y_1$D_IN = (reg_mode == 2'd0) ? x__h7070 : m2[31:16] ;
  assign y_1$EN = inp_ready ;

  // register y_10
  always@(reg_mode or m2 or x__h7134)
  begin
    case (reg_mode)
      2'd0: y_10$D_IN = x__h7134;
      2'd1: y_10$D_IN = m2[47:32];
      default: y_10$D_IN = m2[63:48];
    endcase
  end
  assign y_10$EN = inp_ready ;

  // register y_11
  always@(reg_mode or m2 or x__h7198)
  begin
    case (reg_mode)
      2'd0: y_11$D_IN = x__h7198;
      2'd1: y_11$D_IN = m2[63:48];
      default: y_11$D_IN = m2[47:32];
    endcase
  end
  assign y_11$EN = inp_ready ;

  // register y_12
  always@(reg_mode or m2 or x__h7262)
  begin
    case (reg_mode)
      2'd0: y_12$D_IN = x__h7262;
      2'd1: y_12$D_IN = m2[15:0];
      2'd2: y_12$D_IN = m2[47:32];
      2'd3: y_12$D_IN = m2[31:16];
    endcase
  end
  assign y_12$EN = inp_ready ;

  // register y_13
  always@(reg_mode or m2 or x__h7326)
  begin
    case (reg_mode)
      2'd0: y_13$D_IN = x__h7326;
      2'd1: y_13$D_IN = m2[31:16];
      default: y_13$D_IN = m2[63:48];
    endcase
  end
  assign y_13$EN = inp_ready ;

  // register y_14
  assign y_14$D_IN = (reg_mode == 2'd0) ? x__h7390 : m2[47:32] ;
  assign y_14$EN = inp_ready ;

  // register y_15
  assign y_15$D_IN = (reg_mode == 2'd0) ? x__h7454 : m2[63:48] ;
  assign y_15$EN = inp_ready ;

  // register y_2
  always@(reg_mode or m2 or x__h7134)
  begin
    case (reg_mode)
      2'd0: y_2$D_IN = x__h7134;
      2'd1: y_2$D_IN = m2[47:32];
      default: y_2$D_IN = m2[15:0];
    endcase
  end
  assign y_2$EN = inp_ready ;

  // register y_3
  always@(reg_mode or m2 or x__h7198)
  begin
    case (reg_mode)
      2'd0: y_3$D_IN = x__h7198;
      2'd1: y_3$D_IN = m2[63:48];
      2'd2: y_3$D_IN = m2[31:16];
      2'd3: y_3$D_IN = m2[47:32];
    endcase
  end
  assign y_3$EN = inp_ready ;

  // register y_4
  always@(reg_mode or m2 or x__h7262)
  begin
    case (reg_mode)
      2'd0: y_4$D_IN = x__h7262;
      2'd1: y_4$D_IN = m2[15:0];
      default: y_4$D_IN = m2[31:16];
    endcase
  end
  assign y_4$EN = inp_ready ;

  // register y_5
  always@(reg_mode or m2 or x__h7326)
  begin
    case (reg_mode)
      2'd0: y_5$D_IN = x__h7326;
      2'd1: y_5$D_IN = m2[31:16];
      default: y_5$D_IN = m2[15:0];
    endcase
  end
  assign y_5$EN = inp_ready ;

  // register y_6
  always@(reg_mode or m2 or x__h7390)
  begin
    case (reg_mode)
      2'd0: y_6$D_IN = x__h7390;
      2'd1: y_6$D_IN = m2[47:32];
      2'd2: y_6$D_IN = m2[15:0];
      2'd3: y_6$D_IN = m2[63:48];
    endcase
  end
  assign y_6$EN = inp_ready ;

  // register y_7
  always@(reg_mode or m2 or x__h7454)
  begin
    case (reg_mode)
      2'd0: y_7$D_IN = x__h7454;
      2'd1: y_7$D_IN = m2[63:48];
      2'd2: y_7$D_IN = m2[31:16];
      2'd3: y_7$D_IN = m2[47:32];
    endcase
  end
  assign y_7$EN = inp_ready ;

  // register y_8
  always@(reg_mode or m2 or x__h7006)
  begin
    case (reg_mode)
      2'd0: y_8$D_IN = x__h7006;
      2'd1: y_8$D_IN = m2[15:0];
      2'd2: y_8$D_IN = m2[47:32];
      2'd3: y_8$D_IN = m2[31:16];
    endcase
  end
  assign y_8$EN = inp_ready ;

  // register y_9
  always@(reg_mode or m2 or x__h7070)
  begin
    case (reg_mode)
      2'd0: y_9$D_IN = x__h7070;
      2'd1: y_9$D_IN = m2[31:16];
      2'd2: y_9$D_IN = m2[63:48];
      2'd3: y_9$D_IN = m2[15:0];
    endcase
  end
  assign y_9$EN = inp_ready ;

  // remaining internal signals
  assign NOT_get_values_multiplicand1_EQ_m1_48_49_OR_NO_ETC___d355 =
	     get_values_multiplicand1 != m1 ||
	     get_values_multiplicand2 != m2 ||
	     get_values_addend != a ;
  assign _0_CONCAT_x_0_10_11_MUL_0_CONCAT_y_0_12_13___d114 =
	     x__h15960 * y__h15961 ;
  assign _0_CONCAT_x_10_70_71_MUL_0_CONCAT_y_10_72_73___d174 =
	     x__h16632 * y__h16633 ;
  assign _0_CONCAT_x_11_76_77_MUL_0_CONCAT_y_11_78_79___d180 =
	     x__h16697 * y__h16698 ;
  assign _0_CONCAT_x_12_82_83_MUL_0_CONCAT_y_12_84_85___d186 =
	     x__h16762 * y__h16763 ;
  assign _0_CONCAT_x_13_88_89_MUL_0_CONCAT_y_13_90_91___d192 =
	     x__h16827 * y__h16828 ;
  assign _0_CONCAT_x_14_94_95_MUL_0_CONCAT_y_14_96_97___d198 =
	     x__h16892 * y__h16893 ;
  assign _0_CONCAT_x_15_00_01_MUL_0_CONCAT_y_15_02_03___d204 =
	     x__h16957 * y__h16958 ;
  assign _0_CONCAT_x_1_16_17_MUL_0_CONCAT_y_1_18_19___d120 =
	     x__h16047 * y__h16048 ;
  assign _0_CONCAT_x_2_22_23_MUL_0_CONCAT_y_2_24_25___d126 =
	     x__h16112 * y__h16113 ;
  assign _0_CONCAT_x_3_28_29_MUL_0_CONCAT_y_3_30_31___d132 =
	     x__h16177 * y__h16178 ;
  assign _0_CONCAT_x_4_34_35_MUL_0_CONCAT_y_4_36_37___d138 =
	     x__h16242 * y__h16243 ;
  assign _0_CONCAT_x_5_40_41_MUL_0_CONCAT_y_5_42_43___d144 =
	     x__h16307 * y__h16308 ;
  assign _0_CONCAT_x_6_46_47_MUL_0_CONCAT_y_6_48_49___d150 =
	     x__h16372 * y__h16373 ;
  assign _0_CONCAT_x_7_52_53_MUL_0_CONCAT_y_7_54_55___d156 =
	     x__h16437 * y__h16438 ;
  assign _0_CONCAT_x_8_58_59_MUL_0_CONCAT_y_8_60_61___d162 =
	     x__h16502 * y__h16503 ;
  assign _0_CONCAT_x_9_64_65_MUL_0_CONCAT_y_9_66_67___d168 =
	     x__h16567 * y__h16568 ;
  assign partial_product_3_25_BITS_15_TO_0_70_PLUS_0_CO_ETC___d288 =
	     { partial_product_3[15:0] + y__h18269,
	       partial_product_2[15:0] + y__h18322,
	       partial_product_1[15:0] + y__h18375,
	       partial_product_0[15:0] + y__h18428 } ;
  assign partial_product_5_27_BITS_15_TO_0_62_PLUS_0_CO_ETC___d289 =
	     { partial_product_5[15:0] + y__h18163,
	       partial_product_4[15:0] + y__h18216,
	       partial_product_3_25_BITS_15_TO_0_70_PLUS_0_CO_ETC___d288 } ;
  assign x7334_PLUS_y7335__q1 = x__h17334 + y__h17335 ;
  assign x7424_PLUS_y7425__q2 = x__h17424 + y__h17425 ;
  assign x7604_PLUS_y7605__q3 = x__h17604 + y__h17605 ;
  assign x7673_PLUS_y7674__q5 = x__h17673 + y__h17674 ;
  assign x7740_PLUS_y7741__q4 = x__h17740 + y__h17741 ;
  assign x__h15960 = { 16'd0, x_0 } ;
  assign x__h16047 = { 16'd0, x_1 } ;
  assign x__h16112 = { 16'd0, x_2 } ;
  assign x__h16177 = { 16'd0, x_3 } ;
  assign x__h16242 = { 16'd0, x_4 } ;
  assign x__h16307 = { 16'd0, x_5 } ;
  assign x__h16372 = { 16'd0, x_6 } ;
  assign x__h16437 = { 16'd0, x_7 } ;
  assign x__h16502 = { 16'd0, x_8 } ;
  assign x__h16567 = { 16'd0, x_9 } ;
  assign x__h16632 = { 16'd0, x_10 } ;
  assign x__h16697 = { 16'd0, x_11 } ;
  assign x__h16762 = { 16'd0, x_12 } ;
  assign x__h16827 = { 16'd0, x_13 } ;
  assign x__h16892 = { 16'd0, x_14 } ;
  assign x__h16957 = { 16'd0, x_15 } ;
  assign x__h17334 = { 96'd0, partial_product_1 } ;
  assign x__h17424 = { 96'd0, partial_product_13 } ;
  assign x__h17604 = { 96'd0, partial_product_3 } ;
  assign x__h17673 = { 96'd0, partial_product_10 } ;
  assign x__h17740 = x__h17742 + y__h17743 ;
  assign x__h17742 = x__h17744 + y__h17745 ;
  assign x__h17744 = { 96'd0, partial_product_6 } ;
  assign x__h18737 = x__h18739 + partial_sum_3[63:0] ;
  assign x__h18739 = x__h18741 + partial_sum_1[63:0] ;
  assign x__h18741 = { 32'd0, partial_product_8 } ;
  assign x__h18840 = x__h18842 + partial_sum_2[63:0] ;
  assign x__h18842 = x__h18844 + partial_sum_0[63:0] ;
  assign x__h18844 = { 32'd0, partial_product_0 } ;
  assign x__h18994 = x__h18996 + y__h18997 ;
  assign x__h18996 = x__h18998 + y__h18999 ;
  assign x__h18998 = x__h19000 + y__h19001 ;
  assign x__h19000 = x__h19002 + y__h19003 ;
  assign x__h19002 = x__h19004 + partial_sum_5 ;
  assign x__h19004 = x__h19006 + y__h19007 ;
  assign x__h19006 = x__h19008 + partial_sum_2 ;
  assign x__h19008 = x__h19010 + partial_sum_0 ;
  assign x__h19010 = { 96'd0, partial_product_0 } ;
  assign x__h5533 = { 8'd0, m1[7:0] } ;
  assign x__h5597 = { 8'd0, m1[15:8] } ;
  assign x__h5661 = { 8'd0, m1[23:16] } ;
  assign x__h5725 = { 8'd0, m1[31:24] } ;
  assign x__h5789 = { 8'd0, m1[39:32] } ;
  assign x__h5853 = { 8'd0, m1[47:40] } ;
  assign x__h5917 = { 8'd0, m1[55:48] } ;
  assign x__h5981 = { 8'd0, m1[63:56] } ;
  assign x__h7006 = { 8'd0, m2[7:0] } ;
  assign x__h7070 = { 8'd0, m2[15:8] } ;
  assign x__h7134 = { 8'd0, m2[23:16] } ;
  assign x__h7198 = { 8'd0, m2[31:24] } ;
  assign x__h7262 = { 8'd0, m2[39:32] } ;
  assign x__h7326 = { 8'd0, m2[47:40] } ;
  assign x__h7390 = { 8'd0, m2[55:48] } ;
  assign x__h7454 = { 8'd0, m2[63:56] } ;
  assign y__h15961 = { 16'd0, y_0 } ;
  assign y__h16048 = { 16'd0, y_1 } ;
  assign y__h16113 = { 16'd0, y_2 } ;
  assign y__h16178 = { 16'd0, y_3 } ;
  assign y__h16243 = { 16'd0, y_4 } ;
  assign y__h16308 = { 16'd0, y_5 } ;
  assign y__h16373 = { 16'd0, y_6 } ;
  assign y__h16438 = { 16'd0, y_7 } ;
  assign y__h16503 = { 16'd0, y_8 } ;
  assign y__h16568 = { 16'd0, y_9 } ;
  assign y__h16633 = { 16'd0, y_10 } ;
  assign y__h16698 = { 16'd0, y_11 } ;
  assign y__h16763 = { 16'd0, y_12 } ;
  assign y__h16828 = { 16'd0, y_13 } ;
  assign y__h16893 = { 16'd0, y_14 } ;
  assign y__h16958 = { 16'd0, y_15 } ;
  assign y__h17335 = { 96'd0, partial_product_2 } ;
  assign y__h17425 = { 96'd0, partial_product_14 } ;
  assign y__h17605 = { 96'd0, partial_product_5 } ;
  assign y__h17674 = { 96'd0, partial_product_12 } ;
  assign y__h17741 = { 96'd0, partial_product_9 } ;
  assign y__h17743 = { 96'd0, partial_product_8 } ;
  assign y__h17745 = { 96'd0, partial_product_7 } ;
  assign y__h18050 = { 8'd0, a[63:56] } ;
  assign y__h18110 = { 8'd0, a[55:48] } ;
  assign y__h18163 = { 8'd0, a[47:40] } ;
  assign y__h18216 = { 8'd0, a[39:32] } ;
  assign y__h18269 = { 8'd0, a[31:24] } ;
  assign y__h18322 = { 8'd0, a[23:16] } ;
  assign y__h18375 = { 8'd0, a[15:8] } ;
  assign y__h18428 = { 8'd0, a[7:0] } ;
  assign y__h18546 = { 16'd0, a[63:48] } ;
  assign y__h18583 = { 16'd0, a[47:32] } ;
  assign y__h18615 = { 16'd0, a[31:16] } ;
  assign y__h18647 = { 16'd0, a[15:0] } ;
  assign y__h18738 = { 32'd0, a[63:32] } ;
  assign y__h18841 = { 32'd0, a[31:0] } ;
  assign y__h18995 = { 64'd0, a } ;
  assign y__h18997 = { partial_sum_3[63:0], 64'd0 } ;
  assign y__h18999 = { partial_sum_1[63:0], 64'd0 } ;
  assign y__h19001 = { partial_sum_6[79:0], 48'd0 } ;
  assign y__h19003 = { 32'd0, partial_product_11, 64'd0 } ;
  assign y__h19007 = { partial_sum_4[111:0], 16'd0 } ;

  // handling of inlined registers

  always@(posedge CLK)
  begin
    if (RST == 1)
      begin
        a <= 64'd0;
	flag_0 <= 1'd0;
	flag_1 <= 1'd0;
	flag_2 <= 1'd0;
	flag_3 <= 1'd0;
	inp_ready <= 1'd0;
	m1 <= 64'd0;
	m2 <= 64'd0;
	mac_output_0 <= 128'd0;
	mac_output_1 <= 128'd0;
	mac_output_2 <= 128'd0;
	mac_output_3 <= 128'd0;
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
	if (flag_0$EN) flag_0 <= flag_0$D_IN;
	if (flag_1$EN) flag_1 <= flag_1$D_IN;
	if (flag_2$EN) flag_2 <= flag_2$D_IN;
	if (flag_3$EN) flag_3 <= flag_3$D_IN;
	if (inp_ready$EN) inp_ready <= inp_ready$D_IN;
	if (m1$EN) m1 <= m1$D_IN;
	if (m2$EN) m2 <= m2$D_IN;
	if (mac_output_0$EN)
	  mac_output_0 <= mac_output_0$D_IN;
	if (mac_output_1$EN)
	  mac_output_1 <= mac_output_1$D_IN;
	if (mac_output_2$EN)
	  mac_output_2 <= mac_output_2$D_IN;
	if (mac_output_3$EN)
	  mac_output_3 <= mac_output_3$D_IN;
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
    flag_0 = 1'h0;
    flag_1 = 1'h0;
    flag_2 = 1'h0;
    flag_3 = 1'h0;
    inp_ready = 1'h0;
    m1 = 64'hAAAAAAAAAAAAAAAA;
    m2 = 64'hAAAAAAAAAAAAAAAA;
    mac_output_0 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    mac_output_1 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    mac_output_2 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
    mac_output_3 = 128'hAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA;
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

