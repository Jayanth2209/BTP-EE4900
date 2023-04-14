package MAC;

import Vector :: *;

interface Ifc_MAC;
    method Action get_values(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend, Bit#(2) mode);
    method Bit#(128) mac_result;
    // method Bit#(132) mac_result;
endinterface: Ifc_MAC

(*synthesize*)
module mkMAC(Ifc_MAC);

    // Registers for Inputs
    Reg#(Bit#(64)) m1 <- mkReg(0);
    Reg#(Bit#(64)) m2 <- mkReg(0);
    Reg#(Bit#(64)) a <- mkReg(0);

    // Mode of Operation of the VFU
    Reg#(Bit#(2)) reg_mode <- mkReg(0);

    // Ready Signal for Inputs
    Reg#(Bool) inp_ready <- mkReg(False);

    // Ready Signal for MAC Result
    Reg#(Bool) mac_ready <- mkReg(False);

    // Intermediate Registers
    Vector#(16, Reg#(Bit#(16))) x <- replicateM(mkReg(0));
    Vector#(16, Reg#(Bit#(16))) y <- replicateM(mkReg(0));

    // Partial Product Terms
    Vector#(16, Reg#(Bit#(32))) partial_product <- replicateM(mkReg(0));

    // Shifted Product Sums
    Vector#(7, Reg#(Bit#(128))) partial_sum <- replicateM(mkReg(0));

    // Register for Output
    Reg#(Bit#(128)) mac_output <- mkReg(0);

    // Pipeline Flags
    Vector#(2, Reg#(Bit#(1))) flag <- replicateM(mkReg(0));

    // function Action route_inputs(Bit#(64) i_m1, Bit#(64) i_m2, Bit#(2) i_mode, Bool inp_check);
    //     return
    //     (action
    //         if (inp_check == False) flag[0] <= 0;
    //         else begin
    //             case (i_mode)
    //                 0: begin
    //                     x[0] <= extend(m1[7:0]);
    //                     x[1] <= extend(m1[15:8]);
    //                     x[2] <= extend(m1[23:16]);
    //                     x[3] <= extend(m1[31:24]);
    //                     x[4] <= extend(m1[39:32]);
    //                     x[5] <= extend(m1[47:40]);
    //                     x[6] <= extend(m1[55:48]);
    //                     x[7] <= extend(m1[63:56]);
    //                     x[8] <= extend(m1[7:0]);
    //                     x[9] <= extend(m1[15:8]);
    //                     x[10] <= extend(m1[23:16]);
    //                     x[11] <= extend(m1[31:24]);
    //                     x[12] <= extend(m1[39:32]);
    //                     x[13] <= extend(m1[47:40]);
    //                     x[14] <= extend(m1[55:48]);
    //                     x[15] <= extend(m1[63:56]);

    //                     y[0] <= extend(m2[7:0]);
    //                     y[1] <= extend(m2[15:8]);
    //                     y[2] <= extend(m2[23:16]);
    //                     y[3] <= extend(m2[31:24]);
    //                     y[4] <= extend(m2[39:32]);
    //                     y[5] <= extend(m2[47:40]);
    //                     y[6] <= extend(m2[55:48]);
    //                     y[7] <= extend(m2[63:56]);
    //                     y[8] <= extend(m2[7:0]);
    //                     y[9] <= extend(m2[15:8]);
    //                     y[10] <= extend(m2[23:16]);
    //                     y[11] <= extend(m2[31:24]);
    //                     y[12] <= extend(m2[39:32]);
    //                     y[13] <= extend(m2[47:40]);
    //                     y[14] <= extend(m2[55:48]);
    //                     y[15] <= extend(m2[63:56]); 
    //                 end
    //                 1: begin
    //                     x[0] <= m1[15:0];
    //                     x[1] <= m1[31:16];
    //                     x[2] <= m1[47:32];
    //                     x[3] <= m1[63:48];
    //                     x[4] <= m1[15:0];
    //                     x[5] <= m1[31:16];
    //                     x[6] <= m1[47:32];
    //                     x[7] <= m1[63:48];
    //                     x[8] <= m1[15:0];
    //                     x[9] <= m1[31:16];
    //                     x[10] <= m1[47:32];
    //                     x[11] <= m1[63:48];
    //                     x[12] <= m1[15:0];
    //                     x[13] <= m1[31:16];
    //                     x[14] <= m1[47:32];
    //                     x[15] <= m1[63:48];

    //                     y[0] <= m2[15:0];
    //                     y[1] <= m2[31:16];
    //                     y[2] <= m2[47:32];
    //                     y[3] <= m2[63:48];
    //                     y[4] <= m2[15:0];
    //                     y[5] <= m2[31:16];
    //                     y[6] <= m2[47:32];
    //                     y[7] <= m2[63:48];
    //                     y[8] <= m2[15:0];
    //                     y[9] <= m2[31:16];
    //                     y[10] <= m2[47:32];
    //                     y[11] <= m2[63:48];
    //                     y[12] <= m2[15:0];
    //                     y[13] <= m2[31:16];
    //                     y[14] <= m2[47:32];
    //                     y[15] <= m2[63:48]; 
    //                 end
    //                 2: begin
    //                     x[0] <= m1[15:0];   // A0
    //                     x[1] <= m1[15:0];   // A0
    //                     x[2] <= m1[31:16];  // A1
    //                     x[3] <= m1[15:0];   // A0
    //                     x[4] <= m1[31:16];  // A1
    //                     x[5] <= m1[31:16];  // A1
    //                     x[6] <= m1[15:0];   // A0
    //                     x[7] <= m1[31:16];  // A1
    //                     x[8] <= m1[47:32];  // A2
    //                     x[9] <= m1[63:48];  // A3
    //                     x[10] <= m1[47:32]; // A2
    //                     x[11] <= m1[47:32]; // A2
    //                     x[12] <= m1[63:48]; // A3
    //                     x[13] <= m1[47:32]; // A2
    //                     x[14] <= m1[63:48]; // A3
    //                     x[15] <= m1[63:48]; // A3

    //                     y[0] <= m2[15:0];   // B0
    //                     y[1] <= m2[31:16];  // B1
    //                     y[2] <= m2[15:0];  // B0
    //                     y[3] <= m2[31:16];  // B1
    //                     y[4] <= m2[31:16];  // B1
    //                     y[5] <= m2[15:0];  // B0
    //                     y[6] <= m2[15:0];  // B0
    //                     y[7] <= m2[31:16];  // B1
    //                     y[8] <= m2[47:32];  // B2
    //                     y[9] <= m2[63:48];  // B3
    //                     y[10] <= m2[63:48];  // B3
    //                     y[11] <= m2[47:32];  // B2
    //                     y[12] <= m2[47:32];  // B2
    //                     y[13] <= m2[63:48];  // B3
    //                     y[14] <= m2[47:32];  // B2
    //                     y[15] <= m2[63:48];  // B3 
    //                 end
    //                 3: begin
    //                     x[0] <= m1[15:0];   // A0
    //                     x[1] <= m1[15:0];   // A0
    //                     x[2] <= m1[31:16];  // A1
    //                     x[3] <= m1[15:0];   // A0
    //                     x[4] <= m1[31:16];  // A1
    //                     x[5] <= m1[47:32];  // A2
    //                     x[6] <= m1[15:0];   // A0
    //                     x[7] <= m1[31:16];  // A1
    //                     x[8] <= m1[47:32];  // A2
    //                     x[9] <= m1[63:48];  // A3
    //                     x[10] <= m1[31:16]; // A1
    //                     x[11] <= m1[47:32]; // A2
    //                     x[12] <= m1[63:48]; // A3
    //                     x[13] <= m1[47:32]; // A2
    //                     x[14] <= m1[63:48]; // A3
    //                     x[15] <= m1[63:48]; // A3

    //                     y[0] <= m2[15:0];   // B0
    //                     y[1] <= m2[31:16];  // B1
    //                     y[2] <= m2[15:0];  // B0
    //                     y[3] <= m2[47:32];  // B2
    //                     y[4] <= m2[31:16];  // B1
    //                     y[5] <= m2[15:0];  // B0
    //                     y[6] <= m2[63:48];  // B3
    //                     y[7] <= m2[47:32];  // B2
    //                     y[8] <= m2[31:16];  // B1
    //                     y[9] <= m2[15:0];  // B0
    //                     y[10] <= m2[63:48];  // B3
    //                     y[11] <= m2[47:32];  // B2
    //                     y[12] <= m2[31:16];  // B1
    //                     y[13] <= m2[63:48];  // B3
    //                     y[14] <= m2[47:32];  // B2
    //                     y[15] <= m2[63:48];  // B3
    //                 end
    //                 default: begin
    //                     x[0] <= m1[15:0];   // A0
    //                     x[1] <= m1[15:0];   // A0
    //                     x[2] <= m1[31:16];  // A1
    //                     x[3] <= m1[15:0];   // A0
    //                     x[4] <= m1[31:16];  // A1
    //                     x[5] <= m1[47:32];  // A2
    //                     x[6] <= m1[15:0];   // A0
    //                     x[7] <= m1[31:16];  // A1
    //                     x[8] <= m1[47:32];  // A2
    //                     x[9] <= m1[63:48];  // A3
    //                     x[10] <= m1[31:16]; // A1
    //                     x[11] <= m1[47:32]; // A2
    //                     x[12] <= m1[63:48]; // A3
    //                     x[13] <= m1[47:32]; // A2
    //                     x[14] <= m1[63:48]; // A3
    //                     x[15] <= m1[63:48]; // A3

    //                     y[0] <= m2[15:0];   // B0
    //                     y[1] <= m2[31:16];  // B1
    //                     y[2] <= m2[15:0];  // B0
    //                     y[3] <= m2[47:32];  // B2
    //                     y[4] <= m2[31:16];  // B1
    //                     y[5] <= m2[15:0];  // B0
    //                     y[6] <= m2[63:48];  // B3
    //                     y[7] <= m2[47:32];  // B2
    //                     y[8] <= m2[31:16];  // B1
    //                     y[9] <= m2[15:0];  // B0
    //                     y[10] <= m2[63:48];  // B3
    //                     y[11] <= m2[47:32];  // B2
    //                     y[12] <= m2[31:16];  // B1
    //                     y[13] <= m2[63:48];  // B3
    //                     y[14] <= m2[47:32];  // B2
    //                     y[15] <= m2[63:48];  // B3
    //                 end
    //             endcase
    //             flag[0] <= 1;
    //         end
    //     endaction);
    // endfunction

    
    function Action generate_partials(Bit#(2) i_mode1, Bit#(1) route_inputs_check);
        return
        (action
            if (route_inputs_check == 0) flag[0] <= 0;
            else begin                                              // 64       // 32
                partial_product[0] <= extend(x[0])*extend(y[0]);    // A0B0     // A0B0 1

                partial_product[1] <= extend(x[1])*extend(y[1]);   // A0B1      // A0B1 1
                partial_product[2] <= extend(x[2])*extend(y[2]);   // A1B0      // A1B0 1

                partial_product[3] <= extend(x[3])*extend(y[3]);   // A0B2      // A0B1 2  
                partial_product[4] <= extend(x[4])*extend(y[4]);  // A1B1       // A1B1 1
                partial_product[5] <= extend(x[5])*extend(y[5]);   // A2B0      // A1B0 2

                partial_product[6] <= extend(x[6])*extend(y[6]);   // A0B3      // A0B0 2
                partial_product[7] <= extend(x[7])*extend(y[7]);  // A1B2       // A1B1 2
                partial_product[8] <= extend(x[8])*extend(y[8]);  // A2B1       // A2B2 3
                partial_product[9] <= extend(x[9])*extend(y[9]);   // A3B0      // A3B3 3

                partial_product[10] <= extend(x[10])*extend(y[10]); // A1B3     // A2B3 3
                partial_product[11] <= extend(x[11])*extend(y[11]); // A2B2     // A2B2 4
                partial_product[12] <= extend(x[12])*extend(y[12]); // A3B1     // A3B2 3

                partial_product[13] <= extend(x[13])*extend(y[13]);   // A2B3   // A2B3 4
                partial_product[14] <= extend(x[14])*extend(y[14]);   // A3B2   // A3B2 4

                partial_product[15] <= extend(x[15])*extend(y[15]);   // A3B3   // A3B3 4
                
                case (i_mode1)
                    0: 
                    1: 
                    2: flag[0] <= 1;
                    3: flag[0] <= 1;
                    default: flag[0] <= 1;
                endcase
            end
        endaction);
    endfunction

    function Action shift_add_partials(Bit#(1) generate_partials_check);
        return
        (action
            if (generate_partials_check == 0) flag[2] <= 0;
            else begin                                                                                  // 64                       // 32
                partial_sum[0] <= (extend(partial_product[1]) + extend(partial_product[2])) << 16;      // A0B1 + A1B0 << 16        // A0B1 + A1B0 << 16

                partial_sum[1] <= (extend(partial_product[13]) + extend(partial_product[14])) << 16;    // A2B3 + A3B2 << 16        // A2B3 + A3B2 << 16

                partial_sum[2] <= extend(partial_product[4]) << 32;                                     // A1B1 << 32               // A1B1 << 32                      

                partial_sum[3] <= extend(partial_product[15]) << 32;                                    // A3B3 << 32               // A3B3 << 32

                partial_sum[4] <= (extend(partial_product[3]) + extend(partial_product[5])) << 16 ;     // A0B2 + A2B0 << 16        // A0B1 + A1B0 << 16     
                
                partial_sum[6] <= (extend(partial_product[10]) + extend(partial_product[12])) << 16;    // A1B3 + A3B1 << 16        // A2B3 + A3B2 << 16

                partial_sum[5] <= (extend(partial_product[6]) + extend(partial_product[7]) + extend(partial_product[8]) + extend(partial_product[9])) << 48;  // A0B3 + A1B2 + A2B1 + A3B0 << 48

                flag[2] <= 1;
            end
        endaction);
    endfunction

    function Action sum_partials(Bit#(64) i_a, Bit#(2) i_mode2, Bit#(1) shift_add_partials_check, Bit#(1) mode_check);
        return
        (action
            if (shift_add_partials_check == 0 && mode_check == 0) flag[3] <= 0;
            else begin
                case(i_mode2)
                    0: begin
                        mac_output <= {(partial_product[7][15:0] + extend(i_a[63:56])), (partial_product[6][15:0] + extend(i_a[55:48])), 
                                            (partial_product[5][15:0] + extend(i_a[47:40])), (partial_product[4][15:0] + extend(i_a[39:32])), 
                                            (partial_product[3][15:0] + extend(i_a[31:24])), (partial_product[2][15:0] + extend(i_a[23:16])), 
                                            (partial_product[1][15:0] + extend(i_a[15:8])), (partial_product[0][15:0] + extend(i_a[7:0]))};
                    end
                    1: begin
                        mac_output <= {(partial_product[3] + extend(i_a[63:48])), (partial_product[2] + extend(i_a[47:32])), 
                                        (partial_product[1] + extend(i_a[31:16])), (partial_product[0] + extend(i_a[15:0]))};
                    end
                    2: begin
                        mac_output <= {(extend(partial_product[8]) + (partial_sum[1])[63:0] + (partial_sum[3])[63:0] + extend(i_a[63:32])), 
                                        (extend(partial_product[0]) + (partial_sum[0])[63:0] + (partial_sum[2])[63:0] + extend(i_a[31:0]))};
                    end
                    3: begin
                        mac_output <= extend(partial_product[0]) + partial_sum[0] + partial_sum[2] + (partial_sum[4] << 16) +
                                        partial_sum[5] + (extend(partial_product[11]) << 64) + (partial_sum[6] << 48) +
                                        (partial_sum[1] << 64) + (partial_sum[3] << 64) + extend(i_a);
                    end
                    default: begin
                        mac_output <= extend(partial_product[0]) + partial_sum[0] + partial_sum[2] + (partial_sum[4] << 16) +
                                        partial_sum[5] + (extend(partial_product[11]) << 64) + (partial_sum[6] << 48) +
                                        (partial_sum[1] << 64) + (partial_sum[3] << 64) + extend(i_a);
                    end
                endcase
                flag[3] <= 1;
                mac_ready <= True;
            end
        endaction);
    endfunction

    Reg#(Bit#(4)) counter <- mkReg(0);

    rule compute_MAC;
        //counter <= counter + 1;
        route_inputs(m1, m2, reg_mode, inp_ready);
        generate_partials(reg_mode, flag[0]);
        shift_add_partials(flag[1]);
        sum_partials(a, reg_mode, flag[2], flag[4]);
    endrule: compute_MAC

    method Action get_values(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend, Bit#(2) mode);
    if (multiplicand1 != m1 || multiplicand2 != m2 || addend != a || mode != reg_mode)
    begin
        m1 <= multiplicand1;
        m2 <= multiplicand2;
        a <= addend;
        reg_mode <= mode;

        case(mode)
            0: begin
                x[0] <= extend(m1[7:0]);
                x[1] <= extend(m1[15:8]);
                x[2] <= extend(m1[23:16]);
                x[3] <= extend(m1[31:24]);
                x[4] <= extend(m1[39:32]);
                x[5] <= extend(m1[47:40]);
                x[6] <= extend(m1[55:48]);
                x[7] <= extend(m1[63:56]);
                x[8] <= extend(m1[7:0]);
                x[9] <= extend(m1[15:8]);
                x[10] <= extend(m1[23:16]);
                x[11] <= extend(m1[31:24]);
                x[12] <= extend(m1[39:32]);
                x[13] <= extend(m1[47:40]);
                x[14] <= extend(m1[55:48]);
                x[15] <= extend(m1[63:56]);

                y[0] <= extend(m2[7:0]);
                y[1] <= extend(m2[15:8]);
                y[2] <= extend(m2[23:16]);
                y[3] <= extend(m2[31:24]);
                y[4] <= extend(m2[39:32]);
                y[5] <= extend(m2[47:40]);
                y[6] <= extend(m2[55:48]);
                y[7] <= extend(m2[63:56]);
                y[8] <= extend(m2[7:0]);
                y[9] <= extend(m2[15:8]);
                y[10] <= extend(m2[23:16]);
                y[11] <= extend(m2[31:24]);
                y[12] <= extend(m2[39:32]);
                y[13] <= extend(m2[47:40]);
                y[14] <= extend(m2[55:48]);
                y[15] <= extend(m2[63:56]); 
            end
            1: begin
                x[0] <= m1[15:0];
                x[1] <= m1[31:16];
                x[2] <= m1[47:32];
                x[3] <= m1[63:48];
                x[4] <= m1[15:0];
                x[5] <= m1[31:16];
                x[6] <= m1[47:32];
                x[7] <= m1[63:48];
                x[8] <= m1[15:0];
                x[9] <= m1[31:16];
                x[10] <= m1[47:32];
                x[11] <= m1[63:48];
                x[12] <= m1[15:0];
                x[13] <= m1[31:16];
                x[14] <= m1[47:32];
                x[15] <= m1[63:48];

                y[0] <= m2[15:0];
                y[1] <= m2[31:16];
                y[2] <= m2[47:32];
                y[3] <= m2[63:48];
                y[4] <= m2[15:0];
                y[5] <= m2[31:16];
                y[6] <= m2[47:32];
                y[7] <= m2[63:48];
                y[8] <= m2[15:0];
                y[9] <= m2[31:16];
                y[10] <= m2[47:32];
                y[11] <= m2[63:48];
                y[12] <= m2[15:0];
                y[13] <= m2[31:16];
                y[14] <= m2[47:32];
                y[15] <= m2[63:48]; 
            end
            2: begin
                x[0] <= m1[15:0];   // A0
                x[1] <= m1[15:0];   // A0
                x[2] <= m1[31:16];  // A1
                x[3] <= m1[15:0];   // A0
                x[4] <= m1[31:16];  // A1
                x[5] <= m1[31:16];  // A1
                x[6] <= m1[15:0];   // A0
                x[7] <= m1[31:16];  // A1
                x[8] <= m1[47:32];  // A2
                x[9] <= m1[63:48];  // A3
                x[10] <= m1[47:32]; // A2
                x[11] <= m1[47:32]; // A2
                x[12] <= m1[63:48]; // A3
                x[13] <= m1[47:32]; // A2
                x[14] <= m1[63:48]; // A3
                x[15] <= m1[63:48]; // A3

                y[0] <= m2[15:0];   // B0
                y[1] <= m2[31:16];  // B1
                y[2] <= m2[15:0];  // B0
                y[3] <= m2[31:16];  // B1
                y[4] <= m2[31:16];  // B1
                y[5] <= m2[15:0];  // B0
                y[6] <= m2[15:0];  // B0
                y[7] <= m2[31:16];  // B1
                y[8] <= m2[47:32];  // B2
                y[9] <= m2[63:48];  // B3
                y[10] <= m2[63:48];  // B3
                y[11] <= m2[47:32];  // B2
                y[12] <= m2[47:32];  // B2
                y[13] <= m2[63:48];  // B3
                y[14] <= m2[47:32];  // B2
                y[15] <= m2[63:48];  // B3 
            end
            3: begin
                x[0] <= m1[15:0];   // A0
                x[1] <= m1[15:0];   // A0
                x[2] <= m1[31:16];  // A1
                x[3] <= m1[15:0];   // A0
                x[4] <= m1[31:16];  // A1
                x[5] <= m1[47:32];  // A2
                x[6] <= m1[15:0];   // A0
                x[7] <= m1[31:16];  // A1
                x[8] <= m1[47:32];  // A2
                x[9] <= m1[63:48];  // A3
                x[10] <= m1[31:16]; // A1
                x[11] <= m1[47:32]; // A2
                x[12] <= m1[63:48]; // A3
                x[13] <= m1[47:32]; // A2
                x[14] <= m1[63:48]; // A3
                x[15] <= m1[63:48]; // A3

                y[0] <= m2[15:0];   // B0
                y[1] <= m2[31:16];  // B1
                y[2] <= m2[15:0];  // B0
                y[3] <= m2[47:32];  // B2
                y[4] <= m2[31:16];  // B1
                y[5] <= m2[15:0];  // B0
                y[6] <= m2[63:48];  // B3
                y[7] <= m2[47:32];  // B2
                y[8] <= m2[31:16];  // B1
                y[9] <= m2[15:0];  // B0
                y[10] <= m2[63:48];  // B3
                y[11] <= m2[47:32];  // B2
                y[12] <= m2[31:16];  // B1
                y[13] <= m2[63:48];  // B3
                y[14] <= m2[47:32];  // B2
                y[15] <= m2[63:48];  // B3
            end
            default: begin
                x[0] <= m1[15:0];   // A0
                x[1] <= m1[15:0];   // A0
                x[2] <= m1[31:16];  // A1
                x[3] <= m1[15:0];   // A0
                x[4] <= m1[31:16];  // A1
                x[5] <= m1[47:32];  // A2
                x[6] <= m1[15:0];   // A0
                x[7] <= m1[31:16];  // A1
                x[8] <= m1[47:32];  // A2
                x[9] <= m1[63:48];  // A3
                x[10] <= m1[31:16]; // A1
                x[11] <= m1[47:32]; // A2
                x[12] <= m1[63:48]; // A3
                x[13] <= m1[47:32]; // A2
                x[14] <= m1[63:48]; // A3
                x[15] <= m1[63:48]; // A3

                y[0] <= m2[15:0];   // B0
                y[1] <= m2[31:16];  // B1
                y[2] <= m2[15:0];  // B0
                y[3] <= m2[47:32];  // B2
                y[4] <= m2[31:16];  // B1
                y[5] <= m2[15:0];  // B0
                y[6] <= m2[63:48];  // B3
                y[7] <= m2[47:32];  // B2
                y[8] <= m2[31:16];  // B1
                y[9] <= m2[15:0];  // B0
                y[10] <= m2[63:48];  // B3
                y[11] <= m2[47:32];  // B2
                y[12] <= m2[31:16];  // B1
                y[13] <= m2[63:48];  // B3
                y[14] <= m2[47:32];  // B2
                y[15] <= m2[63:48];  // B3
            end
    endcase
        inp_ready <= True;
    end
    else
        inp_ready <= False;
    endmethod

    method Bit#(128) mac_result if (mac_ready);
        Bit#(128) final_mac_result = 0;
        final_mac_result = mac_output;
        return final_mac_result;
    endmethod

    // method Bit#(132) mac_result if (mac_ready);
    //     Bit#(132) final_mac_result = 0;
    //     final_mac_result = {counter, mac_output};
    //     return final_mac_result;
    // endmethod

endmodule
                
endpackage : MAC

// 16 MULTS + 19 128-Bit SHIFTS