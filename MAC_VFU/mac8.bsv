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
    // Ready Signal
    Reg#(Bit#(2)) isReady <- mkRegA(0);

    // Rule that computes MAC for 8-bit Operands
    rule compute_mac8(isReady == 1);
        resmac <= ((extend(m1)*extend(m2))+extend(a));
        isReady <= 2;
    endrule: compute_mac8

    // Action Method for Setting the Inputs
    method Action get_values(Bit#(8) multiplicand1, Bit#(8) multiplicand2, Bit#(8) addend) if (isReady == 0);
        m1 <= multiplicand1;
        m2 <= multiplicand2;
        a <= addend;
        isReady <= 1;
    endmethod

    // Returning the 16-bit MAC Result
    method Bit#(16) mac_result if (isReady == 2);
        Bit#(16) final_mac_result = resmac;
        return final_mac_result;
    endmethod

endmodule

endpackage : mac8