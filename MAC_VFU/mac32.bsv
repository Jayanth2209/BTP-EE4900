package mac32;

interface Ifc_mac32;
    method Action get_values(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend);
    method Bit#(64) mac_result;
endinterface: Ifc_mac32

(*synthesize*)
module mkmac32(Ifc_mac32);
    // Registers for Inputs
    Reg#(Bit#(32)) m1 <- mkReg(0);
    Reg#(Bit#(32)) m2 <- mkReg(0);
    Reg#(Bit#(32)) a <- mkReg(0);
    // Register for MAC Result
    Reg#(Bit#(64)) resmac <- mkReg(0);
    // Ready Signal
    Reg#(Bit#(2)) isReady <- mkRegA(0);

    // Rule that computes MAC for 32-bit Operands
    rule compute_mac32(isReady == 1);
        resmac <= ((extend(m1)*extend(m2))+extend(a));
        isReady <= 2;
    endrule: compute_mac32

    // Action Method for Setting the Inputs
    method Action get_values(Bit#(32) multiplicand1, Bit#(32) multiplicand2, Bit#(32) addend) if (isReady == 0);
        m1 <= multiplicand1;
        m2 <= multiplicand2;
        a <= addend;
        isReady <= 1;
    endmethod

    // Returning the 64-bit MAC Result
    method Bit#(64) mac_result if (isReady == 2);
        Bit#(64) final_mac_result = resmac;
        return final_mac_result;
    endmethod

endmodule

endpackage : mac32