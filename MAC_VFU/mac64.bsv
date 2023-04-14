package mac64;

interface Ifc_mac64;
    method Action get_values(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend);
    method Bit#(128) mac_result;
endinterface: Ifc_mac64

(*synthesize*)
module mkmac64(Ifc_mac64);
    // Registers for Inputs
    Reg#(Bit#(64)) m1 <- mkReg(0);
    Reg#(Bit#(64)) m2 <- mkReg(0);
    Reg#(Bit#(64)) a <- mkReg(0);
    // Register for MAC Result
    Reg#(Bit#(128)) resmac <- mkReg(0);
    // Ready Signal
    Reg#(Bit#(2)) isReady <- mkRegA(0);

    // Rule that computes MAC for 64-bit Operands
    rule compute_mac64(isReady == 1);
        resmac <= ((extend(m1)*extend(m2))+extend(a));
        isReady <= 2;
    endrule: compute_mac64

    // Action Method for Setting the Inputs
    method Action get_values(Bit#(64) multiplicand1, Bit#(64) multiplicand2, Bit#(64) addend) if (isReady == 0);
        m1 <= multiplicand1;
        m2 <= multiplicand2;
        a <= addend;
        isReady <= 1;
    endmethod

    // Returning the 128-bit MAC Result
    method Bit#(128) mac_result if (isReady == 2);
        Bit#(128) final_mac_result = resmac;
        return final_mac_result;
    endmethod

endmodule

endpackage : mac64