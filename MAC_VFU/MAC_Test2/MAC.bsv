package MAC;

import Vector :: *;

interface Ifc_MAC;
    method Action get_values(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend, Bit#(2) mode);
    method Bit#(128) mac_result;
endinterface: Ifc_MAC

(*synthesize*)
module mkMAC(Ifc_MAC);

    // Registers for Inputs
    Reg#(Bit#(64)) m1 <- mkReg(0);
    Reg#(Bit#(64)) m2 <- mkReg(0);
    Reg#(Bit#(64)) a <- mkReg(0);

    // Ready Signal for Inputs
    Reg#(Bool) inp_ready <- mkReg(False);

     // Ready Signal for MAC Result
     Reg#(Bool) mac_ready <- mkReg(False);

     // Intermediate Registers
     // // First Lower Byte Partial Products
     Vector#(8, Reg#(Bit#(16))) p_20_1 <- replicateM(mkReg(0));
     // // First Lower Byte Partial Products
     Vector#(8, Reg#(Bit#(16))) p_21_1 <- replicateM(mkReg(0));
     // // First Lower Byte Partial Products
     Vector#(8, Reg#(Bit#(16))) p_22_1 <- replicateM(mkReg(0));
     // // First Lower Byte Partial Products
     Vector#(8, Reg#(Bit#(16))) p_23_1 <- replicateM(mkReg(0));
     // // First Lower Byte PartialProducts
     Vector#(8, Reg#(Bit#(16))) p_24_1 <- replicateM(mkReg(0));
     // // First Lower Byte Partial Products
     Vector#(8, Reg#(Bit#(16))) p_25_1 <- replicateM(mkReg(0));
     // // First Lower Byte Partial Products
     Vector#(8, Reg#(Bit#(16))) p_26_1 <- replicateM(mkReg(0));
     // // First Lower Byte Partial Products
     Vector#(8, Reg#(Bit#(16))) p_27_1 <- replicateM(mkReg(0));

     // Shifted Partial Products
     Vector#(64, Reg#(Bit#(128))) partial_product <- replicateM(mkReg(0));

     // Register for Partial Product Sums
     Vector#(4, Reg#(Bit#(128))) partials_sum <- replicateM(mkReg(0));

     // Register for Output
     Vector#(4, Reg#(Bit#(128))) mac_output <- replicateM(mkReg(0));

    // Pipeline Flags
    Vector#(4, Reg#(Bit#(1))) flag <- replicateM(mkReg(0));
    
    // Mode of Operation of the VFU
    Reg#(Bit#(2)) reg_mode <- mkReg(0);

    function Action generate_partials(Bit#(64) i_m1, Bit#(64) i_m2, Bool inp_check);
        return
        (action
            if (inp_check == False) flag[0] <= 0;
            else begin
                p_20_1[0] <= extend(i_m1[7:0])*extend(i_m2[7:0]);   // A0B0 << 0    // 16
                
                p_20_1[1] <= extend(i_m1[15:8])*extend(i_m2[7:0]);  // A1B0 << 8    // 24
                p_21_1[0] <= extend(i_m1[7:0])*extend(i_m2[15:8]);  // A0B1 << 8    // 24
                
                p_20_1[2] <= extend(i_m1[23:16])*extend(i_m2[7:0]); // A2B0 << 16   // 32
                p_21_1[1] <= extend(i_m1[15:8])*extend(i_m2[15:8]); // A1B1 << 16   // 32
                p_22_1[0] <= extend(i_m1[7:0])*extend(i_m2[23:16]); // A0B2 << 16   // 32

                p_20_1[3] <= extend(i_m1[31:24])*extend(i_m2[7:0]); // A3B0 << 24   // 40
                p_21_1[2] <= extend(i_m1[23:16])*extend(i_m2[15:8]);    // A2B1 << 24   // 40
                p_22_1[1] <= extend(i_m1[15:8])*extend(i_m2[23:16]);    // A1B2 << 24   // 40
                p_23_1[0] <= extend(i_m1[7:0])*extend(i_m2[31:24]); // A0B3 << 24   // 40

                p_20_1[4] <= extend(i_m1[39:32])*extend(i_m2[7:0]); // A4B0 << 32   // 48
                p_21_1[3] <= extend(i_m1[31:24])*extend(i_m2[15:8]);    // A3B1 << 32   // 48
                p_22_1[2] <= extend(i_m1[23:16])*extend(i_m2[23:16]);   // A2B2 << 32   // 48
                p_23_1[1] <= extend(i_m1[15:8])*extend(i_m2[31:24]);    // A1B3 << 32   // 48
                p_24_1[0] <= extend(i_m1[7:0])*extend(i_m2[39:32]); // A0B4 << 32   // 48

                p_20_1[5] <= extend(i_m1[47:40])*extend(i_m2[7:0]); // A5B0 << 40   // 56
                p_21_1[4] <= extend(i_m1[39:32])*extend(i_m2[15:8]);    // A4B1 << 40   // 56
                p_22_1[3] <= extend(i_m1[31:24])*extend(i_m2[23:16]);   // A3B2 << 40   // 56
                p_23_1[2] <= extend(i_m1[23:16])*extend(i_m2[31:24]);   // A2B3 << 40   // 56
                p_24_1[1] <= extend(i_m1[15:8])*extend(i_m2[39:32]);    // A1B4 << 40   // 56
                p_25_1[0] <= extend(i_m1[7:0])*extend(i_m2[47:40]); // A0B5 << 40   // 56

                p_20_1[6] <= extend(i_m1[55:48])*extend(i_m2[7:0]); // A6B0 << 48   // 64
                p_21_1[5] <= extend(i_m1[47:40])*extend(i_m2[15:8]);    // A5B1 << 48   // 64
                p_22_1[4] <= extend(i_m1[39:32])*extend(i_m2[23:16]);   // A4B2 << 48   // 64
                p_23_1[3] <= extend(i_m1[31:24])*extend(i_m2[31:24]);   // A3B3 << 48   // 64
                p_24_1[2] <= extend(i_m1[23:16])*extend(i_m2[39:32]);   // A2B4 << 48   // 64
                p_25_1[1] <= extend(i_m1[15:8])*extend(i_m2[47:40]);    // A1B5 << 48   // 64
                p_26_1[0] <= extend(i_m1[7:0])*extend(i_m2[55:48]); // A0B6 << 48   // 64
                
                p_20_1[7] <= extend(i_m1[63:56])*extend(i_m2[7:0]); // A7B0 << 56   // 72
                p_21_1[6] <= extend(i_m1[55:48])*extend(i_m2[15:8]);    // A6B1 << 56   // 72
                p_22_1[5] <= extend(i_m1[47:40])*extend(i_m2[23:16]);   // A5B2 << 56   // 72
                p_23_1[4] <= extend(i_m1[39:32])*extend(i_m2[31:24]);   // A4B3 << 56   // 72
                p_24_1[3] <= extend(i_m1[31:24])*extend(i_m2[39:32]);   // A3B4 << 56   // 72
                p_25_1[2] <= extend(i_m1[23:16])*extend(i_m2[47:40]);   // A2B5 << 56   // 72
                p_26_1[1] <= extend(i_m1[15:8])*extend(i_m2[55:48]);    // A1B6 << 56   // 72
                p_27_1[0] <= extend(i_m1[7:0])*extend(i_m2[63:56]); // A0B7 << 56   // 72

                p_21_1[7] <= extend(i_m1[63:56])*extend(i_m2[15:8]);    // A7B1 << 64   // 80
                p_22_1[6] <= extend(i_m1[55:48])*extend(i_m2[23:16]);   // A6B2 << 64   // 80
                p_23_1[5] <= extend(i_m1[47:40])*extend(i_m2[31:24]);   // A5B3 << 64   // 80
                p_24_1[4] <= extend(i_m1[39:32])*extend(i_m2[39:32]);   // A4B4 << 64   // 80
                p_25_1[3] <= extend(i_m1[31:24])*extend(i_m2[47:40]);   // A3B5 << 64   // 80
                p_26_1[2] <= extend(i_m1[23:16])*extend(i_m2[55:48]);   // A2B6 << 64   // 80
                p_27_1[1] <= extend(i_m1[15:8])*extend(i_m2[63:56]);    // A1B7 << 64   // 80

                p_22_1[7] <= extend(i_m1[63:56])*extend(i_m2[23:16]);   // A7B2 << 72   // 88
                p_23_1[6] <= extend(i_m1[55:48])*extend(i_m2[31:24]);   // A6B3 << 72   // 88
                p_24_1[5] <= extend(i_m1[47:40])*extend(i_m2[39:32]);   // A5B4 << 72   // 88
                p_25_1[4] <= extend(i_m1[39:32])*extend(i_m2[47:40]);   // A4B5 << 72   // 88
                p_26_1[3] <= extend(i_m1[31:24])*extend(i_m2[55:48]);   // A3B6 << 72   // 88
                p_27_1[2] <= extend(i_m1[23:16])*extend(i_m2[63:56]);   // A2B7 << 72   // 88

                p_23_1[7] <= extend(i_m1[63:56])*extend(i_m2[31:24]);   // A7B3 << 80   // 96
                p_24_1[6] <= extend(i_m1[55:48])*extend(i_m2[39:32]);   // A6B4 << 80   // 96
                p_25_1[5] <= extend(i_m1[47:40])*extend(i_m2[47:40]);   // A5B5 << 80   // 96
                p_26_1[4] <= extend(i_m1[39:32])*extend(i_m2[55:48]);   // A4B6 << 80   // 96
                p_27_1[3] <= extend(i_m1[31:24])*extend(i_m2[63:56]);   // A3B7 << 80   // 96

                p_24_1[7] <= extend(i_m1[63:56])*extend(i_m2[39:32]);   // A7B4 << 88   // 104
                p_25_1[6] <= extend(i_m1[55:48])*extend(i_m2[47:40]);   // A6B5 << 88   // 104
                p_26_1[5] <= extend(i_m1[47:40])*extend(i_m2[55:48]);   // A5B6 << 88   // 104
                p_27_1[4] <= extend(i_m1[39:32])*extend(i_m2[63:56]);   // A4B7 << 88   // 104

                p_25_1[7] <= extend(i_m1[63:56])*extend(i_m2[47:40]);   // A7B5 << 96   // 112
                p_26_1[6] <= extend(i_m1[55:48])*extend(i_m2[55:48]);   // A6B6 << 96   // 112
                p_27_1[5] <= extend(i_m1[47:40])*extend(i_m2[63:56]);   // A5B7 << 96   // 112

                p_26_1[7] <= extend(i_m1[63:56])*extend(i_m2[55:48]);   // A7B6 << 104  // 120
                p_27_1[6] <= extend(i_m1[55:48])*extend(i_m2[63:56]);   // A6B7 << 104  // 120

                p_27_1[7] <= extend(i_m1[63:56])*extend(i_m2[63:56]);   // A7B7 << 112  // 128
                
                flag[0] <= 1;
            end
        endaction);
    endfunction

    function Action shift_partials(Bit#(1) partials_check);
        return
        (action
            if (partials_check == 0) flag[1] <= 0;
            else begin
                partial_product[0] <= extend(p_20_1[0]);   // A0B0 << 0    // 16
                
                partial_product[1] <= extend(p_21_1[0]) << 8;  // A0B1 << 8    // 24
                partial_product[2] <= extend(p_20_1[1]) << 8;  // A1B0 << 8    // 24

                partial_product[3] <= extend(p_21_1[1]) << 16; // A1B1 << 16   // 32
                
                partial_product[4] <= extend(p_22_1[0]) << 16; // A0B2 << 16   // 32
                partial_product[5] <= extend(p_20_1[2]) << 16; // A2B0 << 16   // 32

                partial_product[6] <= extend(p_22_1[1]) << 24;    // A1B2 << 24   // 40
                partial_product[7] <= extend(p_21_1[2]) << 24;    // A2B1 << 24   // 40
                partial_product[8] <= extend(p_23_1[0]) << 24; // A0B3 << 24   // 40
                partial_product[9] <= extend(p_20_1[3]) << 24; // A3B0 << 24   // 40

                partial_product[10] <= extend(p_22_1[2]) << 32;   // A2B2 << 32   // 48
                partial_product[11] <= extend(p_23_1[1]) << 32;    // A1B3 << 32   // 48
                partial_product[12] <= extend(p_21_1[3]) << 32;    // A3B1 << 32   // 48
                partial_product[13] <= extend(p_24_1[0]) << 32; // A0B4 << 32   // 48
                partial_product[14] <= extend(p_20_1[4]) << 32; // A4B0 << 32   // 48

                partial_product[15] <= extend(p_23_1[2]) << 40;   // A2B3 << 40   // 56
                partial_product[16] <= extend(p_22_1[3]) << 40;   // A3B2 << 40   // 56
                partial_product[17] <= extend(p_24_1[1]) << 40;    // A1B4 << 40   // 56
                partial_product[18] <= extend(p_21_1[4]) << 40;    // A4B1 << 40   // 56
                partial_product[19] <= extend(p_25_1[0]) << 40; // A0B5 << 40   // 56
                partial_product[20] <= extend(p_20_1[5]) << 40; // A5B0 << 40   // 56

                partial_product[21] <= extend(p_23_1[3]) << 48;   // A3B3 << 48   // 64
                partial_product[22] <= extend(p_24_1[2]) << 48;   // A2B4 << 48   // 64
                partial_product[23] <= extend(p_22_1[4]) << 48;   // A4B2 << 48   // 64
                partial_product[24] <= extend(p_25_1[1]) << 48;    // A1B5 << 48   // 64
                partial_product[25] <= extend(p_21_1[5]) << 48;    // A5B1 << 48   // 64
                partial_product[26] <= extend(p_26_1[0]) << 48; // A0B6 << 48   // 64
                partial_product[27] <= extend(p_20_1[6]) << 48; // A6B0 << 48   // 64
                
                partial_product[28] <= extend(p_24_1[3]) << 56;   // A3B4 << 56   // 72
                partial_product[29] <= extend(p_23_1[4]) << 56;   // A4B3 << 56   // 72
                partial_product[30] <= extend(p_25_1[2]) << 56;   // A2B5 << 56   // 72
                partial_product[31] <= extend(p_22_1[5]) << 56;   // A5B2 << 56   // 72
                partial_product[32] <= extend(p_26_1[1]) << 56;    // A1B6 << 56   // 72
                partial_product[33] <= extend(p_21_1[6]) << 56;    // A6B1 << 56   // 72
                partial_product[34] <= extend(p_27_1[0]) << 56; // A0B7 << 56   // 72
                partial_product[35] <= extend(p_20_1[7]) << 56; // A7B0 << 56   // 72

                partial_product[36] <= extend(p_24_1[4]) << 64;   // A4B4 << 64   // 80
                partial_product[37] <= extend(p_25_1[3]) << 64;   // A3B5 << 64   // 80
                partial_product[38] <= extend(p_23_1[5]) << 64;   // A5B3 << 64   // 80
                partial_product[39] <= extend(p_26_1[2]) << 64;   // A2B6 << 64   // 80
                partial_product[40] <= extend(p_22_1[6]) << 64;   // A6B2 << 64   // 80
                partial_product[41] <= extend(p_27_1[1]) << 64;    // A1B7 << 64   // 80
                partial_product[42] <= extend(p_21_1[7]) << 64;    // A7B1 << 64   // 80

                partial_product[43] <= extend(p_25_1[4]) << 72;   // A4B5 << 72   // 88
                partial_product[44] <= extend(p_24_1[5]) << 72;   // A5B4 << 72   // 88
                partial_product[45] <= extend(p_26_1[3]) << 72;   // A3B6 << 72   // 88
                partial_product[46] <= extend(p_23_1[6]) << 72;   // A6B3 << 72   // 88
                partial_product[47] <= extend(p_27_1[2]) << 72;   // A2B7 << 72   // 88
                partial_product[48] <= extend(p_22_1[7]) << 72;   // A7B2 << 72   // 88

                partial_product[49] <= extend(p_25_1[5]) << 80;   // A5B5 << 80   // 96
                partial_product[50] <= extend(p_26_1[4]) << 80;   // A4B6 << 80   // 96
                partial_product[51] <= extend(p_24_1[6]) << 80;   // A6B4 << 80   // 96
                partial_product[52] <= extend(p_27_1[3]) << 80;   // A3B7 << 80   // 96
                partial_product[53] <= extend(p_23_1[7]) << 80;   // A7B3 << 80   // 96

                partial_product[54] <= extend(p_26_1[5]) << 88;   // A5B6 << 88   // 104
                partial_product[55] <= extend(p_25_1[6]) << 88;   // A6B5 << 88   // 104
                partial_product[56] <= extend(p_27_1[4]) << 88;   // A4B7 << 88   // 104
                partial_product[57] <= extend(p_24_1[7]) << 88;   // A7B4 << 88   // 104

                partial_product[58] <= extend(p_26_1[6]) << 96;   // A6B6 << 96   // 112
                partial_product[59] <= extend(p_27_1[5]) << 96;   // A5B7 << 96   // 112
                partial_product[60] <= extend(p_25_1[7]) << 96;   // A7B5 << 96   // 112

                partial_product[61] <= extend(p_27_1[6]) << 104;   // A6B7 << 104  // 120
                partial_product[62] <= extend(p_26_1[7]) << 104;   // A7B6 << 104  // 120

                partial_product[63] <= extend(p_27_1[7]) << 112;   // A7B7 << 112  // 128

                flag[1] <= 1;
            end
        endaction);
    endfunction

    function Action add_partials(Bit#(1) shift_check);
        return
        (action
            if (shift_check == 0) flag[2] <= 0;
            else begin
                partials_sum[0] <= partial_product[0];
                partials_sum[1] <= partial_product[1] + partial_product[2] + partial_product[3];
                partials_sum[2] <= partial_product[4] + partial_product[5] + 
                                   partial_product[6] + partial_product[7] + 
                                   partial_product[8] + partial_product[9] + 
                                   partial_product[10] + partial_product[11] + partial_product[12] + 
                                   partial_product[15] + partial_product[16] + 
                                   partial_product[21];
                partials_sum[3] <= partial_product[13] + partial_product[14] + 
                                   partial_product[17] + partial_product[18] + 
                                   partial_product[19] + partial_product[20] + 
                                   partial_product[22] + partial_product[23] + 
                                   partial_product[24] + partial_product[25] + 
                                   partial_product[26] + partial_product[27] +
                                   partial_product[28] + partial_product[29] + partial_product[30] + partial_product[31] +
                                   partial_product[32] + partial_product[33] + partial_product[34] + partial_product[35] +
                                   partial_product[36] + partial_product[37] + partial_product[38] +
                                   partial_product[39] + partial_product[40] + partial_product[41] +
                                   partial_product[42] + partial_product[43] + partial_product[44] +
                                   partial_product[45] + partial_product[46] + partial_product[47] +
                                   partial_product[48] + partial_product[49] + partial_product[50] +
                                   partial_product[51] + partial_product[52] + partial_product[53] +
                                   partial_product[54] + partial_product[55] +
                                   partial_product[56] + partial_product[57] +
                                   partial_product[58] + partial_product[59] +
                                   partial_product[60] + partial_product[61] +
                                   partial_product[62] + partial_product[63];
                flag[2] <= 1;
            end
        endaction);
    endfunction

    function Action macs(Bit#(64) i_a, Bit#(1) add_partials_check);
        return
        (action
            if (add_partials_check == 0) flag[3] <= 0;
            else begin
                mac_output[0] <= partials_sum[0] + extend(i_a);
                mac_output[1] <= partials_sum[0] + partials_sum[1] + extend(i_a);
                mac_output[2] <= partials_sum[0] + partials_sum[1] + partials_sum[2] + extend(i_a);
                mac_output[3] <= partials_sum[0] + partials_sum[1] + partials_sum[2] + partials_sum[3] + extend(i_a);
                flag[3] <= 1;
                mac_ready <= True;
            end
        endaction);
    endfunction

    rule compute_MAC;
        generate_partials(m1, m2, inp_ready);
        shift_partials(flag[0]);
        add_partials(flag[1]);
        macs(a, flag[2]);
    endrule: compute_MAC

    method Action get_values(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend, Bit#(2) mode);
    if (multiplicand1 != m1 || multiplicand2 != m2 || addend != a || mode != reg_mode)
    begin
        m1 <= multiplicand1;
        m2 <= multiplicand2;
        a <= addend;
        reg_mode <= mode;
        inp_ready <= True;
    end
    else
        inp_ready <= False;
    endmethod

    method Bit#(128) mac_result if (mac_ready);
        Bit#(128) final_mac_result = 0;
        case (reg_mode)
            0: final_mac_result = {mac_output[0][15:0], mac_output[0][15:0], mac_output[0][15:0], mac_output[0][15:0], mac_output[0][15:0], mac_output[0][15:0], mac_output[0][15:0], mac_output[0][15:0]};
            1: final_mac_result = {mac_output[1][31:0], mac_output[1][31:0], mac_output[1][31:0], mac_output[1][31:0]};
            2: final_mac_result = {mac_output[2][63:0], mac_output[2][63:0]};
            3: final_mac_result = mac_output[3];
            default: final_mac_result = mac_output[3];
        endcase
        return final_mac_result;
    endmethod

endmodule
                
endpackage : MAC
    