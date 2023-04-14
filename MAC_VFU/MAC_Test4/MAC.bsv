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
    Vector#(8, Reg#(Bit#(16))) b0a <- replicateM(mkReg(0));
    // // First Lower Byte Partial Products
    Vector#(8, Reg#(Bit#(16))) b1a <- replicateM(mkReg(0));
    // // First Lower Byte Partial Products
    Vector#(8, Reg#(Bit#(16))) b2a <- replicateM(mkReg(0));
    // // First Lower Byte Partial Products
    Vector#(8, Reg#(Bit#(16))) b3a <- replicateM(mkReg(0));
    // // First Lower Byte PartialProducts
    Vector#(8, Reg#(Bit#(16))) b4a <- replicateM(mkReg(0));
    // // First Lower Byte Partial Products
    Vector#(8, Reg#(Bit#(16))) b5a <- replicateM(mkReg(0));
    // // First Lower Byte Partial Products
    Vector#(8, Reg#(Bit#(16))) b6a <- replicateM(mkReg(0));
    // // First Lower Byte Partial Products
    Vector#(8, Reg#(Bit#(16))) b7a <- replicateM(mkReg(0));

    // Shifted Partial Products
    Vector#(24, Reg#(Bit#(128))) partial_sum <- replicateM(mkReg(0));

    // Register for 16x16 Product
    Vector#(4, Reg#(Bit#(32))) product16 <- replicateM(mkReg(0));

    // Register for 32x32 Product
    Vector#(2, Reg#(Bit#(64))) product32 <- replicateM(mkReg(0));

    // Register for 16x16 Product
    Reg#(Bit#(128)) product64 <- mkReg(0);

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
                b0a[0] <= extend(i_m1[7:0])*extend(i_m2[7:0]);   // A0B0 << 0    // 16
                
                b0a[1] <= extend(i_m1[15:8])*extend(i_m2[7:0]);  // A1B0 << 8    // 24
                b1a[0] <= extend(i_m1[7:0])*extend(i_m2[15:8]);  // A0B1 << 8    // 24
                
                b0a[2] <= extend(i_m1[23:16])*extend(i_m2[7:0]); // A2B0 << 16   // 32
                b1a[1] <= extend(i_m1[15:8])*extend(i_m2[15:8]); // A1B1 << 16   // 32
                b2a[0] <= extend(i_m1[7:0])*extend(i_m2[23:16]); // A0B2 << 16   // 32

                b0a[3] <= extend(i_m1[31:24])*extend(i_m2[7:0]); // A3B0 << 24   // 40
                b1a[2] <= extend(i_m1[23:16])*extend(i_m2[15:8]);    // A2B1 << 24   // 40
                b2a[1] <= extend(i_m1[15:8])*extend(i_m2[23:16]);    // A1B2 << 24   // 40
                b3a[0] <= extend(i_m1[7:0])*extend(i_m2[31:24]); // A0B3 << 24   // 40

                b0a[4] <= extend(i_m1[39:32])*extend(i_m2[7:0]); // A4B0 << 32   // 48
                b1a[3] <= extend(i_m1[31:24])*extend(i_m2[15:8]);    // A3B1 << 32   // 48
                b2a[2] <= extend(i_m1[23:16])*extend(i_m2[23:16]);   // A2B2 << 32   // 48
                b3a[1] <= extend(i_m1[15:8])*extend(i_m2[31:24]);    // A1B3 << 32   // 48
                b4a[0] <= extend(i_m1[7:0])*extend(i_m2[39:32]); // A0B4 << 32   // 48

                b0a[5] <= extend(i_m1[47:40])*extend(i_m2[7:0]); // A5B0 << 40   // 56
                b1a[4] <= extend(i_m1[39:32])*extend(i_m2[15:8]);    // A4B1 << 40   // 56
                b2a[3] <= extend(i_m1[31:24])*extend(i_m2[23:16]);   // A3B2 << 40   // 56
                b3a[2] <= extend(i_m1[23:16])*extend(i_m2[31:24]);   // A2B3 << 40   // 56
                b4a[1] <= extend(i_m1[15:8])*extend(i_m2[39:32]);    // A1B4 << 40   // 56
                b5a[0] <= extend(i_m1[7:0])*extend(i_m2[47:40]); // A0B5 << 40   // 56

                b0a[6] <= extend(i_m1[55:48])*extend(i_m2[7:0]); // A6B0 << 48   // 64
                b1a[5] <= extend(i_m1[47:40])*extend(i_m2[15:8]);    // A5B1 << 48   // 64
                b2a[4] <= extend(i_m1[39:32])*extend(i_m2[23:16]);   // A4B2 << 48   // 64
                b3a[3] <= extend(i_m1[31:24])*extend(i_m2[31:24]);   // A3B3 << 48   // 64
                b4a[2] <= extend(i_m1[23:16])*extend(i_m2[39:32]);   // A2B4 << 48   // 64
                b5a[1] <= extend(i_m1[15:8])*extend(i_m2[47:40]);    // A1B5 << 48   // 64
                b6a[0] <= extend(i_m1[7:0])*extend(i_m2[55:48]); // A0B6 << 48   // 64
                
                b0a[7] <= extend(i_m1[63:56])*extend(i_m2[7:0]); // A7B0 << 56   // 72
                b1a[6] <= extend(i_m1[55:48])*extend(i_m2[15:8]);    // A6B1 << 56   // 72
                b2a[5] <= extend(i_m1[47:40])*extend(i_m2[23:16]);   // A5B2 << 56   // 72
                b3a[4] <= extend(i_m1[39:32])*extend(i_m2[31:24]);   // A4B3 << 56   // 72
                b4a[3] <= extend(i_m1[31:24])*extend(i_m2[39:32]);   // A3B4 << 56   // 72
                b5a[2] <= extend(i_m1[23:16])*extend(i_m2[47:40]);   // A2B5 << 56   // 72
                b6a[1] <= extend(i_m1[15:8])*extend(i_m2[55:48]);    // A1B6 << 56   // 72
                b7a[0] <= extend(i_m1[7:0])*extend(i_m2[63:56]); // A0B7 << 56   // 72

                b1a[7] <= extend(i_m1[63:56])*extend(i_m2[15:8]);    // A7B1 << 64   // 80
                b2a[6] <= extend(i_m1[55:48])*extend(i_m2[23:16]);   // A6B2 << 64   // 80
                b3a[5] <= extend(i_m1[47:40])*extend(i_m2[31:24]);   // A5B3 << 64   // 80
                b4a[4] <= extend(i_m1[39:32])*extend(i_m2[39:32]);   // A4B4 << 64   // 80
                b5a[3] <= extend(i_m1[31:24])*extend(i_m2[47:40]);   // A3B5 << 64   // 80
                b6a[2] <= extend(i_m1[23:16])*extend(i_m2[55:48]);   // A2B6 << 64   // 80
                b7a[1] <= extend(i_m1[15:8])*extend(i_m2[63:56]);    // A1B7 << 64   // 80

                b2a[7] <= extend(i_m1[63:56])*extend(i_m2[23:16]);   // A7B2 << 72   // 88
                b3a[6] <= extend(i_m1[55:48])*extend(i_m2[31:24]);   // A6B3 << 72   // 88
                b4a[5] <= extend(i_m1[47:40])*extend(i_m2[39:32]);   // A5B4 << 72   // 88
                b5a[4] <= extend(i_m1[39:32])*extend(i_m2[47:40]);   // A4B5 << 72   // 88
                b6a[3] <= extend(i_m1[31:24])*extend(i_m2[55:48]);   // A3B6 << 72   // 88
                b7a[2] <= extend(i_m1[23:16])*extend(i_m2[63:56]);   // A2B7 << 72   // 88

                b3a[7] <= extend(i_m1[63:56])*extend(i_m2[31:24]);   // A7B3 << 80   // 96
                b4a[6] <= extend(i_m1[55:48])*extend(i_m2[39:32]);   // A6B4 << 80   // 96
                b5a[5] <= extend(i_m1[47:40])*extend(i_m2[47:40]);   // A5B5 << 80   // 96
                b6a[4] <= extend(i_m1[39:32])*extend(i_m2[55:48]);   // A4B6 << 80   // 96
                b7a[3] <= extend(i_m1[31:24])*extend(i_m2[63:56]);   // A3B7 << 80   // 96

                b4a[7] <= extend(i_m1[63:56])*extend(i_m2[39:32]);   // A7B4 << 88   // 104
                b5a[6] <= extend(i_m1[55:48])*extend(i_m2[47:40]);   // A6B5 << 88   // 104
                b6a[5] <= extend(i_m1[47:40])*extend(i_m2[55:48]);   // A5B6 << 88   // 104
                b7a[4] <= extend(i_m1[39:32])*extend(i_m2[63:56]);   // A4B7 << 88   // 104

                b5a[7] <= extend(i_m1[63:56])*extend(i_m2[47:40]);   // A7B5 << 96   // 112
                b6a[6] <= extend(i_m1[55:48])*extend(i_m2[55:48]);   // A6B6 << 96   // 112
                b7a[5] <= extend(i_m1[47:40])*extend(i_m2[63:56]);   // A5B7 << 96   // 112

                b6a[7] <= extend(i_m1[63:56])*extend(i_m2[55:48]);   // A7B6 << 104  // 120
                b7a[6] <= extend(i_m1[55:48])*extend(i_m2[63:56]);   // A6B7 << 104  // 120

                b7a[7] <= extend(i_m1[63:56])*extend(i_m2[63:56]);   // A7B7 << 112  // 128
                
                flag[0] <= 1;
            end
        endaction);
    endfunction

    function Action shift_add_partials(Bit#(1) generate_partials_check);
        return
        (action
            if (generate_partials_check == 0) flag[1] <= 0;
            else begin
                partial_sum[0] <= ((extend(b1a[0]) + extend(b0a[1])) << 8); // A0B1 + A1B0 << 8
                partial_sum[1] <= ((extend(b3a[2]) + extend(b2a[3])) << 8); // A2B3 + A3B2 << 8
                partial_sum[2] <= ((extend(b5a[4]) + extend(b4a[5])) << 8); // A4B5 + A5B4 << 8
                partial_sum[3] <= ((extend(b7a[6]) + extend(b6a[7])) << 8); // A6B7 + A7B6 << 8

                partial_sum[4] <= (extend(b1a[1]) << 16);   // A1B1 << 16
                partial_sum[5] <= (extend(b3a[3]) << 16);   // A3B3 << 16
                partial_sum[6] <= (extend(b5a[5]) << 16);   // A5B5 << 16
                partial_sum[7] <= (extend(b7a[7]) << 16);   // A7B7 << 16

                partial_sum[8] <= ((extend(b2a[0]) + extend(b0a[2])) << 16);    // A0B2 + A2B0 << 16
                partial_sum[9] <= ((extend(b6a[4]) + extend(b4a[6])) << 16);    // A4B6 + A6B4 << 16

                partial_sum[10] <= ((extend(b3a[0]) + extend(b2a[1]) + extend(b1a[2]) + extend(b0a[3])) << 24);  // A0B3 + A1B2 + A2B1 + A3B0 << 24		
                partial_sum[11] <= ((extend(b7a[4]) + extend(b6a[5]) + extend(b5a[6]) + extend(b4a[7])) << 24);  // A4B7 + A5B6 + A6B5 + A7B4 << 24		

                partial_sum[12] <= ((extend(b3a[1]) + extend(b1a[3])) << 32); // A1B3 + A3B1 << 32		
                partial_sum[13] <= ((extend(b4a[0]) + extend(b0a[4])) << 32);   // A0B4 + A4B0 << 32 
                partial_sum[14] <= ((extend(b7a[5]) + extend(b5a[7])) << 32);   // A5B7 + A7B5 << 32

                partial_sum[15] <= ((extend(b5a[0]) + extend(b4a[1]) + extend(b1a[4]) + extend(b0a[5])) << 40); // A0B5 + A1B4 + A4B1 + A5B0 << 40		

                
                partial_sum[16] <= ((extend(b6a[0]) + extend(b5a[1]) + extend(b4a[2]) + extend(b2a[4]) + extend(b1a[5]) + extend(b0a[6])) << 48);   // A0B6 + A1B5 + A2B4 + A4B2 + A5B1 + A6B0 << 48	

                partial_sum[17] <= ((extend(b7a[0]) + extend(b6a[1]) + extend(b5a[2]) + extend(b4a[3]) + extend(b3a[4]) + extend(b2a[5]) + extend(b1a[6]) + extend(b0a[7])) << 56); // A0B7 + A1B6 + A2B5 + A3B4 + A4B3 + A5B2 + A6B1 + A7B0 << 56		

                partial_sum[18] <= ((extend(b7a[1]) + extend(b6a[2]) + extend(b5a[3]) + extend(b3a[5]) + extend(b2a[6]) + extend(b1a[7])) << 64);   // A1B7 + A2B6 + A3B5 + A5B3 + A6B2 + A7B1 << 64		

                partial_sum[19] <= ((extend(b7a[2]) + extend(b6a[3]) + extend(b3a[6]) + extend(b2a[7])) << 72); // A2B7 + A3B6 + A6B3 + A7B2 << 72		

                partial_sum[20] <= ((extend(b7a[3]) + extend(b3a[7])) << 80);   // A3B7 + A7B3 << 80	
                
                partial_sum[21] <= (extend(b2a[2]) << 32);  // A2B2 << 32
                partial_sum[22] <= (extend(b4a[4]) << 64);  // A4B4 << 64
                partial_sum[23] <= (extend(b6a[6]) << 32);  // A6B6 << 32

                flag[1] <= 1;
            end
        endaction);
    endfunction

    function Action sum_partials(Bit#(1) shift_add_partials_check);
        return
        (action
            if (shift_add_partials_check == 0) flag[2] <= 0;
            else begin
                product16[0] <= extend(b0a[0]) + partial_sum[0][31:0] + partial_sum[4][31:0];
                product16[1] <= extend(b2a[2]) + partial_sum[1][31:0] + partial_sum[5][31:0];
                product16[2] <= extend(b4a[4]) + partial_sum[2][31:0] + partial_sum[6][31:0];
                product16[3] <= extend(b6a[6]) + partial_sum[3][31:0] + partial_sum[7][31:0];

                product32[0] <= extend(b0a[0]) + partial_sum[0][63:0] + partial_sum[4][63:0] 
                               + partial_sum[8][63:0] + partial_sum[10][63:0] + partial_sum[21][63:0] 
                               + partial_sum[12][63:0] + (partial_sum[1] << 32)[63:0] 
                               + (partial_sum[5] << 32)[63:0];
                product32[1] <= extend(b4a[4]) + partial_sum[2][63:0] + partial_sum[6][63:0] 
                               + partial_sum[9][63:0] + partial_sum[11][63:0] + partial_sum[23][63:0] 
                               + partial_sum[14][63:0] +(partial_sum[3] << 32)[63:0] 
                               + (partial_sum[7] << 32)[63:0];

                product64 <= extend(b0a[0]) + partial_sum[0] + partial_sum[4] + partial_sum[8] + partial_sum[10] 
                           + partial_sum[21] + partial_sum[12] + partial_sum[13] + (partial_sum[1] << 32) 
                           + partial_sum[15] + (partial_sum[5] << 32) + partial_sum[16] + partial_sum[17] 
                           + partial_sum[22] + partial_sum[18] + (partial_sum[2] << 64) + partial_sum[19] 
                           + (partial_sum[6] << 64) + (partial_sum[9] << 64) + partial_sum[20] 
                           + (partial_sum[11] << 64) + (partial_sum[23] << 64) + (partial_sum[14] << 64)
                           + (partial_sum[3] << 96) + (partial_sum[7] << 96);

                flag[2] <= 1;
            end
        endaction);
    endfunction

    function Action macs(Bit#(64) i_a, Bit#(1) sum_partials_check);
        return
        (action
            if (sum_partials_check == 0) flag[3] <= 0;
            else begin
                mac_output[0] <= {(b7a[7] + extend(i_a[63:56])), (b6a[6] + extend(i_a[55:48])), (b5a[5] + extend(i_a[47:40])), (b4a[4] + extend(i_a[39:32])), (b3a[3] + extend(i_a[31:24])), (b2a[2] + extend(i_a[23:16])), (b1a[1] + extend(i_a[15:8])), (b0a[0] + extend(i_a[7:0]))};
                mac_output[1] <= {(product16[3] + extend(i_a[63:48])), (product16[2] + extend(i_a[47:32])), (product16[1] + extend(i_a[31:16])), (product16[0] + extend(i_a[15:0]))};
                mac_output[2] <= {(product32[1] + extend(i_a[63:32])), (product32[0] + extend(i_a[31:0]))};
                mac_output[3] <= (product64 + extend(i_a));
                flag[3] <= 1;
                mac_ready <= True;
            end
        endaction);
    endfunction

    rule compute_MAC;
        generate_partials(m1, m2, inp_ready);
        shift_add_partials(flag[0]);
        sum_partials(flag[1]);
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
        final_mac_result = mac_output[reg_mode];
        return final_mac_result;
    endmethod

endmodule
                
endpackage : MAC
    