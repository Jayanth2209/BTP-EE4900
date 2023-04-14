package mult64;

    interface Ifc_mult64;
        (*always_ready, always_enabled*)
        method Action iA (Bit#(64) a);
        (*always_ready, always_enabled*)
        method Action iB (Bit#(64) b);
        (*always_enabled*)
        method Bit#(128) oP();
    endinterface: Ifc_mult64

    (*synthesize*)
    module mkmult64(Ifc_mult64);
        Reg#(Bit#(64)) reg_a <- mkReg(0);
        Reg#(Bit#(64)) reg_b <- mkReg(0);

        method Action iA (Bit#(64) a);
            reg_a <= a;
        endmethod

        method Action iB (Bit#(64) b);
            reg_b <= b;
        endmethod

        method Bit#(128) oP();
            return signExtend(reg_a*reg_b);
        endmethod

    endmodule

endpackage
