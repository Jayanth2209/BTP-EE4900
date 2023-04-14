package mult16;

    interface Ifc_mult16;
        (*always_ready, always_enabled*)
        method Action iA (Bit#(16) a);
        (*always_ready, always_enabled*)
        method Action iB (Bit#(16) b);
        (*always_enabled*)
        method Bit#(32) oP();
    endinterface: Ifc_mult16

    (*synthesize*)
    module mkmult16(Ifc_mult16);
        Reg#(Bit#(16)) reg_a <- mkReg(0);
        Reg#(Bit#(16)) reg_b <- mkReg(0);

        method Action iA (Bit#(16) a);
            reg_a <= a;
        endmethod

        method Action iB (Bit#(16) b);
            reg_b <= b;
        endmethod

        method Bit#(32) oP();
            return signExtend(reg_a*reg_b);
        endmethod

    endmodule

endpackage
