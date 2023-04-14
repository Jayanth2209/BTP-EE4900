package mac644p;

import Vector :: *;

interface Ifc_mac644p;
    method Action get_values(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend);
    method ActionValue#(Bit#(128)) mac_result();
endinterface: Ifc_mac644p

(*synthesize*)
module mkmac644p(Ifc_mac644p);

    // Registers for Inputs
    Reg#(Bit#(64)) m1 <- mkReg(0);
    Reg#(Bit#(64)) m2 <- mkReg(0);
    Reg#(Bit#(64)) a <- mkReg(0);

    // Ready Signal for Inputs
    Reg#(Bool) inp_ready <- mkReg(False);

    // Ready Signal for MAC Result
    Reg#(Bool) mac_ready <- mkReg(False);

    // Pipeline Flag
    Vector#(4, Reg#(Bit#(1))) flag <- replicateM(mkReg(0));

    // Pipeline Stage 1
    Reg#(Bit#(128)) p1 <- mkReg(0);
    Reg#(Bit#(128)) p2 <- mkReg(0);

    // Pipeline Stage 2
    Reg#(Bit#(128)) p3 <- mkReg(0);
    Reg#(Bit#(128)) p4 <- mkReg(0);

    // Pipeline Stage 3
    Reg#(Bit#(128)) resmac <- mkReg(0);

    function Action fn_pipeline_1(Bit#(64) p1_m1, Bit#(64) p1_m2, Bool inp_check);
        return
        action  
        if(!inp_check)
            flag[0] <= 0;
        else
        begin
            p1 <= extend(p1_m1[31:0])*extend(p1_m2[31:0]);
            p2 <= ((extend(p1_m1[31:0])*extend(p1_m2[63:32])) << 32);
            flag[0] <= 1;
        end
        endaction;
    endfunction

    function Action fn_pipeline_2(Bit#(64) p2_m1, Bit#(64) p2_m2, Bit#(1) pipe1_check);
        return
        action  
        if(pipe1_check == 0)
            flag[1] <= 0;
        else
        begin
            p3 <= ((extend(p2_m1[63:32])*extend(p2_m2[31:0])) << 32);
            flag[1] <= 1;
        end
        endaction;
    endfunction 

    function Action fn_pipeline_3(Bit#(64) p3_m1, Bit#(64) p3_m2, Bit#(1) pipe2_check);
        return
        action  
        if(pipe2_check == 0)
            flag[2] <= 0;
        else
        begin
            p4 <= ((extend(p3_m1[63:32])*extend(p3_m2[63:32])) << 64);
            flag[2] <= 1;
        end
        endaction;
    endfunction

    function Action fn_pipeline_4(Bit#(128) p4_p1, Bit#(128) p4_p2, Bit#(128) p4_p3, Bit#(128) p4_p4, Bit#(64) p4_a, Bit#(1) pipe3_check);
        return
        action
        if (pipe3_check == 0)
            flag[3] <= 0;
        else
        begin
            resmac <= (p4_p1 + p4_p2 + p4_p3 + p4_p4 + extend(p4_a));
            mac_ready <= True;
            flag[3] <= 1;
        end
        endaction;
    endfunction


    // Rule that computes MAC for 64-bit Operands
    rule mac;
        fn_pipeline_1(m1, m2, inp_ready);
        fn_pipeline_2(m1, m2, flag[0]);
        fn_pipeline_3(m1, m2, flag[1]);
        fn_pipeline_4(p1, p2, p3, p4, a, flag[2]);
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

endpackage : mac644p