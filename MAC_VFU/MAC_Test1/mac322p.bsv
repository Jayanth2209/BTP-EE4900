package mac322p;

import Vector::*;

interface Ifc_mac322p;
    method Action get_values(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend);
        method Bit#(64) mac_result;
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
    Reg#(Bit#(64)) p <- mkReg(0);

    // Pipeline Stage 2
    Reg#(Bit#(64)) resmac <- mkReg(0);

    function Action fn_pipeline_1(Bit#(32) p1_m1, Bit#(32) p1_m2, Bool inp_check);
        return
        (action
            if (inp_check == False) flag[0] <= 0;
            else begin
                p <= (extend(p1_m1)*extend(p1_m2));
                flag[0] <= 1;
            end
        endaction);
    endfunction

    function Action fn_pipeline_2(Bit#(64) p2_p, Bit#(32) p2_a, Bit#(1) pipe1_check);
        return
        (action
            if (pipe1_check == 0) flag[1] <= 0;
            else begin
                resmac <= (p2_p + extend(p2_a));
                flag[1] <= 1;
                mac_ready <= True;
            end
        endaction);
    endfunction


    // Rule that computes MAC for 32-bit Operands
    rule mac;
        fn_pipeline_1(m1, m2, inp_ready);
        fn_pipeline_2(p, a, flag[0]);
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
    method Bit#(64) mac_result if (mac_ready);
        Bit#(64) final_mac_result = resmac;
        return final_mac_result;
    endmethod

endmodule

endpackage : mac322p