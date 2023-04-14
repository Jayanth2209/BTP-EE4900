package mac643p;

import Vector :: *;

interface Ifc_mac643p;
    method Action get_values(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend);
    method ActionValue#(Bit#(128)) mac_result();
endinterface: Ifc_mac643p

(*synthesize*)
module mkmac643p(Ifc_mac643p);

    // Registers for Inputs
    Reg#(Bit#(64)) m1 <- mkReg(0);
    Reg#(Bit#(64)) m2 <- mkReg(0);
    Reg#(Bit#(64)) a <- mkReg(0);

    // Ready Signal for Inputs
    Reg#(Bool) inp_ready <- mkReg(False);

    // Ready Signal for MAC Result
    Reg#(Bool) mac_ready <- mkReg(False);

    // Pipeline Stage 1
    Reg#(Bit#(128)) p1 <- mkReg(0);

    // Pipeline Stage 2
    Reg#(Bit#(128)) p2 <- mkReg(0);

    // Pipeline Stage 3
    Reg#(Bit#(128)) resmac <- mkReg(0);

    // Pipeline Flags
    Vector#(3, Reg#(Bit#(1))) flag <- replicateM(mkReg(0));

    function Action fn_pipeline_1(Bit#(64) p1_m1, Bit#(64) p1_m2, Bool inp_check);
        return
        (action
            if (inp_check == False) flag[0] <= 0;
            else begin
                p1 <= (extend(p1_m1)*extend(p1_m2[31:0]));
                flag[0] <= 1;
            end
        endaction);
    endfunction

    function Action fn_pipeline_2(Bit#(64) p1_m1, Bit#(64) p1_m2, Bit#(1) pipe1_check);
        return
        (action
            if (pipe1_check == 0) flag[1] <= 0;
            else begin
                p2 <= (extend(p1_m1)*extend(p1_m2[63:32]));
                flag[1] <= 1;
            end
        endaction);
    endfunction

    function Action fn_pipeline_3(Bit#(128) p3_p1, Bit#(128) p3_p2, Bit#(64) p3_a, Bit#(1) pipe2_check);
        return
        (action
            if (pipe2_check == 0) flag[2] <= 0;
            else begin
                resmac <= (p3_p1 + p3_p2 + extend(p3_a));
                flag[2] <= 1;
                mac_ready <= True;
            end
        endaction);
    endfunction


    // Rule that computes MAC for 64-bit Operands
    rule mac;
        fn_pipeline_1(m1, m2, inp_ready);
        fn_pipeline_2(m1, m2, flag[0]);
        fn_pipeline_3(p1, p2, a, flag[1]);
    endrule

    // Action Method for Setting the Inputs
    method Action get_values(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend);
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
    method ActionValue#(Bit#(128)) mac_result() if (mac_ready);
        mac_ready <= False;
        Bit#(128) final_mac_result = resmac;
        return final_mac_result;
    endmethod

endmodule

endpackage : mac643p