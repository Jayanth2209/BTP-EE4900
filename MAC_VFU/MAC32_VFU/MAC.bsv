package MAC;

import Vector :: *;

interface Ifc_MAC;
    method Action get_values(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend, Bit#(2) mode);
    method Bit#(64) mac_result;
    //method Bit#(68) mac_result;
endinterface: Ifc_MAC

(*synthesize*)
module mkMAC(Ifc_MAC);

    // Registers for Inputs
    Reg#(Bit#(32)) m1 <- mkReg(0);
    Reg#(Bit#(32)) m2 <- mkReg(0);
    Reg#(Bit#(32)) a <- mkReg(0);

    // Mode of Operation of the VFU
    Reg#(Bit#(2)) reg_mode <- mkReg(0);

    // Ready Signal for Inputs
    Reg#(Bool) inp_ready <- mkReg(False);

    // Ready Signal for MAC Result
    Reg#(Bool) mac_ready <- mkReg(False);

    // Intermediate Registers
    Vector#(4, Reg#(Bit#(16))) x <- replicateM(mkReg(0));
    Vector#(4, Reg#(Bit#(16))) y <- replicateM(mkReg(0));

    // Partial Product Terms
    Vector#(4, Reg#(Bit#(32))) partial_product <- replicateM(mkReg(0));

    // Register for Output
    Reg#(Bit#(64)) mac_output <- mkReg(0);

    // Pipeline Flags
    Vector#(3, Reg#(Bit#(1))) flag <- replicateM(mkReg(0));

    function Action route_inputs(Bit#(32) i_m1, Bit#(32) i_m2, Bit#(2) i_mode, Bool inp_check);
        return
        (action
            if (inp_check == False) flag[0] <= 0;
            else begin
                case (i_mode)
                    0: begin
                        x[0] <= extend(m1[7:0]);
                        x[1] <= extend(m1[15:8]);
                        x[2] <= extend(m1[23:16]);
                        x[3] <= extend(m1[31:24]);

                        y[0] <= extend(m2[7:0]);
                        y[1] <= extend(m2[15:8]);
                        y[2] <= extend(m2[23:16]);
                        y[3] <= extend(m2[31:24]); 
                    end
                    1: begin
                        x[0] <= m1[15:0];
                        x[1] <= m1[31:16];
                        x[2] <= m1[15:0];
                        x[3] <= m1[31:16];

                        y[0] <= m2[15:0];
                        y[1] <= m2[31:16];
                        y[2] <= m2[15:0];
                        y[3] <= m2[31:16];
                    end
                    2: begin
                        x[0] <= m1[15:0];   // A0
                        x[1] <= m1[15:0];   // A0
                        x[2] <= m1[31:16];  // A1
                        x[3] <= m1[31:16];   // A1

                        y[0] <= m2[15:0];   // B0
                        y[1] <= m2[31:16];  // B1
                        y[2] <= m2[15:0];  // B0
                        y[3] <= m2[31:16];  // B1
                    end
                    default: begin
                        x[0] <= m1[15:0];   // A0
                        x[1] <= m1[15:0];   // A0
                        x[2] <= m1[31:16];  // A1
                        x[3] <= m1[31:16];   // A1

                        y[0] <= m2[15:0];   // B0
                        y[1] <= m2[31:16];  // B1
                        y[2] <= m2[15:0];  // B0
                        y[3] <= m2[31:16];  // B1
                    end
                endcase
                flag[0] <= 1;
            end
        endaction);
    endfunction

    
    function Action generate_partials(Bit#(2) i_mode1, Bit#(1) route_inputs_check);
        return
        (action
            if (route_inputs_check == 0) flag[1] <= 0;
            else begin                                              // 32
                partial_product[0] <= extend(x[0])*extend(y[0]);    // A0B0

                partial_product[1] <= extend(x[1])*extend(y[1]);    // A0B1
                partial_product[2] <= extend(x[2])*extend(y[2]);    // A1B0

                partial_product[3] <= extend(x[3])*extend(y[3]);    // A1B1
                
                flag[1] <= 1;
            end
        endaction);
    endfunction

    function Action sum_partials(Bit#(32) i_a, Bit#(2) i_mode2, Bit#(1) shift_add_partials_check);
        return
        (action
            if (shift_add_partials_check == 0) flag[2] <= 0;
            else begin
                case(i_mode2)
                    0: begin
                        mac_output <= {(partial_product[3][15:0] + extend(i_a[31:24])), (partial_product[2][15:0] + extend(i_a[23:16])), 
                                       (partial_product[1][15:0] + extend(i_a[15:8])), (partial_product[0][15:0] + extend(i_a[7:0]))};
                    end
                    1: begin
                        mac_output <= {(partial_product[1] + extend(i_a[31:16])), (partial_product[0] + extend(i_a[15:0]))};
                    end
                    2: begin
                        mac_output <= extend(partial_product[0]) + ((extend(partial_product[1]) + extend(partial_product[2])) << 16) +
                                      (extend(partial_product[3]) << 32) + extend(i_a);
                    end
                    default: begin
                        mac_output <= extend(partial_product[0]) + ((extend(partial_product[1]) + extend(partial_product[2])) << 16) +
                                      (extend(partial_product[3]) << 32) + extend(i_a);
                    end
                endcase
                flag[2] <= 1;
                mac_ready <= True;
            end
        endaction);
    endfunction

    Reg#(Bit#(4)) counter <- mkReg(0);

    rule compute_MAC;
        //counter <= counter + 1;
        route_inputs(m1, m2, reg_mode, inp_ready);
        generate_partials(reg_mode, flag[0]);
        sum_partials(a, reg_mode, flag[1]);
    endrule: compute_MAC

    method Action get_values(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend, Bit#(2) mode);
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

    method Bit#(64) mac_result if (mac_ready);
        Bit#(64) final_mac_result = 0;
        final_mac_result = mac_output;
        return final_mac_result;
    endmethod

    // method Bit#(68) mac_result if (mac_ready);
    //     Bit#(68) final_mac_result = 0;
    //     final_mac_result = {counter, mac_output};
    //     return final_mac_result;
    // endmethod

endmodule
                
endpackage : MAC

// 4 MULTS and 3 64-Bit SHIFTS := 4 DSP + 