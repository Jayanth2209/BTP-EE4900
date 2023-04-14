package mac322p;

import Vector::*;

interface Ifc_mac322p;
    method Action get_values(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend);
        method ActionValue#(Bit#(64)) mac_result();
endinterface: Ifc_mac322p

(*synthesize*)
module mkmac322p(Ifc_mac322p);
    // Registers for Inputs
    Reg#(Bit#(32)) m1 <- mkReg(0);
    Reg#(Bit#(32)) m2 <- mkReg(0);
    Reg#(Bit#(32)) a <- mkReg(0);

    // Ready Signal for Inputs
    Reg#(Bool) inp_ready <- mkReg(False);

    // Ready Signal for MAC Result
    Reg#(Bool) mac_ready <- mkReg(False);

    // Pipeline Flag
    Vector#(2, Reg#(Bit#(1))) flag <- replicateM(mkReg(0));

    // Pipeline Stage 1
    Reg#(Bit#(64)) p1 <- mkReg(0);
    Reg#(Bit#(64)) p2 <- mkReg(0);
    Reg#(Bit#(64)) p3 <- mkReg(0);
    Reg#(Bit#(64)) p4 <- mkReg(0);

    // Pipeline Stage 2
    Reg#(Bit#(64)) resmac <- mkReg(0);

    function Action fn_pipeline_1(Bit#(32) p1_m1, Bit#(32) p1_m2, Bool inp_check);
        return
        action  
        if(!inp_check)
            flag[0] <= 0;
        else
        begin
            p1 <= extend(p1_m1[15:0])*extend(p1_m2[15:0]);
            p2 <= ((extend(p1_m1[15:0])*extend(p1_m2[31:16])) << 16);
            p3 <= ((extend(p1_m1[31:16])*extend(p1_m2[15:0])) << 16);
            p4 <= ((extend(p1_m1[31:16])*extend(p1_m2[31:16])) << 32);
            flag[0] <= 1;
        end
        endaction;
    endfunction

    function Action fn_pipeline_2(Bit#(64) p2_p1, Bit#(64) p2_p2, Bit#(64) p2_p3, Bit#(64) p2_p4, Bit#(32) p2_a, Bit#(1) prev_check);
        return
        action
        if (prev_check == 0)
            flag[1] <= 0;
        else
        begin
            resmac <= (p2_p1 + p2_p2 + p2_p3 + p2_p4 + extend(p2_a));
            mac_ready <= True;
            flag[1] <= 1;
        end
        endaction;
    endfunction


    // Rule that computes MAC for 32-bit Operands
    rule mac;
        fn_pipeline_1(m1, m2, inp_ready);
        fn_pipeline_2(p1, p2, p3, p4, a, flag[0]);
    endrule

    // Action Method for Setting the Inputs
    method Action get_values(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend);
        if (multiplicand1 != m1 || multiplicand2 != m2 || addend != a)
        begin
            m1 <= multiplicand1;
            m2 <= multiplicand2;
            a <= addend;
            inp_ready <= True;
        end
        else
            inp_ready <= False;
    endmethod

    // Returning the 128-bit MAC Result
    method ActionValue#(Bit#(64)) mac_result() if (mac_ready);
        mac_ready <= False;
        Bit#(64) final_mac_result = resmac;
        return final_mac_result;
    endmethod

endmodule

endpackage : mac322p