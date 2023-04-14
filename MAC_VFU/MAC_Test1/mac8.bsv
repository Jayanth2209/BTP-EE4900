package mac8;

interface Ifc_mac8;
    method Action get_values(Bit#(8) multiplicand1, Bit#(8) multiplicand2, Bit#(8) addend);
    method Bit#(16) mac_result;
endinterface: Ifc_mac8

(*synthesize*)
module mkmac8(Ifc_mac8);
    // Registers for Inputs
    Reg#(Bit#(8)) m1 <- mkReg(0);
    Reg#(Bit#(8)) m2 <- mkReg(0);
    Reg#(Bit#(8)) a <- mkReg(0);

    // Register for MAC Result
    Reg#(Bit#(16)) resmac <- mkReg(0);

    // Ready Signal for Inputs
    Reg#(Bool) inp_ready <- mkReg(False);

    // Ready Signal for MAC Result
    Reg#(Bool) mac_ready <- mkReg(False);

    function Action fn_mac(Bit#(8) p1_m1, Bit#(8) p1_m2, Bit#(8) p1_a, Bool inp_check);
        return
        (action
            if (inp_check == False) mac_ready <= False;
            else begin
                resmac <= (extend(p1_m1)*extend(p1_m2) + extend(p1_a));
                mac_ready <= True;
            end
        endaction);
    endfunction

    rule mac;
        fn_mac(m1, m2, a, inp_ready);
    endrule

    // Action Method for Setting the Inputs
    method Action get_values(Bit#(8) multiplicand1, Bit#(8) multiplicand2, Bit#(8) addend);
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

    // Returning the 16-bit MAC Result
    method Bit#(16) mac_result if (mac_ready);
        Bit#(16) final_mac_result = resmac;
        return final_mac_result;
    endmethod

endmodule

endpackage : mac8