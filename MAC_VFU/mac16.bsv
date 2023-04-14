package mac16;

interface Ifc_mac16;
    method Action get_values(Bit#(16) multiplicand1, Bit#(16) multiplicand2, Bit#(16) addend);
    method Bit#(32) mac_result;
endinterface: Ifc_mac16

(*synthesize*)
module mkmac16(Ifc_mac16);
    // Registers for Inputs
    Reg#(Bit#(16)) m1 <- mkReg(0);
    Reg#(Bit#(16)) m2 <- mkReg(0);
    Reg#(Bit#(16)) a <- mkReg(0);
    // Register for MAC Result
    Reg#(Bit#(32)) resmac <- mkReg(0);
    // Ready Signal
    Reg#(Bit#(2)) isReady <- mkRegA(0);

    // Rule that computes MAC for 16-bit Operands
    rule compute_mac16(isReady == 1);
        resmac <= ((extend(m1)*extend(m2))+extend(a));
        isReady <= 2;
    endrule: compute_mac16

    // Action Method for Setting the Inputs
    method Action get_values(Bit#(16) multiplicand1, Bit#(16) multiplicand2, Bit#(16) addend) if (isReady == 0);
        m1 <= multiplicand1;
        m2 <= multiplicand2;
        a <= addend;
        isReady <= 1;
    endmethod

    // Returning the 32-bit MAC Result
    method Bit#(32) mac_result if (isReady == 2);
        Bit#(32) final_mac_result = resmac;
        return final_mac_result;
    endmethod

endmodule

endpackage : mac16