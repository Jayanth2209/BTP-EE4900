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

    // Mode of Operation of the VFU
    Reg#(Bit#(2)) reg_mode <- mkReg(0);

    // Ready Signal for Inputs
    Reg#(Bool) inp_ready <- mkReg(False);

    // Ready Signal for MAC Result
    Reg#(Bool) mac_ready <- mkReg(False);

    // Intermediate Registers
    // // First Lower Byte Partial Products
    Vector#(4, Reg#(Bit#(128))) p_20_1 <- replicateM(mkReg(0));
    // // First Lower Byte Partial Products
    Vector#(4, Reg#(Bit#(128))) p_21_1 <- replicateM(mkReg(0));
    // // First Lower Byte Partial Products
    Vector#(4, Reg#(Bit#(128))) p_22_1 <- replicateM(mkReg(0));
    // // First Lower Byte Partial Products
    Vector#(4, Reg#(Bit#(128))) p_23_1 <- replicateM(mkReg(0));

    // Register for Output
    Reg#(Bit#(128)) mac_output <- mkReg(0);

    // Pipeline Flags
    Reg#(Bit#(2)) stage <- mkReg(0);

    /*function Action generate_partials(Bit#(64) i_m1, Bit#(64) i_m2, Bool inp_check);
        return
        (action
            if (inp_check == False) flag[0] <= 0;
            else begin
                p_20_1[0] <= extend(m1[15:0])*extend(m2[15:0]); // A0B0

                p_21_1[0] <= extend(m1[15:0])*extend(m2[31:16]); // A0B1
                p_20_1[1] <= extend(m1[31:16])*extend(m2[15:0]); // A1B0

                p_22_1[0] <= extend(m1[15:0])*extend(m2[47:32]); // A0B2
                p_21_1[1] <= extend(m1[31:16])*extend(m2[31:16]); // A1B1
                p_20_1[2] <= extend(m1[47:32])*extend(m2[15:0]); // A2B0

                p_23_1[0] <= extend(m1[15:0])*extend(m2[63:48]); // A0B3
                p_22_1[1] <= extend(m1[31:16])*extend(m2[47:32]); // A1B2
                p_21_1[2] <= extend(m1[47:32])*extend(m2[31:16]); // A2B1
                p_20_1[3] <= extend(m1[63:48])*extend(m2[15:0]); // A3B0

                p_23_1[1] <= extend(m1[31:16])*extend(m2[63:48]); // A1B3
                p_22_1[2] <= extend(m1[47:32])*extend(m2[47:32]); // A2B2
                p_21_1[3] <= extend(m1[63:48])*extend(m2[31:16]); // A3B1

                p_23_1[2] <= extend(m1[47:32])*extend(m2[63:48]); // A2B3
                p_22_1[3] <= extend(m1[63:48])*extend(m2[47:32]); // A3B2

                p_23_1[3] <= extend(m1[63:48])*extend(m2[63:48]); // A3B3
                
                flag[0] <= 1;
            end
        endaction);
    endfunction

    function Action shift_partials(Bit#(1) partials_check);
        return
        (action
            if (partials_check == 0) flag[1] <= 0;
            else begin
                p_20_1[0] <= p_20_1[0];   // A0B0 

                p_21_1[0] <= p_21_1[0] << 16; // A0B1 << 16
                p_20_1[1] <= p_20_1[1] << 16; // A1B0 << 16

                p_22_1[0] <= p_22_1[0] << 32; // A0B2 << 32
                p_21_1[1] <= p_21_1[1] << 32; // A1B1 << 32
                p_20_1[2] <= p_20_1[2] << 32; // A2B0 << 32

                p_23_1[0] <= p_23_1[0] << 48; // A0B3 << 48
                p_22_1[1] <= p_22_1[1] << 48; // A1B2 << 48
                p_21_1[2] <= p_21_1[2] << 48; // A2B1 << 48
                p_20_1[3] <= p_20_1[3] << 48; // A3B0 << 48

                p_23_1[1] <= p_23_1[1] << 64; // A1B3 << 64
                p_22_1[2] <= p_23_1[1] << 64; // A2B2 << 64
                p_21_1[3] <= p_23_1[1] << 64; // A3B1 << 64

                p_23_1[2] <= p_23_1[2] << 80; // A2B3 << 80
                p_22_1[3] <= p_22_1[3] << 80; // A3B2 << 80

                p_23_1[3] <= p_23_1[3] << 96; // A3B3 << 96

                flag[1] <= 1;
            end
        endaction);
    endfunction

    function Action add_partials(Bit#(64) i_a, Bit#(1) shift_check);
        return
        (action
            if (shift_check == 0) flag[2] <= 0;
            else begin
                p_20_1[0] <= p_20_1[0] + extend(i_a);

                p_22_1[0] <= p_20_1[0] + p_21_1[0] + p_20_1[1] + p_21_1[1] + + extend(i_a);

                p_23_1[0] <= p_20_1[0]
                           + p_21_1[0] + p_20_1[1]
                           + p_22_1[0] + p_21_1[1] + p_20_1[2]
                           + p_23_1[0] + p_22_1[1] + p_21_1[2] + p_20_1[3]
                           + p_23_1[1] + p_22_1[2] + p_21_1[3]
                           + p_23_1[2] + p_22_1[3]
                           + p_23_1[3]
                           + extend(i_a);

                flag[2] <= 1;
            end
        endaction);
    endfunction

    function Action macs(Bit#(2) i_mode, Bit#(1) add_partials_check);
        return
        (action
            if (add_partials_check == 0) flag[3] <= 0;
            else begin
                case (i_mode)
                    0: mac_output <= {p_20_1[0][15:0], p_20_1[0][15:0], p_20_1[0][15:0], p_20_1[0][15:0], p_20_1[0][15:0], p_20_1[0][15:0], p_20_1[0][15:0], p_20_1[0][15:0]};
                    1: mac_output <= {p_20_1[0][31:0], p_20_1[0][31:0], p_20_1[0][31:0], p_20_1[0][31:0]};
                    2: mac_output <= {p_22_1[0][63:0], p_22_1[0][63:0]};
                    3: mac_output <= p_23_1[0];
                    default: mac_output <= p_23_1[0];
                endcase
                flag[3] <= 1;
            end
        endaction);
    endfunction*/

    rule compute_MAC1 (inp_ready && (stage == 0));
        (action
            p_20_1[0] <= extend(m1[15:0])*extend(m2[15:0]); // A0B0

            p_21_1[0] <= extend(m1[15:0])*extend(m2[31:16]); // A0B1
            p_20_1[1] <= extend(m1[31:16])*extend(m2[15:0]); // A1B0

            p_22_1[0] <= extend(m1[15:0])*extend(m2[47:32]); // A0B2
            p_21_1[1] <= extend(m1[31:16])*extend(m2[31:16]); // A1B1
            p_20_1[2] <= extend(m1[47:32])*extend(m2[15:0]); // A2B0

            p_23_1[0] <= extend(m1[15:0])*extend(m2[63:48]); // A0B3
            p_22_1[1] <= extend(m1[31:16])*extend(m2[47:32]); // A1B2
            p_21_1[2] <= extend(m1[47:32])*extend(m2[31:16]); // A2B1
            p_20_1[3] <= extend(m1[63:48])*extend(m2[15:0]); // A3B0

            p_23_1[1] <= extend(m1[31:16])*extend(m2[63:48]); // A1B3
            p_22_1[2] <= extend(m1[47:32])*extend(m2[47:32]); // A2B2
            p_21_1[3] <= extend(m1[63:48])*extend(m2[31:16]); // A3B1

            p_23_1[2] <= extend(m1[47:32])*extend(m2[63:48]); // A2B3
            p_22_1[3] <= extend(m1[63:48])*extend(m2[47:32]); // A3B2

            p_23_1[3] <= extend(m1[63:48])*extend(m2[63:48]); // A3B3

            stage <= stage + 1;
        endaction);
    endrule: compute_MAC1

    rule compute_MAC2 (stage == 1);
        (action
            p_20_1[0] <= p_20_1[0];   // A0B0 

            p_21_1[0] <= p_21_1[0] << 16; // A0B1 << 16
            p_20_1[1] <= p_20_1[1] << 16; // A1B0 << 16

            p_22_1[0] <= p_22_1[0] << 32; // A0B2 << 32
            p_21_1[1] <= p_21_1[1] << 32; // A1B1 << 32
            p_20_1[2] <= p_20_1[2] << 32; // A2B0 << 32

            p_23_1[0] <= p_23_1[0] << 48; // A0B3 << 48
            p_22_1[1] <= p_22_1[1] << 48; // A1B2 << 48
            p_21_1[2] <= p_21_1[2] << 48; // A2B1 << 48
            p_20_1[3] <= p_20_1[3] << 48; // A3B0 << 48

            p_23_1[1] <= p_23_1[1] << 64; // A1B3 << 64
            p_22_1[2] <= p_23_1[1] << 64; // A2B2 << 64
            p_21_1[3] <= p_23_1[1] << 64; // A3B1 << 64

            p_23_1[2] <= p_23_1[2] << 80; // A2B3 << 80
            p_22_1[3] <= p_22_1[3] << 80; // A3B2 << 80

            p_23_1[3] <= p_23_1[3] << 96; // A3B3 << 96

            stage <= stage + 1;
        endaction);
    endrule: compute_MAC2

    rule compute_MAC3 (stage == 2);
        (action
            p_20_1[0] <= p_20_1[0] + extend(a);

            p_22_1[0] <= p_20_1[0] + p_21_1[0] + p_20_1[1] + p_21_1[1] + + extend(a);

            p_23_1[0] <= p_20_1[0]
                        + p_21_1[0] + p_20_1[1]
                        + p_22_1[0] + p_21_1[1] + p_20_1[2]
                        + p_23_1[0] + p_22_1[1] + p_21_1[2] + p_20_1[3]
                        + p_23_1[1] + p_22_1[2] + p_21_1[3]
                        + p_23_1[2] + p_22_1[3]
                        + p_23_1[3]
                        + extend(a);

            stage <= stage + 1;
        endaction);
    endrule: compute_MAC3

    rule compute_MAC4 (stage == 3);
        (action
            case (reg_mode)
                0: mac_output <= {p_20_1[0][15:0], p_20_1[0][15:0], p_20_1[0][15:0], p_20_1[0][15:0], p_20_1[0][15:0], p_20_1[0][15:0], p_20_1[0][15:0], p_20_1[0][15:0]};
                1: mac_output <= {p_20_1[0][31:0], p_20_1[0][31:0], p_20_1[0][31:0], p_20_1[0][31:0]};
                2: mac_output <= {p_22_1[0][63:0], p_22_1[0][63:0]};
                3: mac_output <= p_23_1[0];
                default: mac_output <= p_23_1[0];
            endcase
            stage <= stage + 1;
            mac_ready <= True;
        endaction);
    endrule: compute_MAC4

    method Action get_values(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend, Bit#(2) mode);
    if (multiplicand1 != m1 || multiplicand2 != m2 || addend != a || mode != reg_mode)
    begin
        m1 <= multiplicand1;
        m2 <= multiplicand2;
        a <= addend;
        reg_mode <= mode;
        stage <= 0;
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

endmodule
                
endpackage : MAC
    