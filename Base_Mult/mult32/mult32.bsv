package mult32;

    interface Ifc_mult32;
        (*always_ready, always_enabled*)
        method Action iA (Bit#(32) a);
        (*always_ready, always_enabled*)
        method Action iB (Bit#(32) b);
        (*always_enabled*)
        method Bit#(64) oP();
    endinterface: Ifc_mult32

    (*synthesize*)
    module mkmult32(Ifc_mult32);
        Reg#(Bit#(32)) reg_a <- mkReg(0);
        Reg#(Bit#(32)) reg_b <- mkReg(0);

        method Action iA (Bit#(32) a);
            reg_a <= a;
        endmethod

        method Action iB (Bit#(32) b);
            reg_b <= b;
        endmethod

        method Bit#(64) oP();
            return signExtend(reg_a*reg_b);
        endmethod

    endmodule

endpackage
